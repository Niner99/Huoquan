//
//  RootVC.h
//  shepin
//
//  Created by 家瓷网 on 2017/7/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNC.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "ShopViewController.h"
//#import "LoginViewController.h"

@interface RootVC : UITabBarController<UITabBarControllerDelegate>
+(instancetype)shareRootVC;
@end
