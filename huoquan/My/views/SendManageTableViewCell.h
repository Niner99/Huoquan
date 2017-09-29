//
//  SendManageTableViewCell.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendManageTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *sendCode;


@property (nonatomic, strong) UILabel *commtTime;


@property (nonatomic, strong) UILabel *sendState;


@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) NSString *stateStr;
@end
