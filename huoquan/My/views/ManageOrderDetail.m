//
//  ManageOrderDetail.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/25.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "ManageOrderDetail.h"

@implementation ManageOrderDetail

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
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 59)];
        [self addSubview:view1];
        
        _stateLabel=[UILabel newAutoLayoutView];
        [view1 addSubview:_stateLabel];
        [_stateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:17];
        [_stateLabel autoSetDimensionsToSize:CGSizeMake(300, 18)];
        [_stateLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _stateLabel.font=EIGHTTEEN;
        _stateLabel.textColor=kDABF66;
        
        _shouhuoTime=[UILabel newAutoLayoutView];
        [view1 addSubview:_shouhuoTime];
        [_shouhuoTime autoSetDimensionsToSize:CGSizeMake(130, 12)];
        [_shouhuoTime autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:17];
        [_shouhuoTime autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _shouhuoTime.textColor=k333333;
        _shouhuoTime.font=TWELVE;
        _shouhuoTime.textAlignment=NSTextAlignmentRight;
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0,59, kScreenWidth, 64)];
        [self addSubview:view2];
        
        _locationicon=[UIImageView newAutoLayoutView];
        [view2 addSubview:_locationicon];
        [_locationicon autoSetDimensionsToSize:CGSizeMake(11, 16)];
        [_locationicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_locationicon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        _locationicon.image=[UIImage imageNamed:@"定位图标"];
        
        _username=[UILabel newAutoLayoutView];
        [view2 addSubview:_username];
        [_username autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17];
        [_username autoSetDimensionsToSize:CGSizeMake(100, 12)];
        [_username autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_locationicon withOffset:14];
        _username.font=TWELVE;
        _username.textColor=k191919;
        
        _userphone=[UILabel newAutoLayoutView];
        [view2 addSubview:_userphone];
        [_userphone autoSetDimensionsToSize:CGSizeMake(120, 12)];
        [_userphone autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        [_userphone autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17];
        _userphone.font=TWELVE;
        _userphone.textAlignment=NSTextAlignmentRight;
        _userphone.textColor=k191919;
        
        _useraddress=[UILabel newAutoLayoutView];
        [view2 addSubview:_useraddress];
        [_useraddress autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_username];
        [_useraddress autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_username withOffset:1];
        [_useraddress autoSetDimensionsToSize:CGSizeMake(320,35)];
        _useraddress.font=TWELVE;
        _useraddress.textColor=k191919;
        _useraddress.numberOfLines=0;
        
        UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 59+64, kScreenWidth, 62)];
        [self addSubview:view3];
        
        _ordercode=[UILabel newAutoLayoutView];
        [view3 addSubview:_ordercode];
        [_ordercode autoSetDimensionsToSize:CGSizeMake(200, 12)];
        [_ordercode autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_ordercode autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
        _ordercode.font=TWELVE;
        _ordercode.textColor=k191919;
        
        _ordertime=[UILabel newAutoLayoutView];
        [view3 addSubview:_ordertime];
        [_ordertime autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
        [_ordertime autoSetDimensionsToSize:CGSizeMake(200, 12)];
        [_ordertime autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:_ordercode withOffset:10];
        _ordertime.font=TWELVE;
        _ordertime.textColor=k191919;
        
        
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 59, kScreenWidth, 0.7)];
        line1.backgroundColor=kD8D8D8;
        [self addSubview:line1];
        
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 59+64, kScreenWidth, 0.7)];
        line2.backgroundColor=kD8D8D8;
        [self addSubview:line2];
        
        
        
    }
    return self;
}

@end
