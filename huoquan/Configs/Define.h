//
//  Define.h
//  test
//
//  Created by 家瓷网 on 2017/3/28.
//  Copyright © 2017年 test. All rights reserved.
//

#ifndef Define_h
#define Define_h
#import "UIColor+Color.h"


/*
 color
 */





#define kColorWithCode(string)                  ((UIColor *)[UIColor colorWithString:string])
#define kColorWithRGBHalf(_R,_G,_B)             ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:0.5])

#define kColorWithRGB(_R,_G,_B)                 ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:1])

/*
 screen size
 */
#define kScreenWidth                            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                           [UIScreen mainScreen].bounds.size.height

#define weakify(var)   __weak typeof(var) weakSelf = var
#define strongify(var) __strong typeof(var) strongSelf = var

/*
 *  Standard UserDefaults
 */
#define kStandardUserDefaults                   [NSUserDefaults standardUserDefaults]
#define kStandardUserDefaultsObject(_KEY)       [kStandardUserDefaults objectForKey:_KEY]
#define kSaveStandardUserDefaults(_O,_K)        [kStandardUserDefaults setObject:_O forKey:_K]
#define kRemoveStandardUserDefaults(_K)         [kStandardUserDefaults removeObjectForKey:_K]
#define kStandardUserDefaultsSync               [kStandardUserDefaults synchronize]


















#endif /* Define_h */
