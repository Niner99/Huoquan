//
//  MyOrderListModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/7.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol OrderDetailModel;
@interface MyOrderListModel : JSONModel
@property (nonatomic, strong) NSArray <Optional,OrderDetailModel>*detailList;
@property (nonatomic, strong) NSString <Optional>*orderStatus;
@property (nonatomic, strong) NSString <Optional>*payType;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*totalMoney;
@property (nonatomic, strong) NSString <Optional>*virtualOrderNo;
@property (nonatomic, strong) NSString <Optional>*addTime;
@end


@interface OrderDetailModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*addTime;
@property (nonatomic, strong) NSString <Optional>*chainId;
@property (nonatomic, strong) NSString <Optional>*chainName;
@property (nonatomic, strong) NSString <Optional>*chainTelephone;
@property (nonatomic, strong) NSString <Optional>*deliveredQuantity;
@property (nonatomic, strong) NSString <Optional>*earningsScale;
@property (nonatomic, strong) NSString <Optional>*franchiseeId;
@property (nonatomic, strong) NSString <Optional>*goodsId;
@property (nonatomic, strong) NSString <Optional>*goodsName;
@property (nonatomic, strong) NSString <Optional>*goodsPic;
@property (nonatomic, strong) NSString <Optional>*goodsPrice;
@property (nonatomic, strong) NSString <Optional>*goodsQuantity;
@property (nonatomic, strong) NSString <Optional>*goodsScale;
@property (nonatomic, strong) NSString <Optional>*orderChainId;
@property (nonatomic, strong) NSString <Optional>*orderNo;
@property (nonatomic, strong) NSString <Optional>*orderSource;
@property (nonatomic, strong) NSString <Optional>*orderStatus;
@property (nonatomic, strong) NSString <Optional>*orderVirtualId;
@property (nonatomic, strong) NSString <Optional>*payType;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*remainingQuantity;
@property (nonatomic, strong) NSString <Optional>*sellAttribute;
@property (nonatomic, strong) NSString <Optional>*sellQuantity;
@property (nonatomic, strong) NSString <Optional>*sellScale;
@property (nonatomic, strong) NSString <Optional>*skuId;
@property (nonatomic, strong) NSString <Optional>*skuNo;
@property (nonatomic, strong) NSString <Optional>*totalMoney;


@property (nonatomic, strong) NSString <Optional>*goodsSpec;
@end
