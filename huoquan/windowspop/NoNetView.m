//
//  NoNetView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/9/11.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "NoNetView.h"

@implementation NoNetView

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
        
        _lostIcon=[UIImageView newAutoLayoutView];
        [self addSubview:_lostIcon];
        [_lostIcon autoSetDimensionsToSize:CGSizeMake(196, 137)];
        [_lostIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:226];
        [_lostIcon autoAlignAxisToSuperviewAxis:ALAxisVertical];
        _lostIcon.image=[UIImage imageNamed:@"网络不稳定"];
        
        _lostlabel=[UILabel newAutoLayoutView];
        [self addSubview:_lostlabel];
        [_lostlabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_lostlabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 13)];
        [_lostlabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lostIcon withOffset:18];
        _lostlabel.text=@"您的网络不稳定哦，请刷新重试";
        _lostlabel.font=THIRTEEN;
        _lostlabel.textColor=k888888;
        _lostlabel.textAlignment=NSTextAlignmentCenter;
        
        _btnrefresh=[UIButton newAutoLayoutView];
        [self addSubview:_btnrefresh];
        [_btnrefresh autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lostlabel withOffset:23];
        [_btnrefresh autoSetDimensionsToSize:CGSizeMake(114, 30)];
        [_btnrefresh autoAlignAxisToSuperviewAxis:ALAxisVertical];
        _btnrefresh.backgroundColor=k000000;
        [_btnrefresh setTitle:@"刷新" forState:0];
        _btnrefresh.titleLabel.font=FIFTEEN;
        _btnrefresh.layer.cornerRadius=15;

    }
    return self;
}














@end
