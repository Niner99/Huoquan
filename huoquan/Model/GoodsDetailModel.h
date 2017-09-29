//
//  GoodsDetailModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SkuModel;


@interface GoodsDetailModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*brandName;
@property (nonatomic, strong) NSString <Optional>*delMark;
@property (nonatomic, strong) NSString <Optional>*goodsId;
@property (nonatomic, strong) NSString <Optional>*goodsName;
@property (nonatomic, strong) NSString <Optional>*goodsStatus;
@property (nonatomic, strong) NSString <Optional>*mainPicture;
@property (nonatomic, strong) NSArray <Optional,SkuModel>*sku;

@end


@interface SkuModel : JSONModel

@property (nonatomic, strong) NSString *goodsPrice;
@property (nonatomic, strong) NSString *markPrice;
@property (nonatomic, strong) NSString *minPurchaseQuantity;
@property (nonatomic, strong) NSString *skuNo;
@property (nonatomic, strong) NSString *specId;
@property (nonatomic, strong) NSString *specName;
@property (nonatomic, strong) NSString *specStock;

@end
