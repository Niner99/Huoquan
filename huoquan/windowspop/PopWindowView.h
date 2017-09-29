//
//  PopWindowView.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/18.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopWindowView : UIView
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *btnsing;

-(instancetype)initWithFrame:(CGRect)frame firstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle;


-(instancetype)initWithFrame:(CGRect)frame singleTitle:(NSString *)singleTitle leftBtn:(NSString *)leftBtn rightBtn:(NSString *)rightBtn;


-(instancetype)initWithFrame:(CGRect)frame commit:(NSString *)commit;


-(instancetype)initWithFrame:(CGRect)frame mainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle leftBtn:(NSString *)leftBtn rightBtn:(NSString *)rightBtn;

-(instancetype)initWithFrame:(CGRect)frame singlebtn:(NSString *)singlebtn singletitle:(NSString *)singletitle;

@end
