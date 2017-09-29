//
//  AddressModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddressModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*cityId;
@property (nonatomic, strong) NSString <Optional>*consignee;
@property (nonatomic, strong) NSString <Optional>*defaultFlag;
@property (nonatomic, strong) NSString <Optional>*districtId;
@property (nonatomic, strong) NSString <Optional>*fullAddress;
@property (nonatomic, strong) NSString <Optional>*jsonAddress;
@property (nonatomic, strong) NSString <Optional>*mobile;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*provinceId;
@property (nonatomic, strong) NSString <Optional>*telephone;
@property (nonatomic, strong) NSString <Optional>*zip;


@end
