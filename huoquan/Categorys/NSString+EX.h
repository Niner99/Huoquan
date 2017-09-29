//
//  NSString+EX.h
//  PPBuyer
//
//  Created by sven on 15/4/20.
//  Copyright (c) 2015年 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EX)

+ (NSString *)UUID;
- (NSDictionary *)queryDictionaryFromString;
//- (NSString*)stringForMD5;
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font;
+ (NSString *)md5:(NSString *)str;

+ (CGFloat)heightOfStr:(NSString *)str
                  font:(UIFont *)font
                 width:(CGFloat)width;

+ (CGFloat)widthOfStr:(NSString *)str
                 font:(UIFont *)font
               height:(CGFloat)height;

+(NSString *)calNSStringWithStar:(NSString *)startStr End:(NSString *)endStr BaseStr:(NSString *)baseStr;



- (unsigned long long)fileSize;


+(BOOL) isValidateMobile:(NSString *)mobile;


+(NSString *)mobileChange:(NSString *)mobile;


+(NSString *)setTimewithString:(NSString *)timeString;//时间戳转化为时间

+(NSString *)setDaywithString:(NSString *)dayString;//时间戳转化为时间


+(NSString *)convertToJsonData:(NSDictionary *)dict;//字典转Json字符串

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;//JSON字符串转化为字典


+(NSString *)pointtwo:(NSString *)numValue;


+(NSString *)distanceTime:(NSString *)addtime deadlineTime:(NSString *)deadlineTime;


@end
