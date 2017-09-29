//
//  CommitOrderViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/24.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "CommitOrderViewController.h"
#import "MyAddressTableViewCell.h"
#import "CommitOrderTableViewCell.h"
#import "BillInfoModel.h"
#import "AddressModel.h"
#import "SendManageViewController.h"
#import "MyAddressViewController.h"
#import "NoaddressOrderTableViewCell.h"
@interface CommitOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    JCAlertView *jcaler;
    AddressModel *address;
    NSMutableArray *dataArray;
    NoNetView *noview;
    UIButton *commitbtn;
}
@end

@implementation CommitOrderViewController
static NSString *celladdress=@"celladdress";
static NSString *cellgoods=@"cellgoods";
static NSString *cellnoaddres=@"cellnoaddres";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"填写订单" color:k000000 fontSize:kTitleFloat];
    [self creatUI];
}

-(void)initData{
    [self showNHUD];
    dataArray=[[NSMutableArray alloc]init];
    NSDictionary *dic=@{@"param":_jsonString};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kBillInfo] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        if ([responseObject[@"code"] intValue]==200) {
            
            BillInfoModel *bill=[[BillInfoModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
            address=[[AddressModel alloc]initWithDictionary:bill.address error:nil];
            [dataArray addObjectsFromArray:bill.pitchOnlist];
            [tv reloadData];
            
            if (address) {
                commitbtn.backgroundColor=k000000;
                
            }else{
                commitbtn.backgroundColor=kD8D8D8;
            }
            
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
    }];
}




-(void)creatUI{
    
    UIImageView *imagetop=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 6)];
    imagetop.image=[UIImage imageNamed:@"分割修饰"];
    [self.view addSubview:imagetop];
    
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight-70-51) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=kF8F8F8;
    [self.view addSubview:tv];
    [tv registerClass:[MyAddressTableViewCell class] forCellReuseIdentifier:celladdress];
    [tv registerClass:[CommitOrderTableViewCell class] forCellReuseIdentifier:cellgoods];
    [tv registerClass:[NoaddressOrderTableViewCell class] forCellReuseIdentifier:cellnoaddres];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    UIView *booo=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-51, kScreenWidth, 51)];
    [self.view addSubview:booo];
    booo.backgroundColor=[UIColor whiteColor];
    
    commitbtn=[[UIButton alloc]initWithFrame:CGRectMake(15,5, kScreenWidth-30, 41)];
    commitbtn.backgroundColor=k000000;
    [commitbtn setTitle:@"提 交" forState:0];
    commitbtn.layer.cornerRadius=4;
    commitbtn.titleLabel.font=FIFTEEN;
    [booo addSubview:commitbtn];
    [commitbtn addTarget:self action:@selector(commitOrderclick) forControlEvents:UIControlEventTouchUpInside];
    
    
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if (address) {
            MyAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celladdress];
            cell.username.text=address.consignee;
            cell.phonenum.text=address.mobile;
            NSDictionary *citydic=[NSString dictionaryWithJsonString:address.jsonAddress];
            if (citydic) {
                NSString *cityStr=[NSString stringWithFormat:@"%@%@%@",citydic[@"c"],citydic[@"d"],citydic[@"p"]];
                cell.useraddress.text=[NSString stringWithFormat:@"%@%@",cityStr,address.fullAddress];
            }
            cell.moren.hidden=NO;
            cell.editbtn.hidden=YES;
            return cell;
        }else{
            NoaddressOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellnoaddres];
            [cell.addbtn addTarget:self action:@selector(addaddress_choose) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }

    }if(indexPath.section==1){
        CommitOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellgoods];
        ReadySendModel *reay=dataArray[indexPath.row];
        
        cell.goodstitle.text=reay.goodsName;
        NSArray *specArray=(NSArray *)[NSString dictionaryWithJsonString:reay.sellAttribute];
        
        NSString *specString=@"";
        for (int i=0; i<specArray.count; i++) {
            NSDictionary *specdic=specArray[i];
            NSString *cityStr=[NSString stringWithFormat:@"%@/%@",specdic[@"spec"],specdic[@"value"]];
            specString=[specString stringByAppendingString:[NSString stringWithFormat:@" %@",cityStr]];
            
        }
        cell.goodsColor.text=specString;
        
        NSURL *ulstr=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE,reay.mainPicture]];
        
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                     forHTTPHeaderField:@"Accept"];
        [cell.goodsIcon sd_setImageWithURL:ulstr placeholderImage:[UIImage imageNamed:@"主图"]];
        
        cell.goodsNum.text=[NSString stringWithFormat:@"×%@",reay.amount];
        
        
        return cell;
    }
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 66;
    }
    return 92;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return dataArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UILabel *senlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 27)];
        senlabel.text=@"  发货清单";
        senlabel.font=TWELVE;
        senlabel.textColor=k333333;
        return senlabel;
        
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }
    return 27;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        [self addaddress_choose];
    }
}

#pragma mark 添加或选择地址
-(void)addaddress_choose{
    MyAddressViewController *myaddress=[MyAddressViewController new];
    [self.navigationController pushViewController:myaddress animated:YES];
}


#pragma mark 提交订单
-(void)commitOrderclick{
    
    if (address) {
        NSDictionary *dic=@{@"param":_jsonString,@"addressId":address.pkId};
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kBillCommit] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([responseObject[@"code"] intValue]==200) {
                PopWindowView *pop=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) commit:@"提交订单"];
                [pop.leftBtn addTarget:self action:@selector(rebackhomeview) forControlEvents:UIControlEventTouchUpInside];
                [pop.rightBtn addTarget:self action:@selector(btn_dismissview) forControlEvents:UIControlEventTouchUpInside];
                jcaler=nil;
                jcaler =[[JCAlertView alloc]initWithCustomView:pop dismissWhenTouchedBackground:NO];
                [jcaler show];
            }
            
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            
        }];
    }else{
        [self displayNHUDTitle:@"您还没有添加收货地址"];
    }
    
    


}



-(void)rebackhomeview{
    [jcaler dismissWithCompletion:^{
        jcaler=nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.tabBarController.selectedIndex=0;
    }];
}


-(void)btn_dismissview{
    [jcaler dismissWithCompletion:^{
        jcaler=nil;
        SendManageViewController *send=[SendManageViewController new];
        [self.navigationController pushViewController:send animated:YES];
    }];
}

-(void)ishaveView:(BOOL )isnet{
    if (isnet==YES) {
        noview.hidden=YES;
    }else{
        noview.hidden=NO;
    }
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
