//
//  MyOrderTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderTableViewCell : UITableViewCell
@property (nonatomic, strong) myLabel *titleLabel;


@property (nonatomic, strong) UIImageView *goodsIcon;


@property (nonatomic, strong) UILabel *goodsPrice;


@property (nonatomic, strong) UILabel *goodsColor;


@property (nonatomic, strong) UILabel *goodsNum;


@property (nonatomic, strong) NSString *ordername;
@end
