//
//  PopWindowView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/18.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "PopWindowView.h"

@implementation PopWindowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame firstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle{
    if (self =[super initWithFrame:frame]) {
        
        UIView *backView=[UIView newAutoLayoutView];
        [self addSubview:backView];
        backView.backgroundColor=[UIColor whiteColor];
        [backView autoSetDimensionsToSize:CGSizeMake(kScreenWidth-90, 139)];
        [backView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [backView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        backView.layer.cornerRadius=15;
        
        
        UILabel *titleLabel=[UILabel newAutoLayoutView];
        [backView addSubview:titleLabel];
        [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [titleLabel autoSetDimensionsToSize:CGSizeMake(233, 15)];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17];
        titleLabel.text=firstTitle;
        titleLabel.font=FIFTEEN;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        
        UIImageView *kefuicon=[[UIImageView alloc]initWithFrame:CGRectMake(64*HH, 45, 25, 19)];
        kefuicon.image=[UIImage imageNamed:@"客服电话"];
        [backView addSubview:kefuicon];
        
        UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(99*HH, 47, 150, 19)];
        phonelabel.text=secondTitle;
        phonelabel.textColor=k333333;
        [backView addSubview:phonelabel];
        phonelabel.font=EIGHTTEEN;
        
   
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,85, (kScreenWidth-90)/2.0, 60)];
        _leftBtn.titleLabel.font=FIFTEEN;
        [_leftBtn setTitleColor:kDABF66 forState:0];
        [backView addSubview:_leftBtn];
        
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0,85, (kScreenWidth-90)/2.0, 60)];
        _rightBtn.titleLabel.font=FIFTEEN;
        [_rightBtn setTitleColor:kDABF66 forState:0];
        [backView addSubview:_rightBtn];
        
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 85, kScreenWidth-90, 1)];
        line.backgroundColor=kD8D8D8;
        [backView addSubview:line];
        
        UIView *linever=[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0, 100, 1, 31 )];
        linever.backgroundColor=kD8D8D8;
        [backView addSubview:linever];

        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame commit:(NSString *)commit{
    if (self =[super initWithFrame:frame]) {
        
        UIView *backView=[UIView newAutoLayoutView];
        [self addSubview:backView];
        backView.backgroundColor=[UIColor whiteColor];
        [backView autoSetDimensionsToSize:CGSizeMake(kScreenWidth-90, 154)];
        [backView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [backView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        backView.layer.cornerRadius=15;
        
        
        UILabel *titleLabel=[UILabel newAutoLayoutView];
        [backView addSubview:titleLabel];
        [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [titleLabel autoSetDimensionsToSize:CGSizeMake(233, 17)];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17];
        titleLabel.text=@"提交成功！";
        titleLabel.font=EIGHTTEEN;
        titleLabel.textColor=kDABF66;
        titleLabel.textAlignment=NSTextAlignmentCenter;

        UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(39, 45, 209, 40)];
        phonelabel.text=@"我们会尽快安排发货！请注意查看物流信息。";
        phonelabel.textColor=k333333;
        [backView addSubview:phonelabel];
        phonelabel.numberOfLines=2;
        phonelabel.font=FOURTEEN;
        
        
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,95, (kScreenWidth-90)/2.0, 60)];
        _leftBtn.titleLabel.font=FIFTEEN;
        [_leftBtn setTitleColor:kDABF66 forState:0];
        [_leftBtn setTitle:@"返回首页" forState:0];
        [backView addSubview:_leftBtn];
        
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0,95, (kScreenWidth-90)/2.0, 60)];
        _rightBtn.titleLabel.font=FIFTEEN;
        [_rightBtn setTitleColor:kDABF66 forState:0];
        [_rightBtn setTitle:@"查看发货状态" forState:0];
        [backView addSubview:_rightBtn];
        
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 95, kScreenWidth-90, 1)];
        line.backgroundColor=kD8D8D8;
        [backView addSubview:line];
        
        UIView *linever=[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0, 110, 1, 31 )];
        linever.backgroundColor=kD8D8D8;
        [backView addSubview:linever];
        
        
    }
    return self;
}





-(instancetype)initWithFrame:(CGRect)frame singleTitle:(NSString *)singleTitle leftBtn:(NSString *)leftBtn rightBtn:(NSString *)rightBtn{
    if (self =[super initWithFrame:frame]) {
        
        CGFloat width=[NSString widthOfStr:singleTitle font:EIGHTTEEN height:18];
     //   CGFloat height=[NSString heightOfStr:singleTitle font:EIGHTTEEN width:233];
        
        UIView *backView=[UIView newAutoLayoutView];
        [self addSubview:backView];
        backView.backgroundColor=[UIColor whiteColor];
        [backView autoSetDimensionsToSize:CGSizeMake(kScreenWidth-90, 130)];
        [backView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [backView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        backView.layer.cornerRadius=15;
        

        
        UILabel *titleLabel=[UILabel newAutoLayoutView];
        [backView addSubview:titleLabel];
        [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [titleLabel autoSetDimensionsToSize:CGSizeMake(233, 44)];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
        titleLabel.numberOfLines=0;
        titleLabel.text=singleTitle;
        
        
        if (width>=233) {
            titleLabel.textAlignment=NSTextAlignmentLeft;
            titleLabel.font=FIFTEEN;
        }else{
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.font=EIGHTTEEN;
        }

        
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 70, (kScreenWidth-90)/2.0, 60)];
        _leftBtn.titleLabel.font=FIFTEEN;
        [_leftBtn setTitleColor:kDABF66 forState:0];
        [_leftBtn setTitle:leftBtn forState:0];
        [backView addSubview:_leftBtn];
        
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0,70, (kScreenWidth-90)/2.0, 60)];
        _rightBtn.titleLabel.font=FIFTEEN;
        [_rightBtn setTitleColor:kDABF66 forState:0];
        [_rightBtn setTitle:rightBtn forState:0];
        [backView addSubview:_rightBtn];
        
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth-90, 1)];
        line.backgroundColor=kD8D8D8;
        [backView addSubview:line];
        
        UIView *linever=[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0, 85, 1, 31 )];
        linever.backgroundColor=kD8D8D8;
        [backView addSubview:linever];
         
    }
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame mainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle leftBtn:(NSString *)leftBtn rightBtn:(NSString *)rightBtn{
    if (self =[super initWithFrame:frame]) {
        
        CGFloat width=[NSString widthOfStr:subTitle font:FOURTEEN height:14];
        
        UIView *backView=[UIView newAutoLayoutView];
        [self addSubview:backView];
        backView.backgroundColor=[UIColor whiteColor];
        [backView autoSetDimensionsToSize:CGSizeMake(kScreenWidth-90, 154)];
        [backView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [backView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        backView.layer.cornerRadius=15;
        
        
        UILabel *titleLabel=[UILabel newAutoLayoutView];
        [backView addSubview:titleLabel];
        [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [titleLabel autoSetDimensionsToSize:CGSizeMake(233, 17)];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17];
        titleLabel.text=mainTitle;
        titleLabel.font=EIGHTTEEN;
        titleLabel.textColor=kDABF66;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        
        UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(39, 45, 209, 40)];
        phonelabel.text=subTitle;
        phonelabel.textColor=k333333;
        [backView addSubview:phonelabel];
        phonelabel.numberOfLines=2;
        phonelabel.font=FOURTEEN;
        if (width>209) {
            phonelabel.textAlignment=NSTextAlignmentLeft;
        }else{
            phonelabel.textAlignment=NSTextAlignmentCenter;
        }
        
        
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,95, (kScreenWidth-90)/2.0, 60)];
        _leftBtn.titleLabel.font=FIFTEEN;
        [_leftBtn setTitleColor:kDABF66 forState:0];
        [_leftBtn setTitle:leftBtn forState:0];
        [backView addSubview:_leftBtn];
        
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0,95, (kScreenWidth-90)/2.0, 60)];
        _rightBtn.titleLabel.font=FIFTEEN;
        [_rightBtn setTitleColor:kDABF66 forState:0];
        [_rightBtn setTitle:rightBtn forState:0];
        [backView addSubview:_rightBtn];
        
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 95, kScreenWidth-90, 1)];
        line.backgroundColor=kD8D8D8;
        [backView addSubview:line];
        
        UIView *linever=[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2.0, 110, 1, 31 )];
        linever.backgroundColor=kD8D8D8;
        [backView addSubview:linever];
        
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame singlebtn:(NSString *)singlebtn singletitle:(NSString *)singletitle{
    if (self =[super initWithFrame:frame]) {
        UIView *backView=[UIView newAutoLayoutView];
        [self addSubview:backView];
        backView.backgroundColor=[UIColor whiteColor];
        [backView autoSetDimensionsToSize:CGSizeMake(kScreenWidth-90, 139)];
        [backView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [backView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        backView.layer.cornerRadius=15;
        
        UILabel *titleLabel=[UILabel newAutoLayoutView];
        [backView addSubview:titleLabel];
        [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [titleLabel autoSetDimensionsToSize:CGSizeMake(239,88)];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
        titleLabel.text=singletitle;
        titleLabel.font=FIFTEEN;
        titleLabel.textColor=k333333;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.numberOfLines=0;
        
        _btnsing=[[UIButton alloc]initWithFrame:CGRectMake(0, 88, kScreenWidth-90, 139-88)];
        [_btnsing setTitle:singlebtn forState:0];
        _btnsing.titleLabel.font=FIFTEEN;
        [_btnsing setTitleColor:kDABF66 forState:0];
        [backView addSubview:_btnsing];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 88, kScreenWidth-90, 1)];
        line.backgroundColor=kD8D8D8;
        [backView addSubview:line];
    }
    return self;
}











@end
