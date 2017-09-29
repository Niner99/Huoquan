//
//  BillInfoModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/8.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ReadySendModel.h"
@protocol ReadySendModel;
@interface BillInfoModel : JSONModel

@property (nonatomic, strong) NSDictionary <Optional>*address;
@property (nonatomic, strong) NSArray <Optional,ReadySendModel>*pitchOnlist;



@end
