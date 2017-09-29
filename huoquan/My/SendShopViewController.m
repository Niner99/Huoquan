//
//  SendShopViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SendShopViewController.h"
#import "SendShopTableViewCell.h"
#import "CommitOrderViewController.h"
#import "ReadySendModel.h"

@interface SendShopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    NSMutableArray *dataArray;
    UILabel *chooseLabel;
    NSInteger currentPage;
    NoNetView *noview;
    UIView *noshopView;
}
@end

@implementation SendShopViewController
static NSString *cellone=@"cellone";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"发货至门店" color:k000000 fontSize:kTitleFloat];
    
    [self creatUI];
}




-(void)initData{
    currentPage=1;
    [self showNHUD];
    NSDictionary *dicc=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};
    dataArray=[[NSMutableArray alloc]init];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kReadySendList] parameters:dicc success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            currentPage=2;
            TestShopDataModel *ddd=[[TestShopDataModel alloc]initWithDictionary:responseObject error:nil];
        
            [dataArray addObjectsFromArray:ddd.data];
            [tv reloadData];
            if (dataArray.count>0) {
                noshopView.hidden=YES;
            }else{
                noshopView.hidden=NO;
            }
            //初始化加入发货单数
            for (int i=0; i<dataArray.count; i++) {
                ReadySendModel *ready=dataArray[i];
                ready.plus_count=@"0";
            }
            [self update_bottomNum];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        [tv.mj_header endRefreshing];
    }];
    
    
}

-(void)loadMoreData{
    [self showNHUD];
    NSDictionary *dicc=@{@"page":[NSString stringWithFormat:@"%ld",currentPage],@"rows":@"20"};

    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kReadySendList] parameters:dicc success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [tv.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]==200) {
            
            TestShopDataModel *ddd=[[TestShopDataModel alloc]initWithDictionary:responseObject error:nil];
            
            NSArray *tempArray=ddd.data;
            if (tempArray.count>0) {
                [dataArray addObjectsFromArray:ddd.data];
                [tv reloadData];
                currentPage++;
                
                //初始化加入发货单数
                for (int i=0; i<dataArray.count; i++) {
                    ReadySendModel *ready=dataArray[i];
                    ready.plus_count=@"0";
                }
                [self update_bottomNum];
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
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64-40) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    tv.separatorColor=[UIColor clearColor];
    [tv registerClass:[SendShopTableViewCell class] forCellReuseIdentifier:cellone];
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
    
    UIView *botView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    botView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:botView];
    
    chooseLabel=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 100, 49)];
    [botView addSubview:chooseLabel];
    chooseLabel.textColor=k888888;
    chooseLabel.font=TWELVE;
    NSMutableAttributedString *strtemp=[UsefulClass setStr:@"0" onlyColor:k010101 maintext:@"已选择0件"];
    [chooseLabel setAttributedText:strtemp];
    
    UIButton *sendList=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-99, 0, 99, 50)];
    [sendList setTitle:@"进入发货单" forState:0];
    sendList.titleLabel.font=FIFTEEN;
    sendList.backgroundColor=k000000;
    [botView addSubview:sendList];
    [sendList addTarget:self action:@selector(sendListOrderclick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor=kCCCCCC;
    [botView addSubview:line];
    
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
    
    noshopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:noshopView];
    
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [noshopView addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(60, 48)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:208];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"无商品"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,279, kScreenWidth, 13)];
    shopLabel.text=@"没有可以发往门店的商品";
    shopLabel.textAlignment=NSTextAlignmentCenter;
    shopLabel.font=THIRTEEN;
    shopLabel.textColor=k888888;
    [noshopView addSubview:shopLabel];

    noshopView.hidden=YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SendShopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellone];
    
    ReadySendModel *ready=dataArray[indexPath.section];
    
    cell.max_goodsnum=[ready.remainingQuantity intValue];
    cell.goodstitle.text=ready.goodsName;
  //  cell.numlabel.text=ready.plus_count;
    cell.countsnum=[ready.plus_count integerValue];
    NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:ready.sellAttribute];
    
    NSString *specString=@"";
    for (int i=0; i<specArray.count; i++) {
        NSDictionary *specdic=specArray[i];
        NSString *cityStr=[NSString stringWithFormat:@"%@/%@",specdic[@"spec"],specdic[@"value"]];
        specString=[specString stringByAppendingString:[NSString stringWithFormat:@" %@",cityStr]];
        
    }
    cell.goodsNum.text=specString;
    
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,ready.mainPicture]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [cell.goodsIcon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];

    cell.goodsPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:ready.goodsPrice]];
    cell.sendNum.text=[NSString stringWithFormat:@"可发货数：%@",ready.remainingQuantity];
    
    cell.goodsblock=^(NSString *numbers){
        ready.plus_count=numbers;
        [self update_bottomNum];
    };
    return cell;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 183;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 27;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 27)];
        headLabel.text=@"  请选择需要发货的商品";
        headLabel.font=TWELVE;
        headLabel.textColor=k333333;
        return headLabel;
    }
    return nil;

}




#pragma mark 进入发货单
-(void)sendListOrderclick{
    
    int count=0;
    NSString *dicString=@"";
    for (int i=0; i<dataArray.count; i++) {
        ReadySendModel *ready=dataArray[i];
        if ([ready.plus_count intValue]>0) {
        
           NSDictionary *dic=@{@"oid":ready.detailId,@"amount":ready.plus_count};
     
            if (count==0) {
                dicString=[NSString convertToJsonData:dic];
            }else{
                dicString=[dicString stringByAppendingString:[NSString stringWithFormat:@",%@",[NSString convertToJsonData:dic]]];
            }
    
            count++;
        }
        
    }

    if (dicString.length>0) {
        CommitOrderViewController *comm=[CommitOrderViewController new];
        comm.jsonString=[NSString stringWithFormat:@"[%@]",dicString];
        [self.navigationController pushViewController:comm animated:YES];
    }else{
        [self displayNHUDTitle:@"您还没有加入发货单商品"];
    }

}



-(void)viewWillAppear:(BOOL)animated{
    [self initData];
}

#pragma mark 更新底部发货单数量
-(void)update_bottomNum{
    
    int totalcount=0;
    for (int i=0; i<dataArray.count; i++) {

        ReadySendModel *ready=dataArray[i];
        totalcount+=[ready.plus_count intValue];
    }
    NSString *totalStr=[NSString stringWithFormat:@"%d",totalcount];
    NSMutableAttributedString *strtemp=[UsefulClass setStr:totalStr onlyColor:k010101 maintext:[NSString stringWithFormat:@"已选择%@件",totalStr]];
    [chooseLabel setAttributedText:strtemp];
}


-(void)ishaveView:(BOOL )isnet{
    if (isnet==YES) {
        noview.hidden=YES;
    }else{
        noview.hidden=NO;
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
