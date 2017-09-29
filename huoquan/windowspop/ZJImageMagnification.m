//
//  ZJImageMagnification.m
//  huoquan
//
//  Created by 家瓷网 on 2017/9/12.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "ZJImageMagnification.h"

@implementation ZJImageMagnification

static CGRect oldframe;


+(void)scanBigImageWithImageView:(UIImageView *)currentImageview alpha:(CGFloat)alpha {
    // 当前imageview的图片
    UIImage *image=currentImageview.image;
    
    //当前视图
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    //背景
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
     //  当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
    oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];
    
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:alpha]];
    
    //  此时视图不会显示
    [backgroundView setAlpha:0];
    
    //  将所展示的imageView重新绘制在Window中
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    [imageView setImage:image];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.tag=1024;
    [backgroundView addSubview:imageView];
    
    //讲原始视图添加到背景是图
    [window addSubview:backgroundView];
    
    
    //点击事件
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    
    //动画放大所展示的imageview
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat y,width,height;
         y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
         //宽度为屏幕宽度
        width = [UIScreen mainScreen].bounds.size.width;
        //高度 根据图片宽高比设置
        height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        
        [imageView setFrame:CGRectMake(0, y, width, height)];
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
    }];
 
}


+(void)hideImageView:(UITapGestureRecognizer *)tap{
    UIView *backgroundView=tap.view;
    
    // 原始imageview
    UIImageView *imageView = [tap.view viewWithTag:1024];
    // 恢复
    [UIView animateWithDuration:0.4 animations:^{
        [imageView setFrame:oldframe];
        [backgroundView setAlpha:0];
    } completion:^(BOOL finished) {
        //完成后操作->将背景视图删掉
        [backgroundView removeFromSuperview];
    }];
    

}










@end
