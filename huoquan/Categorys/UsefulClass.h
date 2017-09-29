//
//  UsefulClass.h
//  Limintong
//
//  Created by 家瓷网 on 2017/3/31.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsefulClass : NSObject
//两个颜色的
+(NSMutableAttributedString *)setStr:(NSString *)textOne oneColor:(UIColor *)oneColor  textTwo:(NSString *)textTwo twoColor:(UIColor *)twoColor maintext:(NSString *)str;

/*一个颜色的*/
+(NSMutableAttributedString *)setStr:(NSString *)textOnly onlyColor:(UIColor *)onlyColor  maintext:(NSString *)str;


/*一个字体的*/
+(NSMutableAttributedString *)setStr:(NSString *)textOnly onlyFont:(UIFont *)onlyFont  maintext:(NSString *)str;


/*一个字体一个颜色的*/
+(NSMutableAttributedString *)setStr:(NSString *)textOnly colorWithFont:(UIFont *)textFont textColor:(UIColor *)textColor maintext:(NSString *)str;





@end
