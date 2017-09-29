//
//  ShopBottomView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/21.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "ShopBottomView.h"

@implementation ShopBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        _allselect=[UIButton newAutoLayoutView ];
        [self addSubview:_allselect];
        [_allselect autoSetDimensionsToSize:CGSizeMake(19, 19)];
        [_allselect autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_allselect autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_allselect setImage:[UIImage imageNamed:@"未选"] forState:0];
        [_allselect setImage:[UIImage imageNamed:@"选中黄"] forState:UIControlStateSelected];
        
        _quanxuan=[UILabel newAutoLayoutView];
        [self addSubview:_quanxuan];
        [_quanxuan autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_quanxuan autoSetDimensionsToSize:CGSizeMake(40, 13)];
        [_quanxuan autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_allselect withOffset:15];
        _quanxuan.text=@"全选";
        _quanxuan.font=THIRTEEN;
        _quanxuan.textColor=k333333;
        
        _priceLabel=[UILabel newAutoLayoutView];
        [self addSubview:_priceLabel];
        [_priceLabel autoSetDimensionsToSize:CGSizeMake(130, 13)];
        [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:120];
        [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:9];
        _priceLabel.font=THIRTEEN;
        _priceLabel.textAlignment=NSTextAlignmentRight;
        
        _numlabel=[UILabel newAutoLayoutView];
        [self addSubview:_numlabel];
        [_numlabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:120];
        [_numlabel autoSetDimensionsToSize:CGSizeMake(50, 12)];
        [_numlabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
        _numlabel.font=TWELVE;
        _numlabel.textAlignment=NSTextAlignmentRight;
        
        _btnbottom=[UIButton newAutoLayoutView];
        
        [self addSubview:_btnbottom];
        [_btnbottom autoSetDimensionsToSize:CGSizeMake(100, 46)];
        [_btnbottom autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_btnbottom autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_btnbottom setTitle:@"结算" forState:0];
        _btnbottom.backgroundColor=k000000;
        _btnbottom.titleLabel.font=FIFTEEN;
        
        UIView *viewline=[UIView newAutoLayoutView];
        [self addSubview:viewline];
        viewline.backgroundColor=kD8D8D8;
        [viewline autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [viewline autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 1)];
        [viewline autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        
    }
    return self;
}


















@end
