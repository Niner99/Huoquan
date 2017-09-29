//
//  JSTextView.m
//  shepin
//
//  Created by 家瓷网 on 2017/7/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "JSTextView.h"

@interface JSTextView()

@property (nonatomic,weak) UILabel *placeholderLabel; //这里先拿出这个label以方便我们后面的使用
@end


@implementation JSTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setUp];
    return self;
}

- (void)setUp {
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_placeholderLabel = placeholderLabel];
    
    self.myPlaceholderColor =k888888;
    self.myplaceholderFont = THIRTEEN;
    self.font = THIRTEEN;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}


#pragma mark -监听文字改变

- (void)textDidChange {
    
    self.placeholderLabel.hidden = self.hasText;//这个 hasText  是一个 系统的 BOOL  属性，如果 UITextView 输入了文字  hasText 就是 YES，反之就为 NO。
    
}



-(void)setText:(NSString *)text{
    [super setText:text];
    
    [self textDidChange];
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

-(void)setMyplaceholderFont:(UIFont *)myplaceholderFont{
    _myplaceholderFont = myplaceholderFont;
    self.placeholderLabel.font = myplaceholderFont;
    [self setNeedsLayout];
}

-(void)setMyPlaceholder:(NSString *)myPlaceholder{
    _myPlaceholder=[myPlaceholder copy];
    self.placeholderLabel.text=myPlaceholder;
    [self setNeedsLayout];
    
}

-(void)setMyPlaceholderColor:(UIColor *)myPlaceholderColor{
    _myPlaceholderColor=myPlaceholderColor;
    self.placeholderLabel.textColor=myPlaceholderColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.placeholderLabel.frame;
    frame.origin.y = self.textContainerInset.top;
    frame.origin.x = self.textContainerInset.left+6.0f;
    frame.size.width = self.frame.size.width - self.textContainerInset.left*2.0;
    
    CGSize maxSize = CGSizeMake(frame.size.width, MAXFLOAT);
    frame.size.height = [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    self.placeholderLabel.frame = frame;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}




















@end
