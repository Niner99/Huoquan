//
//  SendManageViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SendManageViewController.h"
#import "SendManageTableViewCell.h"
#import "OrderManageDetailViewController.h"
#import "SendGoodsListModel.h"
#import "SendShopViewController.h"
@interface SendManageViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *tv;
    NSMutableArray *dataArray;
    JCAlertView *jcView;
    NSString *deliveryOrderId;
    NSInteger currentPage;
    NoNetView *noview;
    UIView *nogoodsview;
}
@end

@implementation SendManageViewController
static NSString *celltv=@"celltv";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"发往门店商品" color:k000000 fontSize:kTitleFloat];
    [self creatUI];
}


-(void)initData{
    currentPage=1;
    [self showNHUD];
    dataArray=[[NSMutableArray alloc]init];
    NSDictionary *dic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kSendShopList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            [dataArray addObjectsFromArray:responseObject[@"data"]];
            if (dataArray.count>0) {
                currentPage=2;
                [tv reloadData];
                nogoodsview.hidden=YES;
            }else{
                nogoodsview.hidden=NO;
            }
            
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
        [tv.mj_header endRefreshing];
    }];
}

-(void)loadMoreData{

    [self showNHUD];

    NSDictionary *dic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kSendShopList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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

        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
    }];
}



-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tv];
    tv.separatorColor=[UIColor clearColor];
    [tv registerClass:[SendManageTableViewCell class] forCellReuseIdentifier:celltv];
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
    
    nogoodsview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:nogoodsview];
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [nogoodsview addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(75,61)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:183];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"暂无发往门店商品"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 279, kScreenWidth, 13)];
    shopLabel.text=@"您还没发货到门店哦~";
    shopLabel.textAlignment=NSTextAlignmentCenter;
    shopLabel.font=THIRTEEN;
    shopLabel.textColor=k888888;
    [nogoodsview addSubview:shopLabel];
    
    UIButton *btnshop=[UIButton newAutoLayoutView];
    [nogoodsview addSubview:btnshop];
    [btnshop autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [btnshop autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:315];
    [btnshop autoSetDimensionsToSize:CGSizeMake(180, 30*HH)];
    btnshop.backgroundColor=k000000;
    [btnshop setTitle:@"发货至门店" forState:0];
    [btnshop addTarget:self action:@selector(btn_lookgoods) forControlEvents:UIControlEventTouchUpInside];
    btnshop.layer.cornerRadius=15*HH;
    btnshop.titleLabel.font=FIFTEEN;
    
    nogoodsview.hidden=YES;
}

-(void)btn_lookgoods{
    SendShopViewController *ss=[SendShopViewController new];
    [self.navigationController pushViewController:ss animated:YES];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SendManageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    SendGoodsListModel *send=[[SendGoodsListModel alloc]initWithDictionary:dataArray[indexPath.row] error:nil];
    cell.sendCode.text=[NSString stringWithFormat:@"发货单号：%@",send.deliveryNo];

    [cell.sureBtn addTarget:self action:@selector(sureReceivegoods:) forControlEvents:UIControlEventTouchUpInside];
    cell.sureBtn.tag=indexPath.row+10;
    
    if ([send.orderStatus intValue]==12) {
        cell.sendState.text=@"待发货";
        cell.stateStr=@"0";
        NSString *timell=[NSString setDaywithString:send.addTime];
        cell.commtTime.text=[NSString stringWithFormat:@"提交时间：%@",timell];
    }
    if ([send.orderStatus intValue]==13) {
        cell.sendState.text=@"待收货";
        cell.stateStr=@"1";
        NSString *timell=[NSString setDaywithString:send.deliveryTime];
        cell.commtTime.text=[NSString stringWithFormat:@"发货时间：%@",timell];
    }
    if ([send.orderStatus intValue]==14) {
        cell.sendState.text=@"已完成";
        cell.stateStr=@"0";
        NSString *timell=[NSString setDaywithString:send.confirmTime];
        cell.commtTime.text=[NSString stringWithFormat:@"收货时间：%@",timell];
    }
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SendGoodsListModel *send=[[SendGoodsListModel alloc]initWithDictionary:dataArray[indexPath.row] error:nil];
    OrderManageDetailViewController *order=[OrderManageDetailViewController new];
    order.orderDetailID=send.pkId;
    order.orderState=send.orderStatus;
    [self.navigationController pushViewController:order animated:YES];
}

#pragma mark 确认收货
-(void)sureReceivegoods:(UIButton *)sender{
    SendGoodsListModel *send=[[SendGoodsListModel alloc]initWithDictionary:dataArray[sender.tag-10] error:nil];
    deliveryOrderId=send.pkId;
    
    PopWindowView *pop=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singleTitle:@"您确定收货吗?" leftBtn:@"取消" rightBtn:@"确定"];
    [pop.leftBtn addTarget:self action:@selector(dismiss_alert) forControlEvents:UIControlEventTouchUpInside];
    [pop.rightBtn addTarget:self action:@selector(dismiss_getgoods) forControlEvents:UIControlEventTouchUpInside];
    jcView=nil;
    jcView=[[JCAlertView alloc]initWithCustomView:pop dismissWhenTouchedBackground:NO];
    [jcView show];

}


-(void)dismiss_alert{
    [jcView dismissWithCompletion:^{
        jcView=nil;
        [tv reloadData];
    }];
}

-(void)dismiss_getgoods{
    [jcView dismissWithCompletion:^{
        jcView=nil;
        [self showNHUD];
        NSDictionary *dicc=@{@"deliveryOrderId":deliveryOrderId};
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kSureGetGoods] parameters:dicc success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            if ([responseObject[@"code"] intValue]==200) {
                [self initData];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];
    }];
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
