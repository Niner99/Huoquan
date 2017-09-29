//
//  ZJImageMagnification.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/12.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJImageMagnification : NSObject

/**
 *  浏览大图
 *
 *  @param currentImageview 当前图片
 *  @param alpha            背景透明度
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview alpha:(CGFloat)alpha;

@end
