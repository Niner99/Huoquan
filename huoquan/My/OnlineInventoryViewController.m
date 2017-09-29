//
//  OnlineInventoryViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "OnlineInventoryViewController.h"
#import "OnlineInventoryTableViewCell.h"
#import "SaleDetailViewController.h"
#import "SendShopViewController.h"
#import "CloudStorageModel.h"
@interface OnlineInventoryViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tv;
    UIView *btnline;
    UIButton *tempbtn;
    UISearchBar *ksearchBar;
    NSMutableArray *dataAry;
    NSInteger currentPage;
    UIView *noshopView;
}
@end

@implementation OnlineInventoryViewController
static NSString *celltv=@"celltv";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"云库存" color:k000000 fontSize:kTitleFloat];
    [self loadinventory:@"发货至门店" target:self action:@selector(sendShop) position:PPBarItemPosition_right];
    [self creatUI];
     _orderString=@"0";
}

-(void)initData{
    currentPage=1;
    [self showNHUD];
    dataAry=[[NSMutableArray alloc]init];
    NSDictionary *dic=@{@"soldStatus":_orderString,@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCloudStorageList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            currentPage=2;
            [dataAry addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
            
            if (dataAry.count>0) {
                noshopView.hidden=YES;
            }else{
                noshopView.hidden=NO;
            }
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [tv.mj_header endRefreshing];
    }];
}

-(void)loadMoreData{

    [self showNHUD];

    NSDictionary *dic=@{@"soldStatus":_orderString,@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCloudStorageList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            NSArray *tempArray=responseObject[@"data"];
            if (tempArray.count>0) {
                [dataAry addObjectsFromArray:responseObject[@"data"]];
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
    UIView *btnview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
    [self.view addSubview:btnview];
    btnview.backgroundColor=[UIColor whiteColor];
    
    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 29.5, kScreenWidth, 1)];
    linev.backgroundColor=kD8D8D8;
    [btnview addSubview:linev];
    
    NSArray *arraybtn=@[@"全部",@"待销售",@"已销售"];
    for (int i=0; i<3; i++) {
        UIButton *btns=[[UIButton alloc]initWithFrame:CGRectMake(i*kScreenWidth/3.0, 0, kScreenWidth/3.0, 30)];
        [btns setTitle:arraybtn[i] forState:0];
        [btns setTitleColor:k333333 forState:0];
        btns.titleLabel.font=FIFTEEN;
        [btns setTitleColor:kDABF66 forState:UIControlStateSelected];
        btns.tag=10+i;
        [btns addTarget:self action:@selector(selectorder:) forControlEvents:UIControlEventTouchUpInside];
        [btnview addSubview:btns];
        
        if (i==0) {
            btns.selected=YES;
            tempbtn=btns;
        }
    }
    
    UIView *searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 30+64, kScreenWidth, 53)];
    searchView.backgroundColor=kF8F8F8;
    [self.view addSubview:searchView];
    
    ksearchBar=[UISearchBar newAutoLayoutView];
    //   searchBar.keyboardType=UIKeyboardAppearanceDefault;
    ksearchBar.placeholder= @"可以按品牌、商品、货权订单号搜索" ;
    [searchView addSubview:ksearchBar];
    ksearchBar.backgroundColor=kF8F8F8;
    ksearchBar.barTintColor=kF8F8F8;
    ksearchBar.delegate=self;
    ksearchBar.layer.cornerRadius=4;
    [ksearchBar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [ksearchBar autoSetDimensionsToSize:CGSizeMake(277, 43)];
    [ksearchBar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    for (UIView *subView in ksearchBar.subviews) {
        if ([subView isKindOfClass:[UIView class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
            if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                UITextField *textField = [subView.subviews objectAtIndex:0];
            //    textField.backgroundColor =kEEEEEE;

                textField.layer.borderColor=kD8D8D8.CGColor;
                [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"可以按品牌、商品、货权订单号搜索" attributes:@{NSFontAttributeName:THIRTEEN}]];
            }
        }
    }
    
    btnline=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 1)];
    btnline.center=CGPointMake(kScreenWidth/6.0, 30);
    btnline.backgroundColor=kDABF66;
    [btnview addSubview:btnline];
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,94+53, kScreenWidth, kScreenHeight-94-53) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    [tv registerClass:[OnlineInventoryTableViewCell class] forCellReuseIdentifier:celltv];
    tv.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapp=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActiondismiss)];
    [tv addGestureRecognizer:tapp];
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
    
    noshopView=[[UIView alloc]initWithFrame:CGRectMake(0, 95, kScreenWidth, kScreenHeight)];
    [self.view addSubview:noshopView];
    
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [noshopView addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(104, 74)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:88];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"云库存无"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,186, kScreenWidth, 13)];
    shopLabel.text=@"云库存里暂时没有货品哦~";
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

-(void)btn_lookgoods{
    self.tabBarController.selectedIndex=0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OnlineInventoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    CloudStorageModel *cloud=[[CloudStorageModel alloc]initWithDictionary:dataAry[indexPath.section] error:nil];
    cell.iconWidth=@"94";
    cell.goodstitle.text=cloud.goodsName;

    cell.goodsOrder.text=cloud.orderNo;
    cell.goodsPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:cloud.goodsPrice]];
    cell.goodsNum.text=[NSString stringWithFormat:@"×%@",cloud.goodsQuantity];
    
    NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:cloud.sellAttribute];
    
    NSString *specString=@"";
    for (int i=0; i<specArray.count; i++) {
        NSDictionary *specdic=specArray[i];
        NSString *cityStr=[NSString stringWithFormat:@"%@/%@",specdic[@"spec"],specdic[@"value"]];
        specString=[specString stringByAppendingString:[NSString stringWithFormat:@" %@",cityStr]];
        
    }
    cell.goodsNum.text=specString;
    
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,cloud.mainPicture]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [cell.goodsIcon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([_orderString intValue]==0) {
        return 181;
    }if ([_orderString intValue]==1) {
        return 160;
    }
    return 205;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 205)];
    
    UIView *firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    firstView.backgroundColor=[UIColor whiteColor];
    [backView addSubview:firstView];
    
    UILabel *numlabel=[UILabel newAutoLayoutView];
    [firstView addSubview:numlabel];
    [numlabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [numlabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [numlabel autoSetDimensionsToSize:CGSizeMake(100, 13)];
    numlabel.textColor=k888888;
    numlabel.font=THIRTEEN;
    numlabel.text=@"商品总数";
    
    CloudStorageModel *cloud=[[CloudStorageModel alloc]initWithDictionary:dataAry[section] error:nil];
    
    UILabel *goodsnum=[UILabel newAutoLayoutView];
    [firstView addSubview:goodsnum];
    [goodsnum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [goodsnum autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [goodsnum autoSetDimensionsToSize:CGSizeMake(100, 13)];
    goodsnum.textColor=k010101;
    goodsnum.font=THIRTEEN;
    goodsnum.textAlignment=NSTextAlignmentRight;
    goodsnum.text=[NSString stringWithFormat:@"×%@",cloud.goodsQuantity];
    
    
    UIView *secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 45)];
    secondView.backgroundColor=[UIColor whiteColor];
    [backView addSubview:secondView];
    
    UILabel *sendlabel=[UILabel newAutoLayoutView];
    [secondView addSubview:sendlabel];
    [sendlabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [sendlabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [sendlabel autoSetDimensionsToSize:CGSizeMake(100, 13)];
    sendlabel.textColor=k888888;
    sendlabel.font=THIRTEEN;
    sendlabel.text=@"发货至门店数";
    
    UILabel *sendnum=[UILabel newAutoLayoutView];
    [secondView addSubview:sendnum];
    [sendnum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [sendnum autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [sendnum autoSetDimensionsToSize:CGSizeMake(100, 13)];
    sendnum.textColor=kDABF66;
    sendnum.font=THIRTEEN;
    sendnum.textAlignment=NSTextAlignmentRight;
    sendnum.text=[NSString stringWithFormat:@"×%@",cloud.deliveredQuantity];
    
    UIView *thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, 78)];
    thirdView.backgroundColor=[UIColor whiteColor];
    [backView addSubview:thirdView];
    
    UILabel *leftlabel=[UILabel newAutoLayoutView];
    [thirdView addSubview:leftlabel];
    [leftlabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [leftlabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [leftlabel autoSetDimensionsToSize:CGSizeMake(100, 13)];
    leftlabel.textColor=k333333;
    leftlabel.font=THIRTEEN;
    leftlabel.text=@"云库存剩余数";
    
    UILabel *leftnum=[UILabel newAutoLayoutView];
    [thirdView addSubview:leftnum];
    [leftnum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [leftnum autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [leftnum autoSetDimensionsToSize:CGSizeMake(100, 13)];
    leftnum.textColor=k010101;
    leftnum.font=THIRTEEN;
    leftnum.textAlignment=NSTextAlignmentRight;
    NSInteger leftOrderQuantity=[cloud.remainingQuantity integerValue]+[cloud.sellQuantity integerValue];
    leftnum.text=[NSString stringWithFormat:@"×%ld",leftOrderQuantity];
    
    UILabel *haveLabel=[UILabel newAutoLayoutView];
    [thirdView addSubview:haveLabel];
    [haveLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:94];
    [haveLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:33];
    [haveLabel autoSetDimensionsToSize:CGSizeMake(100, 12)];
    haveLabel.textColor=k333333;
    haveLabel.font=TWELVE;
    haveLabel.text=@"已销售数";
    
    UILabel *havenum=[UILabel newAutoLayoutView];
    [thirdView addSubview:havenum];
    [havenum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [havenum autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:33];
    [havenum autoSetDimensionsToSize:CGSizeMake(100, 12)];
    havenum.textColor=k010101;
    havenum.font=TWELVE;
    havenum.textAlignment=NSTextAlignmentRight;
    havenum.text=[NSString stringWithFormat:@"×%@",cloud.sellQuantity];
    
    if ([_orderString intValue]==0) {
        thirdView.frame=CGRectMake(0, 90, kScreenWidth, 78);
        
        UILabel *readyLabel=[UILabel newAutoLayoutView];
        [thirdView addSubview:readyLabel];
        [readyLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:94];
        [readyLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:53];
        [readyLabel autoSetDimensionsToSize:CGSizeMake(100, 12)];
        readyLabel.textColor=k333333;
        readyLabel.font=TWELVE;
        readyLabel.text=@"待销售数";
        
        UILabel *readynum=[UILabel newAutoLayoutView];
        [thirdView addSubview:readynum];
        [readynum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [readynum autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:53];
        [readynum autoSetDimensionsToSize:CGSizeMake(100, 12)];
        readynum.textColor=k010101;
        readynum.font=TWELVE;
        readynum.textAlignment=NSTextAlignmentRight;
        readynum.text=[NSString stringWithFormat:@"×%@",cloud.remainingQuantity];
        
        UIImageView *saleout=[[UIImageView alloc]initWithFrame:CGRectMake(171, 0, 65, 57)];
        saleout.image=[UIImage imageNamed:@"已售罄"];
        [backView addSubview:saleout];
        if ([cloud.remainingQuantity integerValue]==0) {
            saleout.hidden=NO;
        }else{
            saleout.hidden=YES;
        }
    }if ([_orderString intValue]==1) {
        thirdView.frame=CGRectMake(0, 90, kScreenWidth, 58);
        haveLabel.text=@"待销售数";
        havenum.text=[NSString stringWithFormat:@"×%@",cloud.remainingQuantity];
        

    }if ([_orderString intValue]==2) {
        thirdView.frame=CGRectMake(0, 90, kScreenWidth, 103);
        
        UIButton *detaibtn=[UIButton newAutoLayoutView];
        [thirdView addSubview:detaibtn];
        [detaibtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [detaibtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:58];
        [detaibtn autoSetDimensionsToSize:CGSizeMake(73, 30)];
        detaibtn.layer.cornerRadius=4;
        [detaibtn setTitle:@"销售明细" forState:0];
        detaibtn.backgroundColor=kDABF66;
        detaibtn.titleLabel.font=TWELVE;
        [detaibtn addTarget:self action:@selector(saleDetail:) forControlEvents:UIControlEventTouchUpInside];
        detaibtn.tag=section+10;
        
        UIImageView *saleout=[[UIImageView alloc]initWithFrame:CGRectMake(171, 0, 65, 57)];
        saleout.image=[UIImage imageNamed:@"已售罄"];
        [backView addSubview:saleout];
        if ([cloud.remainingQuantity integerValue]==0) {
            saleout.hidden=NO;
        }else{
            saleout.hidden=YES;
        }

    }
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 1)];
    line1.backgroundColor=kD8D8D8;
    [backView addSubview:line1];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, 1)];
    line2.backgroundColor=kD8D8D8;
    [backView addSubview:line2];
    

    
    return backView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

#pragma mark 搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    dataAry=[[NSMutableArray alloc]init];
    NSDictionary *dic=@{@"soldStatus":_orderString,@"page":@"1",@"rows":@"20",@"keyword":searchBar.text};
    
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCloudStorageList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]==200) {
            
            [dataAry addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
}




#pragma mark 发货至门店
-(void)sendShop{
    SendShopViewController *sendshop=[SendShopViewController new];
    [self.navigationController pushViewController:sendshop animated:YES];
}

#pragma mark 销售明细
-(void)saleDetail:(UIButton *)sender{
    CloudStorageModel *cloud=[[CloudStorageModel alloc]initWithDictionary:dataAry[sender.tag-10] error:nil];
    SaleDetailViewController *sale=[SaleDetailViewController new];
    sale.orderDetailID=cloud.pkId;
    FLog(@"%@",cloud.pkId);
    [self.navigationController pushViewController:sale animated:YES];
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
            _orderString=@"0";
        }
            break;
        case 11:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*3, 30);
            _orderString=@"1";
        }
            break;
        case 12:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*5, 30);
            _orderString=@"2";
        }
            break;
            
        default:
            break;
    }
    [self initData];
    
}

-(void)viewWillAppear:(BOOL)animated{
   self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self initData];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage =nil;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [ksearchBar resignFirstResponder];
}

-(void)tapActiondismiss{
    [ksearchBar resignFirstResponder];
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
