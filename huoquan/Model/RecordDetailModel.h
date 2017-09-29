//
//  RecordDetailModel.h
//  huoquan
//
//  Created by apple on 2017/9/28.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RecordDetailModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*afterChangeMoney;
@property (nonatomic, strong) NSString <Optional>*changeMoney;
@property (nonatomic, strong) NSString <Optional>*changeType;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*recordTime;
@property (nonatomic, strong) NSString <Optional>*recordType;
@property (nonatomic, strong) NSString <Optional>*remark;
@property (nonatomic, strong) NSString <Optional>*runningNo;
@property (nonatomic, strong) NSString <Optional>*recordTypeStr;
@end
