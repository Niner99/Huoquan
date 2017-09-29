//
//  GoodsListModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GoodsListModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*goodsId;
@property (nonatomic, strong) NSString <Optional>*goodsName;
@property (nonatomic, strong) NSString <Optional>*goodsPrice;
@property (nonatomic, strong) NSString <Optional>*mainPicture;
@property (nonatomic, strong) NSString <Optional>*markePrice;
@property (nonatomic, strong) NSString <Optional>*stockQuantity;

@property (nonatomic, strong) NSString <Optional>*brandName;
@end
