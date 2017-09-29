//
//  GoodsListTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/16.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "GoodsListTableViewCell.h"

@implementation GoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        

        
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 135)];
        backView.backgroundColor=[UIColor whiteColor];
        [self addSubview:backView];
        
        _goodsimage=[UIImageView newAutoLayoutView];
        [backView addSubview:_goodsimage];
        [_goodsimage autoSetDimensionsToSize:CGSizeMake(95,95)];
        [_goodsimage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_goodsimage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _goodsimage.layer.borderColor=kD8D8D8.CGColor;
        _goodsimage.layer.borderWidth=1;
        
        _goodsname=[UILabel newAutoLayoutView];
        [backView addSubview:_goodsname];
        [_goodsname autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_goodsimage];
        [_goodsname autoSetDimensionsToSize:CGSizeMake(237, 40)];
        [_goodsname autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsimage withOffset:15];
        _goodsname.font=THIRTEEN;
        _goodsname.textColor=k333333;
        _goodsname.numberOfLines=2;
        
        _huoprice=[UILabel newAutoLayoutView];
        [backView addSubview:_huoprice];
        [_huoprice autoSetDimensionsToSize:CGSizeMake(150, 13)];
        [_huoprice autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_goodsname];
        [_huoprice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsname withOffset:10];
        _huoprice.textColor=kDABF66;
        _huoprice.font=THIRTEEN;
        
        _marketprice=[UILabel newAutoLayoutView];
        [backView addSubview:_marketprice];
        [_marketprice autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_huoprice];
        [_marketprice autoSetDimensionsToSize:CGSizeMake(100, 11)];
        [_marketprice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_huoprice withOffset:10];
        _marketprice.textColor=k888888;
        _marketprice.font=ELEVEN;
        
        _buyBtn=[UIButton newAutoLayoutView];
        [backView addSubview:_buyBtn];
        [_buyBtn autoSetDimensionsToSize:CGSizeMake(91, 31)];
        [_buyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_buyBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
        [_buyBtn setTitle:@"抢购" forState:0];
        _buyBtn.titleLabel.font=FIFTEEN;
        _buyBtn.backgroundColor=kDABF66;
        _buyBtn.layer.cornerRadius=4;
        

        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,135, kScreenWidth, 10)];
        line.backgroundColor=kF8F8F8;
        [self addSubview:line];
        
    }
    return self;
}
-(void)setLeftQuantity:(NSString *)leftQuantity{
    if ([leftQuantity intValue]>0) {
        [_buyBtn setTitle:@"抢购 +" forState:0];
        _buyBtn.backgroundColor=kDABF66;
    }else{
        [_buyBtn setTitle:@"已售罄" forState:0];
        _buyBtn.backgroundColor=kB8B8B8;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
