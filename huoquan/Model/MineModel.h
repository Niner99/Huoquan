//
//  MineModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MineModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*franchiseeLogoPhoto;
@property (nonatomic, strong) NSString <Optional>*franchiseeName;
@property (nonatomic, strong) NSString <Optional>*loginName;
@property (nonatomic, strong) NSString <Optional>*pendingPaymentNum;
@property (nonatomic, strong) NSString <Optional>*tradeSuccessfullyNum;
@property (nonatomic, strong) NSString <Optional>*balance;
@end
