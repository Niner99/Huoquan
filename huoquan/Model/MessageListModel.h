//
//  MessageListModel.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/5.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageListModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*msgType;
@property (nonatomic, strong) NSString <Optional>*noticeMsg;
@property (nonatomic, strong) NSString <Optional>*noticeTitle;
@property (nonatomic, strong) NSString <Optional>*pkId;
@property (nonatomic, strong) NSString <Optional>*sendTime;
@end
