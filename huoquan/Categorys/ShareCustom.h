//
//  ShareCustom.h
//  Limintong
//
//  Created by 家瓷网 on 2017/4/1.
//  Copyright © 2017年 limintong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
@interface ShareCustom : NSObject

+(void)shareWithContent:(id)publishContent;//自定义分享界面

@end
