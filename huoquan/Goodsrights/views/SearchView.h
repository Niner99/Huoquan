//
//  SearchView.h
//  huoquan
//
//  Created by 家瓷网 on 2017/8/16.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapActionBlock)(NSString *strs);




@interface SearchView : UIView

@property (nonatomic, copy) TapActionBlock tapAction;


@property (nonatomic, strong) NSMutableArray *historyArray;

@end
