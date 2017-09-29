//
//  ShopViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/18.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopTableViewCell.h"
#import "NouseTableViewCell.h"
#import "ShopBottomView.h"
#import "MakeSureViewController.h"
#import "ShopCarModel.h"

@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource,ShopcarCellDelegate>
{
    UITableView *tv;
    ShopBottomView *bottomview;
    BOOL editall;
    NSMutableArray *dataArray;
    NSMutableArray *shopArray;
    NSMutableArray *lostArray;
    JCAlertView *jcView;
    NSDictionary *dic_remove;
    NSDictionary *lost_remove;
    UIView *noshopView;
    NoNetView *noview;
}
@end

@implementation ShopViewController
static NSString *cellshop=@"shopcell";
static NSString *cellnouse=@"cellnouse";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"采购单" color:k000000 fontSize:kTitleFloat];
    [self loadItemWithTitle:@"编辑" font:THIRTEEN target:self action:@selector(editGoods) position:PPBarItemPosition_right];
    
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    dataArray=[[NSMutableArray alloc]init];
    shopArray=[[NSMutableArray alloc]init];
    lostArray=[[NSMutableArray alloc]init];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kShopCarList] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self NhideHUD:YES];
        [self ishaveView:YES];
        if ([responseObject[@"code"] intValue]==200) {
            [dataArray addObjectsFromArray:responseObject[@"data"]];
            
            if (dataArray.count>0) {
                bottomview.hidden=NO;
                noshopView.hidden=YES;
            }else{
                bottomview.hidden=YES;
                noshopView.hidden=NO;
            }

            for (int i=0; i<dataArray.count; i++) {
                ShopCarModel *car=[[ShopCarModel alloc]initWithDictionary:dataArray[i] error:nil];
                if ([car.goodsStatus intValue]==1) {
                    [shopArray addObject:car];
                }else{
                    [lostArray addObject:car];
                }
            }
            bottomview.allselect.selected=NO;
            [tv reloadData];
            [self total_pricecount];
        }
        if ([responseObject[@"code"] intValue]==401) {
            
            kRemoveStandardUserDefaults(kTokenHuoquan);
            LoginViewController *lauchvc=[LoginViewController new];
            BaseNC *nc=[[BaseNC alloc]initWithRootViewController:lauchvc];
            self.view.window.rootViewController=nc;
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
    }];
}


-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64-44-46) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tv];
    [tv registerClass:[ShopTableViewCell class] forCellReuseIdentifier:cellshop];
    [tv registerClass:[NouseTableViewCell class] forCellReuseIdentifier:cellnouse];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    bottomview=[[ShopBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight-46-50, kScreenWidth, 46)];
    [self.view addSubview:bottomview];
    bottomview.numlabel.text=@"共0件";
    NSMutableAttributedString *str=[UsefulClass setStr:@"￥0.00" onlyColor:kDABF66 maintext:@"总计：￥0.00"];
    bottomview.priceLabel.attributedText=str;
    [bottomview.allselect addTarget:self action:@selector(allselectbtn) forControlEvents:UIControlEventTouchUpInside];
    [bottomview.btnbottom addTarget:self action:@selector(countPrice) forControlEvents:UIControlEventTouchUpInside];
    
    
    noshopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:noshopView];
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [noshopView addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(78, 73)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:183];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"暂无购物车图标"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 279, kScreenWidth, 13)];
    shopLabel.text=@"购物车里什么也没有~";
    shopLabel.textAlignment=NSTextAlignmentCenter;
    shopLabel.font=THIRTEEN;
    shopLabel.textColor=k888888;
    [noshopView addSubview:shopLabel];
    
    UIButton *btnshop=[UIButton newAutoLayoutView];
    [noshopView addSubview:btnshop];
    [btnshop autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [btnshop autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:315];
    [btnshop autoSetDimensionsToSize:CGSizeMake(180, 30*HH)];
    btnshop.backgroundColor=k000000;
    [btnshop setTitle:@"随便逛逛" forState:0];
    [btnshop addTarget:self action:@selector(btn_lookgoods) forControlEvents:UIControlEventTouchUpInside];
    btnshop.layer.cornerRadius=15*HH;
    btnshop.titleLabel.font=FIFTEEN;
    
    noshopView.hidden=YES;
    
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
}

#pragma mark 随便逛逛
-(void)btn_lookgoods{
    self.tabBarController.selectedIndex=0;
    NSNotification *notification =[NSNotification notificationWithName:kfreturnHome object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (lostArray.count>0) {
        return 2;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (lostArray.count>0) {
        //有失效商品
        if (section==0) {
            return shopArray.count;
        }else{
            return lostArray.count;
        }
    }else{
        return shopArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        ShopTableViewCell *shopcell=[tableView dequeueReusableCellWithIdentifier:cellshop];
        shopcell.shopcardelegate=self;
        ShopCarModel *shop=shopArray[indexPath.row];
        shopcell.countsnum=[shop.amount intValue];
        shopcell.min_num=[shop.minPurchaseQuantity intValue];
        shopcell.titleLabel.text=shop.goodsName;
        shopcell.max_stock=[shop.specStock integerValue];
        shopcell.goodsPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:shop.goodsPrice]];
        
        NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,shop.mainPicture]];
        
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                     forHTTPHeaderField:@"Accept"];
        [shopcell.goodsicon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
        
        NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:shop.specName];
        
        NSString *specString=@"";
        for (int i=0; i<specArray.count; i++) {
            NSDictionary *specdic=specArray[i];
            NSString *cityStr=[NSString stringWithFormat:@"%@ %@",specdic[@"spec"],specdic[@"value"]];
            specString=[specString stringByAppendingString:cityStr];
            
        }
        shopcell.goodsColor.text=specString;

        if ([shop.isSelect intValue]==1) {
            shopcell.checkicon.selected=YES;
        }else{
            shopcell.checkicon.selected=NO;
        }
        
        return shopcell;
    }if (indexPath.section==1) {
        NouseTableViewCell *nocell=[tableView dequeueReusableCellWithIdentifier:cellnouse];
        ShopCarModel *shop=lostArray[indexPath.row];
        nocell.titleLabel.text=shop.goodsName;
        nocell.goodsPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:shop.goodsPrice]];
        nocell.goodsColor.text=shop.specName;
        NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,shop.mainPicture]];
        
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                     forHTTPHeaderField:@"Accept"];
        [nocell.goodsicon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];

        NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:shop.specName];
        
        NSString *specString=@"";
        for (int i=0; i<specArray.count; i++) {
            NSDictionary *specdic=specArray[i];
            NSString *cityStr=[NSString stringWithFormat:@"%@%@",specdic[@"spec"],specdic[@"value"]];
            specString=[specString stringByAppendingString:cityStr];
            
        }
        nocell.goodsColor.text=specString;
        return nocell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return nil;
    }else{
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth, 43)];
        UILabel *lostGoods=[UILabel newAutoLayoutView];
        [headView addSubview:lostGoods];
        lostGoods.text=@"失效货权商品";
        [lostGoods autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [lostGoods autoSetDimensionsToSize:CGSizeMake(120, 13)];
        [lostGoods autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        lostGoods.font=THIRTEEN;
        lostGoods.textColor=k333333;
        
        UIButton *clearbtn=[UIButton newAutoLayoutView];
        [headView addSubview:clearbtn];
        [clearbtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [clearbtn autoSetDimensionsToSize:CGSizeMake(30, 13)];
        [clearbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [clearbtn setTitle:@"清空" forState:0];
        [clearbtn setTitleColor:k333333 forState:0];
        clearbtn.titleLabel.font=THIRTEEN;
        [clearbtn addTarget:self action:@selector(clear_shopgoods) forControlEvents:UIControlEventTouchUpInside];
        
        return headView;
    }
}

#pragma mark 清空失效商品
-(void)clear_shopgoods{
    
    PopWindowView *pop=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singleTitle:@"确定要清空失效商品吗?" leftBtn:@"取消" rightBtn:@"确定"];
    [pop.leftBtn addTarget:self action:@selector(dismiss_alert) forControlEvents:UIControlEventTouchUpInside];
    [pop.rightBtn addTarget:self action:@selector(remove_lostgoods) forControlEvents:UIControlEventTouchUpInside];
    jcView=nil;
    jcView=[[JCAlertView alloc]initWithCustomView:pop dismissWhenTouchedBackground:NO];
    [jcView show];


    
}


-(void)remove_lostgoods{
    
    [jcView dismissWithCompletion:^{
        NSString *caridString=@"";
        NSInteger car_count=0;
        for (ShopCarModel *car in lostArray) {
            
            if (car_count==0) {
                caridString=car.cartId;
            }else{
                caridString=[caridString stringByAppendingString:[NSString stringWithFormat:@",%@",car.cartId]];
            }
            car_count++;
            
        }
        lost_remove=@{@"cartIds":caridString};
        [self showNHUD];
        
        //删除购物车商品
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kShopRemove] parameters:lost_remove success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            if ([responseObject[@"code"] intValue]==200) {
                [self initData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];
    }];

}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }else{
        return 43;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (lostArray.count>0 && section==0) {
        UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 6)];
        footview.backgroundColor=kF1F1F1;
        return footview;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (lostArray.count>0 && section==0) {
        return 6;
    }else{
        return 0.1;
    }
}

#pragma mark 选择单个商品
-(void)productSelected:(ShopTableViewCell *)cell isSelected:(BOOL)choosed{
    NSIndexPath *indexPath = [tv indexPathForCell:cell];
    ShopCarModel *car=shopArray[indexPath.row];
    if ([car.isSelect intValue]==1) {
        car.isSelect=@"0";
    }else{
        car.isSelect=@"1";
    }
    
    __block NSInteger count=0;
    [shopArray enumerateObjectsUsingBlock:^(ShopCarModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.isSelect intValue]==1) {
            count++;
        }
    }];
    
    if (count==shopArray.count) {
        [self is_allselect:YES];
    }else{
        [self is_allselect:NO];
    }
    
    [tv reloadData];
    [self total_pricecount];

}

#pragma mark 增加或减少购物车商品
-(void)countgoodsnum:(NSInteger)goodsnum cell:(ShopTableViewCell *)cell{
    NSIndexPath *indexPath = [tv indexPathForCell:cell];
    ShopCarModel *car=shopArray[indexPath.row];
    
    NSDictionary *dic=@{@"cartId":car.cartId,@"amount":[NSString stringWithFormat:@"%ld",goodsnum]};
    [self showNHUD];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kEditShopCarAmount] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            [self initData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];

//    car.amount=[NSString stringWithFormat:@"%ld",goodsnum];
//    [tv reloadData];
//    [self total_pricecount];
}

#pragma mark 全选
-(void)allselectbtn{
    bottomview.allselect.selected=!bottomview.allselect.selected;
    for (ShopCarModel *car in shopArray) {
        if (bottomview.allselect.selected==YES) {
            car.isSelect=@"1";
        }else{
            car.isSelect=@"0";
        }
    }
    [tv reloadData];
    [self total_pricecount];
    
}

#pragma mark 结算
-(void)countPrice{
    NSString *caridString=@"";
    NSInteger car_count=0;
    for (ShopCarModel *car in shopArray) {
        if ([car.isSelect intValue]==1) {
            if (car_count==0) {
                caridString=car.cartId;
            }else{
                caridString=[caridString stringByAppendingString:[NSString stringWithFormat:@",%@",car.cartId]];
            }
            car_count++;
        }
    }
    dic_remove=@{@"cartIds":caridString};
    
    if (editall) {
        
        if (caridString.length>0) {
            PopWindowView *pop=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singleTitle:@"确定要删除选中商品吗?" leftBtn:@"取消" rightBtn:@"确定"];
            [pop.leftBtn addTarget:self action:@selector(dismiss_alert) forControlEvents:UIControlEventTouchUpInside];
            [pop.rightBtn addTarget:self action:@selector(dismiss_remove) forControlEvents:UIControlEventTouchUpInside];
            jcView=nil;
            jcView=[[JCAlertView alloc]initWithCustomView:pop dismissWhenTouchedBackground:NO];
            [jcView show];
        }else{
            [self displayNHUDTitle:@"您还没有选择要删除的商品"];
        }
    
    }else{
        //结算
        
        if (caridString.length>0) {
            MakeSureViewController *makesure=[MakeSureViewController new];
            makesure.hidesBottomBarWhenPushed=YES;
            makesure.cartid=caridString;
            [self.navigationController pushViewController:makesure animated:YES];
        }else{
            [self displayNHUDTitle:@"您还没有选中结算商品"];
        }

    }
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
        
        //删除购物车商品
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kShopRemove] parameters:dic_remove success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            if ([responseObject[@"code"] intValue]==200) {
                [self initData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];
    }];
}








#pragma mark 编辑
-(void)editGoods{
    editall=!editall;
    
    if (editall) {
        //编辑  删除状态
       [self loadItemWithTitle:@"完成" font:THIRTEEN target:self action:@selector(editGoods) position:PPBarItemPosition_right];
        [bottomview.btnbottom setTitle:@"删除" forState:0];
        bottomview.priceLabel.hidden=YES;
        bottomview.numlabel.hidden=YES;
        
    }else{
        [self loadItemWithTitle:@"编辑" font:THIRTEEN target:self action:@selector(editGoods) position:PPBarItemPosition_right];
        [bottomview.btnbottom setTitle:@"结算" forState:0];
        bottomview.priceLabel.hidden=NO;
        bottomview.numlabel.hidden=NO;
    }
 
}

#pragma mark 是否全选
-(void)is_allselect:(BOOL)selectbool{
    if (selectbool==YES) {
        bottomview.allselect.selected=YES;
    }else{
        bottomview.allselect.selected=NO;
    }
}

#pragma mark 计算商品总价
-(void)total_pricecount{
    CGFloat totalp=0.00;
    NSInteger count=0;
    for (ShopCarModel *car in shopArray) {
        if ([car.isSelect intValue]==1) {

            totalp+=[car.amount integerValue]*[car.goodsPrice floatValue];
            count+=[car.amount integerValue];

        }
    }
    
    bottomview.numlabel.text=[NSString stringWithFormat:@"共%ld件",count];
    NSMutableAttributedString *str=[UsefulClass setStr:[NSString stringWithFormat:@"￥%.2f",totalp] onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"总计：￥%.2f",totalp]];
    bottomview.priceLabel.attributedText=str;

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
