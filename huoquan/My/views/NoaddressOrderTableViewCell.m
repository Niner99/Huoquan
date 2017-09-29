//
//  NoaddressOrderTableViewCell.m
//  huoquan
//
//  Created by finecasa on 2017/9/19.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "NoaddressOrderTableViewCell.h"

@implementation NoaddressOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _addbtn=[UIButton newAutoLayoutView];
        [self addSubview:_addbtn];
        [_addbtn autoSetDimensionsToSize:CGSizeMake(43, 43)];
        [_addbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:83];
        [_addbtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_addbtn setImage:[UIImage imageNamed:@"暂无地址"] forState:0];
        
        _noaddresslabel=[UILabel newAutoLayoutView];
        [self addSubview:_noaddresslabel];
        [_noaddresslabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_noaddresslabel autoSetDimensionsToSize:CGSizeMake(200, 15)];
        [_noaddresslabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:137];
        _noaddresslabel.textColor=k333333;
        _noaddresslabel.font=FIFTEEN;
        _noaddresslabel.text=@"暂无地址，请添加地址";
        
        
    }
    return self;
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
