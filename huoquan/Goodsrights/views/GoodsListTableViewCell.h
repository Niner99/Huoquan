//
//  GoodsListTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/16.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) UIImageView *goodsimage;

@property (nonatomic, strong) UILabel *goodsname;
@property (nonatomic, strong) UILabel *huoprice;
@property (nonatomic, strong) UILabel *marketprice;
@property (nonatomic, strong) NSString *leftQuantity;
@end
