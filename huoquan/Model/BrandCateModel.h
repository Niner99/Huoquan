//
//  BrandCateModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BrandCateModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*brandLogoId;
@property (nonatomic, strong) NSString <Optional>*brandName;
@property (nonatomic, strong) NSString <Optional>*pkId;
@end

@interface CategoryModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*categoryName;
@property (nonatomic, strong) NSString <Optional>*categoryPic;
@property (nonatomic, strong) NSString <Optional>*pkId;
@end
