//
//  CodeManager.m
//  Limintong
//
//  Created by 家瓷网 on 2017/4/20.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import "CodeManager.h"
static dispatch_once_t onceToken;
static CodeManager *_sharedCodeManager = nil;
@implementation CodeManager
+ (instancetype)sharedCodeManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedCodeManager = [[CodeManager alloc] init];
    });
    
    return _sharedCodeManager;
}

#pragma mark - Error Code Handler
- (void)errorCode:(NSHTTPURLResponse *)httpResponse Error:(NSError *)neterror response:(void(^)(NSError *error, NSNumber *result))response {
    //超时httpResponse为nil
    if (httpResponse == nil) {
        FLog(@"request timeout");
        
        if (neterror.code == -1009) {
            response(neterror, @1009);
        } else {
            response(neterror,@99);
        }
        return;
    }
    
    switch (httpResponse.statusCode) {
        case 401: {//授权失败，需重新登陆，返回1

            response(neterror,@401);
            kRemoveStandardUserDefaults(kTokenHuoquan);
        }
            break;
            
        case 400: {
            FLog(@"http error code == %ld URL = %@",(long)httpResponse.statusCode, httpResponse.URL);
            response(neterror,@400);
        }
            break;
        default://未处理的错误代码返回0
            FLog(@"http error code == %ld URL = %@",(long)httpResponse.statusCode, httpResponse.URL);
            response(neterror,@0);
            break;
    }
}
@end
