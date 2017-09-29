//
//  GoodsDetailViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/22.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "ShopView.h"
#import "GoodsDetailModel.h"
#import "MakeSureViewController.h"
@interface GoodsDetailViewController ()<ShopGoodsDelegate>
{
    UILabel *goodsnumLabel;
    GoodsDetailModel *detail;
    NSNumber *shopcar_num;
    NSInteger isShop_car;
    UIButton *buygoodsbtn;
    UIButton *addshopbtn;
    UIView *verline;
}
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"商品详情页" color:k000000 fontSize:18];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"顶部购物车"] forState:0];
    [btn addTarget:self action:@selector(btn_shop) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    [self loadItemWithCustomView:btn position:PPBarItemPosition_right];

    
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    NSDictionary *dicGoods=@{@"goodsId":_goodsID};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kGoodsDetail] parameters:dicGoods success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            
            detail=[[GoodsDetailModel alloc]initWithDictionary:responseObject[@"data"] error:nil];

            [self updateAllValues];
        }
        
    
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
    
}



-(void)updateAllValues{
    SkuModel *sku=detail.sku[0];
    
    if ([sku.specStock intValue]>0  && [detail.goodsStatus intValue]==1) {
        addshopbtn.backgroundColor=k000000;
        buygoodsbtn.backgroundColor=kDABF66;
        goodsnumLabel.text=[NSString stringWithFormat:@"剩余货权数：%@件",sku.specStock];
        goodsnumLabel.textColor=k888888;
        verline.hidden=YES;
    }else{
        addshopbtn.backgroundColor=kB8B8B8;
        buygoodsbtn.backgroundColor=kB8B8B8;
        goodsnumLabel.textColor=kDABF66;
        verline.hidden=NO;
        if ([detail.goodsStatus intValue]==1) {
            goodsnumLabel.text=@"已售罄";
        }
        if ([detail.goodsStatus intValue]==2) {
            goodsnumLabel.text=@"等待审核";
        }
        if ([detail.goodsStatus intValue]==3) {
            goodsnumLabel.text=@"下架商品";
        }
        if ([detail.goodsStatus intValue]==4) {
            goodsnumLabel.text=@"审核失败";
        }
        if ([detail.goodsStatus intValue]==5) {
            goodsnumLabel.text=@"违规下架";
        }
        if ([detail.goodsStatus intValue]==6) {
            goodsnumLabel.text=@"等待编辑";
        }
    }
    
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kShopCarAmount] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]==200) {
            shopcar_num=responseObject[@"data"];
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"顶部购物车"] forState:0];
            [btn addTarget:self action:@selector(btn_shop) forControlEvents:UIControlEventTouchUpInside];
            [btn sizeToFit];
            if ([shopcar_num intValue]>0) {
                UILabel *dainum=[[UILabel alloc]initWithFrame:CGRectMake(13, 0,12, 12)];
                dainum.text=[NSString stringWithFormat:@"%@",shopcar_num];
                dainum.backgroundColor=kDABF66;
                dainum.layer.cornerRadius=6;
                dainum.font=TENFONT;
                dainum.textColor=[UIColor whiteColor];
                dainum.layer.masksToBounds=YES;
                dainum.textAlignment=NSTextAlignmentCenter;
                [btn addSubview:dainum];
            }
            [self loadItemWithCustomView:btn position:PPBarItemPosition_right];
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
   
}




-(void)creatUI{

    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,64,kScreenWidth, kScreenHeight-64-49)];
    [webView scalesPageToFit];
    [self.view addSubview:webView];
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    NSString *caURLStr=[NSString stringWithFormat:@"%@%@",kGoodsDetailHtml,_goodsID];
    
    
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)caURLStr]];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    
    
    if (!(htmlString ==nil || [htmlString isEqualToString:@""])) {
        
        [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:caURLStr]];
        
    }else{
        
        NSURL* url = [NSURL URLWithString:caURLStr];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [webView loadRequest:request];
        
        [self writeToCache:caURLStr];
        
    }

    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    goodsnumLabel=[UILabel newAutoLayoutView];
    [bottomView addSubview:goodsnumLabel];
    [goodsnumLabel autoSetDimensionsToSize:CGSizeMake(200, 12)];
    [goodsnumLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [goodsnumLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    goodsnumLabel.textColor=k888888;
    goodsnumLabel.font=TWELVE;
    
    
    buygoodsbtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-99, 0, 99, 49)];
    buygoodsbtn.backgroundColor=kDABF66;
    [buygoodsbtn setTitle:@"立即下单" forState:0];
    buygoodsbtn.titleLabel.font=FIFTEEN;
    [bottomView addSubview:buygoodsbtn];
    [buygoodsbtn addTarget:self action:@selector(nowbuyOrder) forControlEvents:UIControlEventTouchUpInside];
    
    addshopbtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-99-100, 0, 100, 49)];
    [addshopbtn setTitle:@"加入采购单" forState:0];
    addshopbtn.titleLabel.font=FIFTEEN;
    [bottomView addSubview:addshopbtn];
    addshopbtn.backgroundColor=k000000;
    
    [addshopbtn addTarget:self action:@selector(btnaddshop) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor=kD8D8D8;
    [bottomView addSubview:line];
    
    verline=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-99, 0, 1, 49)];
    verline.backgroundColor=[UIColor whiteColor];
    [bottomView addSubview:verline];
    verline.hidden=YES;

    
}



#pragma mark 加入采购单
-(void)btnaddshop{
    SkuModel *sku=detail.sku[0];
    
    if ([sku.specStock intValue]>0 && [detail.goodsStatus intValue]==1) {
        SkuModel *sku=detail.sku[0];
        ShopView *shopv=[[ShopView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 298) model:sku detail:detail];
        shopv.goodsdelegate=self;
        isShop_car=1;
        
        
    }else{
        [self displayNHUDTitle:@"该商品已下架"];
    }

}

-(void)choosegoods:(NSInteger)goodsnum specId:(NSString *)specId{
    [self showNHUD];
    NSDictionary *dicc=@{@"specId":specId,@"amount":[NSString stringWithFormat:@"%ld",goodsnum]};
    
    if (isShop_car==1) {
        
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kAddShopCar] parameters:dicc success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            if ([responseObject[@"code"] intValue]==200) {
                
                [self displayNHUDTitle:@"加入采购单成功"];
                
                [self updateAllValues];
            }else{
                NSString *info=responseObject[@"info"];
                [self displayNHUDTitle:info];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];
    }else{
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kShopCarBuyNow] parameters:dicc success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            if ([responseObject[@"code"] intValue]==200) {

                MakeSureViewController *make=[MakeSureViewController new];
       
                make.cartid=responseObject[@"data"];
                [self.navigationController pushViewController:make animated:YES];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];

    }
}






#pragma mark 前往购物车
-(void)btn_shop{
    self.tabBarController.selectedIndex=1;
}

#pragma mark 立即下单
-(void)nowbuyOrder{
    
    SkuModel *sku=detail.sku[0];
    if ([sku.specStock intValue]>0 && [detail.goodsStatus intValue]==1) {
        
        ShopView *shopv=[[ShopView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 298) model:sku detail:detail];
        shopv.goodsdelegate=self;
        isShop_car=0;
    }else{

        [self displayNHUDTitle:@"该商品已下架"];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:kfreturnHome object:nil];
    [self initData];
}


- (void)InfoNotificationAction:(NSNotification *)notification{

    [self.navigationController popToRootViewControllerAnimated:NO];
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
