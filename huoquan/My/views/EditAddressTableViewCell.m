//
//  EditAddressTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "EditAddressTableViewCell.h"

@implementation EditAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titlelabel=[UILabel newAutoLayoutView];
        [self addSubview:_titlelabel];
        [_titlelabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [_titlelabel autoSetDimensionsToSize:CGSizeMake(65, 14)];
        [_titlelabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _titlelabel.font=FOURTEEN;
        _titlelabel.textColor=k191919;
        
        _txtlabel=[UITextField newAutoLayoutView];
        [self addSubview:_txtlabel];
        [_txtlabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_txtlabel autoSetDimensionsToSize:CGSizeMake(200, 14)];
        [_txtlabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
        _txtlabel.font=FOURTEEN;
        
        _addresslabel=[UILabel newAutoLayoutView];
        [self addSubview:_addresslabel];
        [_addresslabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_addresslabel autoSetDimensionsToSize:CGSizeMake(200, 14)];
        [_addresslabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
        _addresslabel.font=FOURTEEN;
        _addresslabel.hidden=YES;
        
    }
    return self;
}
















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
