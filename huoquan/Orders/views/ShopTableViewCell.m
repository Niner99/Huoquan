//
//  ShopTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/18.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "UIViewController+HUDN.h"
@implementation ShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        _countsnum=1*_min_num;
        
        _checkicon=[UIButton newAutoLayoutView];
        [self addSubview:_checkicon];
        [_checkicon autoSetDimensionsToSize:CGSizeMake(19, 19)];
        [_checkicon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_checkicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_checkicon setImage:[UIImage imageNamed:@"未选"] forState:0];
        [_checkicon setImage:[UIImage imageNamed:@"选中黄"] forState:UIControlStateSelected];
        [_checkicon addTarget:self action:@selector(clickSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        _goodsicon =[UIImageView newAutoLayoutView];
        [self addSubview:_goodsicon];
        [_goodsicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:49];
        [_goodsicon autoSetDimensionsToSize:CGSizeMake(81, 81)];
        [_goodsicon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        _goodsicon.layer.borderColor=kD8D8D8.CGColor;
        _goodsicon.layer.borderWidth=1;
        
        _titleLabel=[myLabel newAutoLayoutView];
        [self addSubview:_titleLabel];
        [_titleLabel autoSetDimensionsToSize:CGSizeMake(227,37)];
        _titleLabel.font=THIRTEEN;
        [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_goodsicon];
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:144];
        _titleLabel.numberOfLines=0;
        _titleLabel.verticalAlignment=VerticalAlignmentTop;
        _titleLabel.textColor=k333333;
        
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
        _goodsPrice.textColor=k000000;
        
        _cutbtn =[UIButton newAutoLayoutView];
        [self addSubview:_cutbtn];
        [_cutbtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
        [_cutbtn autoSetDimensionsToSize:CGSizeMake(35,26)];
        [_cutbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:104];
        [_cutbtn setTitle:@"-" forState:0];
        [_cutbtn setTitleColor:k333333 forState:0];
        [_cutbtn addTarget:self action:@selector(cutcounts) forControlEvents:UIControlEventTouchUpInside];
        _cutbtn.titleLabel.font=FIFTEEN;
        _cutbtn.layer.borderWidth=1;
        _cutbtn.layer.borderColor=kD8D8D8.CGColor;
        
        _numlabel=[UILabel newAutoLayoutView];
        [self addSubview:_numlabel];
        [_numlabel autoSetDimensionsToSize:CGSizeMake(57,26)];
        [_numlabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cutbtn withOffset:-1];
        [_numlabel autoPinEdge:ALEdgeTop  toEdge:ALEdgeTop ofView:_cutbtn];
        _numlabel.font=FIFTEEN;
        _numlabel.textAlignment=NSTextAlignmentCenter;
        
        _numlabel.layer.borderColor=k333333.CGColor;
        _numlabel.layer.borderWidth=1;
        _numlabel.textColor=k333333;

        _plusbtn=[UIButton newAutoLayoutView];
        [self addSubview:_plusbtn];
        [_plusbtn autoSetDimensionsToSize:CGSizeMake(35,26)];
        [_plusbtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_numlabel withOffset:-1];
        [_plusbtn autoPinEdge:ALEdgeTop  toEdge:ALEdgeTop ofView:_cutbtn];
        [_plusbtn setTitle:@"+" forState:0];
        [_plusbtn setTitleColor:k333333 forState:0];
        [_plusbtn addTarget:self action:@selector(pluscounts) forControlEvents:UIControlEventTouchUpInside];
        _plusbtn.titleLabel.font=FIFTEEN;
        _plusbtn.layer.borderWidth=1;
        _plusbtn.layer.borderColor=k333333.CGColor;

        
        
    }
    return self;
}

-(void)cutcounts{
    if (_countsnum>1*_min_num) {
        _countsnum-=_min_num;
        _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
        if (_countsnum==1*_min_num) {
            _cutbtn.layer.borderColor=kD8D8D8.CGColor;
        }
        
    }else{
        _cutbtn.layer.borderColor=kD8D8D8.CGColor;
    }
    
    if (self.shopcardelegate && [self.shopcardelegate respondsToSelector:@selector(countgoodsnum:cell:)]) {
        [self.shopcardelegate countgoodsnum:_countsnum cell:self];
    }
    
}

-(void)pluscounts{
    if (_countsnum<_max_stock) {
        _countsnum+=_min_num;
        _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
        _cutbtn.layer.borderColor=k333333.CGColor;
        if (self.shopcardelegate && [self.shopcardelegate respondsToSelector:@selector(countgoodsnum:cell:)]) {
            [self.shopcardelegate countgoodsnum:_countsnum cell:self];
        }
    }else{
        UIViewController *vew=[[UIViewController alloc]init];
        [vew displayNHUDTitle:@"库存不足"];
    }

}

#pragma mark 点击单个商品选择的按钮回调
-(void)clickSelected:(UIButton *)sender{
    //确定委托是否存在productSelected:isSelected:方法
    if (self.shopcardelegate && [self.shopcardelegate respondsToSelector:@selector(productSelected:isSelected:)]) {
        [self.shopcardelegate productSelected:self isSelected:!sender.selected];
    }
}

-(void)setMin_num:(NSInteger)min_num{
    _min_num=min_num;
    
}

-(void)setCountsnum:(NSInteger)countsnum{
    _countsnum=countsnum;
    _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
    
    if (_countsnum>1*_min_num) {
        if (_countsnum==1*_min_num) {
            _cutbtn.layer.borderColor=kD8D8D8.CGColor;
        }
        
    }else{
        _cutbtn.layer.borderColor=kD8D8D8.CGColor;
    }
    
}

-(void)setMax_stock:(NSInteger)max_stock{
    _max_stock=max_stock;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
