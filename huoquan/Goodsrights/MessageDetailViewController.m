//
//  MessageDetailViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/17.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()
{
    UILabel *titleLabel;
    UILabel *timeLabel;
    NoNetView *noview;
    myLabel *contentLabel;
}
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"消息详情页" color:k000000 fontSize:18];
    
    [self creatUI];
}


-(void)creatUI{
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(16, 20+64, 300, 15)];
    titleLabel.font=FIFTEEN;
    
    [self.view addSubview:titleLabel];
    
    UIImageView *timeicon=[[UIImageView alloc]initWithFrame:CGRectMake(16, 46+64, 14, 14)];
    timeicon.image=[UIImage imageNamed:@"时间"];
    [self.view addSubview:timeicon];
    
    timeLabel=[UILabel newAutoLayoutView];
    [self.view addSubview:timeLabel];
    [timeLabel autoSetDimensionsToSize:CGSizeMake(200, 11)];
    [timeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:timeicon withOffset:5];
    [timeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:timeicon];
    timeLabel.textColor=k888888;
    timeLabel.font=ELEVEN;
    
    
    contentLabel=[[myLabel alloc]initWithFrame:CGRectMake(16, 79+64, 345, kScreenHeight)];
    contentLabel.font=TWELVE;
    contentLabel.textColor=k333333;
    contentLabel.numberOfLines=0;
    contentLabel.verticalAlignment=VerticalAlignmentTop;
    [self.view addSubview:contentLabel];

    
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
}

-(void)initData{
    [self showNHUD];
    NSDictionary *dic=@{@"noticeId":_noticeID};
    
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kMessageDetail] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        if ([responseObject[@"code"] intValue]==200) {
            
            NSDictionary *data=responseObject[@"data"];
            
            titleLabel.text=data[@"noticeTitle"];
            timeLabel.text=[NSString setTimewithString:data[@"sendTime"]];
                contentLabel.text=data[@"noticeMsg"];
        
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
    }];
}





-(void)viewWillAppear:(BOOL)animated{
    [self initData];
}


-(void)ishaveView:(BOOL )isnet{
    if (isnet==YES) {
        noview.hidden=YES;
    }else{
        noview.hidden=NO;
    }
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
