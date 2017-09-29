//
//  MakeSureViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/21.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MakeSureViewController.h"
#import "MakeSureTableViewCell.h"
#import "MAkeResultViewController.h"
#import "ShopCarModel.h"
@interface MakeSureViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    UILabel *numLabel;
    UILabel *totalLabel;
    NSMutableArray *dataArray;
    NoNetView *noview;
    UIButton *selectbtn;
    NSString *zijinnum;
    ShopWalletCarModel *shopwa;
    CGFloat goods_price;
    JCAlertView *jcview;
}
@end

@implementation MakeSureViewController
static NSString *cellshop=@"shopcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"确认订单" color:k000000 fontSize:kTitleFloat];
    [self creatUI];
    
}


-(void)initData{
    
        //从购物车来
        [self showNHUD];
        NSDictionary *dic=@{@"cartIds":_cartid};
        dataArray=[[NSMutableArray alloc]init];
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kShopWalletOrderbyid] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            [self ishaveView:YES];
            if ([responseObject[@"code"] intValue]==200) {
                
                shopwa=[[ShopWalletCarModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
                
                [dataArray addObjectsFromArray:shopwa.goodsCart];
                [tv reloadData];
                [self update_totalPrice];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
            [self ishaveView:NO];
        }];


}





-(void)creatUI{
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64-50) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    tv.separatorColor=[UIColor clearColor];
    [tv registerClass:[MakeSureTableViewCell class] forCellReuseIdentifier:cellshop];
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
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MakeSureTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellshop];
    ShopCarModel *shop=dataArray[indexPath.section];
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,shop.mainPicture]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [cell.goodsicon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
    cell.goodsname.text=shop.goodsName;
//    cell.goodscolor.text=@"颜色：红色";
//    cell.goodsStand.text=@"件数：31头";
    cell.goodsnum.text=[NSString stringWithFormat:@"×%@",shop.amount];
    cell.singlePrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:shop.goodsPrice]];
    cell.allPrice.text=[NSString stringWithFormat:@"￥%.2f",[shop.amount floatValue]*[shop.goodsPrice floatValue]];
    NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:shop.specName];
    
    NSString *specString=@"";
    for (int i=0; i<specArray.count; i++) {
        NSDictionary *specdic=specArray[i];
        NSString *cityStr=[NSString stringWithFormat:@"%@/%@",specdic[@"spec"],specdic[@"value"]];
        specString=[specString stringByAppendingString:[NSString stringWithFormat:@" %@",cityStr]];
        
    }
    cell.goodscolor.text=specString;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UILabel *headtitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 23)];
        headtitle.textColor=k888888;
        headtitle.font=TWELVE;
        headtitle.text=@"  货权商品购买清单";
        return headtitle;
    }else{
        UIView *headv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        return headv;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==dataArray.count-1) {
        return 65;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==dataArray.count-1) {
        UIView *foo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
        
        UIView *footerview=[[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 55)];
        footerview.backgroundColor=[UIColor whiteColor];
        [foo addSubview:footerview];
        
        if (!selectbtn) {
            selectbtn=[UIButton newAutoLayoutView];
            [footerview addSubview:selectbtn];
            [selectbtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [selectbtn autoSetDimensionsToSize:CGSizeMake(15, 15)];
            [selectbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
            [selectbtn setImage:[UIImage imageNamed:@"资金池未勾选"] forState:0];
            [selectbtn setImage:[UIImage imageNamed:@"资金池勾选"] forState:UIControlStateSelected];
            [selectbtn addTarget:self action:@selector(isselectzijin) forControlEvents:UIControlEventTouchUpInside];
        }

        
        UILabel *zijinlabel=[UILabel newAutoLayoutView];
        [footerview addSubview:zijinlabel];
        [zijinlabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:selectbtn withOffset:10];
        [zijinlabel autoSetDimensionsToSize:CGSizeMake(200, 13)];
        [zijinlabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        zijinlabel.font=THIRTEEN;
        zijinlabel.textColor=k333333;
        zijinnum=shopwa.balance;
        NSMutableAttributedString *tempstr=[UsefulClass setStr:[NSString stringWithFormat:@"%.2f",[zijinnum floatValue]] onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"资金池金额可抵用%.2f元",[zijinnum floatValue]]];
        [zijinlabel setAttributedText:tempstr];
        
        return foo;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 23;
    }else{
        return 10;
    }
}

-(void)setbottomView{
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor=[UIColor whiteColor];
    
    numLabel=[UILabel newAutoLayoutView];
    [bottomView addSubview:numLabel];
    [numLabel autoSetDimensionsToSize:CGSizeMake(50, 12)];
    [numLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    [numLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    numLabel.textColor=k888888;
    numLabel.font=TWELVE;

    
    totalLabel=[UILabel newAutoLayoutView];
    [bottomView addSubview:totalLabel];
    [totalLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [totalLabel autoSetDimensionsToSize:CGSizeMake(200, 12)];
    [totalLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:83];
    totalLabel.font=TWELVE;
    
  //  NSMutableAttributedString *str2=[UsefulClass setStr:@"￥2080.00" onlyFont:FIFTEEN maintext:@"总价 ￥2080.00"];

  //  totalLabel.attributedText=str3;
    
    UIButton *makeOrder=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-99, 0, 99, 50)];
    [makeOrder setTitle:@"确认下单" forState:0];
    makeOrder.titleLabel.font=FIFTEEN;
    makeOrder.backgroundColor=k000000;
    [bottomView addSubview:makeOrder];
    [makeOrder addTarget:self action:@selector(orderResult) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor=kD8D8D8;
    [bottomView addSubview:line];
    
    
    
}

#pragma mark 是否选择资金池
-(void)isselectzijin{
    selectbtn.selected=!selectbtn.selected;
 //   [tv reloadData];
    [self update_totalPrice];
}


-(void)update_totalPrice{
    NSInteger goods_count=0;
    goods_price=0.00;
    for (int i=0; i<dataArray.count; i++) {
        ShopCarModel *ss=dataArray[i];
        goods_count+=[ss.amount integerValue];
        goods_price+=[ss.goodsPrice floatValue]*[ss.amount integerValue];
    }
    if (selectbtn.selected==YES) {
        goods_price=goods_price-[zijinnum floatValue];
        if (goods_price<0) {
            goods_price=0.00;
        }
    }
    
    NSMutableAttributedString *str1=[UsefulClass setStr:[NSString stringWithFormat:@"%ld",goods_count] onlyColor:k010101 maintext:[NSString stringWithFormat:@"共%ld件",goods_count]];
    numLabel.attributedText=str1;
    
    NSMutableAttributedString *str3=[UsefulClass setStr:[NSString stringWithFormat:@"￥%.2f",goods_price] colorWithFont:FIFTEEN textColor:kDABF66 maintext:[NSString stringWithFormat:@"总价 ￥%.2f",goods_price]];
    totalLabel.attributedText=str3;
}



#pragma mark 下单
-(void)orderResult{
    NSString *deduction=@"";
    if (selectbtn.selected==YES) {
       deduction=@"1";
    }else{
        deduction=@"2";
    }
    if (selectbtn.selected==YES && goods_price>0) {
        PopWindowView *popv=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singlebtn:@"确定" singletitle:@"您好，您的资金池余额不足，为了不影响您抢购货权，请及时充值。"];
        [popv.btnsing addTarget:self action:@selector(dismissWallet) forControlEvents:UIControlEventTouchUpInside];
        jcview=nil;
        jcview=[[JCAlertView alloc]initWithCustomView:popv dismissWhenTouchedBackground:NO];
        [jcview show];
        
        
    }else{
        NSDictionary *dic=@{@"cartIds":_cartid,@"source":@"2",@"deductionFlag":deduction};
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kShopToOrder] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            MAkeResultViewController *mak=[MAkeResultViewController new];
            
            if ([responseObject[@"code"] intValue]==200) {
                mak.isSuccess=YES;
                mak.Ordercode=responseObject[@"data"];
            }else{
                mak.isSuccess=NO;
                mak.errorinfo=responseObject[@"info"];
            }
            [self.navigationController pushViewController:mak animated:YES];
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            
        }];
    }

}

-(void)dismissWallet{
    [jcview dismissWithCompletion:^{
        jcview=nil;
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
