//
//  CatogoryTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/17.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "CatogoryTableViewCell.h"

@implementation CatogoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _branicon=[UIImageView newAutoLayoutView];
        [self addSubview:_branicon];
        [_branicon autoSetDimensionsToSize:CGSizeMake(6, 17)];
        [_branicon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_branicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        _branicon.image=[UIImage imageNamed:@"勺子"];
        _branicon.hidden=YES;
        
        _brandLabel=[UILabel newAutoLayoutView];
        [self addSubview:_brandLabel];
        [_brandLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:28];
        [_brandLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_brandLabel autoSetDimensionsToSize:CGSizeMake(52, 13)];
        _brandLabel.font=THIRTEEN;
        _brandLabel.textColor=k333333;

        
    }
    return self;
}

















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
