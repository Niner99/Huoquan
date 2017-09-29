//
//  TransDetailViewController.m
//  huoquan
//
//  Created by finecasa on 2017/9/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "TransDetailViewController.h"
#import "RecordDetailModel.h"

@interface TransDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    RecordDetailModel *red;
}
@end

@implementation TransDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"交易详情" color:k000000 fontSize:kTitleFloat];
    [self creatUI];
}

-(void)initData{
    [self showNHUD];
    NSDictionary *dic=@{@"recordId":_recordID};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kwalletRecordDetail] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            red=[[RecordDetailModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
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
 //   [tv registerClass:[TransRecordTableViewCell class] forCellReuseIdentifier:celltv];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *phonekefu=[UILabel newAutoLayoutView];
    phonekefu.textAlignment=NSTextAlignmentRight;
    phonekefu.textColor=k333333;
    phonekefu.font=TWELVE;

    [cell addSubview:phonekefu];
    [phonekefu autoSetDimensionsToSize:CGSizeMake(200, 10)];
    [phonekefu autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
    [phonekefu autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    cell.textLabel.font=TWELVE;
    cell.textLabel.textColor=k666666;
    
    if (indexPath.section==0) {
        phonekefu.textColor=k333333;
        if (indexPath.row==0) {
            cell.textLabel.text=@"交易金额";
            phonekefu.text=[NSString stringWithFormat:@"￥%@",red.changeMoney];
        }if (indexPath.row==1) {
            cell.textLabel.text=@"交易类型";
            phonekefu.text=red.recordTypeStr;
        }if (indexPath.row==2) {
            cell.textLabel.text=@"交易日期";
            phonekefu.text=[NSString setTimewithString:red.recordTime];
        }if (indexPath.row==3) {
            cell.textLabel.text=@"流水号";
            phonekefu.text=red.runningNo;
        }if (indexPath.row==4) {
            cell.textLabel.text=@"交易状态";
            phonekefu.text=@"交易成功";
        }if (indexPath.row==5) {
            cell.textLabel.text=@"交易说明";
            phonekefu.text=red.remark;
        }
    }if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"此次操作后余额（元）";
            phonekefu.textColor=kDABF66;
            phonekefu.text=[NSString stringWithFormat:@"%.2f",[red.afterChangeMoney floatValue]];
        }
    }

    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 6;
    }
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
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
