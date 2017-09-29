//
//  MyAddressTableViewCell.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MyAddressTableViewCell.h"

@implementation MyAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        _username=[UILabel newAutoLayoutView];
        [self addSubview:_username];
        [_username autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [_username autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
        [_username autoSetDimensionsToSize:CGSizeMake(70, 14)];
        _username.font=FOURTEEN;
        _username.textColor=k333333;
        
        _phonenum=[UILabel newAutoLayoutView];
        [self addSubview:_phonenum];
        [_phonenum autoSetDimensionsToSize:CGSizeMake(200, 14)];
        [_phonenum autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
        [_phonenum autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:96];
        _phonenum.font=FOURTEEN;
        _phonenum.textColor=k333333;
        
        _useraddress=[UILabel newAutoLayoutView];
        [self addSubview:_useraddress];
        [_useraddress autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:96];
        [_useraddress autoSetDimensionsToSize:CGSizeMake(220, 12)];
        [_useraddress autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:38];
        _useraddress.font=TWELVE;
        _useraddress.textColor=k888888;

        
        _moren=[UILabel newAutoLayoutView];
        [self addSubview:_moren];
        [_moren autoSetDimensionsToSize:CGSizeMake(34, 17)];
        [_moren autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [_moren autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
        _moren.text=@"默认";
        _moren.textColor=kDABF66;
        _moren.textAlignment=NSTextAlignmentCenter;
        _moren.layer.cornerRadius=2;
        _moren.layer.borderWidth=1;
        _moren.layer.borderColor=kDABF66.CGColor;
        _moren.font=TWELVE;
        _moren.hidden=YES;
        
        _editbtn=[UIButton newAutoLayoutView];
        [self addSubview:_editbtn];
        [_editbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [_editbtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:25];
        [_editbtn autoSetDimensionsToSize:CGSizeMake(17, 17)];
        [_editbtn setImage:[UIImage imageNamed:@"地址编辑"] forState:0];
     //   _editbtn.hidden=YES;

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
