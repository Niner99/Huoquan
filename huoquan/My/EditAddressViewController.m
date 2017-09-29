//
//  EditAddressViewController.m
//  huoquan
//
//  Created by 家瓷网 on 2017/8/14.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "EditAddressViewController.h"
#import "EditAddressTableViewCell.h"
#import "AddressChooseView.h"
#import "AddressModel.h"
@interface EditAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChooseAreaDelegate>
{
    UITableView *tv;
    UIButton *keepbtn;
    UIButton *selectbtn;
    NSInteger texttag;
    AddressChooseView *chooseView;
}
@end

@implementation EditAddressViewController
static NSString *cellone=@"cellone";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleWithTitle:_titelabel color:k000000 fontSize:kTitleFloat];
    [self creatUI];
    // 通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)creatUI{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.showsVerticalScrollIndicator=NO;
    [tv registerClass:[EditAddressTableViewCell class] forCellReuseIdentifier:cellone];
    if (@available(iOS 11.0, *)) {
        tv.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:tv];
    
    keepbtn=[UIButton newAutoLayoutView];
    [self.view addSubview:keepbtn];
    [keepbtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [keepbtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [keepbtn autoSetDimensionsToSize:CGSizeMake(345, 38)];
    [keepbtn setTitle:@"保存" forState:0];
    
    keepbtn.titleLabel.font=FIFTEEN;
    [keepbtn addTarget:self action:@selector(keepaddress) forControlEvents:UIControlEventTouchUpInside];
    if (_addressid.length>0) {
        keepbtn.backgroundColor=k000000;
        keepbtn.userInteractionEnabled=YES;
    }else{
        keepbtn.backgroundColor=k888888;
        keepbtn.userInteractionEnabled=NO;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellone];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.titlelabel.text=@"收货人";
        cell.txtlabel.placeholder=@"请输入收货人姓名";
        if (_consignee.length>0) {
            cell.txtlabel.text=_consignee;
        }
        
    }if (indexPath.row==1) {
        cell.titlelabel.text=@"手机号码";
        cell.txtlabel.placeholder=@"请输入11位手机号码";
        if (_phonenum.length>0) {
            cell.txtlabel.text=_phonenum;
        }
        cell.txtlabel.keyboardType=UIKeyboardTypeNumberPad;
    }if (indexPath.row==2) {
        cell.titlelabel.text=@"所在地区";
        cell.txtlabel.hidden=YES;
        cell.addresslabel.hidden=NO;
        if (_provincetxt.length>0) {
            
            cell.addresslabel.textColor=k333333;
            cell.addresslabel.text=[NSString stringWithFormat:@"%@%@%@",_province_name,_city_name,_district_name];;
            
        }else{
            cell.addresslabel.text=@"省份、城市、区县";
            cell.addresslabel.textColor=k888888;
        }
        
    }if (indexPath.row==3) {
        if (_addressdetail.length>0) {
            cell.txtlabel.text=_addressdetail;
        }
        cell.titlelabel.text=@"详细地址";
        cell.txtlabel.placeholder=@"最少三个字，最多40个字";
    }
    cell.txtlabel.tag=indexPath.row+20;
    cell.txtlabel.delegate=self;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    footview.backgroundColor=[UIColor whiteColor];
    
    selectbtn=[[UIButton alloc]initWithFrame:CGRectMake(16,19, 19*WW, 19*WW)];
    
    [selectbtn setImage:[UIImage imageNamed:@"未选"] forState:0];
    
    [selectbtn setImage:[UIImage imageNamed:@"选中黄"] forState:UIControlStateSelected];
    
    
    [selectbtn addTarget:self action:@selector(btn_isdefault:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:selectbtn];
    
    UILabel *moren=[[UILabel alloc]initWithFrame:CGRectMake(50,22, 100, 14)];
    [footview addSubview:moren];
    moren.text=@"设为默认地址";
    moren.font=FOURTEEN;
    moren.textColor=k191919;
    return footview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 54;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        
        UITextField *temptxt=(UITextField *)[self.view viewWithTag:texttag];
        [temptxt resignFirstResponder];
        _provincetxt=@"";
        _provinceID=@"";
        _cityID=@"";
        _districtID=@"";
        chooseView=[[AddressChooseView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth,400)];
        
        chooseView.chooseaddressdelegate=self;
    }
}

-(void)chooseprovince:(AreaModel *)reg choosetwice:(NSInteger)choosetwice{
    _provincetxt=[_provincetxt stringByAppendingString:reg.name];
    NSIndexPath *path=[NSIndexPath indexPathForRow:2 inSection:0];
    EditAddressTableViewCell *cell = (EditAddressTableViewCell *)[tv cellForRowAtIndexPath:path];
    cell.addresslabel.text=[NSString stringWithFormat:@"%@",_provincetxt];
    cell.addresslabel.textColor=k333333;
    
    if (choosetwice==1) {
        _provinceID=reg.pkId;
        _province_name=reg.name;
    }if (choosetwice==2) {
        _cityID=reg.pkId;
        _city_name=reg.name;
    }if (choosetwice==3) {
        _districtID=reg.pkId;
        _district_name=reg.name;
    }
    
}



#pragma mark--通知
-(void)change:(NSNotification *)notification
{
    UITextField *temptxt=(UITextField *)[self.view viewWithTag:21];//手机号
    UITextField *temptxt1=(UITextField *)[self.view viewWithTag:20];//收货人
    UITextField *temptxt3=(UITextField *)[self.view viewWithTag:23];//详细地址

    
    if (temptxt.text.length>11) {
        temptxt.text=[temptxt.text substringToIndex:11];
    }
    if (temptxt1.text.length>20) {
        temptxt1.text=[temptxt1.text substringToIndex:20];
    }
    if (temptxt3.text.length>20) {
        temptxt3.text=[temptxt3.text substringToIndex:20];
    }
    
    if (temptxt1.text.length>0 &&temptxt3.text.length>2 && _provincetxt.length>0 && (temptxt.text.length>0 )) {
        
        keepbtn.userInteractionEnabled=YES;
        keepbtn.backgroundColor=k000000;
        
    }else{
        keepbtn.userInteractionEnabled=NO;
        keepbtn.backgroundColor=k888888;
        
    }
    
}

#pragma mark 保存地址
-(void)keepaddress{
    UITextField *temptxt=(UITextField *)[self.view viewWithTag:21];//手机号
    UITextField *temptxt1=(UITextField *)[self.view viewWithTag:20];//收货人
    UITextField *temptxt3=(UITextField *)[self.view viewWithTag:23];//详细地址
    NSString *defaultStr;
    if (selectbtn.selected) {
        defaultStr=@"1";
    }else{
        defaultStr=@"2";
    }
    
    if (_provinceID.length>0&&_cityID.length>0&&_districtID.length>0){
        
        
        NSDictionary *dic=@{@"p":_province_name,@"c":_city_name,@"d":_district_name};
        
        NSString *jsonAddress=[NSString convertToJsonData:dic];
        
        NSDictionary *dicArea;
        if (_addressid.length>0) {
            //编辑收货地址
            dicArea=@{@"consignee":temptxt1.text,@"provinceId":_provinceID,@"cityId":_cityID,@"districtId":_districtID,@"fullAddress":temptxt3.text,@"mobile":temptxt.text,@"jsonAddress":jsonAddress,@"defaultFlag":defaultStr,@"addressId":_addressid};
            [self showNHUD];
            [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kEditAddress] parameters:dicArea success:^(NSURLSessionDataTask *task, id responseObject) {
                [self NhideHUD:YES];
                if ([responseObject[@"code"] intValue]==200) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
                [self NhideHUD:YES];
            }];
            
            
        }else{
            //新增收货地址
            
            dicArea=@{@"consignee":temptxt1.text,@"provinceId":_provinceID,@"cityId":_cityID,@"districtId":_districtID,@"fullAddress":temptxt3.text,@"mobile":temptxt.text,@"jsonAddress":jsonAddress,@"defaultFlag":defaultStr};
            
            [self showNHUD];
            [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kAdd_Address] parameters:dicArea success:^(NSURLSessionDataTask *task, id responseObject) {
                [self NhideHUD:YES];
                if ([responseObject[@"code"] intValue]==200) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                if ([responseObject[@"code"] intValue]==500) {
                    [self displayNHUDTitle:@"收货地址最多添加10条"];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
                [self NhideHUD:YES];
            }];
            
            
            
        }
    }else{
        [self displayNHUDTitle:@"请选择正确的省市区"];
    }
    
    
    
    
    
    


}




-(void)initData{
    NSDictionary *dicAddress=@{@"addressId":_addressid};
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kSingleAddress] parameters:dicAddress success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]==200) {
            NSDictionary *data=responseObject[@"data"];
            
            AddressModel *address=[[AddressModel alloc]initWithDictionary:data error:nil];
            _consignee=address.consignee;
            _phonenum=address.mobile;
            _addressdetail=address.fullAddress;
            _provincetxt=address.jsonAddress;
            
            NSDictionary *citydic=[NSString dictionaryWithJsonString:address.jsonAddress];
            if (citydic) {
                _province_name=citydic[@"p"];
                _city_name=citydic[@"c"];
                _district_name=citydic[@"d"];
            }
            
            _provinceID=address.provinceId;
            _cityID=address.cityId;
            _districtID=address.districtId;
            
            if ([address.defaultFlag intValue]==1) {
                selectbtn.selected=YES;
            }else{
                 selectbtn.selected=NO;
            }
            [tv reloadData];

        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (_addressid.length>0) {
        [self initData];
    }
}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
    texttag=textField.tag;
}





#pragma mark 是否是默认地址
-(void)btn_isdefault:(UIButton *)sender{
    selectbtn.selected=!selectbtn.selected;
}


- (void)dealloc {
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
