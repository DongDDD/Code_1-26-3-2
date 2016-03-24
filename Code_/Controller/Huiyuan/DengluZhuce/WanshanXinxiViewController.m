//
//  WanshanXinxiViewController.m
//  Code_
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 东. All rights reserved.
//
#import "NSString+hash.h"
#import "WanshanXinxiViewController.h"
//#import "MemberViewController.h"
#import "LoginViewController.h"
#import "MyViewController.h"
#import "MBProgressHUD+MJ.h"
#import <YTKKeyValueStore.h>
#import <AFNetworking.h>
@interface WanshanXinxiViewController ()<UITextFieldDelegate>
@property (nonatomic,assign)NSInteger textFieldTag;
@property(nonatomic,strong)NSMutableDictionary *dataDict;//存放输入信息的字典
//@property(nonatomic,copy)NSString *


@end

@implementation WanshanXinxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"完善信息";
    
    [self setTheView];
    
    if (_dict) {
        _dataDict = [NSMutableDictionary dictionaryWithDictionary:_dict];
    }else{
        _dataDict = [NSMutableDictionary dictionary];
    }
    _textFieldTag = 0;
    [_dataDict setObject:@"0" forKey:@"Sex"];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheView{
    
    NSArray *arr = @[@"昵 称",@"性 别",@"地 址",@"手机号",@"男",@"女"];
    
    for (int i = 0;i<arr.count ; i++) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = arr[i];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14*self.bili];
        if (i>3) {
            label.frame = CGRectMake1(115+60*(i-4), 60, 20, 30);
            
            self.but = [[UIButton alloc]initWithFrame:CGRectMake1(90+(i-4)*60, 65, 20, 20)];
            if (i == 4) {
                self.but.selected = YES;
            }else{
                self.but.selected = NO;
            }
            
            self.but.tag = i+1;
            [self.but setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
            [self.but setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
            [self.but addTarget:self action:@selector(nanOrnvButton:) forControlEvents:UIControlEventTouchDown];
            [_neirongView addSubview:self.but];
            
        }else{
            label.frame =CGRectMake1(20, 10+i*50, 50, 30);
        }
        [_neirongView addSubview:label];
        if (i<4 &&i!= 1) {
            UITextField *textFielf = [[UITextField alloc]initWithFrame:CGRectMake1(70, 10+i*50, 230, 30)];
            textFielf.delegate = self;
            textFielf.tag = i+1;
            //textFielf.font = [UIFont systemFontOfSize:12*self.bili];
            textFielf.borderStyle = UITextBorderStyleRoundedRect;
            textFielf.font = [UIFont systemFontOfSize:14*self.bili];
            [_neirongView addSubview:textFielf];
            
        }
    }
    
    
    //设置完成按钮
    UIButton *wanchengButton = [[UIButton alloc]initWithFrame:CGRectMake1(20, 240, 280, 38)];
    [wanchengButton setTitle:@"完 成" forState:UIControlStateNormal];
    [wanchengButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [wanchengButton setBackgroundColor:[UIColor colorWithRed:46/250.0 green:174/250.0 blue:228/250.0 alpha:1]];
    wanchengButton.titleLabel.font = [UIFont systemFontOfSize:16*self.bili];
    [wanchengButton addTarget:self action:@selector(wanchengButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    wanchengButton.layer.cornerRadius = 6*self.bili;
    [_neirongView addSubview:wanchengButton];
    
}


-(void)nanOrnvButton:(UIButton *)button{
    
    button.selected = !button.isSelected;
    if (button.tag == 5 ) {
        UIButton *bu = (UIButton *)[[self.view viewWithTag:10010]viewWithTag:6];
        bu.selected = !bu.isSelected;
        [_dataDict setObject:@"0" forKey:@"Sex"];
    }else{
        UIButton *bu = (UIButton *)[[self.view viewWithTag:10010]viewWithTag:5];
        bu.selected = !bu.isSelected;
        [_dataDict setObject:@"1" forKey:@"Sex"];
        
    }
    
}

#pragma mark - 设置键盘输入
// 输入框将要输入内容回调方法(参数为textField本身，返回参数决定textField能否编辑)
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //默认为YES，设置为NO时，textField不能被编辑
    if (_textFieldTag != 0) {
        // 取得之前使用的textField
        UITextField *textField1 = (UITextField *)[[self.view viewWithTag:10010]viewWithTag:_textFieldTag ];
        NSLog(@"textField%ld取消第一响应值",(long)_textFieldTag);
        // 取消第一响应值
        [textField1 resignFirstResponder];
    }
    _textFieldTag = textField.tag;
    
    return YES;
}
// 限制账号输入位数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag == 1){
        // 创建可变字符串，获取textField的当前内容
        NSMutableString *mString = [[NSMutableString alloc]initWithString:textField.text];
        // 在可变字符串的最后加入新增字符串
        // Range为将要改变（输入或删除）字符的位置和长度
        [mString insertString:string atIndex:range.location];
        // 限制输入11个
        if (mString.length > 30) {
            return NO;
        }else{
            return YES;
        }
        
    }else{
        return YES;
    }
}

// 输入框将要结束编辑的时候调用的方法
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    // 默认YES为允许结束编辑，NO时不能结束编辑,不能结束编辑意味着键盘无法回收
    
    if (textField.tag == 1) {
        [_dataDict setObject:textField.text forKey:@"NickName"];
        NSLog(@"--昵称%@",textField.text);
    }else if(textField.tag == 3) {
        [_dataDict setObject:textField.text forKey:@"Address"];
        NSLog(@"--地址%@",textField.text);
    }else if(textField.tag == 4){
        [_dataDict setObject:textField.text forKey:@""];
        NSLog(@"--手机号%@",textField.text);
    }
    
    return YES;
}
//回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //回收键盘
    [self.view endEditing:YES];
    NSLog(@"回收键盘");
}





#pragma mark - 完成按钮点击事件
-(void)wanchengButtonClick:(UIButton *)button{
    
    //检查有没有必须填的没有填写的
    
    //    if(){
    //
    //    }
    // 增加蒙板
    [MBProgressHUD showMessage:@"请稍后"];
    
    [self wangluo];
}

#pragma mark - 把账号信息传上服务器
-(void)wangluo{
   
    
    //密码MD5加密
    NSString *mima = self.Passwords;
    mima = [mima md5String];
    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"Reg" forKey:@"action"];//注册
    [dict setObject:_LoginName forKey:@"LoginName"];//账号
    [dict setObject:mima forKey:@"Password"];//密码
    [dict setObject:_dataDict[@"NickName"] forKey:@"NickName"];//昵称
    [dict setObject:@" " forKey:@"Email"];//邮箱
    [dict setObject:@"2015-12-13" forKey:@"BirthDay"];//生日
    [dict setObject:_dataDict[@"Sex"] forKey:@"Sex"];//性别，0男，1女
    [dict setObject:@"0" forKey:@"MembType"];//会员：0；房东，1
    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    NSLog(@"请求的参数是:%@",dict);
    
    //发送POST请求使用
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // 请求成功的时候调用这个block
              
              // 隐藏蒙板
              [MBProgressHUD hideHUD];
              
              NSLog(@"请求成功---%@", responseObject);
              //_data = responseObject;
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              NSLog(@"--------------dic:%@",dic);
              NSString *str = dic[@"Msg"];
              NSLog(@"llllllMsg = %@",str);
              
              //判断注册结果
              BOOL ax = dic[@"IsError"];
              if (ax == YES) {
                  NSLog(@"yes");
                  NSLog(@"注册成功");
                  YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
                  NSString *tableName = @"user_table";
                  // 创建名为user_table的表，如果已存在，则忽略该操作
                  [store createTableWithName:tableName];
                  
                  // 保存账号信息到本地
                  NSString *key = @"user";
                  NSDictionary *userDict = @{@"denglu": @"yes",@"LoginName":_LoginName,@"Password":self.Passwords};
                  [store putObject:userDict withId:key intoTable:tableName];
                  
                  [self dengluP];
                  
              }else{
                  NSLog(@"no");
                  NSLog(@"注册失败，失败原因%@",str);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"注册请求发送不成功，错误信息%@",error);
              //请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              
          }];
    
}


//#pragma mark - 把账号信息传上服务器
//-(void)wangluo1{
//    
//    NSLog(@"lingpai:%@",self.lingpai);
//    //密码MD5加密
//    NSString *mima = self.Passwords;
//    mima = [mima md5String];
//    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:@"PrefectData" forKey:@"action"];//接口方法:完善信息
//    [dict setObject:self.LoginName forKey:@"LoginName"];//账号
//    [dict setObject:mima forKey:@"Password"];//密码
//    [dict setObject:_dataDict[@"NickName"] forKey:@"NickName"];//昵称
//    [dict setObject:@"1209222465@qq.com" forKey:@"Email"];//邮箱
//    [dict setObject:@"2015-12-13" forKey:@"BirthDay"];//生日
//    [dict setObject:@"0" forKey:@"Sex"];//性别，0男，1女
//    [dict setObject:@"0" forKey:@"MembType"];//会员：0；房东，1
//    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
//    NSLog(@"请求的参数是:%@",_dataDict);
//    
//    //发送POST请求使用
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:url parameters:dict
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              // 请求成功的时候调用这个block
//              
//              // 隐藏蒙板
//              [MBProgressHUD hideHUD];
//              
//              NSLog(@"请求成功---%@", responseObject);
//              //_data = responseObject;
//              
//              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//              
//              NSLog(@"--------------dic:%@",dic);
//              NSString *str = dic[@"Msg"];
//              NSLog(@"Msg = %@",str);
//              
//              //判断注册结果
//              BOOL ax = dic[@"IsError"];
//              if (ax == YES) {
//                  NSLog(@"yes");
//                  NSLog(@"完善信息成功");
//                  YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
//                  NSString *tableName = @"user_table";
//                  // 创建名为user_table的表，如果已存在，则忽略该操作
//                  [store createTableWithName:tableName];
//                  
//                  NSString *LoginName = _dataDict[@"LoginName"];
//                  NSString *Password = _dataDict[@"Password"];
//                  // 保存账号信息到本地
//                  NSString *key = @"user";
//                  NSDictionary *userDict = @{@"denglu": @"yes",@"LoginName":LoginName,@"Password":Password};
//                  [store putObject:userDict withId:key intoTable:tableName];
//                  
////               －－－－－－－－－－－－－－－－－－－
//                  
//                  [self dengluP];
////－－－－－－－－－－－－－－－－－
//                  
//              }else{
//                  NSLog(@"no");
//                  NSLog(@"完善信息失败，失败原因%@",str);
//              }
//          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              NSLog(@"完善信息请求发送不成功，错误信息%@",error);
//              //请求失败的时候调用调用这个block
//              NSLog(@"请求失败");
//              
//          }];
//    
//    
//    
//}



- (void)dengluP
{
    //获取密码MD5加密
    NSString *ss = self.Passwords;
    //NSString *ss = @"123456";
    ss = [ss md5String];
    
    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"Login" forKey:@"action"];//接口方式:登陆
    [dict setObject:self.LoginName forKey:@"LoginName"];//账号
    //   [dict setObject:@"apptest" forKey:@"LoginName"];//账号
    [dict setObject:ss forKey:@"Password"];//密码
    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    
    NSLog(@"请求的参数是:%@",dict);
    // 增加蒙板
    [MBProgressHUD showMessage:@"登录中"];
    
    //发送POST请求使用
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // 请求成功的时候调用这个block
              
              NSLog(@"登陆请求成功---%@", responseObject);
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
              NSLog(@"得到的数据转成字典是---dic:%@",dic);
              
              NSString *MsgStr = dic[@"Msg"];
              // NSInteger nu = [dic[@"IsError"] integerValue];
              int nu1 = [dict[@"IsError"] intValue];
              
              if (nu1 == 0) {
                  NSLog(@"无异常");
              }else{
                  NSLog(@"nu:%d,异常信息:%@",nu1,MsgStr);
              }
              
              int aa = [dic[@"Result"][@"State"] intValue];
              if (aa == 0) {
                  NSLog(@"登陆失败,异常信息是%@",MsgStr);
              }else{
                  NSLog(@"发送请求结果无异常");
                  BOOL chenggongOrShibai = dic[@"Result"][@"State"];
                  NSInteger trueOrFalse = [dic[@"Result"][@"State"] integerValue];
                  NSLog(@"trueOrFalse :%lu",trueOrFalse);
                  NSLog(@"%d",chenggongOrShibai);
                  if (chenggongOrShibai == YES) {
                      NSLog(@"登陆成功");
                      YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
                      NSString *tableName = @"user_table";
                      // 创建名为user_table的表，如果已存在，则忽略该操作
                      [store createTableWithName:tableName];
                      NSLog(@"会员ID：%@",dic[@"Result"][@"MembId"]);
                      // 保存账号信息到本地
                      NSString *key = @"user";
                      NSDictionary *userDict = @{@"denglu": @"yes",@"LoginName":self.LoginName,@"Password":ss,@"MembId":dic[@"Result"][@"MembId"]};
                      [store putObject:userDict withId:key intoTable:tableName];
                      NSLog(@"userDict:%@",userDict);
                      
                      
                      NSString *sss = dic[@"Msg"];
                      NSLog(@"Msg:%@",sss);
                      
                      LoginViewController *login = [[LoginViewController alloc]init];
                      [self.navigationController pushViewController:login animated:YES];
                      
                  }else{
                      NSLog(@"登陆不成功，返回的消息是%@",MsgStr);
                      [MBProgressHUD showError:MsgStr];
                  }
                  
              }
              
              // 隐藏蒙板
              [MBProgressHUD hideHUD];
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"000%@",error);
              //请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              // 隐藏蒙板
              [MBProgressHUD hideHUD];
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
