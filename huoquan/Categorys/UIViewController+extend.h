//
//  UIViewController+extend.h
//  Limintong
//
//  Created by 家瓷网 on 2017/3/29.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PPBarItemPosition)
{
    PPBarItemPosition_left,
    PPBarItemPosition_right,
};
@interface UIViewController (extend)
-(void)loadTitleWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size;


- (void)loadItemWithCustomView:(UIView *)view position:(PPBarItemPosition)position;


- (UIButton *)loadItemWithImage:(UIImage *)image HighLightImage:(UIImage *)hlImage target:(id)target action:(SEL)action position:(PPBarItemPosition)position ;
- (UIButton *)loadBackButtonWithTarger:(id)target action:(SEL)action;

- (NSArray *)loadItemTwoImagesWithFirstImage:(UIImage *)firstImage  FirstHighlight:(UIImage *)firstHigh
                                 SecondImage:(UIImage *)secondImage  SecondHighlight:(UIImage *)secondHigh
                                      target:(id)target
                              firstBtnAction:(SEL)firstAction
                             secondBtnAction:(SEL)secondAction
                                    position:(PPBarItemPosition)position;


- (UIButton *)loadItemWithTitle:(NSString *)title font:(UIFont *)titlefont  target:(id)target action:(SEL)action position:(PPBarItemPosition)position;



-(NSString *)readCacheSize;//获取缓存大小


- (UIButton *)loadItemWithTitleAndImage:(NSString *)title image:(UIImage *)image  target:(id)target action:(SEL)action position:(PPBarItemPosition)position;


-(void)writeToCache:(NSString *)urlStr;//网页写入缓存文件

- (UIButton *)loadinventory:(NSString *)title target:(id)target action:(SEL)action position:(PPBarItemPosition)position;










@end
