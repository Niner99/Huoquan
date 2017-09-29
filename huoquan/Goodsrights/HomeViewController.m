//
//  HomeViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/9.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "SearchViewController.h"
#import "HomeHeaderView.h"
#import "MessageViewController.h"
#import "CatogoryViewController.h"
#import "EditPasswordViewController.h"
#import "GoodsDetailViewController.h"
#import "GoodsListModel.h"
#import "GoodsListViewController.h"

@interface HomeViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
  //  UISearchBar *searchBar;
    UITableView *tv;
    UIButton *searchBar;
    JCAlertView *jcalert;
    NSMutableArray *dataAry;
    NSMutableArray *goodsArray;
    NSInteger currentPage;
    NoNetView *noview;
}
@end

@implementation HomeViewController
static NSString *celltv=@"celltv";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [self loadTitleWithTitle:@"首页" color:[UIColor whiteColor] fontSize:kTitleFloat];
    [self loadItemWithImage:[UIImage imageNamed:@"消息"] HighLightImage:nil target:self action:@selector(btn_message) position:PPBarItemPosition_right];
    
    [self creatUI];
}

-(void)initData{
    
    dataAry=[[NSMutableArray alloc]init];
    
    [self showNHUD];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCategory] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self ishaveView:YES];
        if ([responseObject[@"code"] intValue]==200) {
            [dataAry addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
    currentPage=1;
    goodsArray=[[NSMutableArray alloc]init];
    NSDictionary *pagedic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kHomeGoods] parameters:pagedic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
        
            [goodsArray addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
            currentPage=2;
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
        [tv.mj_header endRefreshing];
    }];
    
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kNotReadMessage] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]==200) {
            if ([responseObject[@"data"] intValue]>0) {
                [self loadItemWithImage:[UIImage imageNamed:@"有消息"] HighLightImage:nil target:self action:@selector(btn_message) position:PPBarItemPosition_right];
            }else{
                [self loadItemWithImage:[UIImage imageNamed:@"消息"] HighLightImage:nil target:self action:@selector(btn_message) position:PPBarItemPosition_right];
            }

        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];

}

-(void)loadMoreData{
    [self showNHUD];
    NSDictionary *pagedic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kHomeGoods] parameters:pagedic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            NSArray *tempArray=responseObject[@"data"];
            if (tempArray.count>0) {
               [goodsArray addObjectsFromArray:responseObject[@"data"]];
                
                currentPage++;
                [tv.mj_footer endRefreshing];
                [tv reloadData];
                
            }else{
                [tv.mj_footer endRefreshing];
                [tv.mj_footer setState:MJRefreshStateNoMoreData];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
         [tv.mj_footer endRefreshing];
    }];
}


-(void)creatUI{

    UIView *titileview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,45)];
    searchBar=[[UIButton alloc]initWithFrame:CGRectMake(10, 5,302*HH, 36)];
    [searchBar setTitle:@"可以搜索品牌、商品" forState:0];
    [searchBar addTarget:self action:@selector(pushsearchView) forControlEvents:UIControlEventTouchUpInside];
    [titileview addSubview:searchBar];
    searchBar.backgroundColor=kEEEEEE;
    searchBar.titleLabel.font=FIFTEEN;
    [searchBar setTitleColor:kA9A9A9 forState:0];
    [searchBar setImage:[UIImage imageNamed:@"搜索"] forState:0];
    FLog(@"%f",kScreenWidth);
    if (IS_IPHONE) {
        searchBar.frame=CGRectMake(10, 5,302*HH, 36);
        searchBar.imageEdgeInsets=UIEdgeInsetsMake(0, -63*HH, 0, 63*HH);
        searchBar.titleEdgeInsets=UIEdgeInsetsMake(0, -55*HH, 0, 55*HH);
    }else{
        searchBar.frame=CGRectMake(10, 5,400, 36);
        searchBar.imageEdgeInsets=UIEdgeInsetsMake(0, -63, 0, 63);
        searchBar.titleEdgeInsets=UIEdgeInsetsMake(0, -55, 0, 55);
    }

    searchBar.layer.cornerRadius=4;
    
 //   titileview.backgroundColor=kDABF66;
    self.navigationItem.titleView= titileview;

    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.showsVerticalScrollIndicator=NO;
    tv.separatorColor=[UIColor clearColor];
    [self.view addSubview:tv];
    [tv registerClass:[HomeTableViewCell class] forCellReuseIdentifier:celltv];
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

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (dataAry.count>0) {
        HomeHeaderView *homeview=[[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 237) cateAry:dataAry];
        homeview.tapAction=^(NSString *cateID,NSString *cateName){
            FLog(@"cateID==%@",cateID);
            
            if ([cateID intValue]==0) {
                CatogoryViewController *cate=[CatogoryViewController new];
                cate.selectBrand=0;
                cate.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:cate animated:YES];
            }else{
                GoodsListViewController *lis=[GoodsListViewController new];
                lis.categoryID=cateID;
                lis.goodsstyle=0;
                lis.goodsTitle=cateName;
                
                lis.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:lis animated:YES];
            }

        };
        return homeview;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    GoodsListModel *goods=[[GoodsListModel alloc]initWithDictionary:goodsArray[indexPath.row] error:nil];
    cell.goodsname.text=goods.goodsName;
    cell.huoprice.text=[NSString stringWithFormat:@"货权价：￥%@",[NSString pointtwo:goods.goodsPrice]];
    cell.marketprice.text=[NSString stringWithFormat:@"市场价：￥%@",[NSString pointtwo:goods.markePrice]];
    cell.quantitylabel.text=[NSString stringWithFormat:@"库存数量：%@",goods.stockQuantity];
    
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,goods.mainPicture]];

    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [cell.goodsimage sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
    
    cell.leftQuantity=goods.stockQuantity;
    [cell.buyBtn addTarget:self action:@selector(btnGoodsdetail:) forControlEvents:UIControlEventTouchUpInside];
    cell.buyBtn.tag=indexPath.row+100;

    
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return goodsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 237;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListModel *goodsmodel=[[GoodsListModel alloc]initWithDictionary:goodsArray[indexPath.row] error:nil];
    
    GoodsDetailViewController *goods=[GoodsDetailViewController new];
    goods.hidesBottomBarWhenPushed=YES;
    goods.goodsID=goodsmodel.goodsId;
    [self.navigationController pushViewController:goods animated:YES];
}

#pragma mark 抢购按钮
-(void)btnGoodsdetail:(UIButton *)sender{
    GoodsListModel *goodsmodel=[[GoodsListModel alloc]initWithDictionary:goodsArray[sender.tag-100] error:nil];
    

    GoodsDetailViewController *goods=[GoodsDetailViewController new];
    goods.hidesBottomBarWhenPushed=YES;
    goods.goodsID=goodsmodel.goodsId;
    [self.navigationController pushViewController:goods animated:YES];
}




#pragma mark 进入搜索页面
-(void)pushsearchView{
    SearchViewController *sear=[SearchViewController new];
    sear.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:sear animated:YES];
}

#pragma mark 消息
-(void)btn_message{
    MessageViewController *messa=[MessageViewController new];
    messa.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:messa animated:YES];
}



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    [self initData];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSDictionary *infoDictionary=[[NSBundle mainBundle]infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        NSString *currentVersion=[infoDictionary objectForKey:@"CFBundleShortVersionString"];
        FLog(@"%@",currentVersion);
        
        NSDictionary *appdic=@{@"clientType":@"1"};
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kAppVersion] parameters:appdic success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"code"] intValue]==200) {
                NSDictionary *data=responseObject[@"data"];
                NSString *verStr=data[@"clientVersion"];

                NSString *versonUrl=data[@"upgradeDownloadUrl"];
                kSaveStandardUserDefaults(verStr, kAppVersonCode);
                kSaveStandardUserDefaults(versonUrl, kAppVersonUrl);
                
                if ([verStr floatValue]>[currentVersion floatValue]) {
                    
//                        PopWindowView *popview=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singleTitle:@"是否更新到最新版本？" leftBtn:@"取消" rightBtn:@"更新"];
//                    
//                        [popview.leftBtn addTarget:self action:@selector(cancelpopview) forControlEvents:UIControlEventTouchUpInside];
//                        [popview.rightBtn addTarget:self action:@selector(update_newVerson) forControlEvents:UIControlEventTouchUpInside];
//                        jcalert=[[JCAlertView alloc]initWithCustomView:popview dismissWhenTouchedBackground:NO];
//                        [jcalert show];
                }
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            
        }];
        
            if (!kStandardUserDefaultsObject(kfirstLogin)) {
        
                PopWindowView *popview=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singleTitle:@"为了您的账号安全，请修改登录密码" leftBtn:@"取消" rightBtn:@"现在去修改"];
        
                [popview.leftBtn setTitle:@"取消" forState:0];
                [popview.rightBtn setTitle:@"现在去修改" forState:0];
                [popview.leftBtn addTarget:self action:@selector(cancelpopview) forControlEvents:UIControlEventTouchUpInside];
                [popview.rightBtn addTarget:self action:@selector(editepassword) forControlEvents:UIControlEventTouchUpInside];
                jcalert=[[JCAlertView alloc]initWithCustomView:popview dismissWhenTouchedBackground:NO];
                [jcalert show];
            }
        
        
    });

}

#pragma mark 更新到最新版本
-(void)update_newVerson{
    [jcalert dismissWithCompletion:^{
        jcalert=nil;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id1288463735"]];
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    //实现该方法是需要注意view需要是继承UIControl而来的
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(void)cancelpopview{
    [jcalert dismissWithCompletion:^{
        jcalert=nil;
        kSaveStandardUserDefaults(@"firstlog", kfirstLogin);
    }];
}

-(void)editepassword{
    [jcalert dismissWithCompletion:^{
        EditPasswordViewController *editpass=[EditPasswordViewController new];
        kSaveStandardUserDefaults(@"firstlog", kfirstLogin);
        editpass.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:editpass animated:YES];
    }];
}


-(void)ishaveView:(BOOL )isnet{
    if (isnet==YES) {
        noview.hidden=YES;
    }else{
        noview.hidden=NO;
    }
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
