//
//  OrderManageDetailViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/25.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "OrderManageDetailViewController.h"
#import "ManageOrderDetail.h"
#import "MyOrderTableViewCell.h"
#import "LogisticsInfoViewController.h"
#import "SendGoodsDetailModel.h"

@interface OrderManageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    SendGoodsDetailModel *send;
    UIView *bottomview;
    JCAlertView *jcView;
    NoNetView *noview;
    NSTimer *countTimer;
    ManageOrderDetail *manaview;
    NSInteger countSecond;
}
@end

@implementation OrderManageDetailViewController
static NSString  *cellorder=@"cellorder";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([_orderState intValue]==12) {
       [self loadTitleWithTitle:@"待发货详情" color:k000000 fontSize:kTitleFloat];
    }
    if ([_orderState intValue]==13) {
        [self loadTitleWithTitle:@"待收货详情" color:k000000 fontSize:kTitleFloat];
    }
    if ([_orderState intValue]==14) {
        [self loadTitleWithTitle:@"已完成详情" color:k000000 fontSize:kTitleFloat];
    }
    
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    NSDictionary *dicc=@{@"deliveryOrderId":_orderDetailID};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kSendShopListDetail] parameters:dicc success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        if ([responseObject[@"code"] intValue]==200) {
            
            send=[[SendGoodsDetailModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
            [tv reloadData];
            if ([send.orderStatus intValue]==13) {
                //待收货
                bottomview.hidden=NO;
            }else{
                bottomview.hidden=YES;
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
    }];
}




-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-50) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tv];
    [tv registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:cellorder];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
    [self setBottomview];
    bottomview.hidden=YES;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 186+28)];
    headview.backgroundColor=[UIColor whiteColor];
    
    manaview=[[ManageOrderDetail alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 186)];
    
    if ([send.orderStatus intValue]==12) {
        manaview.stateLabel.text=@"待发货";
    }
    if ([send.orderStatus intValue]==13) {
        manaview.stateLabel.text=@"待收货";
        
        NSString *timenum=[NSString distanceTime:send.addTime deadlineTime:send.receivingDeadline];
        
        if ([timenum rangeOfString:@"秒"].location !=NSNotFound) {
            //如果字符串包含秒

            NSString *timenum=[NSString distanceTime:send.addTime deadlineTime:send.receivingDeadline];
            
            countSecond=[timenum integerValue];
            countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:NO];

        }else{
            NSMutableAttributedString *tempstr=[UsefulClass setStr:timenum onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"还差%@",timenum]];
            [manaview.shouhuoTime setAttributedText:tempstr];
        }

    }
    if ([send.orderStatus intValue]==14) {
        manaview.stateLabel.text=@"已完成";
    }
    
    manaview.username.text=send.consignee;
    manaview.userphone.text=send.consigneeTel;
    manaview.useraddress.text=[NSString stringWithFormat:@"%@%@%@%@",send.deliveryProvince,send.deliveryCity,send.deliveryDistrict,send.deliveryAddress];
    
    manaview.ordercode.text=[NSString stringWithFormat:@"订单编号：%@",send.deliveryNo];
    NSString *timeStr=[NSString setTimewithString:send.addTime];
    manaview.ordertime.text=[NSString stringWithFormat:@"下单时间：%@",timeStr];
    
    [headview addSubview:manaview];
    
    
    UILabel *qingdan=[[UILabel alloc]initWithFrame:CGRectMake(0, 186, kScreenWidth, 28)];
    qingdan.backgroundColor=kF8F8F8;
    qingdan.text=@"   发货清单";
    qingdan.textColor=k333333;
    qingdan.font=TWELVE;
    [headview addSubview:qingdan];
    
    return headview;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 186+28;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return send.detailList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellorder];
    OrderDetailModel *detail=send.detailList[indexPath.row];
    cell.ordername=@"1";
    cell.titleLabel.text=detail.goodsName;
    NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:detail.goodsSpec];
    
    NSString *specString=@"";
    for (int i=0; i<specArray.count; i++) {
        NSDictionary *specdic=specArray[i];
        NSString *cityStr=[NSString stringWithFormat:@"%@/%@",specdic[@"spec"],specdic[@"value"]];
        specString=[specString stringByAppendingString:[NSString stringWithFormat:@" %@",cityStr]];
        
    }
    cell.goodsColor.text=specString;
    cell.goodsNum.text=[NSString stringWithFormat:@"×%@",detail.goodsQuantity];
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,detail.goodsPic]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [cell.goodsIcon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
    return cell;
}



-(void)setBottomview{
    bottomview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    [self.view addSubview:bottomview];
    bottomview.backgroundColor=[UIColor whiteColor];
    
    UIButton *surebtn=[UIButton newAutoLayoutView];
    [bottomview addSubview:surebtn];
    [surebtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [surebtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
    [surebtn autoSetDimensionsToSize:CGSizeMake(81, 30)];
    surebtn.backgroundColor=kDABF66;
    surebtn.layer.cornerRadius=4;
    [surebtn setTitle:@"确认收货" forState:0];
    surebtn.titleLabel.font=FIFTEEN;
    [surebtn addTarget:self action:@selector(sureReceivegoods) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *logisticbtn=[UIButton newAutoLayoutView];
    [bottomview addSubview:logisticbtn];
    [logisticbtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [logisticbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:110];
    [logisticbtn autoSetDimensionsToSize:CGSizeMake(81, 30)];
    logisticbtn.layer.cornerRadius=4;
    [logisticbtn setTitle:@"物流信息" forState:0];
    logisticbtn.titleLabel.font=FIFTEEN;
    logisticbtn.layer.borderColor=k888888.CGColor;
    logisticbtn.layer.borderWidth=1;
    [logisticbtn setTitleColor:k333333 forState:0];
    [logisticbtn addTarget:self action:@selector(pushlogistics) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *lines=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    [bottomview addSubview:lines];
    lines.backgroundColor=kD8D8D8;
}


#pragma mark 物流信息
-(void)pushlogistics{
    LogisticsInfoViewController *logis=[LogisticsInfoViewController new];
    logis.logisticID=send.pkId;
    [self.navigationController pushViewController:logis animated:YES];
}
#pragma mark 确认收货
-(void)sureReceivegoods{

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
        NSDictionary *dicc=@{@"deliveryOrderId":send.pkId};
        
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


-(void) countDownAction{
    //倒计时-1
    countSecond--;
    NSString *str_hour = [NSString stringWithFormat:@"%02ld小时",countSecond/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld分钟",(countSecond%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld秒",countSecond%60];
    NSString *format_time = [NSString stringWithFormat:@"%@%@%@",str_hour,str_minute,str_second]; //修改倒计时标签现实内容

    NSMutableAttributedString *tempstr=[UsefulClass setStr:format_time onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"还差%@",format_time]];
    [manaview.shouhuoTime setAttributedText:tempstr];
    
    if(countSecond==0){
        [countTimer invalidate];
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
