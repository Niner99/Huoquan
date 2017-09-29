//
//  NSString+EX.m
//  PPBuyer
//
//  Created by sven on 15/4/20.
//  Copyright (c) 2015年 Sven. All rights reserved.
//

#import "NSString+EX.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (EX)


+ (NSString *)UUID {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    CFRelease(uuid);
    return uuidString;
}

- (NSDictionary *)queryDictionaryFromString {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSArray *components = [self componentsSeparatedByString:@"&"];
    for (NSString *component in components) {
        NSArray *keyAndValues = [component componentsSeparatedByString:@"="];
        [parameters setObject:[keyAndValues objectAtIndex:1] forKey:[[keyAndValues objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return parameters;
}

- (NSString*)stringForMD5 {
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

#pragma mark - 获取字符串自适应后所占高度
+ (CGFloat)heightOfStr:(NSString *)str
                  font:(UIFont *)font
                 width:(CGFloat)width
{
    CGSize rect;
    NSDictionary *dic=@{NSFontAttributeName:font};
    rect = [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic context:nil].size;
    
    return rect.height;
}

#pragma mark - 获取字符串自适应后所占宽度
+ (CGFloat)widthOfStr:(NSString *)str
                 font:(UIFont *)font
               height:(CGFloat)height
{
    CGSize rect;
    NSDictionary *dic=@{NSFontAttributeName:font};
    rect = [str boundingRectWithSize:CGSizeMake(10000, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic context:nil].size;
    
    return rect.width;
}


- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [self boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}
//md5 32位 加密 （小写）
+ (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr,(CC_LONG)strlen(cStr), result );
    NSMutableString *lastStr = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [lastStr appendFormat:@"%02X", result[i]];
    return [lastStr lowercaseString];
}

#pragma mark - 判断字符串是不是纯数字
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
#pragma mark --截取字符串中指定两个字符之间的字符串
+(NSString *)calNSStringWithStar:(NSString *)startStr End:(NSString *)endStr BaseStr:(NSString *)baseStr{
    
    NSRange start = [baseStr rangeOfString:startStr];
    NSRange end = [baseStr rangeOfString:endStr];
    NSString *sub = [baseStr substringWithRange:NSMakeRange(start.location+1, end.location-start.location-1)];
    return sub;
}



- (unsigned long long)fileSize
{
    unsigned long long size = 0;
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    
    BOOL isExist = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    if(!isExist) return size;
    
    if (isExist) {
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            
            size +=[mgr attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else
    {
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    return size;
}


+(BOOL) isValidateMobile:(NSString *)mobile
{
    /*
     //手机号以13， 15，18开头，八个 \\d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\\\D])|(18[0,0-9]))\\\\d{8}$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
     return [phoneTest evaluateWithObject:mobile];
     */
    
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[34578]([0-9]){9}"];
    return [phoneTest evaluateWithObject:mobile];
}

+(NSString *)mobileChange:(NSString *)mobile{
    
    NSString *strMobile=[mobile stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
    
    return strMobile;
    
}

+(NSString *)setTimewithString:(NSString *)timeString{
    NSTimeInterval time=[timeString doubleValue]/1000;
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

+(NSString *)setDaywithString:(NSString *)dayString{
    NSTimeInterval time=[dayString doubleValue]/1000;
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}


+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString *)pointtwo:(NSString *)numValue{
    CGFloat tempnum=[numValue floatValue];
    return [NSString stringWithFormat:@"%.2f",tempnum];
}

+(NSString *)distanceTime:(NSString *)addtime deadlineTime:(NSString *)deadlineTime{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate  *datenow = [NSDate dateWithTimeIntervalSince1970:[addtime doubleValue]/1000];//添加时间
    NSDate *deadtime = [NSDate dateWithTimeIntervalSince1970:[deadlineTime doubleValue]/1000];//截止时间
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:datenow toDate:deadtime options:0];
    
    NSString *dayStr = [NSString stringWithFormat:@"%ld天",(long)[d day]];
    
    NSString *hourStr = [NSString stringWithFormat:@"%ld小时",(long)[d hour]];
    
 //   NSString *minStr = [NSString stringWithFormat:@"%ld分钟",(long)[d minute]];
    
 //   NSString *secStr = [NSString stringWithFormat:@"%ld秒",(long)[d second]];
    
    NSInteger countDown=[d hour]*3600+[d minute]*60+[d second];
    
    if ([d day]>0) {
        return [NSString stringWithFormat:@"%@%@",dayStr,hourStr];
    }else{
        return [NSString stringWithFormat:@"%ld",countDown];
    }
}

@end
