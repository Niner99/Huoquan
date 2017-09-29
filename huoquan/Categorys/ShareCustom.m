//
//  ShareCustom.m
//  Limintong
//
//  Created by 家瓷网 on 2017/4/1.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import "ShareCustom.h"

@implementation ShareCustom
static id _publishContent;
+(void)shareWithContent:(id)publishContent
{
    _publishContent = publishContent;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor =[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.5];
    blackView.tag = 440;
    
    [window addSubview:blackView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick)];
    [blackView addGestureRecognizer:tap];
    
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth,216)];
    shareView.backgroundColor =[UIColor whiteColor];
    shareView.tag = 441;
    [window addSubview:shareView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shareView.frame.size.width, 45)];
    titleLabel.text = @"分享到";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
  //  titleLabel.textColor =kGray;
    titleLabel.backgroundColor = [UIColor clearColor];
    [shareView addSubview:titleLabel];
    
    UIView *lines=[[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 1)];
    lines.backgroundColor=kCCCCCC;
    [shareView addSubview:lines];
    
    
    
    
    NSArray *btnImages = [NSArray array];
//    
//    BOOL hasWX = NO;
//    if (![WXApi isWXAppInstalled]) {
//        //未安装微信客户端
//        [btnImages addObjectsFromArray:@[@"微信灰", @"朋友圈灰"]];
//    } else {
//        //已安装微信客户端
//        hasWX = YES;
//        [btnImages addObjectsFromArray:@[@"微信好友", @"朋友圈"]];
//    }
//    
//    BOOL hasQQ = NO;
//    if (![QQApiInterface isQQInstalled]) {
//        //未安装QQ客户端
//        [btnImages addObjectsFromArray:@[@"qq灰", @"空间灰"]];
//    } else {
//        //已安装QQ客户端
//        hasQQ = YES;
//        [btnImages addObjectsFromArray:@[@"QQ好友", @"空间"]];
//    }
    
    btnImages = @[@"微信好友", @"QQ好友", @"朋友圈"];
    NSArray *btnTitles = @[@"微信好友",  @"QQ好友", @"朋友圈"];
    for (NSInteger i=0; i<3; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(70+i*95,73,43,43)];
        button.center=CGPointMake(kScreenWidth/6.0*(2*i+1), 94);
        [button setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        
        button.tag = 331+i;
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:button];
        
        UILabel *buttonTitle=[[UILabel alloc]initWithFrame:CGRectMake(70+i*95,124,80,12)];
        buttonTitle.text=btnTitles[i];
        buttonTitle.center=CGPointMake(kScreenWidth/6.0*(2*i+1), 130);
        buttonTitle.font=TWELVE;
     //   buttonTitle.textColor=kColorShare;
        buttonTitle.textAlignment=NSTextAlignmentCenter;
        [shareView addSubview:buttonTitle];
        
//        if (kScreenHeight<500) {
//            button.frame=CGRectMake(15+i*80, 45*HH, 50, 50);
//            buttonTitle.frame=CGRectMake(15+i*80, 105*HH, 50, 50);
//            buttonTitle.font=[UIFont fontWithName:@"Helvetica" size:9];
//        }
//        if (!hasWX) {
//            if (button.tag == 331 || button.tag == 332) {
//                button.enabled = NO;
//            }
//        }
//        if (!hasQQ) {
//            if (button.tag == 333 || button.tag == 334) {
//                button.enabled = NO;
//            }
//        }
    }
    UIView *linevv=[[UIView alloc]initWithFrame:CGRectMake(0, 216-45-6, kScreenWidth, 6)];
    linevv.backgroundColor=kE4E4E4;
    [shareView addSubview:linevv];
    
    
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,216-45,kScreenWidth, 45)];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:0];
    cancleBtn.backgroundColor=[UIColor whiteColor];
    cancleBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:15];
    cancleBtn.tag = 339;
    [cancleBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:cancleBtn];
    
    
    blackView.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        //
        shareView.frame=CGRectMake(0, kScreenHeight-216, kScreenWidth,216);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        //
    }];
    
}

+(void)shareBtnClick:(UIButton *)btn
{
    //    FLog(@"%@",[ShareSDK version]);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //
        shareView.frame=CGRectMake(0, kScreenHeight, kScreenWidth,216);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        //
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
//        for (UIView *subView in window.subviews) {
//            if ([subView isKindOfClass:[ShareWinImage class]]) {
//                [UIView animateWithDuration:0.3 animations:^{
//                    subView.alpha = 0;
//                } completion:^(BOOL finished) {
//                    [subView removeFromSuperview];
//                }];
//                break;
//            }
//        }
    }];
    
    int shareType = 0;
    id publishContent = _publishContent;
    switch (btn.tag) {
        case 331:
        {
            shareType = SSDKPlatformSubTypeWechatSession;
        }
            break;
            
        case 332:
        {
            
            shareType = SSDKPlatformSubTypeQQFriend;
        }
            break;
            
        case 333:
        {
            shareType = SSDKPlatformSubTypeWechatTimeline;

        }
            break;

            
        default:
            break;
    }
    
    
    [ShareSDK share:shareType parameters:publishContent onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        //
        switch (state) {
            case SSDKResponseStateSuccess:
                //
            {
                
            }
                break;
            case SSDKResponseStateFail:
                //
            {
                
            }
                break;
            case SSDKResponseStateCancel:
                //
            {
                
            }
                break;
            default:
                break;
        }
        
    }];
    
}


+(void)tapclick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //
        shareView.frame=CGRectMake(0, kScreenHeight, kScreenWidth,216);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        //
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
//        for (UIView *subView in window.subviews) {
//            if ([subView isKindOfClass:[ShareWinImage class]]) {
//                [UIView animateWithDuration:0.3 animations:^{
//                    subView.alpha = 0;
//                } completion:^(BOOL finished) {
//                    [subView removeFromSuperview];
//                }];
//                break;
//            }
//        }
    }];
}
@end
