//
//  ShopView.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/22.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"
@protocol ShopGoodsDelegate<NSObject>
@optional
-(void)choosegoods:(NSInteger)goodsnum specId:(NSString *)specId;

@end

@interface ShopView : UIView
@property (nonatomic, strong)UIImageView *smallicon;

@property (nonatomic, strong) UILabel *goodsname;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UILabel *leftNum;

@property (nonatomic, strong) UIButton *cutbtn;

@property (nonatomic, strong) UIButton *plusbtn;

@property (nonatomic, strong)UIButton *surebtn;
@property (nonatomic, strong)UIButton *cancelbt;

@property (nonatomic, assign) NSInteger countsnum;
@property (nonatomic, assign) NSInteger min_num;
@property (nonatomic, assign) NSInteger max_num;

@property (nonatomic, strong)UILabel *numlabel;

@property (nonatomic, weak) id<ShopGoodsDelegate> goodsdelegate;

-(instancetype)initWithFrame:(CGRect)frame model:(SkuModel *)skumodel detail:(GoodsDetailModel *)detailmodel;

@property (nonatomic, strong)NSString *specid;

@end
