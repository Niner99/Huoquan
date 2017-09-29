//
//  ShopCarModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/6.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ShopCarModel;
@interface ShopWalletCarModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*accountStatus;
@property (nonatomic, strong) NSString <Optional>*balance;
@property (nonatomic, strong) NSArray <Optional,ShopCarModel>*goodsCart;

@end




@interface ShopCarModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*amount;
@property (nonatomic, strong) NSString <Optional>*cartId;
@property (nonatomic, strong) NSString <Optional>*chainId;
@property (nonatomic, strong) NSString <Optional>*goodsId;
@property (nonatomic, strong) NSString <Optional>*goodsName;
@property (nonatomic, strong) NSString <Optional>*goodsPrice;
@property (nonatomic, strong) NSString <Optional>*goodsStatus;
@property (nonatomic, strong) NSString <Optional>*mainPicture;
@property (nonatomic, strong) NSString <Optional>*markPrice;
@property (nonatomic, strong) NSString <Optional>*minPurchaseQuantity;
@property (nonatomic, strong) NSString <Optional>*skuId;
@property (nonatomic, strong) NSString <Optional>*specName;
@property (nonatomic, strong) NSString <Optional>*specStock;
@property (nonatomic, strong) NSString <Optional>*isSelect;
@end
