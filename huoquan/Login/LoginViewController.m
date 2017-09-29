//
//  LoginViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/9.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "LoginViewController.h"
#import "RootVC.h"
#import "FindPasswordViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    UIButton *forgetbtn;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self loadTitleWithTitle:@"登录" color:k000000 fontSize:kTitleFloat];

    
    [self creatUI];
}


-(void)creatUI{

    
    _phoneicon=[UIImageView newAutoLayoutView];
    [self.view addSubview:_phoneicon];
    _phoneicon.image=[UIImage imageNamed:@"账号"];
    [_phoneicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:44];
    [_phoneicon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:232];
    [_phoneicon autoSetDimensionsToSize:CGSizeMake(16, 21)];
    
    _lineview=[UIView newAutoLayoutView];
    [self.view addSubview:_lineview];
    [_lineview autoSetDimensionsToSize:CGSizeMake(262, 1)];
    [_lineview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:70];
    [_lineview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:251];
    _lineview.backgroundColor=k888888;
    
    _phonetxt=[UITextField newAutoLayoutView];
    [self.view addSubview:_phonetxt];
    [_phonetxt autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
    [_phonetxt autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:231];
    [_phonetxt autoSetDimensionsToSize:CGSizeMake(270, 14)];
    _phonetxt.placeholder=@"请输入手机号";
    _phonetxt.font=FOURTEEN;
    _phonetxt.keyboardType=UIKeyboardTypeNumberPad;
    _phonetxt.clearButtonMode=UITextFieldViewModeWhileEditing;
 //   [_phonetxt addTarget:self action:@selector(phonetxtchange:) forControlEvents:UIControlEventTouchUpInside];
    
    _passwordicon=[UIImageView newAutoLayoutView];
    [self.view addSubview:_passwordicon];
    _passwordicon.image=[UIImage imageNamed:@"密码"];
    [_passwordicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:44];
    [_passwordicon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_phoneicon withOffset:26];
    [_passwordicon autoSetDimensionsToSize:CGSizeMake(16, 21)];
    
    UIView *lineview1=[UIView newAutoLayoutView];
    [self.view addSubview:lineview1];
    [lineview1 autoSetDimensionsToSize:CGSizeMake(262, 1)];
    [lineview1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:70];
    [lineview1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lineview withOffset:45];
    lineview1.backgroundColor=k888888;
    
    _passwordtxt=[UITextField newAutoLayoutView];
    [self.view addSubview:_passwordtxt];
    [_passwordtxt autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
    [_passwordtxt autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lineview withOffset:28];
    [_passwordtxt autoSetDimensionsToSize:CGSizeMake(270, 14)];
    _passwordtxt.placeholder=@"请输入密码";
    _passwordtxt.font=FOURTEEN;
    _passwordtxt.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passwordtxt.secureTextEntry=YES;
    
    
    forgetbtn=[UIButton newAutoLayoutView];
    [self.view addSubview:forgetbtn];
    [forgetbtn autoSetDimensionsToSize:CGSizeMake(65,12)];
    [forgetbtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_lineview];
    [forgetbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineview1 withOffset:15];
    forgetbtn.titleLabel.font=TWELVE;
    [forgetbtn setTitle:@"忘记密码" forState:0];
    [forgetbtn setTitleColor:kDABF66 forState:0];
    [forgetbtn setImage:[UIImage imageNamed:@"忘记密码"] forState:0];
    forgetbtn.imageEdgeInsets=UIEdgeInsetsMake(0, 50, 0, -50);
    forgetbtn.titleEdgeInsets=UIEdgeInsetsMake(0, -13, 0, 13);
    [forgetbtn addTarget:self action:@selector(findPassword) forControlEvents:UIControlEventTouchUpInside];
    
    
    _loginbtn=[UIButton newAutoLayoutView];
    [self.view addSubview:_loginbtn];
    _loginbtn.backgroundColor=kB8B8B8;
    [_loginbtn setTitle:@"登录" forState:0];
    _loginbtn.titleLabel.font=FIFTEEN;
    [_loginbtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-88, 40)];
    [_loginbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineview1 withOffset:73];
    [_loginbtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_loginbtn addTarget:self action:@selector(logintosendcode) forControlEvents:UIControlEventTouchUpInside];
    _loginbtn.layer.cornerRadius=4;
    _loginbtn.userInteractionEnabled=NO;

    
    UIImageView *imagekefu=[[UIImageView alloc]initWithFrame:CGRectMake(105, 607, 20, 15)];
    imagekefu.image=[UIImage imageNamed:@"客服电话"];
    [self.view addSubview:imagekefu];
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(135, 609, 200, 12)];
    phonelabel.text=@"客服电话：0755-25199098";
    phonelabel.font=TWELVE;
    phonelabel.textColor=k333333;
    [self.view addSubview:phonelabel];
}

#pragma mark 登录
-(void)logintosendcode{
    
    
    NSDictionary *dic=@{@"client_id":@"2b3bb4718b158dbfe4cc0ad11dd44e43",@"client_secret":@"e10adc3949ba59abbe56e057f20f883e",@"grant_type":@"password",@"scope":@"openid",@"username":_phonetxt.text,@"password":_passwordtxt.text};
    
    [self showNHUD];
    [NAFNManager postWithURLString:kLogin parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self NhideHUD:YES];
        NSString *tokenStr=responseObject[@"access_token"];
        kSaveStandardUserDefaults(tokenStr, kTokenHuoquan);
        [self statuslogin];
        

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        if ([result intValue]==400 || [result intValue]==401) {
            [self displayNHUDTitle:@"用户名或密码错误"];
        }
    }];
    
}

#pragma mark验证登录状态
-(void)statuslogin{
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCheckLogState] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *strii=responseObject[@"data"];
        if ([strii intValue]==1) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
            self.view.window.rootViewController = [[RootVC alloc] init];
        }else{
            if ([strii intValue]==0) {
                [self displayNHUDTitle:@"未注册"];
            }
            if ([strii intValue]==2) {
                [self displayNHUDTitle:@"待审核"];
            }
            if ([strii intValue]==3) {
                [self displayNHUDTitle:@"审核失败"];
            }
            if ([strii intValue]==4) {
                [self displayNHUDTitle:@"违规关闭"];
            }
        }
        

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
}




#pragma mark 找回密码
-(void)findPassword{
    FindPasswordViewController *findco=[FindPasswordViewController new];
    [self.navigationController pushViewController:findco animated:YES];
}







#pragma mark--通知
-(void)change:(NSNotification *)notification
{

    if (_phonetxt.text.length>11) {
        _phonetxt.text=[_phonetxt.text substringToIndex:11];
    }
    
    if (_phonetxt.text.length==11 && _passwordtxt.text.length>0) {
        
        _loginbtn.userInteractionEnabled=YES;
        _loginbtn.backgroundColor=k000000;
    }else{
        _loginbtn.userInteractionEnabled=NO;
        _loginbtn.backgroundColor=kD8D8D8;
    }
}




-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    // 通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:nil];
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
