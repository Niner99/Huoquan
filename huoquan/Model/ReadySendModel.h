//
//  ReadySendModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/7.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>




@protocol ReadySendModel;
@interface TestShopDataModel : JSONModel


@property (nonatomic, strong) NSArray <ReadySendModel,Optional>*data;
@end







@interface ReadySendModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*brandName;
@property (nonatomic, strong) NSString <Optional>*detailId;
@property (nonatomic, strong) NSString <Optional>*goodsId;
@property (nonatomic, strong) NSString <Optional>*goodsName;
@property (nonatomic, strong) NSString <Optional>*goodsPrice;
@property (nonatomic, strong) NSString <Optional>*mainPicture;
@property (nonatomic, strong) NSString <Optional>*remainingQuantity;
@property (nonatomic, strong) NSString <Optional>*sellAttribute;
@property (nonatomic, strong) NSString <Optional>*amount;

@property (nonatomic, strong) NSString <Optional>*plus_count;
@end
