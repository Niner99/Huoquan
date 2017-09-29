//
//  HomeTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/11.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) UIImageView *goodsimage;

@property (nonatomic, strong) UILabel *goodsname;
@property (nonatomic, strong) UILabel *huoprice;
@property (nonatomic, strong) UILabel *marketprice;

@property (nonatomic, strong) UILabel *quantitylabel;

@property (nonatomic, strong) NSString *leftQuantity;
@end
