//
//  MyOrderDetailViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "MyOrderTableViewCell.h"
#import "OnlineInventoryViewController.h"
#import "MyOrderListModel.h"

@interface MyOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    UIView *bottomView;
    MyOrderListModel *or;
    NoNetView *noview;
}
@end

@implementation MyOrderDetailViewController
static NSString *celltv=@"celltv";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self loadTitleWithTitle:@"货权订单详情" color:k000000 fontSize:kTitleFloat];
    [self creatUI];

}



-(void)initData{
    [self showNHUD];
    NSDictionary *dic=@{@"virtualId":_orderID};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMyOrderDetail] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        if ([responseObject[@"code"] intValue]==200) {
            
            or=[[MyOrderListModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
            [tv reloadData];
            
            if ([or.orderStatus intValue]==11 || [or.orderStatus intValue]==81 || [or.orderStatus intValue]==82) {
                bottomView.hidden=YES;
            }else{
                bottomView.hidden=NO;
            }
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
    }];
    
    
    
}


-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    [tv registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:celltv];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self setbottomView];
    
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return or.detailList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    OrderDetailModel *detail=or.detailList[indexPath.row];
    
    cell.ordername=@"0";
    cell.titleLabel.text=detail.goodsName;
    cell.goodsPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:detail.goodsPrice]];
    cell.goodsNum.text=[NSString stringWithFormat:@"×%@",detail.goodsQuantity];
    NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:detail.sellAttribute];
    
    NSString *specString=@"";
    for (int i=0; i<specArray.count; i++) {
        NSDictionary *specdic=specArray[i];
        NSString *cityStr=[NSString stringWithFormat:@"%@/%@",specdic[@"spec"],specdic[@"value"]];
        specString=[specString stringByAppendingString:[NSString stringWithFormat:@" %@",cityStr]];
        
    }
    cell.goodsColor.text=specString;
    
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,detail.goodsPic]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [cell.goodsIcon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 107)];
    
    UIView *stateView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 54)];
    stateView.backgroundColor=[UIColor whiteColor];
    [headview addSubview:stateView];
    UILabel *stateLabel=[UILabel newAutoLayoutView];
    [stateView addSubview:stateLabel];
    [stateLabel autoSetDimensionsToSize:CGSizeMake(100, 18)];
    [stateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:17];
    [stateLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    stateLabel.textColor=kDABF66;
    stateLabel.font=EIGHTTEEN;
    
    switch ([or.orderStatus intValue]) {
        case 11:
            stateLabel.text=@"待支付";//
            break;
        case 12:
            stateLabel.text=@"已支付";
            break;
        case 13:
            stateLabel.text=@"待收货";
            break;
        case 14:
            stateLabel.text=@"确认收货";
            break;
        case 81:
            stateLabel.text=@"已取消";//
            break;
        case 82:
            stateLabel.text=@"已关闭";//
            break;
        case 60:
            stateLabel.text=@"已结束";
            break;
        default:
            break;
    }
    
    UIView *goodsView=[[UIView alloc]initWithFrame:CGRectMake(0, 59, kScreenWidth, 47)];
    goodsView.backgroundColor=[UIColor whiteColor];
    [headview addSubview:goodsView];
    
    UILabel *goodslabel=[UILabel newAutoLayoutView];
    [goodsView addSubview:goodslabel];
    [goodslabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [goodslabel autoSetDimensionsToSize:CGSizeMake(100, 12)];
    [goodslabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:17];
    goodslabel.text=@"商品清单";
    goodslabel.textColor=k333333;
    goodslabel.font=TWELVE;
    
    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 59, kScreenWidth, 1)];
    linev.backgroundColor=kD8D8D8;
    [headview addSubview:linev];

    
    return headview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 107;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 138)];
    
    UIView *goodsView=[[UIView alloc]initWithFrame:CGRectMake(0,5, kScreenWidth, 47)];
    goodsView.backgroundColor=[UIColor whiteColor];
    [footview addSubview:goodsView];
    
    UILabel *goodslabel=[UILabel newAutoLayoutView];
    [goodsView addSubview:goodslabel];
    [goodslabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [goodslabel autoSetDimensionsToSize:CGSizeMake(100, 12)];
    [goodslabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:17];
    goodslabel.text=@"交易信息";
    goodslabel.textColor=k333333;
    goodslabel.font=TWELVE;
    
    UIView *infoview=[[UIView alloc]initWithFrame:CGRectMake(0, 52, kScreenWidth, 86)];
    infoview.backgroundColor=[UIColor whiteColor];
    [footview addSubview:infoview];
    
    UILabel *bianhao=[[UILabel alloc]initWithFrame:CGRectMake(15, 17, 200, 12)];
    bianhao.text=@"订单编号:";
    bianhao.font=TWELVE;
    bianhao.textColor=k191919;
    [infoview addSubview:bianhao];
    
    UILabel *shijian=[[UILabel alloc]initWithFrame:CGRectMake(15, 38, 200, 12)];
    shijian.text=@"下单时间:";
    shijian.font=TWELVE;
    shijian.textColor=k191919;
    [infoview addSubview:shijian];
    
    UILabel *zonge=[[UILabel alloc]initWithFrame:CGRectMake(15, 59, 200, 12)];
    zonge.text=@"订单总额:";
    zonge.font=TWELVE;
    zonge.textColor=k191919;
    [infoview addSubview:zonge];
    
    UILabel *orderCode=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-215, 17, 200, 12)];
    orderCode.text=or.virtualOrderNo;
    orderCode.font=TWELVE;
    orderCode.textColor=k191919;
    orderCode.textAlignment=NSTextAlignmentRight;
    [infoview addSubview:orderCode];
    
    UILabel *orderTime=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-215, 38, 200, 12)];
    orderTime.text=[NSString setTimewithString:or.addTime];;
    orderTime.font=TWELVE;
    orderTime.textColor=k191919;
    orderTime.textAlignment=NSTextAlignmentRight;
    [infoview addSubview:orderTime];
    
    UILabel *orderPrice=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-215, 59, 200, 12)];
    orderPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:or.totalMoney]];
    orderPrice.font=FIFTEEN;
    orderPrice.textColor=kDABF66;
    orderPrice.textAlignment=NSTextAlignmentRight;
    [infoview addSubview:orderPrice];
    
    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0,52, kScreenWidth, 1)];
    linev.backgroundColor=kD8D8D8;
    [footview addSubview:linev];
    
    UILabel *guanbi=[[UILabel alloc]initWithFrame:CGRectMake(15, 81, 200, 12)];
    guanbi.text=@"关闭时间:";
    guanbi.font=TWELVE;
    guanbi.textColor=k191919;
    [infoview addSubview:guanbi];
    
    UILabel *closeTime=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-215,81, 200, 12)];
    closeTime.text=[NSString setTimewithString:or.addTime];
    closeTime.font=TWELVE;
    closeTime.textColor=k191919;
    closeTime.textAlignment=NSTextAlignmentRight;
    [infoview addSubview:closeTime];
    
    if ([or.orderStatus intValue]==82) {
        guanbi.hidden=NO;
        closeTime.hidden=NO;
        infoview.frame=CGRectMake(0, 52, kScreenWidth, 106);
    }else{
        infoview.frame=CGRectMake(0, 52, kScreenWidth, 86);
        guanbi.hidden=YES;
        closeTime.hidden=YES;
    }
    
    return footview;
}


-(void)setbottomView{
    bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UILabel *kucunlabel=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 49)];
    kucunlabel.textColor=k333333;
    kucunlabel.font=ELEVEN;
    kucunlabel.text=@"交易成功货权，商品会自动进入云库存，如需发货至门店请进入云库存操作。";
    kucunlabel.numberOfLines=2;
    [bottomView addSubview:kucunlabel];
    
    UIButton *kucunbtn=[UIButton newAutoLayoutView];
    [bottomView addSubview:kucunbtn];
    [kucunbtn autoSetDimensionsToSize:CGSizeMake(95, 31)];
    [kucunbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
    [kucunbtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    kucunbtn.layer.cornerRadius=2;
    kucunbtn.backgroundColor=kDABF66;
    [kucunbtn setTitle:@"进入云库存" forState:0];
    kucunbtn.titleLabel.font=FOURTEEN;
    [kucunbtn addTarget:self action:@selector(onlineInventory) forControlEvents:UIControlEventTouchUpInside];
    

}

#pragma mark 云库存
-(void)onlineInventory{
    OnlineInventoryViewController *online=[OnlineInventoryViewController new];
    [self.navigationController pushViewController:online animated:YES];
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
