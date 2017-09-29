//
//  SendManageTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SendManageTableViewCell.h"

@implementation SendManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=kF8F8F8;
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth, 71)];
        [self addSubview:backView];
        backView.backgroundColor=[UIColor whiteColor];
        
        _sendCode=[UILabel newAutoLayoutView];
        [backView addSubview:_sendCode];
        [_sendCode autoSetDimensionsToSize:CGSizeMake(200, 14)];
        [_sendCode autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_sendCode autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        _sendCode.textColor=k888888;
        _sendCode.font=FOURTEEN;
        
        _commtTime=[UILabel newAutoLayoutView];
        [backView addSubview:_commtTime];
        [_commtTime autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_commtTime autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:43];
        [_commtTime autoSetDimensionsToSize:CGSizeMake(200, 14)];
        _commtTime.textColor=k333333;
        _commtTime.font=FOURTEEN;
        
        _sendState=[[UILabel alloc]initWithFrame:CGRectMake(307*HH,13,60,14)];
        [backView addSubview:_sendState];
        _sendState.font=FOURTEEN;
        _sendState.textColor=kDABF66;
        
        
        _sureBtn=[UIButton newAutoLayoutView];
        [backView addSubview:_sureBtn];
        [_sureBtn autoSetDimensionsToSize:CGSizeMake(66, 31)];
        [_sureBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:295*HH ] ;
        [_sureBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:7];
        [_sureBtn setTitle:@"确认收货" forState:0];
        _sureBtn.titleLabel.font=TWELVE;
        _sureBtn.backgroundColor=kDABF66;
        _sureBtn.layer.cornerRadius=4;
        _sureBtn.hidden=YES;
        
    
    }
    return self;
}


-(void)setStateStr:(NSString *)stateStr{
    if ([stateStr intValue]==1) {
//        [ _sendState autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:307*HH ];
//        [_sendState autoSetDimensionsToSize:CGSizeMake(60, 14)];
//        [_sendState autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:13];
        
        _sendState.frame=CGRectMake(307*HH,13,60,14);
        
        _sureBtn.hidden=NO;
    }else{
//        [ _sendState autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:307*HH ];
//        [_sendState autoSetDimensionsToSize:CGSizeMake(60, 14)];
//        [_sendState autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _sendState.frame=CGRectMake(307*HH,28,60,14);
        _sureBtn.hidden=YES;
    }
}


















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
