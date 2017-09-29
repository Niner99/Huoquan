//
//  WalletRecodeModel.h
//  huoquan
//
//  Created by apple on 2017/9/28.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WalletRecodeModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*recordTime;
@property (nonatomic, strong) NSString <Optional>*recordType;
@property (nonatomic, strong) NSString <Optional>*recordTypeStr;
@property (nonatomic, strong) NSString <Optional>*changeType;
@property (nonatomic, strong) NSString <Optional>*changeMoney;
@property (nonatomic, strong) NSString <Optional>*pkId;

@end
