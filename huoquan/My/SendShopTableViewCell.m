//
//  SendShopTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SendShopTableViewCell.h"

@implementation SendShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
      //  _countsnum=1;
        
        _goodsIcon=[UIImageView newAutoLayoutView];
        [self addSubview:_goodsIcon];
        [_goodsIcon autoSetDimensionsToSize:CGSizeMake(74,74)];
        [_goodsIcon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_goodsIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        _goodsIcon.image=[UIImage imageNamed:@"产品图"];
        _goodsIcon.layer.borderColor=kD8D8D8.CGColor;
        _goodsIcon.layer.borderWidth=1;
        
        
        _goodstitle=[UILabel newAutoLayoutView];
        [self addSubview:_goodstitle];
        [_goodstitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_goodstitle autoSetDimensionsToSize:CGSizeMake(230,40)];
        [_goodstitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsIcon withOffset:10];
        _goodstitle.font=THIRTEEN;
        _goodstitle.numberOfLines=0;
        _goodstitle.textColor=k333333;
        
        _goodsPrice =[UILabel newAutoLayoutView];
        [self addSubview:_goodsPrice];
        [_goodsPrice autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_goodsPrice autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:60];
        [_goodsPrice autoSetDimensionsToSize:CGSizeMake(100, 13)];
        _goodsPrice.textColor=kDABF66;
        _goodsPrice.font=THIRTEEN;
        _goodsPrice.textAlignment=NSTextAlignmentRight;
        
        _goodsNum=[UILabel newAutoLayoutView];
        [self addSubview:_goodsNum];
        [_goodsNum autoSetDimensionsToSize:CGSizeMake(200, 12)];
        [_goodsNum autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_goodstitle];
        [_goodsNum autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_goodsIcon];
        _goodsNum.font=TWELVE;
        _goodsNum.textColor=k888888;
        
        
        _sendNum=[UILabel newAutoLayoutView];
        [self addSubview:_sendNum];
        [_sendNum autoSetDimensionsToSize:CGSizeMake(100, 12)];
        [_sendNum autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_sendNum autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:_goodsIcon withOffset:17];
        _sendNum.font=TWELVE;
        _sendNum.textColor=k333333;
        
        
        _cutbtn =[UIButton newAutoLayoutView];
        [self addSubview:_cutbtn];
        [_cutbtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:98];
        [_cutbtn autoSetDimensionsToSize:CGSizeMake(35,25)];
        [_cutbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:104];
        [_cutbtn setTitle:@"-" forState:0];
        [_cutbtn setTitleColor:k333333 forState:0];
        [_cutbtn addTarget:self action:@selector(cutcounts) forControlEvents:UIControlEventTouchUpInside];
        _cutbtn.titleLabel.font=FIFTEEN;
        _cutbtn.layer.borderWidth=1;
        _cutbtn.layer.borderColor=kD8D8D8.CGColor;
        
        _numlabel=[UILabel newAutoLayoutView];
        [self addSubview:_numlabel];
        [_numlabel autoSetDimensionsToSize:CGSizeMake(56,25)];
        [_numlabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cutbtn withOffset:-1];
        [_numlabel autoPinEdge:ALEdgeTop  toEdge:ALEdgeTop ofView:_cutbtn];
        _numlabel.font=FIFTEEN;
        _numlabel.textAlignment=NSTextAlignmentCenter;
        _numlabel.layer.borderColor=k333333.CGColor;
        _numlabel.layer.borderWidth=1;
        _numlabel.textColor=k333333;
        
        _plusbtn=[UIButton newAutoLayoutView];
        [self addSubview:_plusbtn];
        [_plusbtn autoSetDimensionsToSize:CGSizeMake(35,25)];
        [_plusbtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_numlabel withOffset:-1];
        [_plusbtn autoPinEdge:ALEdgeTop  toEdge:ALEdgeTop ofView:_cutbtn];
        [_plusbtn setTitle:@"+" forState:0];
        [_plusbtn setTitleColor:k333333 forState:0];
        [_plusbtn addTarget:self action:@selector(pluscounts) forControlEvents:UIControlEventTouchUpInside];
        _plusbtn.titleLabel.font=FIFTEEN;
        _plusbtn.layer.borderWidth=1;
        _plusbtn.layer.borderColor=k333333.CGColor;
        
        _joinBtn=[UIButton newAutoLayoutView];
        [self addSubview:_joinBtn];
        [_joinBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_joinBtn autoSetDimensionsToSize:CGSizeMake(95, 31)];
        [_joinBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:138];
        [_joinBtn setTitle:@"加入发货单" forState:0];
        _joinBtn.backgroundColor=kDABF66;
        _joinBtn.layer.cornerRadius=4;
        _joinBtn.titleLabel.font=TWELVE;
        [_joinBtn addTarget:self action:@selector(add_sendShop) forControlEvents:UIControlEventTouchUpInside];
        
  
    }
    return self;
}


-(void)cutcounts{
    if (_countsnum>0) {
        _countsnum--;
        _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
        if (_countsnum==0) {
            _cutbtn.layer.borderColor=kD8D8D8.CGColor;
        }
        
    }else{
        _cutbtn.layer.borderColor=kD8D8D8.CGColor;
    }
    
    [_joinBtn setTitle:@"加入发货单" forState:0];
    _joinBtn.alpha=1;
    _joinBtn.userInteractionEnabled=YES;
    
}

-(void)pluscounts{
    if (_countsnum<_max_goodsnum) {
        _countsnum++;
        _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
        _cutbtn.layer.borderColor=k333333.CGColor;
        
        [_joinBtn setTitle:@"加入发货单" forState:0];
        _joinBtn.alpha=1;
        _joinBtn.userInteractionEnabled=YES;
    }
    
}


#pragma mark 加入发货单
-(void)add_sendShop{
    if (_countsnum>0) {
        NSString *titlestr=[NSString stringWithFormat:@"已加入（%ld）",_countsnum];
        [_joinBtn setTitle:titlestr forState:0];
        _joinBtn.alpha=0.7;
        _joinBtn.userInteractionEnabled=NO;
        
        _goodsblock([NSString stringWithFormat:@"%ld",_countsnum]);
    }

}


-(void)setMax_goodsnum:(NSInteger)max_goodsnum{
    _max_goodsnum=max_goodsnum;
}

-(void)setCountsnum:(NSInteger)countsnum{
    _countsnum=countsnum;
    if (_countsnum==0) {
        [_joinBtn setTitle:@"加入发货单" forState:0];
        _joinBtn.alpha=1;
        _joinBtn.userInteractionEnabled=YES;
    }
    _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
