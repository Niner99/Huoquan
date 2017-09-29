//
//  SettingViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "LoginViewController.h"
#import "BaseNC.h"
#import "EditPasswordViewController.h"
#import "FeedbackViewController.h"
#import "AboutJiaciViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    JCAlertView *jcalert;
}
@end

@implementation SettingViewController
static NSString *cellone=@"cellone";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTitleWithTitle:@"设置" color:k000000 fontSize:kTitleFloat];
    
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.showsVerticalScrollIndicator=NO;
    // tv.separatorColor=[UIColor clearColor];
    [tv registerClass:[SettingTableViewCell class] forCellReuseIdentifier:cellone];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:tv];
    
    [self setlogoff];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellone];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.logoicon.image=[UIImage imageNamed:@"修改密码"];
            cell.titlelabel.text=@"修改密码";
        }if (indexPath.row==1) {
            cell.logoicon.image=[UIImage imageNamed:@"意见反馈"];
            cell.titlelabel.text=@"意见反馈";
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.logoicon.image=[UIImage imageNamed:@"清除缓存"];
            cell.titlelabel.text=@"清除缓存";
            cell.detaillabel.text=[self readCacheSize];
        }
//            if (indexPath.row==1) {
//            cell.logoicon.image=[UIImage imageNamed:@"检查更新"];
//            cell.titlelabel.text=@"检查更新";
//            cell.detaillabel.text=[NSString stringWithFormat:@"更新到V%@版本",kStandardUserDefaultsObject(kAppVersonCode)];
//        }
    }if (indexPath.section==2) {
        cell.logoicon.image=[UIImage imageNamed:@"关于"];
        cell.titlelabel.text=@"关于家瓷网";
    }
    
    
    return cell;
}


-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
        
    }if (section==1) {
        return 1;
    }if (section==2) {
        return 1;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 6)];
    
    view.backgroundColor=kF8F8F8;
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //修改密码
            EditPasswordViewController *editpass=[EditPasswordViewController new];
            [self.navigationController pushViewController:editpass animated:YES];
            
        }if (indexPath.row==1) {
            //意见反馈
            FeedbackViewController *feed=[FeedbackViewController new];
            [self.navigationController pushViewController:feed animated:YES];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [self clearCacheClick];
        }
    }if (indexPath.section==2) {
        //关于家瓷网
        AboutJiaciViewController *abou=[AboutJiaciViewController new];
        [self.navigationController pushViewController:abou animated:YES];
    }
    
}

-(void)updateVersion{
    NSDictionary *infoDictionary=[[NSBundle mainBundle]infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *currentVersion=[infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString *verStr=kStandardUserDefaultsObject(kAppVersonCode);
    
    if ([verStr floatValue]>[currentVersion floatValue]) {
        
        PopWindowView *popview=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) singleTitle:@"是否更新到最新版本？" leftBtn:@"取消" rightBtn:@"更新"];
        
        [popview.leftBtn addTarget:self action:@selector(cancelpopview) forControlEvents:UIControlEventTouchUpInside];
        [popview.rightBtn addTarget:self action:@selector(update_newVerson) forControlEvents:UIControlEventTouchUpInside];
        jcalert=[[JCAlertView alloc]initWithCustomView:popview dismissWhenTouchedBackground:NO];
        [jcalert show];
    }
}
-(void)cancelpopview{
    [jcalert dismissWithCompletion:^{
        jcalert=nil;
        
    }];
}
#pragma mark 更新到最新版本
-(void)update_newVerson{
    [jcalert dismissWithCompletion:^{
        jcalert=nil;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%AE%B6%E7%93%B7%E7%BD%91/id1181737557?mt=8"]];
    }];
}
#pragma mark-退出登录视图
-(void)setlogoff{
    
    UIButton *logoff=[UIButton newAutoLayoutView];
    [tv addSubview:logoff];
    [logoff autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 41)];
    logoff.backgroundColor=k000000;
    [logoff autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:500*HH];
    [logoff autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [logoff setTitle:@"退出账号" forState:0];
    logoff.titleLabel.font=FIFTEEN;
    logoff.layer.cornerRadius=4;
    [logoff addTarget:self action:@selector(btn_logoff) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

#pragma mark-退出登录
-(void)btn_logoff{
    kRemoveStandardUserDefaults(kTokenHuoquan);
    [self.navigationController popViewControllerAnimated:YES];
    LoginViewController *lauchvc=[LoginViewController new];
    BaseNC *nc=[[BaseNC alloc]initWithRootViewController:lauchvc];
    self.view.window.rootViewController=nc;
}


#pragma mark清除缓存
- (void)clearCacheClick
{
    [self showNHUD];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:GYLCustomFile error:nil];
            [mgr createDirectoryAtPath:GYLCustomFile withIntermediateDirectories:YES attributes:nil error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self NhideHUD:YES];
                NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:1];
                SettingTableViewCell *cell = (SettingTableViewCell *)[tv cellForRowAtIndexPath:path];
                cell.detaillabel.text=[self readCacheSize];
                // 设置文字
            });
        });
    }];
}

-(void)up_app{
    //获取手机程序的版本号
    NSString *ver = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
    NSDictionary *dic=@{@"id":@"com.huoquan.huoquan"};
    
    [NAFNManager postWithURLString:@"https://itunes.apple.com/lookup" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = responseObject[@"results"]; if (array.count != 0) {
            // 先判断返回的数据是否为空
            NSDictionary *dict = array[0];
            //判断版本[dict[@"version"] floatValue] > [ver floatValue]
            if (dict[@"version"] > ver) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"更新到最新版本吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil] ;
                alert.delegate = self;
                alert.tag = 222;
                [alert show];
            }
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];

}

#pragma mark - AlertViewDelegate 
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 222) {
        if (buttonIndex == 1) {
            UIApplication *application = [UIApplication sharedApplication];
            [application openURL:[NSURL URLWithString:@"AppStore的下载地址"]];
        }
    }
}



-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}


-(void)viewWillAppear:(BOOL)animated{
 //   [self updateVersion];
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
