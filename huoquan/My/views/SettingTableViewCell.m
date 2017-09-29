//
//  SettingTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        _logoicon=[UIImageView newAutoLayoutView];
        [self addSubview:_logoicon];
        [_logoicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_logoicon autoSetDimensionsToSize:CGSizeMake(15, 15)];
        [_logoicon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        
        _titlelabel=[UILabel newAutoLayoutView];
        [self addSubview:_titlelabel];
        [_titlelabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_titlelabel autoSetDimensionsToSize:CGSizeMake(100, 14)];
        [_titlelabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:38];
        _titlelabel.font=FOURTEEN;
        _titlelabel.textColor=k333333;
        
        _detaillabel=[UILabel newAutoLayoutView];
        [self addSubview:_detaillabel];
        [_detaillabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_detaillabel autoSetDimensionsToSize:CGSizeMake(100, 12)];
        [_detaillabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:36];
        _detaillabel.font=TWELVE;
        _detaillabel.textColor=k888888;
        _detaillabel.textAlignment=NSTextAlignmentRight;
        
        
        
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
