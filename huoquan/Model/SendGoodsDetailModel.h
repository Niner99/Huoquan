//
//  SendGoodsDetailModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/7.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MyOrderListModel.h"

@protocol OrderDetailModel;
@interface SendGoodsDetailModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*addTime;
@property (nonatomic, strong) NSString <Optional>*consignee;
@property (nonatomic, strong) NSString <Optional>*consigneeTel;
@property (nonatomic, strong) NSString <Optional>*deliveryAddress;
@property (nonatomic, strong) NSString <Optional>*deliveryCity;
@property (nonatomic, strong) NSString <Optional>*deliveryDistrict;
@property (nonatomic, strong) NSString <Optional>*deliveryNo;
@property (nonatomic, strong) NSString <Optional>*deliveryProvince;
@property (nonatomic, strong) NSArray <Optional,OrderDetailModel>*detailList;
@property (nonatomic, strong) NSString <Optional>*orderStatus;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*receivingDeadline;
@end
