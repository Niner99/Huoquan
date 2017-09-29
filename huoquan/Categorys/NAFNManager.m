//
//  NAFNManager.m
//  LiMinTong1.0
//
//  Created by 家瓷网 on 2017/5/3.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import "NAFNManager.h"
#import "CodeManager.h"
@implementation NAFNManager
+ (instancetype)sharedTool {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
     //   instance = [[self alloc] initWithBaseURL:nil];
        instance=[self manager];
    });
    
    return instance;
}



+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [self sharedTool];
    /**
     *  可以接受的类型
     */
    
    NSString *tokk=kStandardUserDefaultsObject(kTokenHuoquan);

    [manager.requestSerializer setValue:tokk forHTTPHeaderField:@"access_token"];
    manager.requestSerializer.timeoutInterval =3;
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
          //  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            CodeManager *codeManager = [CodeManager sharedCodeManager];//add
            [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result) {
                failureBlock(task,error,result);
                FLog(@"网络异常 - T_T%@", error);
            }];
          
        }
    }];
    
}







+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager =[self sharedTool];
    manager.requestSerializer.timeoutInterval = 3;
    NSString *tokk=kStandardUserDefaultsObject(kTokenHuoquan);

    [manager.requestSerializer setValue:tokk forHTTPHeaderField:@"access_token"];
    manager.requestSerializer.timeoutInterval =3;
    NSDictionary *dicreal;
    if (tokk) {
        NSMutableDictionary *tempdic=[[NSMutableDictionary alloc]initWithObjects:@[tokk] forKeys:@[@"access_token"]];

        NSDictionary *dic=parameters;
        [tempdic addEntriesFromDictionary:dic];
        dicreal=(NSDictionary *)tempdic;
    }else{
        dicreal=parameters;
    }
    
    
    [manager POST:urlString parameters:dicreal progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
           // NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            CodeManager *codeManager = [CodeManager sharedCodeManager];//add
            [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result) {
                failureBlock(task,error,result);
            FLog(@"网络异常 - T_T%@", error);
            }];
        }
    }];
}
@end
