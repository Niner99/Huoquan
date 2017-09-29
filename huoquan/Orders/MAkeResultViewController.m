//
//  MAkeResultViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/21.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MAkeResultViewController.h"
#import "MyOrderDetailViewController.h"
#import "HomeViewController.h"
#import "MakeSureViewController.h"
@interface MAkeResultViewController ()
{
    UIImageView *resulticon;
    UILabel *resultLabel;
    UILabel *orderCode;
    UILabel *orderPrice;
    UIButton *leftBtn;
    UIButton *rightBtn;
    NSString *orderID;
}
@end

@implementation MAkeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    NSDictionary *dic=@{@"virtualId":_Ordercode};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kOrderCashier] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            NSDictionary *data=responseObject[@"data"];
            NSString *moneystr=data[@"totalMoney"];
            
            NSMutableAttributedString *strtemp=[UsefulClass setStr:[NSString stringWithFormat:@"￥%@",[NSString pointtwo:moneystr]] onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"订单金额：￥%@",[NSString pointtwo:moneystr]]];
            [orderPrice setAttributedText:strtemp];
            orderCode.text=[NSString stringWithFormat:@"订单号：%@",data[@"virtualOrderNo"]];
            orderID=data[@"virtualId"];
            
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
}



-(void)creatUI{
    
    resulticon=[[UIImageView alloc]initWithFrame:CGRectMake(119, 107, 21, 17)];
    [self.view addSubview:resulticon];
    
    
    resultLabel=[[UILabel alloc]initWithFrame:CGRectMake(155, 104, 120, 24)];
    [self.view addSubview:resultLabel];

    resultLabel.font=TWENTYFOUR;
    
    orderCode=[[UILabel alloc]initWithFrame:CGRectMake(96, 150, 240, 13)];
    [self.view addSubview:orderCode];
    
    orderCode.font=THIRTEEN;
    orderCode.textColor=k333333;
    
    orderPrice=[[UILabel alloc]initWithFrame:CGRectMake(96, 172, 240, 13)];
    [self.view addSubview:orderPrice];
    orderPrice.font=THIRTEEN;
    orderPrice.textColor=k333333;

    
    
    myLabel *reasonLabel=[[myLabel alloc]initWithFrame:CGRectMake(96, 150, 195, 40)];
    [self.view addSubview:reasonLabel];
    reasonLabel.font=THIRTEEN;
    reasonLabel.textColor=kDABF66;
    reasonLabel.numberOfLines=0;
    reasonLabel.verticalAlignment=VerticalAlignmentTop;
    reasonLabel.text=[NSString stringWithFormat:@"原因：%@",_errorinfo];
    
    
    UIButton *returnbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 121, 41)];
    returnbtn.backgroundColor=kDABF66;
    [returnbtn setTitle:@"返回首页" forState:0];
    returnbtn.titleLabel.font=FIFTEEN;
    [returnbtn addTarget:self action:@selector(returnHomeView) forControlEvents:UIControlEventTouchUpInside];
    returnbtn.center=CGPointMake(kScreenWidth/2.0, 277);
    [self.view addSubview:returnbtn];
    returnbtn.layer.cornerRadius=4;
    
    
    
    leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(49, 257, 121, 41)];
    [leftBtn setTitle:@"返回首页" forState:0];
    leftBtn.titleLabel.font=FIFTEEN;
    [leftBtn setTitleColor:k333333 forState:0];
    [self.view addSubview:leftBtn];
    leftBtn.layer.borderColor=kDABF66.CGColor;
    leftBtn.layer.borderWidth=1;
    leftBtn.layer.cornerRadius=4;
    
    rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-49-121, 257, 121, 41)];
    [rightBtn setTitle:@"查看订单详情" forState:0];
    rightBtn.titleLabel.font=FIFTEEN;
    rightBtn.backgroundColor=k333333;
    [self.view addSubview:rightBtn];
    rightBtn.layer.cornerRadius=4;
    
    [leftBtn addTarget:self action:@selector(returnHomeView) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn addTarget:self action:@selector(searchOrderDetail) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (_isSuccess==YES) {
        resultLabel.textColor=kDABF66;
        resultLabel.text=@"下单成功！";
        orderCode.hidden=NO;
        orderPrice.hidden=NO;
        leftBtn.hidden=NO;
        rightBtn.hidden=NO;
        resulticon.image=[UIImage imageNamed:@"下单成功"];
        reasonLabel.hidden=YES;
        returnbtn.hidden=YES;
    }else{
        resultLabel.textColor=k888888;
        resultLabel.text=@"下单失败！";
        orderCode.hidden=YES;
        orderPrice.hidden=YES;
        leftBtn.hidden=YES;
        rightBtn.hidden=YES;
        resulticon.image=[UIImage imageNamed:@"失败"];
        reasonLabel.hidden=NO;
        returnbtn.hidden=NO;
    }

    
    
    
}



#pragma mark 返回首页
-(void)returnHomeView{
//    for (UIViewController *controller in self.tabBarController.viewControllers) {
//        if ([controller isKindOfClass:[HomeViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
////    
    self.tabBarController.selectedIndex=0;
////    
//////    [self.navigationController popToRootViewControllerAnimated:YES];
////    
//    HomeViewController *hom=[HomeViewController new];
//    hom.hidesBottomBarWhenPushed=NO;
//    [self.navigationController popToViewController:hom animated:YES];
    
    
    
//    //获得选中的item
//  //  NSUInteger tabIndex = [self.tabBarController.tabBar.items indexOfObject:0];
//    // 对应item 上面的子控制器（NavigationController）
//    BaseNC *navVc = self.childViewControllers[0] ;
//    
//    [navVc popToRootViewControllerAnimated:YES];
    
//    self.navigationController.tabBarController.hidesBottomBarWhenPushed=NO;
//    
//    self.navigationController.tabBarController.selectedIndex=0;
    
    NSNotification *notification =[NSNotification notificationWithName:kfreturnHome object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

#pragma mark 查看订单详情
-(void)searchOrderDetail{
    MyOrderDetailViewController *Detail=[MyOrderDetailViewController new];
    Detail.orderID=orderID;
    [self.navigationController pushViewController:Detail animated:YES];
}




-(void)viewWillAppear:(BOOL)animated{
    if (_isSuccess==YES) {
        [self initData];
    }
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
