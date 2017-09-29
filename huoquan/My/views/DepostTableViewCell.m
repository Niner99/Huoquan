//
//  DepostTableViewCell.m
//  huoquan
//
//  Created by finecasa on 2017/9/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "DepostTableViewCell.h"

@implementation DepostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _depostLabel=[UILabel newAutoLayoutView];
        [self addSubview:_depostLabel];
        _depostLabel.textColor=k333333;
        [_depostLabel autoSetDimensionsToSize:CGSizeMake(300, 15)];
        [_depostLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_depostLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        _depostLabel.font=THIRTEEN;
        
        _depostTime=[UILabel newAutoLayoutView];
        [self addSubview:_depostTime];
        [_depostTime autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_depostTime autoSetDimensionsToSize:CGSizeMake(200, 11)];
        [_depostTime autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_depostLabel withOffset:7];
        _depostTime.font=ELEVEN;
        _depostTime.textColor=k888888;
        
        _depostState=[UILabel newAutoLayoutView];
        [self addSubview:_depostState];
        [_depostState autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_depostState autoSetDimensionsToSize:CGSizeMake(100, 12)];
        [_depostState autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _depostState.font=TWELVE;
        _depostState.textAlignment=NSTextAlignmentRight;
  
    }
    return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
