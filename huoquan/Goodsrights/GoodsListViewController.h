//
//  GoodsListViewController.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "BaseVC.h"

@interface GoodsListViewController : BaseVC
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) NSString *brandID;
@property (nonatomic, assign) NSInteger goodsstyle;

@property (nonatomic, strong) NSString *goodsTitle;
@end
