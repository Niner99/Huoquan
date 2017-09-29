//
//  BaseNC.m
//  shepin
//
//  Created by 家瓷网 on 2017/7/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "BaseNC.h"

@interface BaseNC ()

@end

@implementation BaseNC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.navigationBar.barTintColor=kColorGreenBG;
//        self.navigationBar.translucent=NO;//设置导航栏是否半透明
//        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        //去掉导航栏底部的黑线
        
     //   self.navigationBar.shadowImage = [UIImage new];
    }
    return self;
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
