//
//  HelpCenterViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "HelpDetailViewController.h"

@interface HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    NSMutableArray *arraytitle;
    NSInteger currentPage;
    NoNetView *noview;
}
@end

@implementation HelpCenterViewController
static NSString *cellone=@"cellone";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"帮助中心" color:k000000 fontSize:kTitleFloat];
    arraytitle=[[NSMutableArray alloc]init];
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.showsVerticalScrollIndicator=NO;
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellone];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:tv];
    
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
}


-(void)initData{
    currentPage=1;
    [self showNHUD];
    arraytitle=[[NSMutableArray alloc]init];
    NSDictionary *helpdic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kHelpCenter] parameters:helpdic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
         [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            currentPage=2;
            [arraytitle addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
         [tv.mj_header endRefreshing];
    }];
}

-(void)loadMoreData{
 
    [self showNHUD];
    NSDictionary *helpdic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kHelpCenter] parameters:helpdic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {

            NSArray *tempArray=responseObject[@"data"];
            if (tempArray.count>0) {
                [arraytitle addObjectsFromArray:responseObject[@"data"]];
                [tv reloadData];
                currentPage++;
            }else{
                
                [tv.mj_footer setState:MJRefreshStateNoMoreData];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
    }];
}








-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellone];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dictitle=arraytitle[indexPath.row];
    
    cell.textLabel.text=dictitle[@"articleTitle"];
    
    cell.textLabel.font=FOURTEEN;
    cell.textLabel.textColor=k333333;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arraytitle.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vvv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,6)];
    vvv.backgroundColor=kF8F8F8;
    return vvv;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dictitle=arraytitle[indexPath.row];
    
    NSString *pkid=dictitle[@"pkId"];
    NSString *helpTitle=dictitle[@"articleTitle"];
    
    HelpDetailViewController *deta=[HelpDetailViewController new];
    deta.pkid=pkid;
    deta.helpTitle=helpTitle;
    
    [self.navigationController pushViewController:deta animated:YES];
    
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
