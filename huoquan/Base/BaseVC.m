//
//  BaseVC.m
//  shepin
//
//  Created by 家瓷网 on 2017/7/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.extendedLayoutIncludesOpaqueBars=YES;
    if (self.navigationController && self.navigationController.viewControllers.firstObject != self) {
        [self loadBackBtn];
    }
   
    self.automaticallyAdjustsScrollViewInsets=NO;
}

//统一的返回按钮
- (UIButton *)loadBackBtn {
    _backbtn = [self loadBackButtonWithTarger:self action:@selector(backClick:)];
    return _backbtn;
}

- (void)backClick:(UIButton *)btn {
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.barTintColor=kBlack;
//    self.navigationController.navigationBar.translucent=NO;
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    
//    //去掉导航栏底部的黑线
//    
 //   self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //   self.navigationController.navigationBar.barTintColor=k000000;
    self.navigationController.navigationBar.translucent=NO;
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
