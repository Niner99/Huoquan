//
//  AddressChooseView.m
//  huoquan
//
//  Created by 家瓷网 on 2017/9/6.
//  Copyright © 2017年 jiujiu99. All rights reserved.
//

#import "AddressChooseView.h"

@implementation AddressChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _regionID=@"100000";
        _selectNum=0;
        _dataAry =[[NSMutableArray alloc]init];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        blackView.backgroundColor =[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.5];
        blackView.tag = 440;
        blackView.userInteractionEnabled=YES;
        [window addSubview:blackView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
       [blackView addGestureRecognizer:tap];
        
        
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth,400)];
        shareView.backgroundColor =[UIColor whiteColor];
        shareView.tag = 441;
        shareView.userInteractionEnabled=YES;
        [window addSubview:shareView];
        
        UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shareView.frame.size.width, 50)];
        viewtop.userInteractionEnabled=YES;
        [shareView addSubview:viewtop];
        
        _provincelabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 20, 40, 14)];
        _provincelabel.font=FOURTEEN;
        _provincelabel.textColor=k333333;
        _provincelabel.text=@"省份";
        [viewtop addSubview:_provincelabel];
        
        _citylabel=[[UILabel alloc]initWithFrame:CGRectMake(102, 20, 40, 14)];
        _citylabel.font=FOURTEEN;
        _citylabel.textColor=k888888;
        _citylabel.text=@"城市";
        [viewtop addSubview:_citylabel];
        
        _arealabel=[[UILabel alloc]initWithFrame:CGRectMake(189, 20, 40, 14)];
        _arealabel.font=FOURTEEN;
        _arealabel.textColor=k888888;
        _arealabel.text=@"区县";
        [viewtop addSubview:_arealabel];
        
        UIButton *surebtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-50, 0, 50, 50)];
        [viewtop addSubview:surebtn];
        [surebtn setTitle:@"确定" forState:0];
        [surebtn setTitleColor:kDABF66 forState:0];
        surebtn.titleLabel.font=FOURTEEN;
        [surebtn addTarget:self action:@selector(sureAddressClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        _tv=[[UITableView alloc]initWithFrame:CGRectMake(0,50, kScreenWidth, 400-50) style:UITableViewStylePlain];
        _tv.separatorColor=[UIColor clearColor];
        _tv.delegate=self;
        _tv.dataSource=self;
        [shareView addSubview:_tv];
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"region"];
        
        
        UIView *underline=[[UIView alloc]initWithFrame:CGRectMake(0,50, kScreenWidth-10,0.5)];
        underline.backgroundColor=kCCCCCC;
        [shareView addSubview:underline];
        
        _lineYellow=[[UIView alloc]initWithFrame:CGRectMake(7, 50, 50, 1)];
        _lineYellow.backgroundColor=kDABF66;
        [shareView addSubview:_lineYellow];
        
        blackView.alpha = 0;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //
            shareView.frame=CGRectMake(0,kScreenHeight-400, kScreenWidth,400);
            blackView.alpha = 1;
            [self initData];
        } completion:^(BOOL finished) {
            //
        }];
        
        
    }
    return self;
}

#pragma mark 确定选择地址
-(void)sureAddressClick{
    // [self tapClick];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"region"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    AreaModel *rm=[[AreaModel alloc]initWithDictionary:_dataAry[indexPath.row] error:nil];
    
    cell.textLabel.font=TWELVE;
    cell.textLabel.text=rm.name;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    _parentID=rm.parent_id;
    AreaModel *rm=[[AreaModel alloc]initWithDictionary:_dataAry[indexPath.row] error:nil];
    _regionID=rm.pkId;
    [_chooseaddressdelegate chooseprovince:rm choosetwice:_selectNum];
    
    if (_selectNum<3) {
        
        [self initData];
    }else{
        [self tapClick];
    }
    
}



-(void)initData{
    NSDictionary *dics=@{@"parentId":_regionID};
    
    
    _dataAry =[[NSMutableArray alloc]init];
    [NAFNManager postWithURLString:[NSString stringWithFormat:@"%@%@",kBaseURL,kPronvinceCity] parameters:dics success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]==200) {
            [_dataAry addObjectsFromArray:responseObject[@"data"]];
            [_tv reloadData];
            if (_selectNum==0) {
                _lineYellow.frame=CGRectMake(7, 50, 50, 1);
            }if (_selectNum==1) {
                _lineYellow.frame=CGRectMake(95, 50, 50, 1);
            }if (_selectNum==2) {
                _lineYellow.frame=CGRectMake(180, 50, 50, 1);
            }
            _selectNum++;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSNumber *result) {
        
    }];
}



-(void)tapClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //
        shareView.frame=CGRectMake(0, kScreenHeight, kScreenWidth,400);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        //
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
        
    }];
}
























@end
