//
//  UIViewController+HUD.m
//  Limintong
//
//  Created by 家瓷网 on 2017/4/20.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import "UIViewController+HUDN.h"
#import "MBProgressHUD+Appearance.h"
#import <objc/runtime.h>
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation MBProgressHUD (Plist)

+ (NSDictionary *)configuration
{
    NSDictionary *attributes = [[self appearance] HUDAttributes];
    if (attributes) return attributes;
    static NSDictionary *conf;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HUD" ofType:@"plist"];
        conf = [NSDictionary dictionaryWithContentsOfFile:path];
    });
    return conf;
}

@end
@implementation UIViewController (HUDN)




-(void)LoaingView{
    MBProgressHUD *hud = [self HUD];
    hud.mode = MBProgressHUDModeCustomView;
    hud.margin = 10.;
    hud.square = YES;
   // hud.size=CGSizeMake(102,46);
    hud.color=[UIColor clearColor];
    hud.labelFont = [UIFont fontWithName:@"Helvetica" size:13.];
    NSDictionary *conf = [[hud class] configuration];
    NSNumber *square = conf[HUDAttributeSquare];
    if (square) hud.square = [square boolValue];
  //  BOOL uppercase = [conf[HUDAttributeUppercase] boolValue];

    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"图层-1"],[UIImage imageNamed:@"图层-2"],[UIImage imageNamed:@"图层-3"],[UIImage imageNamed:@"图层-4"],[UIImage imageNamed:@"图层-5"],[UIImage imageNamed:@"图层-6"],[UIImage imageNamed:@"图层-7"],[UIImage imageNamed:@"图层-8"],[UIImage imageNamed:@"图层-9"],[UIImage imageNamed:@"图层-10"],[UIImage imageNamed:@"图层-11"],[UIImage imageNamed:@"图层-12"],nil];
    
  //  UIImageView *animateViw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层-1"]];
    UIImageView *animateViw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,122.4,55.2)];
    animateViw.animationImages = images;
    animateViw.contentMode = UIViewContentModeScaleAspectFill;
    animateViw.animationDuration = .6;
    animateViw.animationRepeatCount = 100;

    hud.customView = animateViw;
    [animateViw startAnimating];
}


-(void)showNHUD{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDModeIndeterminate;
    hud.opacity=1;
    hud.activityIndicatorColor = [UIColor whiteColor];
}



- (void)NhideHUD:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:animated];
}



-(void)displayNHUDTitle:(NSString *)message{
  //  MBProgressHUD *hud = [self HUD];
//    hud.square = NO;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(NhideHUD:)];
//    [hud addGestureRecognizer:tap];
//    hud.mode = MBProgressHUDModeText;
//    NSDictionary *conf = [[hud class] configuration];
//    BOOL uppercase = [conf[HUDAttributeUppercase] boolValue];
//    if (uppercase) {
//        hud.detailsLabelText = NSLocalizedString(message, nil).uppercaseString;
//    } else {
//        hud.detailsLabelText = NSLocalizedString(message, nil);
//    }
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = message;
//    
//    [hud hide:YES afterDelay:2.f];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor blackColor];
    showView.frame = CGRectMake(1, 1, 1, 1);
    showView.alpha = 1.0f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    UILabel *label = [[UILabel alloc] init];
    UIFont *font = FOURTEEN;
    CGRect labelRect = [message boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    label.frame = CGRectMake(10,7.5, ceil(CGRectGetWidth(labelRect)), CGRectGetHeight(labelRect));
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font =FOURTEEN;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [showView addSubview:label];
    showView.frame = CGRectMake((kScreenWidth - CGRectGetWidth(labelRect) - 20)/2,kScreenHeight-200, CGRectGetWidth(labelRect)+20, CGRectGetHeight(labelRect)+15);
    
    [UIView animateWithDuration:2.0 animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];
}







- (MBProgressHUD *)HUD
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        NSDictionary *conf = [[hud class] configuration];
        id fontName = conf[HUDAttributeLabelFont];
        if (fontName) {
            if ([fontName isKindOfClass:[UIFont class]]) {
                hud.labelFont = fontName;
            } else {
                BOOL iPad  = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
                CGFloat size = 0;
                if (iPad) size = [conf[@"labelFont.size_iPad"] floatValue];
                if (!size) size = [conf[@"labelFont.size"] floatValue];
                hud.labelFont = [UIFont fontWithName:fontName size:size];
            }
        }
        id detailFontName = conf[HUDAttributeDetailsLabelFont];
        if (detailFontName) {
            if ([detailFontName isKindOfClass:[UIFont class]]) {
                hud.detailsLabelFont = detailFontName;
            } else {
                BOOL iPad  = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
                CGFloat size = 0;
                if (iPad) size = [conf[@"detailsLabelFont.size_iPad"] floatValue];
                if (!size) size = [conf[@"detailsLabelFont.size"] floatValue];
                hud.detailsLabelFont = [UIFont fontWithName:fontName size:size];
            }
        }
        NSNumber *margin = conf[HUDAttributeMargin];
        if (margin) hud.margin = [margin floatValue];
    }
    return hud;
}






@end
