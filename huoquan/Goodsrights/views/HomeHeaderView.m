//
//  HomeHeaderView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/15.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HomeCateModel.h"
@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame cateAry:(NSArray *)cateAry{
    if (self=[super initWithFrame:frame]) {
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 207)];
        [self addSubview:view1];
        
        _cateArray=[NSArray arrayWithArray:cateAry];
        
        int k=0;
        for (int i=0;i<2 ; i++) {
            for (int j=0; j<3; j++) {
                
                if (k<cateAry.count) {
                    HomeCateModel *model=[[HomeCateModel alloc]initWithDictionary:cateAry[k] error:nil];
                    
                    UIImageView *btns=[[UIImageView alloc]initWithFrame:CGRectMake(40+j*121, 15+i*91,54, 54)];
                    btns.center=CGPointMake(kScreenWidth/6.0*(j*2+1), btns.center.y);
                    [view1 addSubview:btns];
                    btns.layer.cornerRadius=27;
                    btns.layer.borderColor=kD8D8D8.CGColor;
                    btns.layer.borderWidth=1;
                    btns.layer.masksToBounds=YES;
                    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,model.categoryPic]];
                    
                    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                                 forHTTPHeaderField:@"Accept"];
                    [btns sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"分类"]];
                    
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(brandClick:)];
                    
                    btns.tag=k+10;
                    btns.userInteractionEnabled=YES;
                    [btns addGestureRecognizer:tap];
                    
                
                    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(20+j*50, 78+i*91,60,14)];
                    titlelabel.center=CGPointMake(kScreenWidth/6.0*(j*2+1), titlelabel.center.y);
                    titlelabel.text=model.categoryName;
                    titlelabel.font=FOURTEEN;
                    titlelabel.textColor=k333333;
                    titlelabel.textAlignment=NSTextAlignmentCenter;
                    [view1 addSubview:titlelabel];
                    k++;
                }
                
            }
        }
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,206, kScreenWidth, 1)];
        line.backgroundColor=kE4E4E4;
        [view1 addSubview:line];
        
        UILabel *tuijian=[[UILabel alloc]initWithFrame:CGRectMake(0, 222, kScreenWidth, 15)];
        tuijian.textColor=k333333;
        tuijian.font=FIFTEEN;
        [self addSubview:tuijian];
        tuijian.text=@"好物推荐";
        tuijian.textAlignment=NSTextAlignmentCenter;
        
        UIImageView *imagelaft=[UIImageView newAutoLayoutView];
        [self addSubview:imagelaft];
        imagelaft.image=[UIImage imageNamed:@"好物推荐修饰左"];
        [imagelaft autoSetDimensionsToSize:CGSizeMake(49, 2)];
        [imagelaft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:94*HH];
        [imagelaft autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:view1 withOffset:22];
        
        UIImageView *imageright=[UIImageView newAutoLayoutView];
        [self addSubview:imageright];
        imageright.image=[UIImage imageNamed:@"好物推荐修饰右"];
        [imageright autoSetDimensionsToSize:CGSizeMake(49, 2)];
        [imageright autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:94*HH];
        [imageright autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:view1 withOffset:22];
        
        
    }
    return self;
}



-(void)brandClick:(UIButton *)sender{
     UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSInteger taptag=[singleTap view].tag;
    HomeCateModel *model=[[HomeCateModel alloc]initWithDictionary:_cateArray[taptag-10] error:nil];
    if (_tapAction) {
        _tapAction(model.categoryId,model.categoryName);
    }
    
}







@end
