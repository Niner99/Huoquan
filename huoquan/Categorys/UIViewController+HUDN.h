//
//  UIViewController+HUD.h
//  Limintong
//
//  Created by 家瓷网 on 2017/4/20.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUDN)


-(void)LoaingView;

- (void)NhideHUD:(BOOL)animated;


-(void)showNHUD;


- (void)displayNHUDTitle:(NSString *)message;


@end
