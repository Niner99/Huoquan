//
//  LogisticsInfoViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/25.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "LogisticsInfoViewController.h"
#import "ZJImageMagnification.h"

@interface LogisticsInfoViewController ()
{
    NSString *logisname;
    NSString *logisCode;
    NSString *logisPic;
    
    UIImageView *photologis;
}
@end

@implementation LogisticsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"查看物流" color:k000000 fontSize:kTitleFloat];
    
    
    
}


-(void)initData{
    [self showNHUD];
    NSDictionary *dicc=@{@"deliveryOrderId":_logisticID};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kLogisticsInfo] parameters:dicc success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        if ([responseObject[@"code"] intValue]==200) {
            
            NSDictionary *data=responseObject[@"data"];
            logisname=data[@"expressName"];
            logisCode=data[@"expressNo"];
            logisPic=data[@"expressPhoto"];
            
            [self creatUI];
        }
        
    
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
}






-(void)creatUI{
    UILabel *wuliu=[[UILabel alloc]initWithFrame:CGRectMake(40, 84, 200, 16)];
    wuliu.font=SIXTEEN;
    wuliu.textColor=k333333;
    wuliu.text=[NSString stringWithFormat:@"物流：%@",logisname];
    [self.view addSubview:wuliu];
    
    UILabel *codeorder=[[UILabel alloc]initWithFrame:CGRectMake(41, 110, 200, 16)];
    codeorder.font=SIXTEEN;
    codeorder.textColor=k333333;
    codeorder.text=[NSString stringWithFormat:@"运单号：%@",logisCode];
    [self.view addSubview:codeorder];
    
    UIView *partview=[[UIView alloc]initWithFrame:CGRectMake(0, 80+64, kScreenWidth, 6)];
    partview.backgroundColor=kF8F8F8;
    [self.view addSubview:partview];
    
    UILabel *pingzheng=[[UILabel alloc]initWithFrame:CGRectMake(0, 105+64, kScreenWidth, 14)];
    pingzheng.text=@"    物流凭证";
    pingzheng.textColor=k333333;
    [self.view addSubview:pingzheng];
    pingzheng.font=FOURTEEN;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(15, 203, kScreenWidth-30, 1)];
    line.backgroundColor=kD8D8D8;
    [self.view addSubview:line];
    
    photologis=[[UIImageView alloc]initWithFrame:CGRectMake(15, 223, kScreenWidth-30, 260)];
    [self.view addSubview:photologis];
    photologis.contentMode=UIViewContentModeScaleAspectFit;
    NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,logisPic]];
    
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                 forHTTPHeaderField:@"Accept"];
    [photologis sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"产品详情图"]];
    photologis.userInteractionEnabled=YES;
    UITapGestureRecognizer *ttt=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappppp)];
    [photologis addGestureRecognizer:ttt];
    
    
}


-(void)tappppp{
    [ZJImageMagnification scanBigImageWithImageView:photologis alpha:0.8];
}












-(void)viewWillAppear:(BOOL)animated{
    [self initData];
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
