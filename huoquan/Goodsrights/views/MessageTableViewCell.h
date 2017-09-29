//
//  MessageTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/17.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell



@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) myLabel *contentLabel;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UILabel *haveRead;

@end
