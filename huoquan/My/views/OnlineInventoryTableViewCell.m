//
//  OnlineInventoryTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/23.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "OnlineInventoryTableViewCell.h"

@implementation OnlineInventoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _goodsIcon=[UIImageView newAutoLayoutView];
        [self addSubview:_goodsIcon];

        _goodsIcon.image=[UIImage imageNamed:@"产品图"];
        _goodsIcon.layer.borderColor=kD8D8D8.CGColor;
        _goodsIcon.layer.borderWidth=1;
        
        
        _goodstitle=[UILabel newAutoLayoutView];
        [self addSubview:_goodstitle];
        [_goodstitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_goodstitle autoSetDimensionsToSize:CGSizeMake(230,40)];
        [_goodstitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsIcon withOffset:10];
        _goodstitle.font=THIRTEEN;
        _goodstitle.numberOfLines=0;
        _goodstitle.textColor=k333333;
        
        _goodsPrice =[UILabel newAutoLayoutView];
        [self addSubview:_goodsPrice];
        [_goodsPrice autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_goodsPrice autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        [_goodsPrice autoSetDimensionsToSize:CGSizeMake(100, 13)];
        _goodsPrice.textColor=kDABF66;
        _goodsPrice.font=THIRTEEN;
        _goodsPrice.textAlignment=NSTextAlignmentRight;
        
        _goodsNum=[UILabel newAutoLayoutView];
        [self addSubview:_goodsNum];
        [_goodsNum autoSetDimensionsToSize:CGSizeMake(180, 12)];
        [_goodsNum autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_goodstitle];
        [_goodsNum autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_goodsIcon];
        _goodsNum.font=TWELVE;
        _goodsNum.textColor=k888888;
        
    
        _goodsOrder=[UILabel newAutoLayoutView];
        [self addSubview:_goodsOrder];
        [_goodsOrder autoSetDimensionsToSize:CGSizeMake(100, 11)];
        [_goodsOrder autoPinEdge:ALEdgeRight  toEdge:ALEdgeRight ofView:_goodsPrice];
        [_goodsOrder autoPinEdge:ALEdgeBottom  toEdge:ALEdgeBottom ofView:_goodsNum];
        _goodsOrder.font=ELEVEN;
        _goodsOrder.textColor=k888888;
        _goodsOrder.textAlignment=NSTextAlignmentRight;
        
    }
    return self;
}



-(void)setIconWidth:(NSString *)iconWidth{
    NSInteger width=[iconWidth intValue];
    [_goodsIcon autoSetDimensionsToSize:CGSizeMake(width,width)];
    [_goodsIcon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_goodsIcon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
