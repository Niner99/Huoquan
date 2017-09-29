//
//  FeedbackViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/28.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "FeedbackViewController.h"
#import "JSTextView.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>
@interface FeedbackViewController ()<UITextViewDelegate>
{
    UILabel *numlabel;
    UITextField *txtphone;
    JSTextView *textview;
    UIButton *comitbtn;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTitleWithTitle:@"意见反馈" color:k000000 fontSize:kTitleFloat];
    [self creatUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:nil];
}


-(void)creatUI{
    txtphone=[[UITextField alloc]initWithFrame:CGRectMake(15, 103, kScreenWidth-30, 35)];
    txtphone.backgroundColor=kE9E9E9;
    txtphone.layer.borderWidth=1;
    txtphone.layer.borderColor=kD8D8D8.CGColor;
    txtphone.layer.cornerRadius=4;
    txtphone.placeholder=@" 请填写手机号码，方便我们与您联系";
    [self.view addSubview:txtphone];
    txtphone.font=TWELVE;
    txtphone.keyboardType=UIKeyboardTypeNumberPad;
    
    textview=[[JSTextView alloc]initWithFrame:CGRectMake(15, 151, kScreenWidth-30, 131)];
    textview.layer.cornerRadius=4;
    textview.layer.borderColor=k888888.CGColor;
    textview.layer.borderWidth=1;
    textview.font=TWELVE;
    textview.myPlaceholder=@" 对我们的产品、服务，您有什么建议吗？请告诉我们...";
    textview.myplaceholderFont=TWELVE;
    textview.myPlaceholderColor=k888888;
    textview.delegate=self;
    [self.view addSubview:textview];
    
    comitbtn=[UIButton newAutoLayoutView];
    [self.view addSubview:comitbtn];
    [comitbtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 41)];
    [comitbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [comitbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textview withOffset:90];
    comitbtn.layer.cornerRadius=4;
    [comitbtn setTitle:@"提交" forState:0];
    comitbtn.titleLabel.font=SIXTEEN;
    comitbtn.backgroundColor=kB8B8B8;
    [comitbtn addTarget:self action:@selector(commitadwice) forControlEvents:UIControlEventTouchUpInside];
    comitbtn.userInteractionEnabled=NO;
    
    numlabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-30-80-15, 109, 80, 12)];
    numlabel.text=@"0/200";
    numlabel.font=TWELVE;
    numlabel.textColor=k888888;
    numlabel.textAlignment=NSTextAlignmentRight;
    [textview addSubview:numlabel];
}


-(void)commitadwice{
    NSString *devicestr=[self deviceVersion];
    NSDictionary *dic=@{@"feedContent":textview.text,@"feedContant":txtphone.text,@"clientType":@"1",@"clientDetail":devicestr};
    [self showNHUD];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kFeedback] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
}


-(void)textViewDidChange:(UITextView *)textView{
    numlabel.text=[NSString stringWithFormat:@"%ld/200",textView.text.length];
    if (txtphone.text.length>11) {
        txtphone.text=[txtphone.text substringToIndex:11];
    }
    
    if (textview.text.length>199) {
        textview.text=[textview.text substringToIndex:199];
    }
    
    if (txtphone.text.length>0 &&textview.text.length>0 ) {
        
        comitbtn.userInteractionEnabled=YES;
        comitbtn.backgroundColor=k000000;
        
    }else{
        comitbtn.userInteractionEnabled=NO;
        comitbtn.backgroundColor=kB8B8B8;
        
    }
}

#pragma mark--通知
-(void)change:(NSNotification *)notification
{
    
    if (txtphone.text.length>11) {
        txtphone.text=[txtphone.text substringToIndex:11];
    }
    
    if (txtphone.text.length>0 &&textview.text.length>0 ) {
        
        comitbtn.userInteractionEnabled=YES;
        comitbtn.backgroundColor=k000000;
        
    }else{
        comitbtn.userInteractionEnabled=NO;
        comitbtn.backgroundColor=kB8B8B8;
        
    }
    
}



- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    return deviceString;
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
