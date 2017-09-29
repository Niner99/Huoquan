//
//  HomeCateModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/4.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeCateModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*categoryId;
@property (nonatomic, strong) NSString <Optional>*categoryName;
@property (nonatomic, strong) NSString <Optional>*categoryPic;
@end
