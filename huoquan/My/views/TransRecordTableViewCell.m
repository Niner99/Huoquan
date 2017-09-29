//
//  TransRecordTableViewCell.m
//  huoquan
//
//  Created by finecasa on 2017/9/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "TransRecordTableViewCell.h"

@implementation TransRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _titlePrice=[UILabel newAutoLayoutView];
        [self addSubview:_titlePrice];
        [_titlePrice autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_titlePrice autoSetDimensionsToSize:CGSizeMake(200, 13)];
        [_titlePrice autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:14];
        _titlePrice.font=THIRTEEN;
        _titlePrice.textColor=k333333;
        
        _transTime=[UILabel newAutoLayoutView];
        [self addSubview:_transTime];
        [_transTime autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_transTime autoSetDimensionsToSize:CGSizeMake(200, 11)];
        [_transTime autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:_titlePrice withOffset:7];
        _transTime.font=ELEVEN;
        _transTime.textColor=k888888;
        
        _priceNum=[UILabel newAutoLayoutView];
        [self addSubview:_priceNum];
        [_priceNum autoSetDimensionsToSize:CGSizeMake(200, 13)];
        [_priceNum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_priceNum autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        _priceNum.textAlignment=NSTextAlignmentRight;
        _priceNum.font=THIRTEEN;
        
        
        
    }
    return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
