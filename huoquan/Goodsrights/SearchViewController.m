//
//  SearchViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/11.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchView.h"
#import "GoodsListTableViewCell.h"
#import "GoodsListModel.h"
#import "GoodsDetailViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *ksearchBar;
    UITableView *tv;
    SearchView *ksearchView;
    NSMutableArray *searchArray;
    NSMutableArray *dataArray;
    NSInteger currentPage;
    NSString *keyWord;
    NoNetView *noview;
}
@end

@implementation SearchViewController
static NSString *celltv=@"celltv";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadItemWithTitle:@"取消" font:FOURTEEN target:self action:@selector(btn_cancel) position:PPBarItemPosition_right];
    
    [self creatUI];
}

-(void)creatUI{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 45)];
    ksearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(15, 5, 252*HH, 35)];
    //   searchBar.keyboardType=UIKeyboardAppearanceDefault;
    ksearchBar.placeholder= @"搜索你需要的商品" ;
    ksearchBar.backgroundColor=kEEEEEE;
    [titleView addSubview:ksearchBar];
    ksearchBar.delegate=self;
    ksearchBar.layer.cornerRadius=4;
//    [ksearchBar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
//    [ksearchBar autoSetDimensionsToSize:CGSizeMake(252, 35)];
//    [ksearchBar autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    for (UIView *subView in ksearchBar.subviews) {
        if ([subView isKindOfClass:[UIView class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
            if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                UITextField *textField = [subView.subviews objectAtIndex:0];
                textField.backgroundColor =kEEEEEE;
                //设置输入框边框的颜色
                // textField.layer.borderColor = [UIColor blackColor].CGColor;
                // textField.layer.borderWidth = 1;
                //设置输入字体颜色
                // textField.textColor = [UIColor lightGrayColor];
                //设置默认文字颜色
            [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索你需要的商品" attributes:@{NSForegroundColorAttributeName:kA9A9A9}]];
            //修改默认的放大镜图片
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
//            imageView.backgroundColor = [UIColor clearColor];
//            imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
//            textField.leftView = imageView;
        }
        }
    }


    
    [ksearchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    tv.backgroundColor=[UIColor whiteColor];
    tv.delegate=self;
    tv.dataSource=self;
    tv.separatorColor=[UIColor clearColor];
    [self.view addSubview:tv];
    [tv registerClass:[GoodsListTableViewCell class] forCellReuseIdentifier:celltv];
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
    
    NSArray *temparray=kStandardUserDefaultsObject(kSearchArray);
    searchArray = [temparray mutableCopy];
    
 //   searchArray=(NSMutableArray *)kStandardUserDefaultsObject(kSearchArray);
    ksearchView=[[SearchView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    ksearchView.historyArray=searchArray;
    __block UIViewController *blockSelf = self;
    __block UITableView *tvblock = tv;
    __block UISearchBar *searblock = ksearchBar;
    __weak typeof(self) weakSelf = self;
    ksearchView.tapAction=^(NSString *strs){
        FLog(@"%@",strs);
        [blockSelf.view bringSubviewToFront:tvblock];
        [searblock resignFirstResponder];
        keyWord=strs;
        currentPage=1;
        [weakSelf initData];
    };
    [self.view addSubview:ksearchView];
    
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
    
}




-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchBar.text==nil || searchBar.text.length<=0) {
        
        ksearchView.historyArray=searchArray;
        [self.view bringSubviewToFront:ksearchView];
    }
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text.length>0) {
        
        if (!searchArray) {
            searchArray=[[NSMutableArray alloc]init];
        }
        [searchArray addObject:searchBar.text];
        NSArray *tempArray=[NSArray arrayWithArray:searchArray];
        kSaveStandardUserDefaults(tempArray, kSearchArray);
        
         [self.view bringSubviewToFront:tv];
        [ksearchBar resignFirstResponder];
        keyWord=searchBar.text;
        currentPage=1;
        [self initData];
    }
}

-(void)initData{
    [self showNHUD];
    dataArray=[[NSMutableArray alloc]init];
    NSDictionary *dic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20",@"keyword":keyWord};
    
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kGoodsList] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            currentPage=2;
            [dataArray addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
        [tv.mj_header endRefreshing];
    }];
}

-(void)loadMoreData{
    NSDictionary *dic=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20",@"keyword":keyWord};
    
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


#pragma mark 取消
-(void)btn_cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ishaveView:(BOOL )isnet{
    if (isnet==YES) {
        noview.hidden=YES;
    }else{
        noview.hidden=NO;
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [ksearchBar resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [ksearchBar resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
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
