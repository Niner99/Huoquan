//
//  TimeDetailModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/7.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TimeDetailModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*recordTime;
@property (nonatomic, strong) NSString <Optional>*sellQuantity;
@end
