//
//  DateView.h
//  shepin
//
//  Created by 家瓷网 on 2017/7/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatepickerDelegate <NSObject>

@optional

-(void)datestr:(NSString *)dateStr;

@end
@interface DateView : UIView

@property (nonatomic, strong) UIDatePicker *datepicker;

@property (nonatomic, weak) id<DatepickerDelegate> datepickerdelegate;
@end
