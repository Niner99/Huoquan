//
//  NewPasswordViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/10.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "NewPasswordViewController.h"

@interface NewPasswordViewController ()
{
    UITextField *newpasswordtxt;
    UITextField *surepasswordtxt;
    UIButton *completeBtn;
    
    
}
@end

@implementation NewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"设置密码" color:k000000 fontSize:kTitleFloat];
    [self loadItemWithImage:[UIImage imageNamed:@"取消导航栏"] HighLightImage:nil target:self action:@selector(popbackView) position:PPBarItemPosition_left];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:nil];
    [self creatUI];
}


-(void)creatUI{
    
    UILabel *newpss=[UILabel newAutoLayoutView];
    [self.view addSubview:newpss];
    [newpss autoSetDimensionsToSize:CGSizeMake(60, 14)];
    [newpss autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:277];
    [newpss autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:157];
    newpss.text=@"新密码";
    newpss.textColor=k333333;
    newpss.textAlignment=NSTextAlignmentRight;
    newpss.font=FOURTEEN;
    
    newpasswordtxt=[UITextField newAutoLayoutView];
    [self.view addSubview:newpasswordtxt];
    [newpasswordtxt autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:newpss withOffset:20];
    [newpasswordtxt autoSetDimensionsToSize:CGSizeMake(270, 14)];
    [newpasswordtxt autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:157];
    newpasswordtxt.placeholder=@"请输入6位数以上的密码";
    newpasswordtxt.font=FOURTEEN;
    newpasswordtxt.clearButtonMode=UITextFieldViewModeWhileEditing;
    newpasswordtxt.secureTextEntry=YES;
    
    UIView *line1=[UIView newAutoLayoutView];
    [self.view addSubview:line1];
    [line1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:newpss withOffset:10];
    [line1 autoSetDimensionsToSize:CGSizeMake(225, 1)];
    [line1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:newpasswordtxt withOffset:5];
    line1.backgroundColor=k888888;
    
    UILabel *surepss=[UILabel newAutoLayoutView];
    [self.view addSubview:surepss];
    [surepss autoSetDimensionsToSize:CGSizeMake(70, 14)];
    [surepss autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:277];
    [surepss autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:203];
    surepss.text=@"确认密码";
    surepss.textColor=k333333;
    surepss.textAlignment=NSTextAlignmentRight;
    surepss.font=FOURTEEN;
    
    surepasswordtxt=[UITextField newAutoLayoutView];
    [self.view addSubview:surepasswordtxt];
    [surepasswordtxt autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:newpss withOffset:20];
    [surepasswordtxt autoSetDimensionsToSize:CGSizeMake(270, 14)];
    [surepasswordtxt autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:202];
    surepasswordtxt.placeholder=@"请再次输入新密码";
    surepasswordtxt.font=FOURTEEN;
    surepasswordtxt.clearButtonMode=UITextFieldViewModeWhileEditing;
    surepasswordtxt.secureTextEntry=YES;
    
    UIView *line2=[UIView newAutoLayoutView];
    [self.view addSubview:line2];
    [line2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:newpss withOffset:10];
    [line2 autoSetDimensionsToSize:CGSizeMake(225, 1)];
    [line2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:surepasswordtxt withOffset:5];
    line2.backgroundColor=k888888;
    
    
    completeBtn=[UIButton newAutoLayoutView];
    [self.view addSubview:completeBtn];
    completeBtn.backgroundColor=kB8B8B8;
    [completeBtn setTitle:@"完成" forState:0];
    completeBtn.titleLabel.font=FIFTEEN;
    [completeBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-88, 40)];
    [completeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line2 withOffset:150];
    [completeBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    completeBtn.layer.cornerRadius=4;
    completeBtn.userInteractionEnabled=NO;
    
    
    
}

#pragma mark--通知
-(void)change:(NSNotification *)notification
{

    if (newpasswordtxt.text.length>0 && surepasswordtxt.text.length>0) {
        
        completeBtn.userInteractionEnabled=YES;
        completeBtn.backgroundColor=k000000;
    }else{
        completeBtn.userInteractionEnabled=NO;
        completeBtn.backgroundColor=kD8D8D8;
    }
}

-(void)completeBtnClick{
    
    if (newpasswordtxt.text.length>5 && surepasswordtxt.text.length>5) {
        if ([newpasswordtxt.text isEqualToString:surepasswordtxt.text]) {
            NSDictionary *dic=@{@"mobi":_phoneNum,@"pwd":newpasswordtxt.text,@"confirmPwd":surepasswordtxt.text};
            [self showNHUD];
            [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kResetPassword] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                [self NhideHUD:YES];
                if ([responseObject[@"code"] intValue]==200) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
                [self NhideHUD:YES];
            }];
        }else{
            [self displayNHUDTitle:@"两次密码输入不一致"];
        }
    }else{
        [self displayNHUDTitle:@"请输入6位数以上密码"];
    }
    

    
    
    

}



-(void)popbackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage =nil;
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
