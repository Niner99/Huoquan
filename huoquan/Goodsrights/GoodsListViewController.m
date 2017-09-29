//
//  GoodsListViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsListTableViewCell.h"
#import "GoodsListModel.h"
#import "GoodsDetailViewController.h"
@interface GoodsListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    NSMutableArray *dataArray;
    NSInteger currentPage;
    NoNetView *noview;
    UIView *noshopView;
}
@end

@implementation GoodsListViewController
static NSString *celltv=@"celltv";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTitleWithTitle:_goodsTitle color:k000000 fontSize:18];
    [self creatUI];
    
}


-(void)initData{
    currentPage=1;
    [self showNHUD];
    NSDictionary *dic;
    if (_goodsstyle==0) {
        //分类ID
        dic=@{@"categoryId":_categoryID,@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    }else{
        //品牌ID
        dic=@{@"brandId":_brandID,@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    }
    dataArray=[[NSMutableArray alloc]init];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kGoodsList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            currentPage=2;
            [dataArray addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
            
            if (dataArray.count>0) {
                noshopView.hidden=YES;
            }else{
                noshopView.hidden=NO;
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
    NSDictionary *dic;
    if (_goodsstyle==0) {
        //分类ID
        dic=@{@"categoryId":_categoryID,@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    }else{
        //品牌ID
        dic=@{@"brandId":_brandID,@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    }
   
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kGoodsList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.separatorColor=[UIColor clearColor];
    [self.view addSubview:tv];
    [tv registerClass:[GoodsListTableViewCell class] forCellReuseIdentifier:celltv];
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
    
    
    noshopView=[[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:noshopView];
    
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [noshopView addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(90, 83)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:173*HH];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"敬请期待"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,279*HH, kScreenWidth, 13)];
    shopLabel.text=@"更多货权正在发布中，敬请期待。";
    shopLabel.textAlignment=NSTextAlignmentCenter;
    shopLabel.font=THIRTEEN;
    shopLabel.textColor=k888888;
    [noshopView addSubview:shopLabel];
    
    noshopView.hidden=YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    GoodsListModel *goods=[[GoodsListModel alloc]initWithDictionary:dataArray[indexPath.row] error:nil];
    cell.goodsname.text=goods.goodsName;
    cell.huoprice.text=[NSString stringWithFormat:@"货权价：￥%@",goods.goodsPrice];
    cell.marketprice.text=[NSString stringWithFormat:@"市场价：￥%@",goods.markePrice];
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,goods.mainPicture]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [cell.goodsimage sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
    cell.leftQuantity=goods.stockQuantity;
    [cell.buyBtn addTarget:self action:@selector(goodslist_btn:) forControlEvents:UIControlEventTouchUpInside];
    cell.buyBtn.tag=100+indexPath.row;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListModel *goods=[[GoodsListModel alloc]initWithDictionary:dataArray[indexPath.row] error:nil];
    
    GoodsDetailViewController *detail=[GoodsDetailViewController new];
    detail.goodsID=goods.goodsId;
    [self.navigationController pushViewController:detail animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}





-(void)goodslist_btn:(UIButton *)sender{
    GoodsListModel *goods=[[GoodsListModel alloc]initWithDictionary:dataArray[sender.tag-100] error:nil];
    
    GoodsDetailViewController *detail=[GoodsDetailViewController new];
    detail.goodsID=goods.goodsId;
    [self.navigationController pushViewController:detail animated:YES];
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
