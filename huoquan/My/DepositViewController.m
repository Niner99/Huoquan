//
//  DepositViewController.m
//  huoquan
//
//  Created by finecasa on 2017/9/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "DepositViewController.h"
#import "DepostTableViewCell.h"
#import "DespostDetailViewController.h"
#import "WithdrawModel.h"

@interface DepositViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    UIView *btnline;
    UIButton *tempbtn;
    NSMutableArray *dataArray;
    UIView *noshopView;
}
@end

@implementation DepositViewController
static NSString *celltv=@"celltv";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"提现管理" color:k000000 fontSize:kTitleFloat];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"提现"] forState:0];
    [btn addTarget:self action:@selector(btn_depost) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"提现" forState:0];
    btn.titleLabel.font=THIRTEEN;
    [btn setTitleColor:kDABF66 forState:0];
    [btn sizeToFit];
    
    [self loadItemWithCustomView:btn position:PPBarItemPosition_right];
    
    [self creatUI];
}

-(void)initData{
    [self showNHUD];
    dataArray =[[NSMutableArray alloc]init];
    NSDictionary *dic1=@{@"page":@"1",@"rows":@"20",@"auditStatus":[NSString stringWithFormat:@"%ld",_orderNum]};
    //[NSString stringWithFormat:@"%@%@",kBaseURL,kwithdrawList]
    [NAFNManager postWithURLString:@"http://192.168.1.211:38003/api/property/franchisee-finance-withdraw-list-app" parameters:dic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            [dataArray addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
        }
        
        if (dataArray.count>0) {
            noshopView.hidden=YES;
        }else{
            noshopView.hidden=NO;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
}



-(void)creatUI{
    UIView *btnview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
    [self.view addSubview:btnview];
    btnview.backgroundColor=[UIColor whiteColor];
    
    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 29.5, kScreenWidth, 1)];
    linev.backgroundColor=kD8D8D8;
    [btnview addSubview:linev];
    
    NSArray *arraybtn=@[@"全部",@"待审核",@"已审核"];
    for (int i=0; i<3; i++) {
        UIButton *btns=[[UIButton alloc]initWithFrame:CGRectMake(i*kScreenWidth/3.0, 0, kScreenWidth/3.0, 30)];
        [btns setTitle:arraybtn[i] forState:0];
        [btns setTitleColor:k333333 forState:0];
        btns.titleLabel.font=FIFTEEN;
        [btns setTitleColor:kDABF66 forState:UIControlStateSelected];
        btns.tag=10+i;
        [btns addTarget:self action:@selector(selecttrans:) forControlEvents:UIControlEventTouchUpInside];
        [btnview addSubview:btns];
        
        if ((i==0 && _orderNum==0) || (i==1 && _orderNum==11)|| (i==2 && _orderNum==12)) {
            btns.selected=YES;
            tempbtn=btns;
        }
    }
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,95, kScreenWidth, kScreenHeight-95) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    [tv registerClass:[DepostTableViewCell class] forCellReuseIdentifier:celltv];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    btnline=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 1)];
    
    btnline.backgroundColor=kDABF66;
    [btnview addSubview:btnline];
    switch (_orderNum) {
        case 0:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0, 30);
        }
            break;
        case 11:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*3, 30);
        }
            break;
        case 12:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*5, 30);
        }
            break;
            
        default:
            break;
    }
    
    noshopView=[[UIView alloc]initWithFrame:CGRectMake(0,95, kScreenWidth, kScreenHeight)];
    [self.view addSubview:noshopView];
    
    UIImageView *imagecar=[UIImageView newAutoLayoutView];
    [noshopView addSubview:imagecar];
    [imagecar autoSetDimensionsToSize:CGSizeMake(66, 74)];
    [imagecar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:95];
    [imagecar autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imagecar.image=[UIImage imageNamed:@"无交易记录"];
    
    UILabel *shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,186, kScreenWidth, 13)];
    shopLabel.text=@"暂时没有交易记录";
    shopLabel.textAlignment=NSTextAlignmentCenter;
    shopLabel.font=THIRTEEN;
    shopLabel.textColor=k888888;
    [noshopView addSubview:shopLabel];
    noshopView.hidden=YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DepostTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celltv];
    WithdrawModel *wi=[[WithdrawModel alloc]initWithDictionary:dataArray[indexPath.row] error:nil];
    cell.depostLabel.text=[NSString stringWithFormat:@"用户提现(其中包含手续费%@元) ￥%.2f",wi.commissionCharge,[wi.amount floatValue]];
    cell.depostTime.text=[NSString setTimewithString:wi.withdrawalTime];
    if ([wi.withdrawalStatus intValue]==1) {
        cell.depostState.text=@"审核中";
        cell.depostState.textColor=kDABF66;
    } if ([wi.withdrawalStatus intValue]==2) {
        cell.depostState.text=@"审核成功";
        cell.depostState.textColor=k66DA69;
    } if ([wi.withdrawalStatus intValue]==3) {
        cell.depostState.text=@"审核失败";
        cell.depostState.textColor=k888888;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

#pragma mark 提现
-(void)btn_depost{
    DespostDetailViewController *des=[DespostDetailViewController new];
    [self.navigationController pushViewController:des animated:YES];
}

-(void)selecttrans:(UIButton *)sender{
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
            _orderNum=0;
        }
            break;
        case 11:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*3, 30);
            _orderNum=1;
        }
            break;
        case 12:
        {
            btnline.center=CGPointMake(kScreenWidth/6.0*5, 30);
            _orderNum=2;
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
