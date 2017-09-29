//
//  SaleDetailViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SaleDetailViewController.h"
#import "OnlineInventoryTableViewCell.h"
#import "SaleDetailTableViewCell.h"
#import "CloudStorageModel.h"
#import "TimeDetailModel.h"

@interface SaleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    CloudStorageModel *cloud;
    NSMutableArray *timeArray;
}
@end

@implementation SaleDetailViewController
static NSString *cellone=@"cellone";
static NSString *celltwo=@"celltwo";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"销售明细" color:k000000 fontSize:kTitleFloat];
    
    [self creatUI];
    
    
}

-(void)initData{
    [self showNHUD];
    NSDictionary *dic=@{@"detailId":_orderDetailID};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCloudStorageOrderDetail] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
      
        if ([responseObject[@"code"] intValue]==200) {
            cloud=[[CloudStorageModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
            [tv reloadData];
        }
        
    
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
    
    timeArray=[[NSMutableArray alloc]init];
    
    NSDictionary *dicsale=@{@"detailId":_orderDetailID,@"page":@"1",@"rows":@"20"};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCloudStorageSaleList] parameters:dicsale success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        
        if ([responseObject[@"code"] intValue]==200) {
            [timeArray addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
    
    
    
    
    
}

-(void)creatUI{
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    [tv registerClass:[OnlineInventoryTableViewCell class] forCellReuseIdentifier:cellone];
    [tv registerClass:[SaleDetailTableViewCell class] forCellReuseIdentifier:celltwo];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        OnlineInventoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellone];
        cell.iconWidth=@"74";
        cell.goodstitle.text=cloud.goodsName;

        cell.goodsPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:cloud.goodsPrice]];
    
        
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
    }else{
        SaleDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltwo];
        TimeDetailModel *time=[[TimeDetailModel alloc]initWithDictionary:timeArray[indexPath.row] error:nil];
        
        cell.saleLabel.text=[NSString setDaywithString:time.recordTime];
        
        cell.numlabel.text=time.sellQuantity;
        return cell;
    }
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return timeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 104;
    }
    return 49;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 26;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    UILabel *detailabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 26)];
    detailabel.text=@"   销售明细";
    detailabel.textColor=k333333;
    detailabel.font=TWELVE;
    return detailabel;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
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
