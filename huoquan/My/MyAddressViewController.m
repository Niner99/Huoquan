//
//  MyAddressViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "MyAddressViewController.h"
#import "MyAddressTableViewCell.h"
#import "EditAddressViewController.h"
#import "UITableViewRowAction+JZExtension.h"
#import "AddressModel.h"
@interface MyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    UIView *noaddressview;
    NSMutableArray *dataArray;
    JCAlertView *jcView;
    NSString *addressId;
    NoNetView *noview;
}
@end

@implementation MyAddressViewController
static NSString *cellcone=@"cellone";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:@"收货地址" color:k000000 fontSize:kTitleFloat];
    [self creatUI];
}


-(void)initData{
    [self showNHUD];
    dataArray=[[NSMutableArray alloc]init];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kAddressList] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self NhideHUD:YES];
        [self ishaveView:YES];
        if ([responseObject[@"code"] intValue]==200) {
            [dataArray addObjectsFromArray:responseObject[@"data"]];
            [tv reloadData];
            if (dataArray.count>0) {
                noaddressview.hidden=YES;
            }else{
                noaddressview.hidden=NO;
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        [self NhideHUD:YES];
        [self ishaveView:NO];
    }];
}







-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-59) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    [self.view addSubview:tv];
    tv.backgroundColor=[UIColor whiteColor];
    [tv registerClass:[MyAddressTableViewCell class] forCellReuseIdentifier:cellcone];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    noaddressview =[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    noaddressview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:noaddressview];
    
    UIImageView *imageaddress=[UIImageView newAutoLayoutView];
    [noaddressview addSubview:imageaddress];
    [imageaddress autoSetDimensionsToSize:CGSizeMake(117, 106)];
    [imageaddress autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:91];
    [imageaddress autoAlignAxisToSuperviewAxis:ALAxisVertical];
    imageaddress.image=[UIImage imageNamed:@"无地址图标"];
    
    UILabel *noaddresslabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 215, kScreenWidth, 14)];
    noaddresslabel.text=@"暂无相关地址~";
    noaddresslabel.textColor=k333333;
    noaddresslabel.font=FOURTEEN;
    noaddresslabel.textAlignment=NSTextAlignmentCenter;
    [noaddressview addSubview:noaddresslabel];
    
    noaddressview.hidden=YES;
    
    UIButton *newAddressbtn=[UIButton newAutoLayoutView];
    [self.view addSubview:newAddressbtn];
    [newAddressbtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 39)];
    [newAddressbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [newAddressbtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    newAddressbtn.backgroundColor=k000000;
    [newAddressbtn setTitle:@"+新建地址" forState:0];
    newAddressbtn.titleLabel.font=FIFTEEN;
    [newAddressbtn addTarget:self action:@selector(add_newAddress) forControlEvents:UIControlEventTouchUpInside];
    
    noview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [noview.btnrefresh addTarget:self action:@selector(initData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noview];
    noview.hidden=YES;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellcone];
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    AddressModel *address=[[AddressModel alloc]initWithDictionary:dataArray[indexPath.row] error:nil];
    
    
    cell.username.text=address.consignee;
    
    cell.phonenum.text=address.mobile;
    if ([address.defaultFlag intValue]==1) {
        cell.moren.hidden=NO;
    }else{
        cell.moren.hidden=YES;
    }
    cell.editbtn.tag=indexPath.row+10;
    [cell.editbtn addTarget:self action:@selector(edit_address:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *citydic=[NSString dictionaryWithJsonString:address.jsonAddress];
    if (citydic) {
        NSString *cityStr=[NSString stringWithFormat:@"%@%@%@",citydic[@"c"],citydic[@"d"],citydic[@"p"]];
        cell.useraddress.text=[NSString stringWithFormat:@"%@%@",cityStr,address.fullAddress];
    }

    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

#pragma mark 进入编辑地址
-(void)edit_address:(UIButton *)sender{
    AddressModel *address=[[AddressModel alloc]initWithDictionary:dataArray[sender.tag-10] error:nil];
    EditAddressViewController *editv=[EditAddressViewController new];
    editv.titelabel=@"编辑地址";
    editv.addressid=address.pkId;
    [self.navigationController pushViewController:editv animated:YES];
}

#pragma mark 新建地址
-(void)add_newAddress{
    EditAddressViewController *editv=[EditAddressViewController new];
    editv.titelabel=@"新建地址";
    editv.addressid=@"";
    [self.navigationController pushViewController:editv animated:YES];
}






-(nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *action1=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault image:[UIImage imageNamed:@"delete"] handler:^(UITableViewRowAction * _Nullable action, NSIndexPath * _Nullable indexPath) {
        
        
        AddressModel *address=[[AddressModel alloc]initWithDictionary:dataArray[indexPath.row] error:nil];
        addressId=address.pkId;
        
        PopWindowView *pop=[[PopWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) mainTitle:@"提示" subTitle:@"确定要删除此收货地址吗？" leftBtn:@"取消" rightBtn:@"确定"];
        [pop.leftBtn addTarget:self action:@selector(dismiss_alert) forControlEvents:UIControlEventTouchUpInside];
        [pop.rightBtn addTarget:self action:@selector(dismiss_remove) forControlEvents:UIControlEventTouchUpInside];
        jcView=nil;
        jcView=[[JCAlertView alloc]initWithCustomView:pop dismissWhenTouchedBackground:NO];
        [jcView show];
        
    }];
    
    action1.title=@"        ";
    
    action1.backgroundColor =kDABF66;
    
    
    
    return @[action1];
}



-(void)dismiss_alert{
    [jcView dismissWithCompletion:^{
        jcView=nil;
        [tv reloadData];
    }];
}

#pragma mark 删除收货地址
-(void)dismiss_remove{
    [jcView dismissWithCompletion:^{
        jcView=nil;
        [self showNHUD];
        NSDictionary *dic_delete=@{@"addressId":addressId};
        
        [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kRemoveAddress] parameters:dic_delete success:^(NSURLSessionDataTask *task, id responseObject) {
            [self NhideHUD:YES];
            if ([responseObject[@"code"] intValue]==200) {
                [self initData];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
            [self NhideHUD:YES];
        }];
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
