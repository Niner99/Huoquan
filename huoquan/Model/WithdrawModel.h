//
//  WithdrawModel.h
//  huoquan
//
//  Created by apple on 2017/9/28.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WithdrawModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*amount;
@property (nonatomic, strong) NSString <Optional>*commissionCharge;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*withdrawalStatus;
@property (nonatomic, strong) NSString <Optional>*withdrawalTime;
@end
