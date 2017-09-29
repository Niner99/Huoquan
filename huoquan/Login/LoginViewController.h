//
//  LoginViewController.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/9.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "BaseVC.h"

@interface LoginViewController : BaseVC
@property (nonatomic, assign) NSInteger lastnum;

@property (nonatomic, strong) UIButton *loginbtn;

@property (nonatomic, strong) UIImageView *phoneicon;

@property (nonatomic, strong) UITextField *phonetxt;

@property (nonatomic, strong) UIImageView *passwordicon;

@property (nonatomic, strong) UITextField *passwordtxt;
@property (nonatomic, strong) UIView *lineview;



@end
