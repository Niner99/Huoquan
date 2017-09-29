//
//  HomeHeaderView.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/15.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BrandTapBlock)(NSString *cateID,NSString *cateName);


@interface HomeHeaderView : UIView


-(instancetype)initWithFrame:(CGRect)frame cateAry:(NSArray *)cateAry;

@property (nonatomic, copy) BrandTapBlock tapAction;

@property (nonatomic, strong) NSArray *cateArray;

@end
