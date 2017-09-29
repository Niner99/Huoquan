//
//  MessageTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/17.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=kF8F8F8;
        
        UIView *roundView=[UIView newAutoLayoutView];
        [self addSubview:roundView];
        [roundView autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 116)];
        [roundView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [roundView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        roundView.layer.cornerRadius=4;
        roundView.backgroundColor=[UIColor whiteColor];
        
        _titleLabel=[UILabel newAutoLayoutView];
        [roundView addSubview:_titleLabel];
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:11];
        [_titleLabel autoSetDimensionsToSize:CGSizeMake(250, 13)];
        _titleLabel.font=THIRTEEN;
        _titleLabel.textColor=k333333;
        
        _haveRead=[UILabel newAutoLayoutView];
        [roundView addSubview:_haveRead];
        [_haveRead autoSetDimensionsToSize:CGSizeMake(50, 11)];
        [_haveRead autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:13];
        [_haveRead autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
        _haveRead.text=@"已读";
        _haveRead.font=ELEVEN;
        _haveRead.textColor=k888888;
        _haveRead.hidden=YES;
        _haveRead.textAlignment=NSTextAlignmentRight;
        
        UIView *lineView=[UIView newAutoLayoutView];
        [roundView addSubview:lineView];
        [lineView autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 1)];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:37];
        lineView.backgroundColor=kD8D8D8;
        
        _contentLabel=[myLabel newAutoLayoutView];
        [roundView addSubview:_contentLabel];
        [_contentLabel autoSetDimensionsToSize:CGSizeMake(323, 50)];
        [_contentLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineView withOffset:8];
        _contentLabel.textColor=k888888;
        _contentLabel.numberOfLines=3;
        _contentLabel.font=TWELVE;
        _contentLabel.verticalAlignment=VerticalAlignmentTop;
        
        _detailBtn=[UIButton newAutoLayoutView];
        [roundView addSubview:_detailBtn];
        [_detailBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [_detailBtn autoSetDimensionsToSize:CGSizeMake(70, 12)];
        [_detailBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        [_detailBtn setTitle:@"查看详情 >" forState:0];
        [_detailBtn setTitleColor:kDABF66 forState:0];
        _detailBtn.titleLabel.font=TWELVE;
        
        
    }
    return self;
}




























- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
