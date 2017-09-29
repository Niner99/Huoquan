//
//  MessageViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/16.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "UITableViewRowAction+JZExtension.h"
#import "MessageDetailViewController.h"
#import "MessageListModel.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *tv;
    NSMutableArray *dataArray;
    NSString *noticeid;
    JCAlertView *jcView;
    NSInteger currentPage;
    NoNetView *noview;
    UIView *noshopView;
}
@end

@implementation MessageViewController
static NSString *celltv=@"celltv";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"消息中心" color:k000000 fontSize:18];
    
    [self creatUI];
    
}

-(void)initData{
    currentPage=1;
    [self showNHUD];
    dataArray=[[NSMutableArray alloc]init];
    NSDictionary *dicmessage=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMessageList] parameters:dicmessage success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
           
            [dataArray addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
            currentPage=2;
            if (dataArray.count>0) {
                noshopView.hidden=YES;
            }else{
                noshopView.hidden=NO;
            }
            
            
        }if ([responseObject[@"code"] intValue]==401) {
  
            kRemoveStandardUserDefaults(kTokenHuoquan);
            LoginViewController *lauchvc=[LoginViewController new];
            BaseNC *nc=[[BaseNC alloc]initWithRootViewController:lauchvc];
            self.view.window.rootViewController=nc;
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
        [tv.mj_header endRefreshing];
    }];
}

-(void)loadMoreData{
    [self showNHUD];

    NSDictionary *dicmessage=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMessageList] parameters:dicmessage success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
             NSArray *tempArray=responseObject[@"data"];
            if (tempArray.count>0) {
                [dataArray addObjectsFromArray:responseObject[@"data"]];
                [tv reloadData];
                currentPage++;
            }else{
                
                [tv.mj_footer setState:MJRefreshStateNoMoreData];
            }

        }if ([responseObject[@"code"] intValue]==401) {
            
            kRemoveStandardUserDefaults(kTokenHuoquan);
            LoginViewController *lauchvc=[LoginViewController new];
            BaseNC *nc=[[BaseNC alloc]initWithRootViewController:lauchvc];
            self.view.window.rootViewController=nc;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
    }];
}




-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    [tv registerClass:[MessageTableViewCell class] forCellReuseIdentifier:celltv];
    tv.separatorColor=[UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    MJRefreshNormalHeader *mjheader=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initData];
    }];
    [mjheader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [mjheader setTitle:@"释放立即刷新" forState:MJRefreshStatePulling];
    [mjheader setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    tv.mj_header=mjheader;
    
    __weak typeof(self) weak_self = self;
    MJRefreshAutoNormalFooter *mjfooter=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self loadMoreData];
    }];
    [mjfooter setTitle:@"" forState:MJRefreshStateIdle];
    [mjfooter setTitle:@"正在加载更多..." forState:MJRefreshStateRefreshing];
    [mjfooter setTitle:kloadMoreString forState:MJRefreshStateNoMoreData];
    tv.mj_footer=mjfooter;

    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
    
    //无消息视图
    noshopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:noshopView];
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [noshopView addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(78, 73)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:183];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"暂无消息"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 279, kScreenWidth, 13)];
    shopLabel.text=@"暂无消息";
    shopLabel.textAlignment=NSTextAlignmentCenter;
    shopLabel.font=THIRTEEN;
    shopLabel.textColor=k888888;
    [noshopView addSubview:shopLabel];
    noshopView.hidden=YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    
    MessageListModel *melis=[[MessageListModel alloc]initWithDictionary:dataArray[indexPath.section] error:nil];
    
    
    Cell.titleLabel.text=melis.noticeTitle;
    Cell.contentLabel.text=melis.noticeMsg;
    if ([melis.msgType intValue]==1) {
        Cell.haveRead.hidden=NO;
    }else{
        Cell.haveRead.hidden=YES;
    }
    
    return Cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *timelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 28)];
     MessageListModel *melis=[[MessageListModel alloc]initWithDictionary:dataArray[section] error:nil];

    timelabel.text=[NSString setTimewithString:melis.sendTime];
    timelabel.textAlignment=NSTextAlignmentCenter;
    timelabel.textColor=k888888;
    timelabel.font=ELEVEN;
    return timelabel;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *action1=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault image:[UIImage imageNamed:@"删除"] handler:^(UITableViewRowAction * _Nullable action, NSIndexPath * _Nullable indexPath) {
        
        MessageListModel *melis=[[MessageListModel alloc]initWithDictionary:dataArray[indexPath.section] error:nil];
        noticeid=melis.pkId;

        
        PopWindowView *pop=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singleTitle:@"确定要删除此条消息?" leftBtn:@"取消" rightBtn:@"删除"];
        [pop.leftBtn addTarget:self action:@selector(dismiss_alert) forControlEvents:UIControlEventTouchUpInside];
        [pop.rightBtn addTarget:self action:@selector(dismiss_remove) forControlEvents:UIControlEventTouchUpInside];
        jcView=nil;
        jcView=[[JCAlertView alloc]initWithCustomView:pop dismissWhenTouchedBackground:NO];
        [jcView show];

    }];
    
    action1.title=@"       ";
    
    action1.backgroundColor =[UIColor clearColor];
    
    
    
    return @[action1];
}



-(void)dismiss_alert{
    [jcView dismissWithCompletion:^{
        jcView=nil;
        [tv reloadData];
    }];
}

-(void)dismiss_remove{
    [jcView dismissWithCompletion:^{
        jcView=nil;
        [self showNHUD];
        NSDictionary *dicdelete=@{@"noticeId":noticeid};
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMessageDelete] parameters:dicdelete success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [self NhideHUD:YES];
            
            if ([responseObject[@"code"] intValue]==200) {
                [self initData];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];
    }];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailViewController *mes=[MessageDetailViewController new];
    MessageListModel *melis=[[MessageListModel alloc]initWithDictionary:dataArray[indexPath.section] error:nil];
    
    mes.noticeID=melis.pkId;
    
    [self.navigationController pushViewController:mes animated:YES];
}

-(void)ishaveView:(BOOL )isnet{
    if (isnet==YES) {
        noview.hidden=YES;
    }else{
        noview.hidden=NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self initData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
