//
//  SaleDetailTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SaleDetailTableViewCell.h"

@implementation SaleDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _saleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 12)];
        _saleLabel.center=CGPointMake(100, 15);
        _saleLabel.font=TWELVE;
        _saleLabel.textColor=k333333;
        [self addSubview:_saleLabel];
        _saleLabel.textAlignment=NSTextAlignmentCenter;
        
        _saleTime=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 11)];
        _saleTime.center=CGPointMake(100, 35);
        _saleTime.font=ELEVEN;
        _saleTime.textColor=k888888;
        [self addSubview:_saleTime];
        _saleTime.text=@"销售时间";
        _saleTime.textAlignment=NSTextAlignmentCenter;
        
        _numlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 12)];
        _numlabel.center=CGPointMake(275, 15);
        _numlabel.font=TWELVE;
        _numlabel.textColor=k333333;
        [self addSubview:_numlabel];
        _numlabel.textAlignment=NSTextAlignmentCenter;
        
        _goodsnum=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 12)];
        _goodsnum.center=CGPointMake(275, 35);
        _goodsnum.font=ELEVEN;
        _goodsnum.textColor=k888888;
        [self addSubview:_goodsnum];
        _goodsnum.text=@"销售数量";
        _goodsnum.textAlignment=NSTextAlignmentCenter;
        
 
        
    }
    return self;
}






























- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
