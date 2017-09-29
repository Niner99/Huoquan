//
//  CatogoryCollectionViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/17.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "CatogoryCollectionViewCell.h"

@implementation CatogoryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _branicon=[UIImageView newAutoLayoutView];
        [self addSubview:_branicon];
        [_branicon autoSetDimensionsToSize:CGSizeMake(54, 54)];
        [_branicon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [_branicon autoAlignAxisToSuperviewAxis:ALAxisVertical];
        _branicon.layer.cornerRadius=27;
        _branicon.layer.masksToBounds=YES;
        _branicon.layer.borderColor=kD8D8D8.CGColor;
        _branicon.layer.borderWidth=1;
        
        _brandLabel=[UILabel newAutoLayoutView];
        [self addSubview:_brandLabel];
        [_brandLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_brandLabel autoSetDimensionsToSize:CGSizeMake(60, 12)];
        [_brandLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_branicon withOffset:15];
        _brandLabel.font=TWELVE;
        _brandLabel.textColor=k333333;
        _brandLabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

@end
