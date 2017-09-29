//
//  MyOrdersViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderDetailViewController.h"
#import "MyOrderListModel.h"

@interface MyOrdersViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    UIView *btnline;
    UIButton *tempbtn;
    NSMutableArray *dataarray;
    NSInteger currentPage;
    NoNetView *noview;
    UIView *noshopView;
}
@end

@implementation MyOrdersViewController
static NSString *celltv=@"celltv";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTitleWithTitle:@"货权订单" color:k000000 fontSize:kTitleFloat];
    
    [self creatUI];
    
}

-(void)initData{
    currentPage=1;
    [self showNHUD];
    dataarray=[[NSMutableArray alloc]init];
    NSDictionary *dic=@{@"orderStatus":[NSString stringWithFormat:@"%ld",_orderNum],@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMyOrders] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            currentPage=2;
            [dataarray addObjectsFromArray:responseObject[@"data"]];
            
            [tv reloadData];
            if (dataarray.count>0) {
                noshopView.hidden=YES;
            }else{
                noshopView.hidden=NO;
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [tv.mj_header endRefreshing];
        [self NhideHUD:YES];
        [self ishaveView:NO];
    }];

}

-(void)loadMoreData{

    [self showNHUD];

    NSDictionary *dic=@{@"orderStatus":[NSString stringWithFormat:@"%ld",_orderNum],@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMyOrders] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            NSArray *tempArray=responseObject[@"data"];
            if (tempArray.count>0) {
                [dataarray addObjectsFromArray:responseObject[@"data"]];
                [tv reloadData];
                currentPage++;
            }else{
                
                [tv.mj_footer setState:MJRefreshStateNoMoreData];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [tv.mj_footer endRefreshing];
        [self NhideHUD:YES];
    }];
}



-(void)creatUI{
    UIView *btnview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
    [self.view addSubview:btnview];
    btnview.backgroundColor=[UIColor whiteColor];
    
    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 29.5, kScreenWidth, 1)];
    linev.backgroundColor=kD8D8D8;
    [btnview addSubview:linev];
    
    NSArray *arraybtn=@[@"全部",@"待付款",@"交易成功"];
    for (int i=0; i<3; i++) {
        UIButton *btns=[[UIButton alloc]initWithFrame:CGRectMake(i*kScreenWidth/3.0, 0, kScreenWidth/3.0, 30)];
        [btns setTitle:arraybtn[i] forState:0];
        [btns setTitleColor:k333333 forState:0];
        btns.titleLabel.font=FIFTEEN;
        [btns setTitleColor:kDABF66 forState:UIControlStateSelected];
        btns.tag=10+i;
        [btns addTarget:self action:@selector(selectorder:) forControlEvents:UIControlEventTouchUpInside];
        [btnview addSubview:btns];
        
        if ((i==0 && _orderNum==0) || (i==1 && _orderNum==11)|| (i==2 && _orderNum==12)) {
            btns.selected=YES;
            tempbtn=btns;
        }
    }
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,95, kScreenWidth, kScreenHeight-95) style:UITableViewStyleGrouped];
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
    MJRefreshNormalHeader *mjheader=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
         currentPage=1;
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
    
    btnline=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 1)];

    btnline.backgroundColor=kDABF66;
    [btnview addSubview:btnline];
    switch (_orderNum) {
        case 0:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0, 30);
        }
            break;
        case 11:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*3, 30);
        }
            break;
        case 12:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*5, 30);
        }
            break;
            
        default:
            break;
    }
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
    
    noshopView=[[UIView alloc]initWithFrame:CGRectMake(0,95, kScreenWidth, kScreenHeight)];
    [self.view addSubview:noshopView];
    
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [noshopView addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(68, 69)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:95];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"暂无订单"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,186, kScreenWidth, 13)];
    shopLabel.text=@"暂无订单";
    shopLabel.textAlignment=NSTextAlignmentCenter;
    shopLabel.font=THIRTEEN;
    shopLabel.textColor=k888888;
    [noshopView addSubview:shopLabel];
    
    UIButton *btnshop=[UIButton newAutoLayoutView];
    [noshopView addSubview:btnshop];
    [btnshop autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [btnshop autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:221];
    [btnshop autoSetDimensionsToSize:CGSizeMake(180, 30*HH)];
    btnshop.backgroundColor=k000000;
    [btnshop setTitle:@"随便逛逛" forState:0];
    [btnshop addTarget:self action:@selector(btn_lookgoods) forControlEvents:UIControlEventTouchUpInside];
    btnshop.layer.cornerRadius=15*HH;
    btnshop.titleLabel.font=FIFTEEN;
    
    noshopView.hidden=YES;
    
}

#pragma mark 随便逛逛
-(void)btn_lookgoods{
    self.tabBarController.selectedIndex=0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataarray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    MyOrderListModel *list=[[MyOrderListModel alloc]initWithDictionary:dataarray[section] error:nil];
    
    return list.detailList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    MyOrderListModel *list=[[MyOrderListModel alloc]initWithDictionary:dataarray[indexPath.section] error:nil];
    OrderDetailModel *detail=list.detailList[indexPath.row];
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
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 57)];
    UIView *bview=[[UIView alloc]initWithFrame:CGRectMake(0,11, kScreenWidth,46)];
    bview.backgroundColor=[UIColor whiteColor];
    [headview addSubview:bview];
    UILabel *stateLabel=[UILabel newAutoLayoutView];
    [bview addSubview:stateLabel];
    [stateLabel autoSetDimensionsToSize:CGSizeMake(100, 14)];
    [stateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:17];
    [stateLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    stateLabel.font=FOURTEEN;
    stateLabel.textColor=kDABF66;
    stateLabel.textAlignment=NSTextAlignmentRight;
    
    //orderStatus (integer, optional):订单状态--11待支付--12已支付--13待收货--14确认收货--81已取消--82已关闭--60已结束 ,
     MyOrderListModel *list=[[MyOrderListModel alloc]initWithDictionary:dataarray[section] error:nil];

    switch ([list.orderStatus intValue]) {
        case 11:
            stateLabel.text=@"待支付";
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
            stateLabel.text=@"已取消";
            break;
        case 82:
            stateLabel.text=@"已关闭";
            break;
        case 60:
            stateLabel.text=@"已结束";
            break;
        default:
            break;
    }
    
    
    
    return headview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 57;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 33)];
    footview.backgroundColor=[UIColor whiteColor];
    UILabel *totallabel=[UILabel newAutoLayoutView];
    totallabel.font=FOURTEEN;
    [footview addSubview:totallabel];
    [totallabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [totallabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:17];
    [totallabel autoSetDimensionsToSize:CGSizeMake(200, 14)];
    totallabel.textAlignment=NSTextAlignmentRight;
    totallabel.textColor=k333333;
    MyOrderListModel *list=[[MyOrderListModel alloc]initWithDictionary:dataarray[section] error:nil];
    NSInteger goods_num=0;
    for (OrderDetailModel *detail in list.detailList) {
        goods_num+=[detail.goodsQuantity integerValue];
    }
    NSMutableAttributedString *att=[UsefulClass setStr:[NSString stringWithFormat:@"￥%@",[NSString pointtwo:list.totalMoney]] onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"共%ld件商品：￥%@",goods_num,[NSString pointtwo:list.totalMoney]]];
    totallabel.attributedText=att;
    
    
    return footview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 33;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderDetailViewController *detail=[MyOrderDetailViewController new];
    MyOrderListModel *list=[[MyOrderListModel alloc]initWithDictionary:dataarray[indexPath.section] error:nil];
    detail.statenum=list.orderStatus;
    detail.orderID=list.pkId;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)selectorder:(UIButton *)sender{
    if(tempbtn== sender) {
        //上次点击过的按钮，不做处理
        
    } else{
        //本次点击的按钮
        sender.selected=YES;
        //将上次点击过的按钮
        tempbtn.selected=NO;
    }
    tempbtn= sender;
    
    switch (sender.tag) {
        case 10:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0, 30);
            _orderNum=0;
        }
            break;
        case 11:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*3, 30);
            _orderNum=11;
        }
            break;
        case 12:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*5, 30);
            _orderNum=12;
        }
            break;
            
        default:
            break;
    }
    [self initData];
    
}

-(void)ishaveView:(BOOL )isnet{
    if (isnet==YES) {
        noview.hidden=YES;
    }else{
        noview.hidden=NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self initData];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage =nil;
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
