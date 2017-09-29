//
//  SendShopTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoodsnumBlock)(NSString *goodsnum);




@interface SendShopTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *goodsIcon;


@property (nonatomic, strong) UILabel *goodstitle;


@property (nonatomic, strong) UILabel *goodsPrice;


@property (nonatomic, strong) UILabel *goodsNum;

@property (nonatomic, strong) UILabel *sendNum;

@property (nonatomic, strong) UIButton *cutbtn;

@property (nonatomic, strong) UIButton *plusbtn;

@property (nonatomic, strong) UILabel *numlabel;

@property (nonatomic, strong) UIButton *joinBtn;

@property (nonatomic, assign) NSInteger countsnum;

@property (nonatomic, assign) NSInteger max_goodsnum;

@property (nonatomic, copy) GoodsnumBlock goodsblock;
@end
