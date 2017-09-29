//
//  OnlineInventoryTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineInventoryTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *goodsIcon;


@property (nonatomic, strong) UILabel *goodstitle;


@property (nonatomic, strong) UILabel *goodsPrice;


@property (nonatomic, strong) UILabel *goodsNum;

@property (nonatomic, strong) UILabel *goodsOrder;

@property (nonatomic, strong) NSString *iconWidth;
@end
