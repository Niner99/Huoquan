//
//  UIViewController+extend.m
//  Limintong
//
//  Created by 家瓷网 on 2017/3/29.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import "UIViewController+extend.h"
#import "NSString+EX.h"


@implementation UIViewController (extend)

- (void)loadItemWithCustomView:(UIView *)view position:(PPBarItemPosition)position
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    if (position == PPBarItemPosition_left) {
        [self.navigationItem setLeftBarButtonItem:item];

    }else if (position == PPBarItemPosition_right) {
        [self.navigationItem setRightBarButtonItem:item];

    }
}
//
//- (void)loadItemWithCustomView:(UIView *)view target:(id)target action:(SEL)action position:(PPBarItemPosition)position
//{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
//    
//    if (position == PPBarItemPosition_left) {
//        [self.navigationItem setLeftBarButtonItem:item];
//        
//    }else if (position == PPBarItemPosition_right) {
//        [self.navigationItem setRightBarButtonItem:item];
//    }
//    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:target action:action];
//    
//    
//}

-(void)loadTitleWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.font = [UIFont fontWithName:@"Helvetica" size:size];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    self.navigationItem.titleView = label;
}

- (UIButton *)loadItemWithImage:(UIImage *)image HighLightImage:(UIImage *)hlImage target:(id)target action:(SEL)action position:(PPBarItemPosition)position {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
   // btn.frame = CGRectMake(position == PPBarItemPosition_left ? 0 : kScreenWidth - 44, 0, 44, 44);
    btn.frame=CGRectMake(position ==PPBarItemPosition_left ? 0:kScreenWidth-20, 0, 20, 20);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hlImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    [self loadItemWithCustomView:btn position:position];
    return btn;
}

- (UIButton *)loadBackButtonWithTarger:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0,20,20);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self loadItemWithCustomView:btn position:PPBarItemPosition_left];
    return btn;
}

- (NSArray *)loadItemTwoImagesWithFirstImage:(UIImage *)firstImage  FirstHighlight:(UIImage *)firstHigh
                                 SecondImage:(UIImage *)secondImage  SecondHighlight:(UIImage *)secondHigh
                                      target:(id)target
                              firstBtnAction:(SEL)firstAction
                             secondBtnAction:(SEL)secondAction
                                    position:(PPBarItemPosition)position
{
    UIButton *first_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    first_btn.frame = CGRectMake(0, 0, 44, 44);
    [first_btn setImage:firstImage forState:UIControlStateNormal];
    [first_btn setImage:firstHigh forState:UIControlStateHighlighted];
    [first_btn addTarget:target action:firstAction forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *second_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    second_btn.frame = CGRectMake(44, 0, 44, 44);
    [second_btn setImage:secondImage forState:UIControlStateNormal];
    [second_btn setImage:secondHigh forState:UIControlStateHighlighted];
    [second_btn addTarget:target action:secondAction forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [backView addSubview:first_btn];
    [backView addSubview:second_btn];
    NSArray *array = @[first_btn, second_btn];
    [self loadItemWithCustomView:backView position:position];
    return array;
}


- (UIButton *)loadItemWithTitle:(NSString *)title font:(UIFont *)titlefont target:(id)target action:(SEL)action position:(PPBarItemPosition)position{
    float text_w = [NSString widthOfStr:title font:[UIFont fontWithName:@"Helvetica" size:15.0f] height:44] + 16;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(position == PPBarItemPosition_left ? 0 : kScreenWidth - text_w, 0, text_w, 44);
   // btn.titleEdgeInsets = UIEdgeInsetsMake(0, position == PPBarItemPosition_left ? 16 : 0, 0, position == PPBarItemPosition_left ? 0 : 16);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:k010101 forState:UIControlStateNormal];
    [btn.titleLabel setFont:titlefont];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self loadItemWithCustomView:btn position:position];
    return btn;
}


-(UIButton *)loadItemWithTitleAndImage:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action position:(PPBarItemPosition)position{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,65, 17)];
    btn.titleLabel.font=FIFTEEN;
    [btn setTitle:title forState:0];
    [btn setImage:image forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0,-25, 0,0);
    btn.titleLabel.textAlignment=NSTextAlignmentLeft;
    btn.imageEdgeInsets=UIEdgeInsetsMake(0, 65-13, 0, 0);
    [self loadItemWithCustomView:btn position:position];
    return btn;
}

- (UIButton *)loadinventory:(NSString *)title target:(id)target action:(SEL)action position:(PPBarItemPosition)position{
    float text_w = [NSString widthOfStr:title font:[UIFont fontWithName:@"Helvetica" size:15.0f] height:44] + 16;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 73, 30)];
    btn.frame = CGRectMake(position == PPBarItemPosition_left ? 0 : kScreenWidth - text_w, 0,73, 30);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:TWELVE];
    btn.backgroundColor=kDABF66;
    btn.layer.cornerRadius=4;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self loadItemWithCustomView:btn position:position];
    return btn;
}








//计算缓存的大小    一部分是使用SDWebImage缓存的内容，其次可能存在自定义的文件夹中的内容（视频，音频等内容）
-(NSString *)readCacheSize
{

    unsigned long long size =
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CustomFile"].fileSize;
    
    size += [SDImageCache sharedImageCache].getSize;
    
    NSString *sizeText = nil;
    if (size >= pow(10, 9)) {
        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    }else if (size >= pow(10, 6)) {
        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    }else if (size >= pow(10, 3)) {
        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    }else {
        sizeText = [NSString stringWithFormat:@"%zdB", size];
    }
    
    return sizeText;
}


-(void)writeToCache:(NSString *)urlStr{
    NSString * htmlResponseStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr]encoding:NSUTF8StringEncoding error:nil];
    
    //创建文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //获取document路径
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,      NSUserDomainMask, YES) objectAtIndex:0];
    
    [fileManager createDirectoryAtPath:[cachesPath stringByAppendingString:@"/Caches"] withIntermediateDirectories:YES attributes:nil error:nil];
    //写入路径
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[urlStr hash]]];
    
    [htmlResponseStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}



































@end
