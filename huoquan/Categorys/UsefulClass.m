//
//  UsefulClass.m
//  Limintong
//
//  Created by 家瓷网 on 2017/3/31.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import "UsefulClass.h"

@implementation UsefulClass

+(NSMutableAttributedString *)setStr:(NSString *)textOne oneColor:(UIColor *)oneColor  textTwo:(NSString *)textTwo twoColor:(UIColor *)twoColor maintext:(NSString *)str{
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:textOne].location, [[noteStr string] rangeOfString:textOne].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:oneColor range:redRange];
    
    NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:textTwo].location, [[noteStr string] rangeOfString:textTwo].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:twoColor range:redRangeTwo];
    
    return noteStr;
}

+(NSMutableAttributedString *)setStr:(NSString *)textOnly onlyColor:(UIColor *)onlyColor maintext:(NSString *)str{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:textOnly].location, [[noteStr string] rangeOfString:textOnly].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:onlyColor range:redRange];
    
    return noteStr;
}

+(NSMutableAttributedString *)setStr:(NSString *)textOnly onlyFont:(UIFont *)onlyFont maintext:(NSString *)str{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:textOnly].location, [[noteStr string] rangeOfString:textOnly].length);
    [noteStr addAttribute:NSFontAttributeName value:onlyFont range:redRange];
    return noteStr;
}


+(NSMutableAttributedString *)setStr:(NSString *)textOnly colorWithFont:(UIFont *)textFont textColor:(UIColor *)textColor maintext:(NSString *)str{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:textOnly].location, [[noteStr string] rangeOfString:textOnly].length);
    [noteStr addAttribute:NSFontAttributeName value:textFont range:redRange];
    
    NSRange redRange1 = NSMakeRange([[noteStr string] rangeOfString:textOnly].location, [[noteStr string] rangeOfString:textOnly].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:textColor range:redRange1];
    
    return noteStr;
}

@end
