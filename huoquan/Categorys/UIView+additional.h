//
//  UIView+additional.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/21.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZJViewBorder) {
    ZJViewBorderTop = 1<<1,
    ZJViewBorderLeft = 1<<2,
    ZJViewBorderBottom = 1<<3,
    ZJViewBorderRight = 1<<4,
};
@interface UIView (additional)
@property (nonatomic, assign) ZJViewBorder borderWhich;  
@end
