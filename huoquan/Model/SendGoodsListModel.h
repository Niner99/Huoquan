//
//  SendGoodsListModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/7.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SendGoodsListModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*addTime;
@property (nonatomic, strong) NSString <Optional>*confirmTime;//收货时间
@property (nonatomic, strong) NSString <Optional>*deliveryTime;//发货时间
@property (nonatomic, strong) NSString <Optional>*deliveryNo;
@property (nonatomic, strong) NSString <Optional>*orderStatus;
@property (nonatomic, strong) NSString <Optional>*pkId;

@end
