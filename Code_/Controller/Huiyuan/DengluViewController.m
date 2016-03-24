//
//  DengluViewController.m
//  登陆
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "OrderlistViewController.h"
#import "DengluViewController.h"
#import "ZHUceViewController.h"
//#import "MemberViewController.h"
#import "LoginViewController.h"
#import "LingpaiYuWangluoQingqiu.h"
#import "NSString+Hash.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"
#import <YTKKeyValueStore.h>
@interface DengluViewController ()<UITextFieldDelegate>

@property(nonatomic,copy)NSString *LoginName;//登陆名

@property(nonatomic,copy)NSString *Password;//登陆密码


@end

@implementation DengluViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self zidingyiDaohanglan];
    
    self.titleLabel.text = @"登陆";
    
    NSString *str = @"aaa";
    
    str = [str md5String];
    
    [self changTheFrame];
    [self setTheTextField];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
//-(void)fanhuiButtonClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


#pragma mark - 设置输入键盘
-(void)setTheTextField{
    
    _zhanghaoTextField.delegate = self;
    _mimaTextField.delegate = self;
    _zhanghaoTextField.clearButtonMode = UITextFieldViewModeAlways;
    _mimaTextField.clearButtonMode = UITextFieldViewModeAlways;
    _mimaTextField.secureTextEntry = YES;
    
}
// 输入框将要输入内容回调方法(参数为textField本身，返回参数决定textField能否编辑)
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //默认为YES，设置为NO时，textField不能被编辑
    if (textField.tag == 111) {
        [_mimaTextField resignFirstResponder];
    }else{
        [_zhanghaoTextField resignFirstResponder];
    }
    return YES;
}
// 限制账号输入位数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == _zhanghaoTextField){
        // 创建可变字符串，获取textField的当前内容
        NSMutableString *mString = [[NSMutableString alloc]initWithString:textField.text];
        // 在可变字符串的最后加入新增字符串
        // Range为将要改变（输入或删除）字符的位置和长度
        [mString insertString:string atIndex:range.location];
        // 限制输入11个
        if (mString.length > 11) {
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
    if (textField.tag ==111) {
        _LoginName = _zhanghaoTextField.text;
        NSLog(@"--账号%@",_LoginName);
    }else{
        _Password = _mimaTextField.text;
        NSLog(@"--密码%@",_Password);
    }

    //保存数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self.LoginName forKey:@"LoginName"];
    [user setObject:self.Password forKey:@"Password"];
    
    

    return YES;
}
//回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 方法一 回收键盘
    [self.view endEditing:YES];
    NSLog(@"回收键盘");
}




#pragma mark - 设置登陆按钮点击方法
- (IBAction)dengluButtonClick:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"账号是:%@\n密码是:%@",_LoginName,_Password);
    
      
    if (_zhanghaoTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        
    }else{
        if (_zhanghaoTextField.text.length!=11) {
            [MBProgressHUD showError:@"请重新输入用户名"];
        }else{
            if (_mimaTextField.text.length == 0) {
                [MBProgressHUD showError:@"请输入密码"];
            }else{
                //获取密码MD5加密
                NSString *ss = _mimaTextField.text;
                //NSString *ss = @"123456";
                ss = [ss md5String];
                
                NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:@"Login" forKey:@"action"];//接口方式:登陆
                [dict setObject:_zhanghaoTextField.text forKey:@"LoginName"];//账号
                //[dict setObject:@"apptest" forKey:@"LoginName"];//账号
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
                                  NSDictionary *userDict = @{@"denglu": @"yes",@"LoginName":_zhanghaoTextField.text,@"Password":ss,@"MembId":dic[@"Result"][@"MembId"]};
                                  [store putObject:userDict withId:key intoTable:tableName];
                                  NSLog(@"userDict:%@",userDict);
                                  
                                  
                                  NSString *sss = dic[@"Msg"];
                                  NSLog(@"Msg:%@",sss);

                                  LoginViewController *login = [[LoginViewController alloc]init];
                                 [self.navigationController pushViewController:login animated:YES];
//                                  MemberViewController *login = [[MemberViewController alloc]init];
//                                  [self.navigationController pushViewController:login animated:YES];
                                  
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
        }
        
 }
    
    
    
    
    
}
#pragma mark -设置注册按钮点击方法
- (IBAction)zhuceButtonClick:(id)sender {
    
    ZHUceViewController *zhuce = [[ZHUceViewController alloc]init];
    
    
    
    [self.navigationController pushViewController:zhuce animated:YES];
    
}
#pragma mark -设置忘记密码点击方法
- (IBAction)wangjiMimaButtonClick:(id)sender {
    
    
}














-(void)changTheFrame{
    float a = ScreenWidth/375.0;
    _zhanghaoImageView.frame = CGRectMake(37*a, 86*a, 15*a, 18*a);
    _zhanghaoTextField.frame = CGRectMake(65*a, 80*a, 215*a, 30*a);
    _zhanghaoxXiahuaxianImageView.frame = CGRectMake(20*a, 110*a, 335*a, 1);
    
    _mimaImageView.frame = CGRectMake(37*a, 136*a, 15*a, 18*a);
    _mimaTextField.frame = CGRectMake(65*a, 130*a, 215*a, 30*a);
//    _mimaXiahuaxianImageView.frame = CGRectMake(20*a, 50*a, 335*a, 1);
    UIView *viexiahuaxian=[[UIView alloc]initWithFrame:CGRectMake(20*a, 160*a, 335*a, 1)];
    viexiahuaxian.backgroundColor=[UIColor colorWithRed:170/250.0 green:170/250.0 blue:170/250.0 alpha:1];
    [self.view addSubview:viexiahuaxian];
    
    _dengluButton.frame = CGRectMake(62*a, 200*a, 251*a, 30*a);
    _zhuceButton.frame = CGRectMake(35*a, 250*a, 30*a, 15*a);
    _wangjiMimaButton.frame = CGRectMake(225*a, 250*a, 70*a, 15*a);
    
    _zhuceImageView.frame = CGRectMake(35*a, 265*a, 30*a, 1);
    _wangjiMimaInageView.frame = CGRectMake(225*a, 265*a, 60*a, 1);
    
    
    _dengluButton.titleLabel.font = [UIFont systemFontOfSize:17*a];
    _wangjiMimaButton.titleLabel.font = [UIFont systemFontOfSize:14*a];
    _zhuceButton.titleLabel.font = [UIFont systemFontOfSize:14*a];
    _zhanghaoTextField.font = [UIFont systemFontOfSize:17*a];
    _mimaTextField.font = [UIFont systemFontOfSize:17*a];
    
    
    
    
    
    _dengluButton.layer.cornerRadius=4*a;
    
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
