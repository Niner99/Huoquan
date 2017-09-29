//
//  SearchView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/16.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame historyArray:(NSMutableArray *)historyArray{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
    }
    return self;
}




-(void)tapClick:(UITapGestureRecognizer *)sender{
    UILabel *label = (UILabel *)sender.view;
    if (_tapAction) {
        _tapAction(label.text);
    }

}


-(void)setHistoryArray:(NSMutableArray *)historyArray{
    for (UIView *vieww in self.subviews) {
        [vieww removeFromSuperview];
    }
    
    
    self.backgroundColor=[UIColor whiteColor];

    if (historyArray.count>0) {
        historyArray=(NSMutableArray *)[[historyArray reverseObjectEnumerator] allObjects];
        //历史搜索
        UILabel *ttt=[[UILabel alloc]initWithFrame:CGRectMake(15, 26, 100, 14)];
        ttt.text=@"历史搜索";
        ttt.textColor=k333333;
        ttt.font=FOURTEEN;
        [self addSubview:ttt];
        
        //历史搜索的内容们
        int k=0;
        for (int i=0; i<2; i++) {
            for (int j=0; j<5; j++) {
                if (k<historyArray.count) {
                    NSString *textStr=historyArray[k];
                    //   CGFloat width=[NSString widthOfStr:textStr font:TWELVE height:12]+30;
                    
                    UILabel *historyLabel=[[UILabel alloc]initWithFrame:CGRectMake(35+70*j, 58+i*40, 50, 12)];
                    historyLabel.text=textStr;
                    historyLabel.font=TWELVE;
                    historyLabel.textColor=k333333;
                    historyLabel.tag=10+i;
                    [self addSubview:historyLabel];
                    historyLabel.userInteractionEnabled=YES;
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
                    
                    [historyLabel addGestureRecognizer:tap];
                    
                    k++;
                }

            }
            
            
            

        }
        
        //清空按钮
        UIButton *clearBtn=[UIButton newAutoLayoutView];
        [self addSubview:clearBtn];
        [clearBtn autoSetDimensionsToSize:CGSizeMake(80, 16)];
        [clearBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:160];
        [clearBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [clearBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:0];
        [clearBtn setTitle:@"清空记录" forState:0];
        [clearBtn setTitleColor:k888888 forState:0];
        clearBtn.titleLabel.font=FIFTEEN;
        clearBtn.imageEdgeInsets=UIEdgeInsetsMake(0, -5, 0, 5);
        [clearBtn addTarget:self action:@selector(clearHistorybtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    

}


-(void)clearHistorybtn{
    kRemoveStandardUserDefaults(kSearchArray);
    for (UIView *vieww in self.subviews) {
        [vieww removeFromSuperview];
    }
}








@end
