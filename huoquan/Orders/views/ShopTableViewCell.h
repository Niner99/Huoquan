//
//  ShopTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/18.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopTableViewCell;
@protocol ShopcarCellDelegate <NSObject>

// 点击单个商品选择按钮回调
- (void)productSelected:(ShopTableViewCell *)cell isSelected:(BOOL)choosed;

- (void)countgoodsnum:(NSInteger )goodsnum cell:(ShopTableViewCell *)cell;
@end

@interface ShopTableViewCell : UITableViewCell
@property (nonatomic, strong) myLabel *titleLabel;


@property (nonatomic, strong) UIImageView *goodsicon;

@property (nonatomic, strong) UIButton *checkicon;

@property (nonatomic, strong) UILabel *goodsPrice;


@property (nonatomic, strong) UILabel *goodsColor;


@property (nonatomic, strong) UIButton *cutbtn;

@property (nonatomic, strong) UIButton *plusbtn;

@property (nonatomic, strong) UILabel *numlabel;
@property (nonatomic, assign) NSInteger countsnum;

@property (nonatomic, assign) NSInteger min_num;

@property (nonatomic, assign) NSInteger max_stock;

@property (nonatomic,assign) id<ShopcarCellDelegate>shopcardelegate;
@end
