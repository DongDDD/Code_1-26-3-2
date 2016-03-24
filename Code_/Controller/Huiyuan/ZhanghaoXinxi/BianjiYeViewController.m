//
//  BianjiYeViewController.m
//  Code_
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 东. All rights reserved.
//

#import "BianjiYeViewController.h"

//#import "BianjiYeViewController.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+hash.h"
#import "LoginViewController.h"
#import <YTKKeyValueStore.h>
#import "AccountController.h"

@interface BianjiYeViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UIView *neirongView;
@property(nonatomic,assign)NSInteger nanOrNvButtonTag;
@property(nonatomic,assign)NSInteger textFieldTag;

@property (nonatomic,retain)NSMutableDictionary *DataDic;//存放基本信息
@property (nonatomic,retain)NSDictionary *UrlDit;


@end

@implementation BianjiYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTheChangyongZhuke];
    self.DataDic = [NSMutableDictionary dictionary];
    [self.DataDic setObject:@"0" forKey:@"Sex"];
    
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"请输入城市或目的地";
    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-60, 20, 60, 44)];
    [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bu setTitle:@"完成" forState:UIControlStateNormal];
    bu.titleLabel.font = [UIFont systemFontOfSize:14];
    [bu addTarget:self action:@selector(wanchengButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
    
    _neirongView = [[UIView alloc]init ];
    _neirongView.tag = 10010;
    _neirongView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_neirongView];
    
    if (_buttonTag == 1000) {
        self.titleLabel.text = @"编辑常用住客";
        [self setTheChangyongZhuke];
    }else{
        self.titleLabel.text = @"编辑常用地址";
    }
    [self ChangeCodeField];
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"会员界面即将显示");
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    
    // 查询令牌的获取时间与数值
    self.UrlDit = [store getObjectById:key fromTable:tableName];
    
}
- (void)ChangeCodeField{
    self.RealNameText.delegate = self;
    self.IDCardText.delegate = self;
    self.TelText.delegate = self;
    
}


-(void)wanchengButtonClick:(UIButton *)button{
    NSLog(@"点击了完成界面");
    [self.DataDic setObject:self.TelText.text forKey:@"Tel"];
    
     [self TheServer:self.UrlDit];
    
    AccountController *Account = [[AccountController alloc]init];
    [self.navigationController pushViewController:Account animated:YES];
    
}

#pragma mark - 编辑常用住客显示
-(void)setTheChangyongZhuke{
    _neirongView.backgroundColor = [UIColor clearColor];
    _neirongView.frame = CGRectMake(0, 64, ScreenWidth, 400*self.bili);
    NSArray *arr = @[@"基本信息",@"真实名字",@"身  份  证",@"性       别",@"联系方式",@"联系电话"];
    
    self.DataL = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenWidth/375, 0, 100*ScreenWidth/375, 40*ScreenWidth/375)];
    self.DataL.text = arr[0];
    self.DataL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
    self.DataL.backgroundColor = [UIColor clearColor];
    [_neirongView addSubview:self.DataL];
    
    self.RealNameView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40*ScreenWidth/375, ScreenWidth, 40*ScreenWidth/375)];
    self.RealNameView.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.RealNameView];
    self.RealNameL = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenWidth/375, 40*ScreenWidth/375, 100*ScreenWidth/375, 40*ScreenWidth/375)];
    self.RealNameL.text = arr[1];
    self.RealNameL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
    self.RealNameL.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.RealNameL.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.RealNameL];
    self.RealNameText = [[UITextField alloc]initWithFrame:CGRectMake(120*ScreenWidth/375, 40*ScreenWidth/375, ScreenWidth-120*ScreenWidth/375, 40*ScreenWidth/375)];
    self.RealNameText.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.RealNameText];
    
    self.IDCardView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80*ScreenWidth/375, ScreenWidth, 40*ScreenWidth/375)];
    self.IDCardView.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.IDCardView];
    self.IDCardL = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenWidth/375, 80*ScreenWidth/375, 100*ScreenWidth/375, 40*ScreenWidth/375)];
    self.IDCardL.text = arr[2];
    self.IDCardL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
    self.IDCardL.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.IDCardL.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.IDCardL];
    self.IDCardText = [[UITextField alloc]initWithFrame:CGRectMake(120*ScreenWidth/375, 80*ScreenWidth/375, ScreenWidth-120*ScreenWidth/375, 40*ScreenWidth/375)];
    self.IDCardText.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.IDCardText];
    
    self.SexView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120*ScreenWidth/375, ScreenWidth, 40*ScreenWidth/375)];
    self.SexView.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.SexView];
    self.SexL = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenWidth/375, 120*ScreenWidth/375, 100*ScreenWidth/375, 40*ScreenWidth/375)];
    self.SexL.text = arr[3];
    self.SexL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
    self.SexL.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.SexL.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.SexL];
    
    for (int k = 1; k<3; k++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((110+(k-1)*50)*ScreenWidth/375, 120*ScreenWidth/375+15*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
        button.tag = k*111;
        [button addTarget:self action:@selector(xuanzeNannvButtonClick:) forControlEvents:UIControlEventTouchDown];
        [button setBackgroundImage:[UIImage imageNamed:@"男女未选中.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"男女选中.png"] forState:UIControlStateSelected];
        [_neirongView addSubview:button];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((128+(k-1)*50)*ScreenWidth/375, 120*ScreenWidth/375+12*ScreenWidth/375, 20*ScreenWidth/375, 20*ScreenWidth/375)];
        label.font = [UIFont systemFontOfSize:13*ScreenWidth/375];
        [_neirongView addSubview:label];
        if (k ==1) {
            label.text = @"男";
            button.selected = YES;
        }else{
            label.text = @"女";
        }
    }
    
    self.ContatctL = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenWidth/375, 160*ScreenWidth/375, 100*ScreenWidth/375, 40*ScreenWidth/375)];
    self.ContatctL.text = arr[4];
    self.ContatctL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
    self.ContatctL.backgroundColor = [UIColor clearColor];
    [_neirongView addSubview:self.ContatctL];
    
    self.TelView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200*ScreenWidth/375, ScreenWidth, 40*ScreenWidth/375)];
    self.TelView.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.TelView];
    self.TelL = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenWidth/375, 200*ScreenWidth/375, 100*ScreenWidth/375, 40*ScreenWidth/375)];
    self.TelL.text = arr[5];
    self.TelL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
    self.TelL.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.TelL.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.TelL];
    self.TelText = [[UITextField alloc]initWithFrame:CGRectMake(120*ScreenWidth/375, 200*ScreenWidth/375, ScreenWidth-120*ScreenWidth/375, 40*ScreenWidth/375)];
    self.TelText.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:self.TelText];
    
    UIImageView *in1 = [[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 80*ScreenWidth/375, ScreenWidth-20*ScreenWidth/375, 1)];
    in1.backgroundColor = [UIColor colorWithRed:237/250.0 green:242/250.0 blue:242/250.0 alpha:1];
    [_neirongView addSubview:in1];
    UIImageView *in2 = [[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 120*ScreenWidth/375, ScreenWidth-20*ScreenWidth/375, 1)];
    in2.backgroundColor = [UIColor colorWithRed:237/250.0 green:242/250.0 blue:242/250.0 alpha:1];
    [_neirongView addSubview:in2];
    
}

-(void)xuanzeNannvButtonClick:(UIButton *)button{
    NSLog(@"点击了选择男女");
    //编辑选择男女;
    button.selected = !button.isSelected;
    if (button.tag == 111) {
        UIButton *bu = (UIButton *)[[self.view viewWithTag:10010]viewWithTag:222];
        bu.selected = !bu.isSelected;
        [self.DataDic setObject:@0 forKey:@"Sex"];
    }else{
        UIButton *bu = (UIButton *)[[self.view viewWithTag:10010]viewWithTag:111];
        bu.selected = !bu.isSelected;
        [self.DataDic setObject:@1 forKey:@"Sex"];
    }
    
    
}


-(void)yanzhengGet:(UIButton *)button{
    NSLog(@"button.titleLabel:%@",button.titleLabel.text);
    UIButton *bu = (UIButton *)[[self.view viewWithTag:10010]viewWithTag:777];
    [bu setTitle:button.titleLabel.text forState:UIControlStateNormal] ;
    UIView *vi = (UIView *)[[self.view viewWithTag:10010]viewWithTag:10086];
    [vi removeFromSuperview];
    
}

#pragma mark - 设置键盘输入

// 输入框将要结束编辑的时候调用的方法
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == self.RealNameText) {
        [self.DataDic setObject:self.RealNameText.text forKey:@"RealName"];
    }else if (textField == self.IDCardText){
        [self.DataDic setObject:self.IDCardText.text forKey:@"IDCard"];
    }else {
        [self.DataDic setObject:self.TelText.text forKey:@"Tel"];
    }
    return YES;
}

// 输入框将要输入内容回调方法(参数为textField本身，返回参数决定textField能否编辑)
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"textField.tag = %lu 将要编辑,",textField.tag);
    if (_textFieldTag) {
        UITextField *te = (UITextField *)[[self.view viewWithTag:10010]viewWithTag:_textFieldTag];
        // 取消第一响应值
        [te resignFirstResponder];
    }
    
    _textFieldTag = textField.tag;
    //默认为YES，设置为NO时，textField不能被编辑
    return YES;
    
}
// 输入框结束编辑调用的方法，即输入框取消第一响应者的时候
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"编辑结束，输入的是%@",textField.text);
}

// 点击键盘的return调用的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:%@",textField.text);
    // 取消第一响应值
    [textField resignFirstResponder];
    return YES;
}
// 点击屏幕键盘回收
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 方法一 回收键盘
    [self.view endEditing:YES];
    NSLog(@"回收键盘,刚才textField.TAG:是%lu",_textFieldTag);
}

- (void)TheServer:(NSDictionary *)dict1{
    
    NSString *url = @"http://120.25.69.40:1005/API/RoomerData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"Add" forKey:@"action"];//接口方式
    [dict setObject:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    NSMutableDictionary *NewDict = [NSMutableDictionary dictionary];
    [NewDict setObject:dict1[@"MembId"] forKey:@"MembId"];//会员ID
    [NewDict setObject:self.DataDic[@"RealName"] forKey:@"RealName"];
    [NewDict setObject:self.DataDic[@"IDCard"] forKey:@"IDCard"];
    [NewDict setObject:self.DataDic[@"Sex"] forKey:@"Sex"];
    [NewDict setObject:self.DataDic[@"Tel"] forKey:@"Tel"];
    NSString *str = [NSString dictionaryToJson:NewDict];
    [dict setObject:str forKey:@"RM"];
    
    NSLog(@"/////请求参数是：%@",dict);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"写入返回信息dic:%@",dic);
              
              NSString *str = dic[@"Msg"];
              NSLog(@"返回消息Nsg = %@",str);
              //BOOL IsError = dic[@"IsError"];
              NSInteger IsError = [dic[@"IsError"] integerValue];
              BOOL Result = dic[@"Result"];
              if (Result == true) {
                  NSLog(@"提交成功");
              }else{
                  NSLog(@"提交不成功");
              }
              
              if (IsError == 0) {
                  NSLog(@"请求成功");
                  
                  
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"请求失败");
          }];
    
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
