//
//  NAFNManager.h
//  LiMinTong1.0
//
//  Created by 家瓷网 on 2017/5/3.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef void (^SuccessBlock)(NSURLSessionDataTask * task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask * task, NSError *error, NSNumber *result);
@interface NAFNManager : AFHTTPSessionManager

+ (instancetype)sharedTool;

+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock;

+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;
@end
