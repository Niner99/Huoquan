//
//  CommitOrderTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "CommitOrderTableViewCell.h"

@implementation CommitOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _goodsIcon=[UIImageView newAutoLayoutView];
        [self addSubview:_goodsIcon];
        [_goodsIcon autoSetDimensionsToSize:CGSizeMake(74, 74)];
        [_goodsIcon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_goodsIcon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _goodsIcon.image=[UIImage imageNamed:@"产品图"];
        _goodsIcon.layer.borderColor=kD8D8D8.CGColor;
        _goodsIcon.layer.borderWidth=1;
    
        _goodstitle=[UILabel newAutoLayoutView];
        [self addSubview:_goodstitle];
        [_goodstitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_goodstitle autoSetDimensionsToSize:CGSizeMake(256,13)];
        [_goodstitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsIcon withOffset:10];
        _goodstitle.font=THIRTEEN;
        _goodstitle.textColor=k333333;
        
        _goodsColor=[UILabel newAutoLayoutView];
        [self addSubview:_goodsColor];
        [_goodsColor autoSetDimensionsToSize:CGSizeMake(200, 12)];
        [_goodsColor autoPinEdge:ALEdgeLeft  toEdge:ALEdgeLeft ofView:_goodstitle];
        [_goodsColor autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:_goodstitle withOffset:8];
        _goodsColor.font=TWELVE;
        _goodsColor.textColor=k888888;
        
        _goodsNum=[UILabel newAutoLayoutView];
        [self addSubview:_goodsNum];
        [_goodsNum autoSetDimensionsToSize:CGSizeMake(40, 14)];
        [_goodsNum autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsColor withOffset:22];
        [_goodsNum autoPinEdge:ALEdgeLeft  toEdge:ALEdgeLeft ofView:_goodstitle];
        _goodsNum.font=FOURTEEN;
        _goodsNum.textColor=k333333;

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
