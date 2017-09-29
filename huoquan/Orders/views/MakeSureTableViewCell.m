//
//  MakeSureTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/21.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MakeSureTableViewCell.h"

@implementation MakeSureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _goodsicon=[UIImageView newAutoLayoutView];
        [self addSubview:_goodsicon];
        [_goodsicon autoSetDimensionsToSize:CGSizeMake(80, 80)];
        [_goodsicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_goodsicon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        _goodsicon.layer.borderColor=kD8D8D8.CGColor;
        _goodsicon.layer.borderWidth=1;
        
        
        _goodsname=[UILabel newAutoLayoutView];
        [self addSubview:_goodsname];
        [_goodsname autoSetDimensionsToSize:CGSizeMake(245, 13)];
        [_goodsname autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:31];
        [_goodsname autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsicon withOffset:15];
        _goodsname.font=THIRTEEN;
        _goodsname.textColor=k333333;
        
        _goodscolor=[UILabel newAutoLayoutView];
        [self addSubview:_goodscolor];
        [_goodscolor autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_goodsname];
        [_goodscolor autoSetDimensionsToSize:CGSizeMake(200, 12)];
        [_goodscolor autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsname withOffset:13];
        _goodscolor.textColor=k888888;
        _goodscolor.font=TWELVE;
        
        _goodsStand=[UILabel newAutoLayoutView];
        [self addSubview:_goodsStand];
        [_goodsStand autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodscolor withOffset:10];
        [_goodsStand autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_goodscolor];
        [_goodsStand autoSetDimensionsToSize:CGSizeMake(100, 12)];
        _goodsStand.textColor=k888888;
        _goodsStand.font=TWELVE;
        
        _goodsnum=[UILabel newAutoLayoutView];
        [self addSubview:_goodsnum];
        [_goodsnum autoSetDimensionsToSize:CGSizeMake(40, 13)];
        [_goodsnum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        [_goodsnum autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_goodsStand];
        _goodsnum.textColor=k010101;
        _goodsnum.font=THIRTEEN;
        _goodsnum.textAlignment=NSTextAlignmentRight;
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 105, kScreenWidth, 1)];
        line.backgroundColor=kD8D8D8;
        [self addSubview:line];
        
        _danjia=[UILabel newAutoLayoutView];
        [self addSubview:_danjia];
        [_danjia autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_danjia autoSetDimensionsToSize:CGSizeMake(50, 13)];
        [_danjia autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line withOffset:10];
        _danjia.textColor=k888888;
        _danjia.font=THIRTEEN;
        _danjia.text=@"单价";
        
        _heji=[UILabel newAutoLayoutView];
        [self addSubview:_heji];
        [_heji autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_heji autoSetDimensionsToSize:CGSizeMake(50, 13)];
        [_heji autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_danjia withOffset:10];
        _heji.textColor=kDABF66;
        _heji.font=THIRTEEN;
        _heji.text=@"合计";
        
        _singlePrice=[UILabel newAutoLayoutView];
        [self addSubview:_singlePrice];
        [_singlePrice autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        [_singlePrice autoSetDimensionsToSize:CGSizeMake(100, 13)];
        [_singlePrice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line withOffset:10];
        _singlePrice.textColor=k888888;
        _singlePrice.font=THIRTEEN;
        _singlePrice.textAlignment=NSTextAlignmentRight;
        
        _allPrice=[UILabel newAutoLayoutView];
        [self addSubview:_allPrice];
        [_allPrice autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        [_allPrice autoSetDimensionsToSize:CGSizeMake(120, 15)];
        [_allPrice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_singlePrice withOffset:9];
        _allPrice.textAlignment=NSTextAlignmentRight;
        _allPrice.font=FIFTEEN;
        _allPrice.textColor=kDABF66;
        

        
    }
    return self;
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
