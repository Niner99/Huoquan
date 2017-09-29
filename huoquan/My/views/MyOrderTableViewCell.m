//
//  MyOrderTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

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
        
    
        _titleLabel=[myLabel newAutoLayoutView];
        [self addSubview:_titleLabel];

        _titleLabel.verticalAlignment=VerticalAlignmentTop;
        _titleLabel.font=THIRTEEN;
        _titleLabel.numberOfLines=0;
        _titleLabel.textColor=k333333;
        
        _goodsColor=[UILabel newAutoLayoutView];
        [self addSubview:_goodsColor];
        [_goodsColor autoSetDimensionsToSize:CGSizeMake(180, 12)];
        [_goodsColor autoPinEdge:ALEdgeLeft  toEdge:ALEdgeLeft ofView:_titleLabel];
        [_goodsColor autoPinEdge:ALEdgeBottom  toEdge:ALEdgeBottom ofView:_goodsIcon];
        _goodsColor.font=TWELVE;
        _goodsColor.textColor=kB1B1B1;
        
        _goodsNum=[UILabel newAutoLayoutView];
        [self addSubview:_goodsNum];
        [_goodsNum autoSetDimensionsToSize:CGSizeMake(40, 12)];
        [_goodsNum autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_goodsColor];
        [_goodsNum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        _goodsNum.textAlignment=NSTextAlignmentRight;
        _goodsNum.font=TWELVE;
        _goodsNum.textColor=k333333;
        
        _goodsPrice =[UILabel newAutoLayoutView];
        [self addSubview:_goodsPrice];
        [_goodsPrice autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16 ];
        [_goodsPrice autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_titleLabel];
        [_goodsPrice autoSetDimensionsToSize:CGSizeMake(100, 13)];
        _goodsPrice.textColor=k333333;
        _goodsPrice.font=THIRTEEN;
        _goodsPrice.textAlignment=NSTextAlignmentRight;
        
        
        
    }
    return self;
}

-(void)setOrdername:(NSString *)ordername{
    if ([ordername intValue]==1) {
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_titleLabel autoSetDimensionsToSize:CGSizeMake(256,40)];
        [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsIcon withOffset:10];
    }else{
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_titleLabel autoSetDimensionsToSize:CGSizeMake(180,40)];
        [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsIcon withOffset:10];
    }
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
