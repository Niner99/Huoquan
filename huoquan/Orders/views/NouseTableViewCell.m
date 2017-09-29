//
//  NouseTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/18.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "NouseTableViewCell.h"

@implementation NouseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];

        
        _nouseicon=[UILabel newAutoLayoutView];
        [self addSubview:_nouseicon];
        [_nouseicon autoSetDimensionsToSize:CGSizeMake(30, 20)];
        [_nouseicon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_nouseicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        _nouseicon.layer.borderWidth=1;
        _nouseicon.layer.borderColor=kAAAAAA.CGColor;
        _nouseicon.layer.cornerRadius=10;
        _nouseicon.textColor=kAAAAAA;
        _nouseicon.text=@"失效";
        _nouseicon.textAlignment=NSTextAlignmentCenter;
        _nouseicon.font=NINEFONT;
        
        _goodsicon =[UIImageView newAutoLayoutView];
        [self addSubview:_goodsicon];
        [_goodsicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:49];
        [_goodsicon autoSetDimensionsToSize:CGSizeMake(81, 81)];
        [_goodsicon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _goodsicon.layer.borderColor=kD8D8D8.CGColor;
        _goodsicon.layer.borderWidth=1;
        
        _titleLabel=[myLabel newAutoLayoutView];
        [self addSubview:_titleLabel];
        [_titleLabel autoSetDimensionsToSize:CGSizeMake(227,35)];
        _titleLabel.font=THIRTEEN;
        [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_goodsicon];
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:144];
        _titleLabel.numberOfLines=0;
        _titleLabel.verticalAlignment=VerticalAlignmentTop;
        _titleLabel.textColor=k888888;
        
        _goodsColor=[UILabel newAutoLayoutView];
        [self addSubview:_goodsColor];
        [_goodsColor autoSetDimensionsToSize:CGSizeMake(70,12)];
        _goodsColor.font=TWELVE;
        [_goodsColor autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
        [_goodsColor autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:10];
        _goodsColor.textColor=k888888;
        
        
        
        
        _goodsPrice=[UILabel newAutoLayoutView];
        [self addSubview:_goodsPrice];
        [_goodsPrice autoSetDimensionsToSize:CGSizeMake(85,13)];
        _goodsPrice.font=THIRTEEN;
        [_goodsPrice autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_goodsicon];
        [_goodsPrice autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
        _goodsPrice.textColor=k888888;
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
