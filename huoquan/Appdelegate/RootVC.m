//
//  RootVC.m
//  shepin
//
//  Created by 家瓷网 on 2017/7/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()
{
    NSInteger tempnum;
}
@end
static RootVC *root;

@implementation RootVC

+(instancetype)shareRootVC{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!root) {
            root=[[self alloc]init];
        }
    });
    return root;
}//使用dispatch_once可以简化代码并且彻底保证线程安全，开发者无需担心加锁或同步。此外，dispatch_once更高效，它没有使用重量级的同步机制，若是那样做的话，每次运行代码前都要获取锁。
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomeViewController *hom=[HomeViewController new];
    BaseNC *n1=[[BaseNC alloc]initWithRootViewController:hom];
    
    ShopViewController *ne=[ShopViewController new];
    BaseNC *n2=[[BaseNC alloc]initWithRootViewController:ne];

    
    MyViewController *my=[MyViewController new];
    BaseNC *n4=[[BaseNC alloc]initWithRootViewController:my];
    
    
    NSArray *dataAry=@[n1,n2,n4];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    self.delegate=self;
    self.viewControllers=dataAry;
    NSArray *titleAry=@[@"首页",@"采购单",@"我的"];
    NSArray *imun=@[@"首页",@"购物车",@"我的"];
    NSArray *imary=@[@"首页点击状态",@"购物车点击状态",@"我的点击状态"];
    
    for (int i=0; i<3; i++) {
        UITabBarItem *item=self.tabBar.items[i];
        item.tag=1000+i;
        UIImage *imum=[UIImage imageNamed:imun[i]];
        imum=[imum imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *imar=[UIImage imageNamed:imary[i]];
        imar=[imar imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:kDABF66,NSFontAttributeName:ELEVEN} forState:UIControlStateSelected];
        
         [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:k888888,NSFontAttributeName:ELEVEN} forState:UIControlStateNormal];
        NSString *tit=titleAry[i];
        item=[item initWithTitle:tit image:imum selectedImage:imar];
        
    }
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSUInteger tabindex=[tabBar.items indexOfObject:item];
    if (tabindex!=self.selectedIndex) {
        tempnum=self.selectedIndex;
    }
//    if ((int)tabindex==2) {
//        if (kStandardUserDefaultsObject(kTokenHuoquan)) {
//            
//        }else{
//            
//            LoginViewController *log=[[LoginViewController alloc]init];
//            log.lastnum=tempnum;
//            BaseNC *navi=[[BaseNC alloc]initWithRootViewController:log];
//            
//            //  self.selectedIndex=tempnum;
//            NSString *tempindex=[NSString stringWithFormat:@"%ld",tempnum];
//            kSaveStandardUserDefaults(tempindex,kselectIndex);
//            [self presentViewController:navi animated:YES completion:^{
//                
//            }];
//            
//        }
//    }

    // 对应item 上面的子控制器（NavigationController）
    BaseNC *navVc = self.childViewControllers[tabindex] ;
    [navVc popToRootViewControllerAnimated:YES];
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
