//
//  CloudStorageModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/7.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CloudStorageModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*brandName;
@property (nonatomic, strong) NSString <Optional>*deliveredQuantity;
@property (nonatomic, strong) NSString <Optional>*goodsId;
@property (nonatomic, strong) NSString <Optional>*goodsName;
@property (nonatomic, strong) NSString <Optional>*goodsPrice;
@property (nonatomic, strong) NSString <Optional>*goodsQuantity;
@property (nonatomic, strong) NSString <Optional>*mainPicture;
@property (nonatomic, strong) NSString <Optional>*orderNo;
@property (nonatomic, strong) NSString <Optional>*orderStatus;
@property (nonatomic, strong) NSString <Optional>*orderVirtualId;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*remainingQuantity;
@property (nonatomic, strong) NSString <Optional>*sellAttribute;
@property (nonatomic, strong) NSString <Optional>*sellQuantity;
@property (nonatomic, strong) NSString <Optional>*skuId;
@property (nonatomic, strong) NSString <Optional>*skuNo;

@end
