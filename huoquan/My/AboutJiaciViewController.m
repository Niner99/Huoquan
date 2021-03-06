//
//  AboutJiaciViewController.m
//  huoquan
//
//  Created by finecasa on 2017/9/15.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "AboutJiaciViewController.h"

@interface AboutJiaciViewController ()

@end

@implementation AboutJiaciViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self loadTitleWithTitle:@"关于家瓷网" color:k000000 fontSize:kTitleFloat];
}

-(void)creatUI{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,64,kScreenWidth, kScreenHeight-64)];
    [webView scalesPageToFit];
    [self.view addSubview:webView];
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    NSString *caURLStr=kAboutJiaci;
    
    
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)caURLStr]];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    
    
    if (!(htmlString ==nil || [htmlString isEqualToString:@""])) {
        
        [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:caURLStr]];
        
    }else{
        
        NSURL* url = [NSURL URLWithString:caURLStr];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [webView loadRequest:request];
        
        [self writeToCache:caURLStr];
        
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
