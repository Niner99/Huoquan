//
//  ShopView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/22.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "ShopView.h"

@implementation ShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame model:(SkuModel *)skumodel detail:(GoodsDetailModel *)detailmodel{
    if (self=[super initWithFrame:frame]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        blackView.backgroundColor =[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.5];
        blackView.tag = 440;
        
        [window addSubview:blackView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismisspresentview)];
        [blackView addGestureRecognizer:tap];
        
        
        [window addSubview:self];
        
        self.backgroundColor=[UIColor whiteColor];
        
        
        _specid=skumodel.specId;
        _min_num=[skumodel.minPurchaseQuantity intValue];
        _countsnum=1*_min_num;
        _max_num=[skumodel.specStock integerValue];
        //小图
        _smallicon=[UIImageView newAutoLayoutView];
        [self addSubview:_smallicon];
        [_smallicon autoSetDimensionsToSize:CGSizeMake(104, 104)];
        [_smallicon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [_smallicon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        _smallicon.image=[UIImage imageNamed:@"产品图"];
        _smallicon.layer.borderColor=kD8D8D8.CGColor;
        _smallicon.layer.borderWidth=1;
        
        
        NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,detailmodel.mainPicture]];
            
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                         forHTTPHeaderField:@"Accept"];
        [_smallicon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
        

        
    
        _goodsname=[UILabel newAutoLayoutView];
        [self addSubview:_goodsname];
        [_goodsname autoSetDimensionsToSize:CGSizeMake(200, 14)];
        [_goodsname autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
        [_goodsname autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_smallicon withOffset:15];
        _goodsname.font=FOURTEEN;
        _goodsname.textColor=k333333;
        _goodsname.text=detailmodel.goodsName;
        
        _cancelbt=[UIButton newAutoLayoutView];
        [self addSubview:_cancelbt];
        [_cancelbt autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [_cancelbt autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [_cancelbt autoSetDimensionsToSize:CGSizeMake(13, 13)];
        [_cancelbt setImage:[UIImage imageNamed:@"返回详情页"] forState:0];
        [_cancelbt addTarget:self action:@selector(dismisspresentview) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *priceIcon=[UIImageView newAutoLayoutView];
        [self addSubview:priceIcon];
        [priceIcon autoSetDimensionsToSize:CGSizeMake(13, 16)];
        [priceIcon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsname withOffset:25];
        [priceIcon autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_goodsname];
        priceIcon.image=[UIImage imageNamed:@"价格牌"];
        
        _goodsPrice=[UILabel newAutoLayoutView];
        [self addSubview:_goodsPrice];
        [_goodsPrice autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:priceIcon];
        [_goodsPrice autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:priceIcon withOffset:5];
        [_goodsPrice autoSetDimensionsToSize:CGSizeMake(80, 15)];
        _goodsPrice.font=FIFTEEN;
        _goodsPrice.textColor=kDABF66;
        _goodsPrice.text=[NSString stringWithFormat:@"￥%@",[NSString pointtwo:skumodel.goodsPrice]];
        
        _leftNum=[UILabel newAutoLayoutView];
        [self addSubview:_leftNum];
        [_leftNum autoSetDimensionsToSize:CGSizeMake(120, 12)];
        [_leftNum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [_leftNum autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:108];
        _leftNum.textColor=k333333;
        _leftNum.font=TWELVE;
        _leftNum.textAlignment=NSTextAlignmentRight;
        _leftNum.text=[NSString stringWithFormat:@"剩余货权数：%@",skumodel.specStock];
        
        
        UILabel *buynumlabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 173, 130, 12)];
        buynumlabel.text=@"请选择需要购买的数量";
        buynumlabel.textColor=k888888;
        [self addSubview:buynumlabel];
        buynumlabel.font=TWELVE;
        
        _cutbtn =[UIButton newAutoLayoutView];
        [self addSubview:_cutbtn];
        [_cutbtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:163];
        [_cutbtn autoSetDimensionsToSize:CGSizeMake(46,31)];
        [_cutbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:132];
        [_cutbtn setTitle:@"-" forState:0];
        [_cutbtn setTitleColor:k333333 forState:0];
        [_cutbtn addTarget:self action:@selector(cutcounts) forControlEvents:UIControlEventTouchUpInside];
        _cutbtn.titleLabel.font=FIFTEEN;
        _cutbtn.layer.borderWidth=1;
        _cutbtn.layer.borderColor=k888888.CGColor;
        
        _numlabel=[UILabel newAutoLayoutView];
        [self addSubview:_numlabel];
        [_numlabel autoSetDimensionsToSize:CGSizeMake(69,31)];
        [_numlabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cutbtn withOffset:-1];
        [_numlabel autoPinEdge:ALEdgeTop  toEdge:ALEdgeTop ofView:_cutbtn];
        _numlabel.font=FIFTEEN;
        _numlabel.textAlignment=NSTextAlignmentCenter;
        _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
        _numlabel.layer.borderColor=k333333.CGColor;
        _numlabel.layer.borderWidth=1;
        _numlabel.textColor=k333333;
        
        _plusbtn=[UIButton newAutoLayoutView];
        [self addSubview:_plusbtn];
        [_plusbtn autoSetDimensionsToSize:CGSizeMake(46,31)];
        [_plusbtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_numlabel withOffset:-1];
        [_plusbtn autoPinEdge:ALEdgeTop  toEdge:ALEdgeTop ofView:_cutbtn];
        [_plusbtn setTitle:@"+" forState:0];
        [_plusbtn setTitleColor:k333333 forState:0];
        [_plusbtn addTarget:self action:@selector(pluscounts) forControlEvents:UIControlEventTouchUpInside];
        _plusbtn.titleLabel.font=FIFTEEN;
        _plusbtn.layer.borderWidth=1;
        _plusbtn.layer.borderColor=k333333.CGColor;
        
        
        _surebtn=[UIButton newAutoLayoutView];
        [self addSubview:_surebtn];
        [_surebtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:233];
        [_surebtn autoSetDimensionsToSize:CGSizeMake(346, 41)];
        [_surebtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        _surebtn.backgroundColor=k000000;
        [_surebtn setTitle:@"确 定" forState:0];
        _surebtn.layer.cornerRadius=4;
        [_surebtn addTarget:self action:@selector(suregoodsnum) forControlEvents:UIControlEventTouchUpInside];
        
        blackView.alpha = 0;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //
            self.frame=CGRectMake(0, kScreenHeight-298, kScreenWidth,298);
            blackView.alpha = 1;
        } completion:^(BOOL finished) {
            //
        }];
        
    }
    return self;
}


-(void)cutcounts{
    if (_countsnum>1*_min_num) {
        _countsnum-=_min_num;
        _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
        if (_countsnum==1*_min_num) {
            _cutbtn.layer.borderColor=k888888.CGColor;
        }
        
    }else{
        _cutbtn.layer.borderColor=k888888.CGColor;
    }
    
}

-(void)pluscounts{
    if (_countsnum<_max_num) {
        _countsnum+=_min_num;
        _numlabel.text=[NSString stringWithFormat:@"%ld",_countsnum];
        _cutbtn.layer.borderColor=k333333.CGColor;
    }else{
        //库存不足
    }

}

#pragma mark 确定
-(void)suregoodsnum{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //
        self.frame=CGRectMake(0, kScreenHeight, kScreenWidth,298);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        //
        if (_max_num<_countsnum) {
            
        }else{
            if (_goodsdelegate && [_goodsdelegate respondsToSelector:@selector(choosegoods:specId:)]) {
                [_goodsdelegate choosegoods:_countsnum specId:_specid];
            }
        }
        
        [self removeFromSuperview];
        [blackView removeFromSuperview];
        
    }];
}


-(void)dismisspresentview{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //
        self.frame=CGRectMake(0, kScreenHeight, kScreenWidth,298);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
        [blackView removeFromSuperview];
        
    }];
}



@end
