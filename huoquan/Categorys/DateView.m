//
//  DateView.m
//  shepin
//
//  Created by 家瓷网 on 2017/7/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "DateView.h"

@implementation DateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        blackView.backgroundColor =[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.5];
        blackView.tag = 440;
        
        [window addSubview:blackView];
        
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissview)];
        [blackView addGestureRecognizer:tap];
        
        [window addSubview:self];
        
        self.backgroundColor=[UIColor whiteColor];
        
        
        UIButton *btncancel=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        [btncancel setTitle:@"取消" forState:0];
        [btncancel setTitleColor:k191919 forState:0];
        [self addSubview:btncancel];
        [btncancel addTarget:self action:@selector(dismissview) forControlEvents:UIControlEventTouchUpInside];
        btncancel.titleLabel.font=FIFTEEN;
        
        
        UIButton *btnsure=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-60, 0, 60, 40)];
        [btnsure setTitle:@"确定" forState:0];
        [btnsure addTarget:self action:@selector(makesuredate) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnsure];
        [btnsure setTitleColor:k000000 forState:0];
        btnsure.titleLabel.font=FIFTEEN;
        
        
        _datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 180)];
        _datepicker.datePickerMode=UIDatePickerModeDate;
        [self addSubview:_datepicker];
        _datepicker.date=[NSDate date];
        [_datepicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];//中国时区
        
        
        
        
        blackView.alpha = 0;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //
            self.frame=CGRectMake(0, kScreenHeight-240, kScreenWidth,240);
            blackView.alpha = 1;
        } completion:^(BOOL finished) {
            //
        }];
        
        
    }
    return self;
}



-(void)makesuredate{
    NSDate *theDate = _datepicker.date;
    //   NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    
    [_datepickerdelegate datestr:[dateFormatter stringFromDate:theDate]];
    
    [self dismissview];
}




-(void)dismissview{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //
        self.frame=CGRectMake(0, kScreenHeight, kScreenWidth,240);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        //
        [self removeFromSuperview];
        [blackView removeFromSuperview];
        
    }];
}


@end
