//
//  CodeManager.h
//  Limintong
//
//  Created by 家瓷网 on 2017/4/20.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeManager : NSObject
+ (instancetype)sharedCodeManager;

#pragma mark - Error Code Handler
- (void)errorCode:(NSHTTPURLResponse *)httpResponse Error:(NSError *)neterror response:(void(^)(NSError *error, NSNumber *result))response;
@end
