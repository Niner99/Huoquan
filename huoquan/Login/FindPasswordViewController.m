//
//  FindPasswordViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/10.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "NewPasswordViewController.h"

@interface FindPasswordViewController ()
{

    UIButton *codeBtn;
    UIButton *nextBtn;
    NSTimer *checkTimer;
    int timeout;//倒计时
    NSTimer * countDownTimer;
    
}
@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"找回密码" color:k000000 fontSize:kTitleFloat];
    [self loadItemWithImage:[UIImage imageNamed:@"取消导航栏"] HighLightImage:nil target:self action:@selector(popbackView) position:PPBarItemPosition_left];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:nil];
    [self creatUI];
}


-(void)creatUI{
    _phoneicon=[UIImageView newAutoLayoutView];
    [self.view addSubview:_phoneicon];
    _phoneicon.image=[UIImage imageNamed:@"手机号"];
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
    _passwordicon.image=[UIImage imageNamed:@"短信验证码"];
    [_passwordicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:44];
    [_passwordicon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_phoneicon withOffset:26];
    [_passwordicon autoSetDimensionsToSize:CGSizeMake(16, 21)];
    
    UIView *lineview1=[UIView newAutoLayoutView];
    [self.view addSubview:lineview1];
    [lineview1 autoSetDimensionsToSize:CGSizeMake(142, 1)];
    [lineview1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:70];
    [lineview1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lineview withOffset:45];
    lineview1.backgroundColor=k888888;
    
    _passwordtxt=[UITextField newAutoLayoutView];
    [self.view addSubview:_passwordtxt];
    [_passwordtxt autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
    [_passwordtxt autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lineview withOffset:28];
    [_passwordtxt autoSetDimensionsToSize:CGSizeMake(270, 14)];
    _passwordtxt.placeholder=@"请输入验证码";
    _passwordtxt.font=FOURTEEN;
    _passwordtxt.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passwordtxt.keyboardType=UIKeyboardTypeNumberPad;
    
    codeBtn=[UIButton newAutoLayoutView];
    [self.view addSubview:codeBtn];
    [codeBtn autoSetDimensionsToSize:CGSizeMake(109, 38)];
    [codeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_lineview];
    [codeBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:lineview1];
    codeBtn.backgroundColor=kDABF66;
    [codeBtn setTitle:@"获取验证码" forState:0];
    codeBtn.titleLabel.font=THIRTEEN;
    [codeBtn addTarget:self action:@selector(getMessagecode) forControlEvents:UIControlEventTouchUpInside];
    

    _loginbtn=[UIButton newAutoLayoutView];
    [self.view addSubview:_loginbtn];
    _loginbtn.backgroundColor=kB8B8B8;
    [_loginbtn setTitle:@"下一步" forState:0];
    _loginbtn.titleLabel.font=FIFTEEN;
    [_loginbtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-88, 40)];
    [_loginbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineview1 withOffset:73];
    [_loginbtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_loginbtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _loginbtn.layer.cornerRadius=4;
    _loginbtn.userInteractionEnabled=NO;

    
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

#pragma mark 获取验证码
-(void)getMessagecode{
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    
    
    NSString *signStr=[NSString stringWithFormat:@"mobi=%@&time=%@",_phonetxt.text,currentTimeString];
    FLog(@"%@",signStr);
    NSString *md5Sign=[NSString md5:signStr];
    
    NSString *sixStr=[md5Sign substringFromIndex:md5Sign.length-6];
    FLog(@"%@",md5Sign);
    NSDictionary *dic=@{@"mobi":_phonetxt.text,@"time":currentTimeString,@"sign":sixStr};
    FLog(@"%@",dic);
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kSendCode] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]==200) {
            [self fireCheckTimer];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
    
}



#pragma mark-下一步
-(void)nextBtnClick{
    NSDictionary *dic=@{@"mobi":_phonetxt.text,@"vcode":_passwordtxt.text};
    [self showNHUD];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kCheckCode] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            NewPasswordViewController *newps=[[NewPasswordViewController alloc]init];
            newps.phoneNum=_phonetxt.text;
            [self.navigationController pushViewController:newps animated:YES];
        }else{
            [self displayNHUDTitle:@"验证码错误"];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];


}

-(void)popbackView{
    [self.navigationController popViewControllerAnimated:YES];
}






#pragma mark - Fire Check Timer
- (void)fireCheckTimer {
    timeout=60;
    if (![checkTimer isValid]) {
        checkTimer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(refreshCountDownSec) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:checkTimer forMode:NSRunLoopCommonModes];
        [checkTimer fire];
    }
}

#pragma mark - 刷新验证码倒计时
- (void)refreshCountDownSec {
    timeout--;
    NSString *lblTimeTemp=[NSString stringWithFormat:@"%dS后重发",timeout];
    codeBtn.userInteractionEnabled=NO;
    codeBtn.backgroundColor=kB8B8B8;
    [codeBtn setTitle:lblTimeTemp forState:0];
    
    if (timeout <= 0) {
        if ([checkTimer isValid]) {
            [checkTimer invalidate];
        }
        [codeBtn setTitle:@"重新发送" forState:0];
        codeBtn.userInteractionEnabled=YES;
        codeBtn.backgroundColor=kDABF66;
        
        
    }
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
