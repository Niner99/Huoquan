//
//  AreaViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "AreaViewController.h"

@interface AreaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    NSString *areaString;
    NSString *franchName;
}
@end

@implementation AreaViewController
static NSString *cellone=@"cellone";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"代理区域" color:k000000 fontSize:kTitleFloat];
    areaString=@"";
    franchName=@"";
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kAreaDistrict] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            NSDictionary *data=responseObject[@"data"];
            areaString=data[@"jsonAddress"];
            franchName=data[@"franchiseeName"];
            [tv reloadData];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
}








-(void)creatUI{
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.showsVerticalScrollIndicator=NO;
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellone];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:tv];
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellone];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];

    if (indexPath.section==0) {
        cell.textLabel.font=THIRTEEN;
        cell.textLabel.textColor=k888888;
        cell.textLabel.text=@"加盟商名称";
        
        UILabel *phonekefu=[UILabel newAutoLayoutView];
        phonekefu.textAlignment=NSTextAlignmentRight;
        phonekefu.font=FIFTEEN;
        phonekefu.text=franchName;
        [cell addSubview:phonekefu];
        [phonekefu autoSetDimensionsToSize:CGSizeMake(120, 15)];
        [phonekefu autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:41];
        [phonekefu autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.textLabel.font=THIRTEEN;
            cell.textLabel.textColor=k888888;
            cell.textLabel.text=@"代理区域";
        }else{
            cell.textLabel.font=FOURTEEN;
            cell.textLabel.textColor=k333333;
            NSDictionary *citydic=[NSString dictionaryWithJsonString:areaString];
            if (citydic) {
                NSString *cityStr=[NSString stringWithFormat:@"%@%@%@",citydic[@"p"],citydic[@"c"],citydic[@"d"]];
                cell.textLabel.text=[NSString stringWithFormat:@"%@",cityStr];
            }
        }

    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 62;
    }
    return 43;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 13)];
    headv.backgroundColor=kF8F8F8;
    if (section==0) {
        return nil;
    }
    return headv;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }
    return 13;
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
