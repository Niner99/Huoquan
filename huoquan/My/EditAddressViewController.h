//
//  EditAddressViewController.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "BaseVC.h"

@interface EditAddressViewController : BaseVC
@property (nonatomic, strong) NSString *titelabel;
@property (nonatomic, strong) NSString *btntitle;

@property (nonatomic, strong) NSString *consignee;
@property (nonatomic, strong) NSString *phonenum;
@property (nonatomic, strong) NSString *addressdetail;
@property (nonatomic, strong) NSString *provincetxt;
@property (nonatomic, strong) NSString *isDefault;
@property (nonatomic, strong) NSString *addressid;

@property (nonatomic, strong) NSString *provinceID;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *districtID;

@property (nonatomic, strong) NSString *province_name;
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSString *district_name;
@end
