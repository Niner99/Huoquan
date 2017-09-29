//
//  CategoryCollectionReusableView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/9/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "CategoryCollectionReusableView.h"

@implementation CategoryCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        _titlebrand=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenWidth-108, 12)];
        [self addSubview:_titlebrand];
        _titlebrand.font=TWELVE;
        _titlebrand.textAlignment=NSTextAlignmentCenter;
        _titlebrand.textColor=k333333;
        
        UIView *yellowview;
        if (yellowview==nil) {
            yellowview =[[UIView alloc]initWithFrame:CGRectMake(67*HH,20, 43*HH, 2)];
            yellowview.backgroundColor=kDABF66;
            [self addSubview:yellowview];
        }
        UIView *yellowview2;
        if (yellowview2==nil) {
            yellowview2=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-(108+67+43)*HH,20, 43*HH, 2)];
            yellowview2.backgroundColor=kDABF66;
            [self addSubview:yellowview2];
        }
        
    }
    return self;
}




@end
