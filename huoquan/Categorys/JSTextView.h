//
//  JSTextView.h
//  shepin
//
//  Created by 家瓷网 on 2017/7/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSTextView : UITextView
@property (copy, nonatomic, nullable)NSString *myPlaceholder;  //文字

@property(strong, nonatomic, nullable) UIColor *myPlaceholderColor; //文字颜色


@property (strong, nonatomic, nullable) UIFont *myplaceholderFont;
@end
