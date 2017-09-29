//
//  AddressChooseView.h
//  huoquan
//
//  Created by 家瓷网 on 2017/9/6.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"

@protocol ChooseAreaDelegate <NSObject>

@optional

-(void)chooseprovince:(AreaModel *)reg choosetwice:(NSInteger )choosetwice;

@end

@interface AddressChooseView : UIView<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tv;


@property (nonatomic, weak) id<ChooseAreaDelegate> chooseaddressdelegate;



@property (nonatomic, strong) UILabel *provincelabel;
@property (nonatomic, strong) UILabel *citylabel;
@property (nonatomic, strong) UILabel *arealabel;

@property (nonatomic, strong) NSMutableArray *dataAry;

@property (nonatomic, assign) NSInteger selectNum;

@property (nonatomic, strong) UIView *lineYellow;

@property (nonatomic, strong) NSString *regionID;
@end
