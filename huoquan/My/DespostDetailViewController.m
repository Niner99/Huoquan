//
//  DespostDetailViewController.m
//  huoquan
//
//  Created by finecasa on 2017/9/27.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "DespostDetailViewController.h"
#import "WithdrawInfoModel.h"
@interface DespostDetailViewController ()<UITextFieldDelegate>
{
    UILabel *userPrice;
    UILabel *bankName;
    UILabel *bankNum;
    UITextField *depostMoney;
    UIButton *commitbtn;
    myLabel *infolabel;
    WithdrawInfoModel *withd;
}
@end

@implementation DespostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self loadTitleWithTitle:@"提现" color:k000000 fontSize:kTitleFloat];
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kwithdrawInfo] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]==200) {
            withd=[[WithdrawInfoModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
            [self updateAllValue];
        }
        [self NhideHUD:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
    }];
}



-(void)creatUI{
    userPrice=[[UILabel alloc]initWithFrame:CGRectMake(15, 64, kScreenWidth, 53)];
    [self.view addSubview:userPrice];
    userPrice.font=FIFTEEN;

    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 64+53, kScreenWidth, 6)];
    line.backgroundColor=kF8F8F8;
    [self.view addSubview:line];
    
    UILabel *banklabel=[UILabel newAutoLayoutView];
    [self.view addSubview:banklabel];
    [banklabel autoSetDimensionsToSize:CGSizeMake(100,42)];
    [banklabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [banklabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    banklabel.text=@"银行名称";
    banklabel.font=THIRTEEN;
    
    bankName=[UILabel newAutoLayoutView];
    [self.view addSubview:bankName];
    [bankName autoSetDimensionsToSize:CGSizeMake(200,42)];
    [bankName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [bankName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line];
    
    bankName.font=THIRTEEN;
    bankName.textAlignment=NSTextAlignmentRight;
    
    UILabel *codelabel=[UILabel newAutoLayoutView];
    [self.view addSubview:codelabel];
    [codelabel autoSetDimensionsToSize:CGSizeMake(100,42)];
    [codelabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [codelabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:banklabel];
    codelabel.text=@"银行账号";
    codelabel.font=THIRTEEN;
    
    bankNum=[UILabel newAutoLayoutView];
    [self.view addSubview:bankNum];
    [bankNum autoSetDimensionsToSize:CGSizeMake(200,42)];
    [bankNum autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [bankNum autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:banklabel];
   
    bankNum.font=THIRTEEN;
    bankNum.textAlignment=NSTextAlignmentRight;
    
    UILabel *moneylabel=[UILabel newAutoLayoutView];
    [self.view addSubview:moneylabel];
    [moneylabel autoSetDimensionsToSize:CGSizeMake(100,42)];
    [moneylabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [moneylabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:codelabel];
    moneylabel.text=@"提现金额(元)";
    moneylabel.font=THIRTEEN;
    
    depostMoney=[UITextField newAutoLayoutView];
    [self.view addSubview:depostMoney];
    [depostMoney autoSetDimensionsToSize:CGSizeMake(200,42)];
    [depostMoney autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [depostMoney autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:codelabel];
    depostMoney.placeholder=@"每笔手续费5元";
    depostMoney.font=THIRTEEN;
    depostMoney.textAlignment=NSTextAlignmentRight;
    depostMoney.keyboardType=UIKeyboardTypeDecimalPad;
    depostMoney.delegate=self;
    
    UIView *line1=[UIView newAutoLayoutView];
    [self.view addSubview:line1];
    [line1 autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 1)];
    [line1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:banklabel];
    line1.backgroundColor=kD8D8D8;
    
    UIView *line2=[UIView newAutoLayoutView];
    [self.view addSubview:line2];
    [line2 autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 1)];
    [line2 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:codelabel];
    line2.backgroundColor=kD8D8D8;
    
    UIView *line3=[UIView newAutoLayoutView];
    [self.view addSubview:line3];
    [line3 autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 1)];
    [line3 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:moneylabel];
    line3.backgroundColor=kD8D8D8;
    
    commitbtn=[UIButton newAutoLayoutView];
    [self.view addSubview:commitbtn];
    [commitbtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-88, 41)];
    [commitbtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [commitbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line3 withOffset:64];
    [commitbtn setTitle:@"提交审核" forState:0];
    commitbtn.backgroundColor=kB8B8B8;
    commitbtn.layer.cornerRadius=4;
    commitbtn.userInteractionEnabled=NO;
    commitbtn.titleLabel.font=SIXTEEN;
    [commitbtn addTarget:self action:@selector(commit_btn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *zhuyi=[[UILabel alloc]initWithFrame:CGRectMake(16, 427, 50, 12)];
    zhuyi.text=@"注意：";
    zhuyi.textColor=kDABF66;
    zhuyi.font=TWELVE;
    [self.view addSubview:zhuyi];
    
    infolabel=[[myLabel alloc ]initWithFrame:CGRectMake(52, 424, 200, 100)];
    infolabel.verticalAlignment=VerticalAlignmentTop;
    infolabel.numberOfLines=0;
    infolabel.textColor=kDABF66;
    infolabel.font=TWELVE;
    [self.view addSubview:infolabel];

}

-(void)updateAllValue{
    NSString *pricenum=[NSString stringWithFormat:@"¥%.2f",[withd.balance floatValue]];
    NSMutableAttributedString *tempstr=[UsefulClass setStr:pricenum onlyColor:kDABF66 maintext:[NSString stringWithFormat:@"可提现金额：%@",pricenum]];
    [userPrice setAttributedText:tempstr];
    
    bankName.text=withd.bankName;
    
    bankNum.text=withd.bankCardCode;
    
    NSString *infoStr=@"";
    for (int i=0; i<withd.rule.count; i++) {
        infoStr=[infoStr stringByAppendingString:[NSString stringWithFormat:@"%d.%@\n",i+1,withd.rule[i]]];
    }
    infolabel.text=infoStr;
}


#pragma mark--通知
-(void)change:(NSNotification *)notification
{
    
    if (depostMoney.text.length>0) {
        commitbtn.backgroundColor=k000000;
        commitbtn.userInteractionEnabled=YES;

    }else{
        commitbtn.backgroundColor=kB8B8B8;
        commitbtn.userInteractionEnabled=NO;

    }
}

#define mark 申请提现
-(void)commit_btn{
    
    if ([depostMoney.text floatValue]>[withd.balance floatValue]) {
        [self displayNHUDTitle:@"提现金额不得超过余额"];
    }else{
        [self showNHUD];
        NSDictionary *dic=@{@"bankCardId":withd.bankCardId,@"amount":depostMoney.text};
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kwithdrawApply] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            if ([responseObject[@"code"] intValue]==200) {
                [self displayNHUDTitle:@"申请提现成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self displayNHUDTitle:responseObject[@"info"]];
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    // 通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:nil];
    [self initData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
