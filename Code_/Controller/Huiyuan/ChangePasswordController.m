//
//  ChangePasswordController.m
//  Code_
//
//  Created by admin on 16/3/4.
//  Copyright © 2016年 lansi All rights reserved.
//

#import "ChangePasswordController.h"
#import <AFNetworking.h>
#import "NSString+Hash.h"
#import "MBProgressHUD+MJ.h"
#import "DengluViewController.h"


@interface ChangePasswordController ()<UITextFieldDelegate>

@property (nonatomic,copy)NSString *OldStr;
@property (nonatomic,copy)NSString *NewStr;
@property (nonatomic,copy)NSString *ConfirmStr;
@property (nonatomic,copy)NSString *CodeStr;
@property (nonatomic,assign)NSInteger textFieldTag;

@property (nonatomic,retain)NSString *Number;
@property (nonatomic,retain)NSString *PassWord;
@end

@implementation ChangePasswordController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"修改密码";
    [self SetAllView];
    [self ChangeCodeField];

    
    
    
   
    
}



#pragma mark - 初始化视图
- (void)SetAllView{
    self.OldView = [[UIImageView alloc]initWithFrame:CGRectMake1(30,80,13,16)];
    self.OldView.image = [UIImage imageNamed:@"登录密码图标.png"];
    self.OldView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/225.0 alpha:1];
    [self.view addSubview:self.OldView];
    self.NewView = [[UIImageView alloc]initWithFrame:CGRectMake1(30,115,13,16)];
    self.NewView.image = [UIImage imageNamed:@"登录密码图标.png"];
    self.NewView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/225.0 alpha:1];
    [self.view addSubview:self.NewView];
    self.ConfirmView = [[UIImageView alloc]initWithFrame:CGRectMake1(30,152,13,16)];
    self.ConfirmView.image = [UIImage imageNamed:@"登录密码图标.png"];
    self.ConfirmView.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/225.0 alpha:1];
    [self.view addSubview:self.ConfirmView];
    
    self.OldPasswordField = [[UITextField alloc]initWithFrame:CGRectMake1(50, 75, 240, 30)];
    self.OldPasswordField.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/225.0 alpha:1];
    self.OldPasswordField.placeholder = @"旧密码";
    [self.view addSubview:self.OldPasswordField];
    self.NewPasswordField = [[UITextField alloc]initWithFrame:CGRectMake1(50, 110, 240, 30)];
    self.NewPasswordField.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/225.0 alpha:1];
    self.NewPasswordField.placeholder = @"新密码";
    [self.view addSubview:self.NewPasswordField];
    self.ConfirmPasswordField = [[UITextField alloc]initWithFrame:CGRectMake1(50, 145, 240, 30)];
    self.ConfirmPasswordField.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/225.0 alpha:1];
    self.ConfirmPasswordField.placeholder = @"确认新密码";
    [self.view addSubview:self.ConfirmPasswordField];
//    self.CodeUITextField = [[UITextField alloc]initWithFrame:CGRectMake1(30, 196, 120, 30)];
//    self.CodeUITextField.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/225.0 alpha:1];
//    self.CodeUITextField.placeholder = @"获取短信效验码";
//    self.CodeUITextField.layer.cornerRadius = 12;
//    [self.view addSubview:self.CodeUITextField];
    
    self.LineView1 = [[UIImageView alloc]initWithFrame:CGRectMake1(10, 105, 300, 1)];
    self.LineView1.backgroundColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:76/225.0 alpha:1];
    [self.view addSubview:self.LineView1];
    self.LineView2 = [[UIImageView alloc]initWithFrame:CGRectMake1(10, 140, 300, 1)];
    self.LineView2.backgroundColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:76/225.0 alpha:1];
    [self.view addSubview:self.LineView2];
    self.LineView3 = [[UIImageView alloc]initWithFrame:CGRectMake1(10, 175, 300, 1)];
    self.LineView3.backgroundColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:76/225.0 alpha:1];
    [self.view addSubview:self.LineView3];
    
//    self.CodeBut = [[UIButton alloc]init];
//    self.CodeBut.frame = CGRectMake1(170, 196, 120, 30);
//    self.CodeBut.backgroundColor =  [UIColor colorWithRed:246/255.0 green:123/255.0 blue:3/225.0 alpha:1];
//    self.CodeBut.layer.cornerRadius = 12;
//    [self.CodeBut setTitle:@"获取短信效验码" forState:UIControlStateNormal];
//    [self.CodeBut addTarget:self action:@selector(CodeButAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.CodeBut];
    
    self.LoginBut = [[UIButton alloc]init];
    self.LoginBut.frame = CGRectMake1(30, 240, 260, 35);
    self.LoginBut.backgroundColor = [UIColor colorWithRed:46/255.0 green:174/255.0 blue:228/225.0 alpha:1];
    self.LoginBut.layer.cornerRadius = 12;
    [self.LoginBut setTitle:@"确认" forState:UIControlStateNormal];
    [self.LoginBut addTarget:self action:@selector(LoginButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.LoginBut];
  
}
#pragma mark - 设置新密码的输入
- (void)ChangeCodeField{

    self.OldPasswordField.delegate = self;
    self.NewPasswordField.delegate = self;
    self.ConfirmPasswordField.delegate = self;
    //设置做图片的一个显示情景
    self.OldPasswordField.clearButtonMode = UITextFieldViewModeAlways;
    self.NewPasswordField.clearButtonMode = UITextFieldViewModeAlways;
    self.OldPasswordField.secureTextEntry = YES;
    self.NewPasswordField.secureTextEntry = YES;
    self.ConfirmPasswordField.secureTextEntry = YES;
   
}

// 输入框将要输入内容回调方法(参数为textField本身，返回参数决定textField能否编辑)
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //默认为YES，设置为NO时，textField不能被编辑
    if (_textFieldTag != 0) {
        // 取得之前使用的textField
        UITextField *textField1 = (UITextField *)[self.view viewWithTag:_textFieldTag];
        
        NSLog(@"textField%ld取消第一响应值",(long)_textFieldTag);
        // 取消第一响应值
        [textField1 resignFirstResponder];
    }
    _textFieldTag = textField.tag;
    
    return YES;
}

// 输入框将要结束编辑的时候调用的方法
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    // 默认YES为允许结束编辑，NO时不能结束编辑,不能结束编辑意味着键盘无法回收
    if (textField == self.OldPasswordField) {
        
        self.OldStr = self.OldPasswordField.text;
        NSLog(@"%@",self.OldStr);
        }else if( textField == self.NewPasswordField){
           self.NewStr = self.NewPasswordField.text;
           NSLog(@"%@",self.NewStr);
        }else{
             self.ConfirmStr = self.ConfirmPasswordField.text;
             NSLog(@"%@",self.ConfirmStr);
        }
    return YES;
}
//回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    NSLog(@"回收键盘L");
}


- (void)CodeButAction{
    NSLog(@"获取短信验证码");
}

- (void)LoginButAction{
    self.ConfirmStr = self.ConfirmPasswordField.text;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.Number = [user objectForKey:@"LoginName"];
    self.PassWord = [user objectForKey:@"Password"];
    NSLog(@"////////%@",self.Number);
    
    
    if ([self.ConfirmStr isEqualToString:self.NewStr]&&![self.ConfirmStr isEqualToString:@""]&&![self.NewStr isEqualToString:@""]&&[self.OldStr isEqualToString:self.PassWord]) {
        [self GetData];
        
    }else{
        
        [self Prompt:@"密码设置有误，请修改后再登陆"];
    }
    
}

#pragma mark - 提示
-(void)Prompt:(NSString *)str{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.message = str;
    [alertView addButtonWithTitle:@"取消"];
    [alertView show];
}


#pragma mark - 解析数据
-(void)GetData{
    //true：1，false：0
 
    //密码md5加密
    NSString *Md5str = self.ConfirmPasswordField.text;
    Md5str = [Md5str md5String];

    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"EditPass" forKey:@"action"];//接口方式
    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    [dict setObject:self.Number forKey:@"LoginName"];//账号
    [dict setObject:Md5str forKey:@"Password"];//密码

    NSLog(@"请求的参数是:%@",dict);
    [MBProgressHUD showMessage:@"请稍后"];
    
    //发送POST请求使用
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
              NSLog(@"等到的数据转成字典是---dic:%@",dic);
              
              NSString *MsgStr = dic[@"Msg"];
              NSInteger nu = [dic[@"IsError"] integerValue];
              
              if (nu =='1') {
                  NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
              }else{
                  NSLog(@"发送请求结果无异常");

                  NSInteger Result = [dic[@"Result"] integerValue];
                  NSLog(@"Result :%lu",Result);
                  if (Result == YES) {
                      NSString *Msg = dic[@"Msg"];
                      NSLog(@"Msg:%@",Msg);

                      // 隐藏蒙板
                      [MBProgressHUD hideHUD];
                      [MBProgressHUD showSuccess:@"修改成功"];
                      [self dismissViewControllerAnimated:YES completion:nil];
                      
                  }else{
                      // 隐藏蒙板
                      [MBProgressHUD hideHUD];
                      NSLog(@"修改不成功，返回的消息是%@",MsgStr);
                      [MBProgressHUD showError:MsgStr];
                  }
                  
              }
   
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"000%@",error);
              
              //请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              [MBProgressHUD hideHUD];
          }];
    
  
}

-(void)fanhuiButtonClick{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
