//
//  Config.h
//  test
//
//  Created by 家瓷网 on 2017/3/28.
//  Copyright © 2017年 test. All rights reserved.
//

#ifndef Config_h
#define Config_h
#import "Define.h"
//color
#define kColorGreenBG                kColorWithCode(@"#47C86B")
//#define kColorGreenBG                kColorWithRGB(71,200,107)

#define AppRed                       kColorWithRGB(110,197,118)
#define k000000                      kColorWithCode(@"#000000")
#define kCCCCCC                      kColorWithCode(@"#CCCCCC")
#define k666666                      kColorWithCode(@"#666666")
#define kDABF66                      kColorWithCode(@"#DABF66")
#define k888888                      kColorWithCode(@"#888888")
#define kF9FBFB                      kColorWithCode(@"#F9FBFB")
#define kF3F4F9                      kColorWithCode(@"#F3F4F9")
#define kE4E4E4                      kColorWithCode(@"#E4E4E4")
#define k191919                      kColorWithCode(@"#191919")
#define k333333                      kColorWithCode(@"#333333")
#define kF5F5F5                      kColorWithCode(@"#F5F5F5")
#define k010101                      kColorWithCode(@"#010101")
#define kC34943                      kColorWithCode(@"#C34943")
#define kEEEEEE                      kColorWithCode(@"#EEEEEE")
#define kA9A9A9                      kColorWithCode(@"#A9A9A9")
#define kD8D8D8                      kColorWithCode(@"#D8D8D8")
#define kF8F8F8                      kColorWithCode(@"#F8F8F8")
#define kB8B8B8                      kColorWithCode(@"#B8B8B8")
#define kAAAAAA                      kColorWithCode(@"#AAAAAA")
#define kF1F1F1                      kColorWithCode(@"#F1F1F1")
#define kB1B1B1                      kColorWithCode(@"#B1B1B1")
#define kE9E9E9                      kColorWithCode(@"#E9E9E9")
#define k66DA69                      kColorWithCode(@"#66DA69")


//margin
#define kSideMargin             10
#define kTitleFloat             18


#define BOLD                        [UIFont fontWithName:@"Helvetica-Bold" size:20]

#define TWENTY                      [UIFont fontWithName:@"PingFangSC-Regular" size:20.0f]
#define EIGHTTEEN                   [UIFont fontWithName:@"PingFangSC-Regular" size:18.0f]
#define SEVENTEEN                   [UIFont fontWithName:@"PingFangSC-Regular" size:17.0f]
#define THIRTEEN                    [UIFont fontWithName:@"PingFangSC-Regular" size:13.0f]
#define TWELVE                      [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f]
#define FOURTEEN                    [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f]
#define FIFTEEN                     [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f]
#define ELEVEN                      [UIFont fontWithName:@"PingFangSC-Regular" size:11.0f]
#define TENFONT                     [UIFont fontWithName:@"PingFangSC-Regular" size:10.0f]
#define SIXTEEN                     [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f]
#define NINEFONT                    [UIFont fontWithName:@"PingFangSC-Regular" size:9.0f]
#define TWENTYFOUR                  [UIFont fontWithName:@"PingFangSC-Regular" size:24.0f]

#define STANDFONT                   [UIFont fontWithName:@"PingFangSC-Regular" size:15]
//log



#define kTokenHuoquan              @"kTokenHuoquan"
#define kselectIndex              @"kselectIndex"
#define kSearchArray              @"kSearchArray"
#define kfirstLogin               @"kfirstLogin"
#define kfreturnHome               @"kreturnHome"
#define kAppVersonCode               @"kAppVersonCode"
#define kAppVersonUrl               @"kAppVersonUrl"


#define kloadMoreString               @"已经没有更多商品啦"

#define HH                          kScreenHeight / 667.0
#define WW                          kScreenWidth / 375.0


#define     FLog(...)                   NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])


#define GYLCustomFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"MP3"]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)





#endif /* Config_h */
