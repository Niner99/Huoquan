//
//  MyViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/9.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MyViewController.h"
#import "SettingViewController.h"
#import "HelpCenterViewController.h"
#import "AreaViewController.h"
#import "MyOrdersViewController.h"
#import "OnlineInventoryViewController.h"
#import "SendManageViewController.h"
#import "MyAddressViewController.h"
#import "MineModel.h"
#import "TransRecordViewController.h"
#import "DepositViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    JCAlertView *jcalert;
    MineModel *mine;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
}

-(void)initData{
    [self showNHUD];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMine] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            
            mine=[[MineModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
            
            
            [tv reloadData];
        }
        if ([responseObject[@"code"] intValue]==401) {
            
            kRemoveStandardUserDefaults(kTokenHuoquan);
            LoginViewController *lauchvc=[LoginViewController new];
            BaseNC *nc=[[BaseNC alloc]initWithRootViewController:lauchvc];
            self.view.window.rootViewController=nc;
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
}







-(void)creatUI{
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    tv.separatorColor=[UIColor clearColor];
    tv.showsVerticalScrollIndicator=NO;
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    if (section==1) {
        return 2;
    }if (section==2) {
        return 1;
    }if (section==3) {
        return 3;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.font=FOURTEEN;
    cell.textLabel.textColor=k333333;
    UIView *line;
    if (!line) {
        line=[[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 1)];
        line.backgroundColor=kD8D8D8;
      //  [cell addSubview:line];
    }

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"财务中心";
            
            UILabel *phonekefu=[UILabel newAutoLayoutView];
            phonekefu.textAlignment=NSTextAlignmentRight;
            phonekefu.textColor=k888888;
            phonekefu.font=TWELVE;
            phonekefu.text=@"交易记录查询";
            [cell addSubview:phonekefu];
            [phonekefu autoSetDimensionsToSize:CGSizeMake(200, 10)];
            [phonekefu autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:41];
            [phonekefu autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [cell addSubview:line];
            
            [cell addSubview:line];
        }if (indexPath.row==1) {
            cell.accessoryType=UITableViewCellAccessoryNone;
            
            UIImageView *iconzijin=[UIImageView newAutoLayoutView];
            [cell addSubview:iconzijin];
            [iconzijin autoSetDimensionsToSize:CGSizeMake(24, 19)];
            [iconzijin autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:71*HH];
            [iconzijin autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            iconzijin.image=[UIImage imageNamed:@"资金池"];
            
            UILabel *zijinlabel=[UILabel newAutoLayoutView];
            [cell addSubview:zijinlabel];
            zijinlabel.textColor=k333333;
            [zijinlabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [zijinlabel autoSetDimensionsToSize:CGSizeMake(200, 13)];
            [zijinlabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconzijin withOffset:10];
            zijinlabel.font=THIRTEEN;
            NSString *zijinprice=[NSString stringWithFormat:@"%.2f元",[mine.balance floatValue]];
            NSMutableAttributedString *zijinStr=[UsefulClass setStr:zijinprice onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"资金池：%@",zijinprice]];
            [zijinlabel setAttributedText:zijinStr];
            
            [cell addSubview:line];
        }if (indexPath.row==2) {
            cell.textLabel.text=@"提现管理";
        }
    }

    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"云库存商品管理";
            [cell addSubview:line];
        }if (indexPath.row==1) {
            cell.textLabel.text=@"发往门店商品管理";
            
        }
    }if (indexPath.section==2) {
        cell.textLabel.text=@"收货地址";
    }
    
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"帮助中心";
            [cell addSubview:line];
        }if (indexPath.row==1) {
            cell.textLabel.text=@"客服电话";
            
            UILabel *phonekefu=[UILabel newAutoLayoutView];
            phonekefu.textAlignment=NSTextAlignmentRight;
            phonekefu.textColor=k888888;
            phonekefu.font=TWELVE;
            phonekefu.text=@"0755-25199098";
            [cell addSubview:phonekefu];
            [phonekefu autoSetDimensionsToSize:CGSizeMake(200, 10)];
            [phonekefu autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:41];
            [phonekefu autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [cell addSubview:line];
        }if (indexPath.row==2) {
            cell.textLabel.text=@"设置";
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 145+6+203;
    }
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
//    return 0;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 145+6+203)];
        UIImageView *firstView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 203)];
        firstView.image=[UIImage imageNamed:@"背景"];
        [backView addSubview:firstView];
        
        UILabel *username=[[UILabel alloc]initWithFrame:CGRectMake(0, 142, kScreenWidth, 15)];
        username.textAlignment=NSTextAlignmentCenter;
        username.font=FIFTEEN;
        [firstView addSubview:username];
        username.text=mine.loginName;
        
        UIButton *btndaili=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-93, 158, 93, 33)];
        [btndaili setImage:[UIImage imageNamed:@"代理区域半圆角"] forState:0];
        [backView addSubview:btndaili];
        [btndaili addTarget:self action:@selector(btndaili) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *btnlabels=[[UILabel alloc]initWithFrame:CGRectMake(23, 12, 70, 12)];
        btnlabels.text=@"代理区域 >";
        btnlabels.font=TWELVE;
        [btndaili addSubview:btnlabels];
        btnlabels.textColor=[UIColor whiteColor];
        
        
        UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, 203+6, kScreenWidth, 41)];
        middleView.backgroundColor=[UIColor whiteColor];
        [backView addSubview:middleView];
        
        UILabel *orderManage=[UILabel newAutoLayoutView];
        [middleView addSubview:orderManage];
        [orderManage autoSetDimensionsToSize:CGSizeMake(100, 14)];
        [orderManage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [orderManage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        orderManage.font=FOURTEEN;
        orderManage.text=@"货权订单管理";
        
        UIButton *searchAll=[UIButton newAutoLayoutView];
        [middleView addSubview:searchAll];
        [searchAll autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [searchAll autoSetDimensionsToSize:CGSizeMake(70, 12)];
        [searchAll autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [searchAll setTitle:@"查看全部" forState:0];
        [searchAll setImage:[UIImage imageNamed:@"右"] forState:0];
        [searchAll setTitleColor:k888888 forState:0];
        searchAll.titleLabel.font=TWELVE;
        searchAll.imageEdgeInsets=UIEdgeInsetsMake(0, 60, 0, -60);
        searchAll.titleEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 15);
        [searchAll addTarget:self action:@selector(searchAllOrder:) forControlEvents:UIControlEventTouchUpInside];
        searchAll.tag=0;
        
        UIView *secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 203+6+41, kScreenWidth, 99)];
        secondView.backgroundColor=[UIColor whiteColor];
        [backView addSubview:secondView];
        
        UIButton *daibtn=[[UIButton alloc]initWithFrame:CGRectMake(75*HH, 14, 50, 50)];
        [daibtn setImage:[UIImage imageNamed:@"待付款"] forState:0];
        [secondView addSubview:daibtn];
        [daibtn addTarget:self action:@selector(searchAllOrder:) forControlEvents:UIControlEventTouchUpInside];
        daibtn.tag=11;
        
        if ([mine.pendingPaymentNum intValue]>0) {
            UILabel *dainum=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
            dainum.text=mine.pendingPaymentNum;
            dainum.backgroundColor=kDABF66;
            dainum.layer.cornerRadius=10;
            dainum.font=FOURTEEN;
            dainum.textColor=[UIColor whiteColor];
            dainum.layer.masksToBounds=YES;
            dainum.textAlignment=NSTextAlignmentCenter;
            [daibtn addSubview:dainum];
        }


        UIButton *overbtn=[[UIButton alloc]initWithFrame:CGRectMake(251*HH, 14, 50, 50)];
        [overbtn setImage:[UIImage imageNamed:@"交易成功"] forState:0];
        [secondView addSubview:overbtn];
        overbtn.tag=12;
         [overbtn addTarget:self action:@selector(searchAllOrder:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([mine.tradeSuccessfullyNum intValue]>0) {
            UILabel *overnum=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
            overnum.text=mine.tradeSuccessfullyNum;
            overnum.backgroundColor=kDABF66;
            overnum.layer.cornerRadius=10;
            overnum.font=FOURTEEN;
            overnum.textColor=[UIColor whiteColor];
            overnum.layer.masksToBounds=YES;
            overnum.textAlignment=NSTextAlignmentCenter;
            [overbtn addSubview:overnum];
        }

        
        UILabel *dailabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 12)];
        dailabel.center=CGPointMake(100*HH, 75);
        dailabel.textColor=k333333;
        dailabel.textAlignment=NSTextAlignmentCenter;
        dailabel.font=TWELVE;
        [secondView addSubview:dailabel];
        dailabel.text=@"待付款";
        
        UILabel *overlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 12)];
        overlabel.center=CGPointMake(276*HH, 75);
        overlabel.textColor=k333333;
        overlabel.textAlignment=NSTextAlignmentCenter;
        overlabel.font=TWELVE;
        [secondView addSubview:overlabel];
        overlabel.text=@"交易成功";
        
        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 203+6+41, kScreenWidth, 1)];
        linev.backgroundColor=kD8D8D8;
        [backView addSubview:linev];
        
        
        
        return backView;
    }
    return nil;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //交易记录
            TransRecordViewController *record=[TransRecordViewController new];
            record.hidesBottomBarWhenPushed=YES;
            record.orderNum=0;
            [self.navigationController pushViewController:record animated:YES];
            
        }if (indexPath.row==2) {
            //提现管理
            DepositViewController *record=[DepositViewController new];
            record.orderNum=0;
            record.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:record animated:YES];
        }
    }

    if (indexPath.section==1) {
        if (indexPath.row==0) {
            OnlineInventoryViewController *online=[OnlineInventoryViewController new];
            online.hidesBottomBarWhenPushed=YES;
            online.orderString=@"0";
            [self.navigationController pushViewController:online animated:YES];
        }if (indexPath.row==1) {
            SendManageViewController *mage=[SendManageViewController new];
            mage.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:mage animated:YES];
        }
    }if (indexPath.section==2) {
        MyAddressViewController *mage=[MyAddressViewController new];
        mage.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mage animated:YES];
        
    }if (indexPath.section==3) {
        if (indexPath.row==0) {
            HelpCenterViewController *helpv=[HelpCenterViewController new];
            helpv.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:helpv animated:YES];

            
        }if (indexPath.row==1) {
            PopWindowView *popv=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) firstTitle:@"拨打客服电话" secondTitle:@"0755-25199098"];
            [popv.leftBtn setTitle:@"取消" forState:0];
            [popv.rightBtn setTitle:@"拨打" forState:0];
            [popv.leftBtn addTarget:self action:@selector(btndismiss) forControlEvents:UIControlEventTouchUpInside];
            [popv.rightBtn addTarget:self action:@selector(callkefuphone) forControlEvents:UIControlEventTouchUpInside];
            jcalert=nil;
            jcalert=[[JCAlertView alloc]initWithCustomView:popv dismissWhenTouchedBackground:YES];
            [jcalert show];
            
            
        }if (indexPath.row==2) {
            SettingViewController *setv=[SettingViewController new];
            setv.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:setv animated:YES];
        }
    }
}

-(void)callkefuphone{
    [jcalert dismissWithCompletion:^{
        jcalert=nil;
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"0755-25199098"];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }];


}


-(void)btndismiss{
    [jcalert dismissWithCompletion:^{
        jcalert=nil;
    }];
}

#pragma mark 代理区域
-(void)btndaili{
    AreaViewController *area=[AreaViewController new];
    area.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:area animated:YES];
}

#pragma mark 查看订单列表
-(void)searchAllOrder:(UIButton *)sender{
    MyOrdersViewController *order=[MyOrdersViewController new];
    order.hidesBottomBarWhenPushed=YES;
    order.orderNum=sender.tag;
    [self.navigationController pushViewController:order animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
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
