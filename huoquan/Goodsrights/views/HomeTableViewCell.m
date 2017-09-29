//
//  HomeTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/11.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        _goodsimage=[UIImageView newAutoLayoutView];
        [self addSubview:_goodsimage];
        [_goodsimage autoSetDimensionsToSize:CGSizeMake(95,95)];
        [_goodsimage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_goodsimage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
        _goodsimage.layer.borderColor=kD8D8D8.CGColor;
        _goodsimage.layer.borderWidth=1;
        
        _goodsname=[UILabel newAutoLayoutView];
        [self addSubview:_goodsname];
        [_goodsname autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_goodsimage];
        [_goodsname autoSetDimensionsToSize:CGSizeMake(226, 13)];
        [_goodsname autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsimage withOffset:15];
        _goodsname.font=THIRTEEN;
        _goodsname.textColor=k333333;
        
        _huoprice=[UILabel newAutoLayoutView];
        [self addSubview:_huoprice];
        [_huoprice autoSetDimensionsToSize:CGSizeMake(150, 13)];
        [_huoprice autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_goodsname];
        [_huoprice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsname withOffset:10];
        _huoprice.textColor=kDABF66;
        _huoprice.font=THIRTEEN;
        
        _marketprice=[UILabel newAutoLayoutView];
        [self addSubview:_marketprice];
        [_marketprice autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_huoprice];
        [_marketprice autoSetDimensionsToSize:CGSizeMake(100, 11)];
        [_marketprice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_huoprice withOffset:10];
        _marketprice.textColor=k888888;
        _marketprice.font=ELEVEN;
        
        _quantitylabel=[UILabel newAutoLayoutView];
        [self addSubview:_quantitylabel];
        [_quantitylabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_marketprice];
        [_quantitylabel autoSetDimensionsToSize:CGSizeMake(150, 12)];
        [_quantitylabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_marketprice withOffset:10];
        _quantitylabel.font=TWELVE;
        _quantitylabel.textColor=k888888;

        
        _buyBtn=[UIButton newAutoLayoutView];
        [self addSubview:_buyBtn];
        [_buyBtn autoSetDimensionsToSize:CGSizeMake(91, 31)];
        [_buyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_buyBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:9];
        [_buyBtn setTitle:@"抢购 +" forState:0];
        _buyBtn.titleLabel.font=FIFTEEN;
        _buyBtn.backgroundColor=kDABF66;
        _buyBtn.layer.cornerRadius=4;
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 119, kScreenWidth, 1)];
        line.backgroundColor=kE4E4E4;
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
