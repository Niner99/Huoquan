//
//  CatogoryViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/16.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "CatogoryViewController.h"
#import "CatogoryTableViewCell.h"
#import "CatogoryCollectionViewCell.h"
#import "BrandCateModel.h"
#import "CategoryCollectionReusableView.h"
#import "GoodsListViewController.h"

@interface CatogoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UITableView *tv;
    UICollectionView *cv;
    NSMutableArray *brandData;
    NSMutableArray *cateData;
    NSMutableArray *childData;
}
@end

@implementation CatogoryViewController
static NSString *celltv=@"celltv";
static NSString *cellcv=@"cellcv";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"分类" color:k000000 fontSize:18];
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    brandData=[[NSMutableArray alloc]init];
    cateData=[[NSMutableArray alloc]init];
    childData=[[NSMutableArray alloc]init];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kBrandCategory] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        
        if ([responseObject[@"code"] intValue]==200) {
            
            NSDictionary *data=responseObject[@"data"];
            [brandData addObjectsFromArray:data[@"brand"]];
            
            [cateData addObjectsFromArray:data[@"categoryList"]];
            
            [tv reloadData];
            [cv reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];

    
    
}





-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 84, 88, kScreenHeight-64) style:UITableViewStylePlain];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.separatorColor=[UIColor clearColor];
    [self.view addSubview:tv];
    [tv registerClass:[CatogoryTableViewCell class] forCellReuseIdentifier:celltv];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.itemSize=CGSizeMake(54+29,97);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    
    cv=[[UICollectionView alloc]initWithFrame:CGRectMake(98, 64, kScreenWidth-108, kScreenHeight-64) collectionViewLayout:layout];
    cv.delegate=self;
    cv.dataSource=self;
    [self.view addSubview:cv];
    [cv registerClass:[CatogoryCollectionViewCell class] forCellWithReuseIdentifier:cellcv];
    [cv registerClass:[CategoryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"aaa"];
    
    cv.backgroundColor=[UIColor whiteColor];
    
    UIView *verline=[[UIView alloc]initWithFrame:CGRectMake(88, 64, 1, kScreenHeight-64)];
    verline.backgroundColor=kD8D8D8;
    [self.view addSubview:verline];
    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cateData.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CatogoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    if (indexPath.row==0) {
         cell.brandLabel.text=@"品牌";
    }else{
        CategoryModel *cate=[[CategoryModel alloc]initWithDictionary:cateData[indexPath.row-1] error:nil];
        cell.brandLabel.text=cate.categoryName;
    }
    
    
    if (indexPath.row==_selectBrand) {
        cell.branicon.hidden=NO;
        cell.brandLabel.textColor=kDABF66;
        cell.brandLabel.font=FIFTEEN;
        
    }else{
        cell.branicon.hidden=YES;
        cell.brandLabel.textColor=k333333;
        cell.brandLabel.font=THIRTEEN;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectBrand=indexPath.row;
    if (_selectBrand==0) {
        
    }else{
        CategoryModel *cate=[[CategoryModel alloc]initWithDictionary:cateData[indexPath.row-1] error:nil];
        [self CollectionViewData:cate.pkId];
    }
    
    
    [tv reloadData];
    [cv reloadData];
}

-(void)CollectionViewData:(NSString *)parentID{
    childData=[[NSMutableArray alloc]init];
    NSDictionary *dicpic=@{@"parentId":parentID};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kChildCategory] parameters:dicpic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]==200) {
            
            [childData addObjectsFromArray:responseObject[@"data"]];

            
            [cv reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
}



#pragma mark UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_selectBrand==0) {
        return brandData.count;
    }
    return childData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CatogoryCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellcv forIndexPath:indexPath];
    
    if (_selectBrand==0) {
        BrandCateModel *brand=[[BrandCateModel alloc]initWithDictionary:brandData[indexPath.row] error:nil];
        cell.brandLabel.text=brand.brandName;
        NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,brand.brandLogoId]];
        
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                     forHTTPHeaderField:@"Accept"];
        [cell.branicon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"分类"]];
    }else{
        CategoryModel *brand=[[CategoryModel alloc]initWithDictionary:childData[indexPath.row] error:nil];
        cell.brandLabel.text=brand.categoryName;
        NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,brand.categoryPic]];
        
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                     forHTTPHeaderField:@"Accept"];
        [cell.branicon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"分类"]];
    }

    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind==UICollectionElementKindSectionHeader) {
        CategoryCollectionReusableView *headerView =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"aaa" forIndexPath:indexPath];
                if (_selectBrand==0) {
                    headerView.titlebrand.text=@"品牌";
                }else{
                    CategoryModel *cate=[[CategoryModel alloc]initWithDictionary:cateData[_selectBrand-1] error:nil];
                    headerView.titlebrand.text=cate.categoryName;
                }


        return headerView;
        
    }else{
        return nil;
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(54+29,100);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth-108, 39);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectBrand==0) {
        //品牌
         BrandCateModel *brand=[[BrandCateModel alloc]initWithDictionary:brandData[indexPath.row] error:nil];
        GoodsListViewController *goods=[GoodsListViewController new];
        goods.brandID=brand.pkId;
        goods.goodsstyle=1;
        goods.goodsTitle=brand.brandName;
        [self.navigationController pushViewController:goods animated:YES];
    }else{
        CategoryModel *brand=[[CategoryModel alloc]initWithDictionary:childData[indexPath.row] error:nil];
        GoodsListViewController *goods=[GoodsListViewController new];
        goods.categoryID=brand.pkId;
        goods.goodsstyle=0;
        goods.goodsTitle=brand.categoryName;
        [self.navigationController pushViewController:goods animated:YES];
    }
}



-(void)viewWillAppear:(BOOL)animated{
   
    if (_selectBrand==0) {
         [self initData];
    }else{
        CategoryModel *cate=[[CategoryModel alloc]initWithDictionary:cateData[_selectBrand-1] error:nil];
        [self CollectionViewData:cate.pkId];
    }
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
