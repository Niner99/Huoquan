//
//  WithdrawInfoModel.h
//  huoquan
//
//  Created by apple on 2017/9/29.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WithdrawInfoModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*accountStatus;
@property (nonatomic, strong) NSString <Optional>*balance;
@property (nonatomic, strong) NSString <Optional>*bankCardAccountType;
@property (nonatomic, strong) NSString <Optional>*bankCardCode;
@property (nonatomic, strong) NSString <Optional>*bankCardId;
@property (nonatomic, strong) NSString <Optional>*bankCardType;
@property (nonatomic, strong) NSString <Optional>*bankName;
@property (nonatomic, strong) NSString <Optional>*bankUser;
@property (nonatomic, strong) NSArray <Optional>*rule;
@end
