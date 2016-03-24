//
//  ZHUceViewController.m
//  Code_
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 东. All rights reserved.
//

#import "ZHUceViewController.h"
#import "YueduViewController.h"
#import "WanshanXinxiViewController.h"
#import "LingpaiYuWangluoQingqiu.h"
#import "NSString+hash.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"
#import <YTKKeyValueStore.h>
#import "ChangePasswordController.h"



@interface ZHUceViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton *tongyiButton;//同意协议的按钮
@property (nonatomic,copy)NSString *LoginName;//注册名
@property (nonatomic,copy)NSString *Password;//密码
@property (nonatomic,copy)NSString *Password1;//确认的密码
@property (nonatomic,assign)NSInteger textFieldTag;
@property (nonatomic,strong)UIView *jianpaView;//设置键盘消失View

@property (nonatomic,retain)ChangePasswordController *change;
@end

@implementation ZHUceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"注册";
    //_textFieldTag = 0;
    
    [self setTheTextField];
    
    self.change = [[ChangePasswordController alloc]init];
    //代理
    //self.change.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)setNumber:(NSString *)str{
    str = self.LoginName;
}
- (void)setPassWord:(NSString *)str{
    str = self.Password;
}


-(void)setTheTextField{
    
    //    _textField1.font = [UIFont systemFontOfSize:14*a];
    //    _textField2.font = [UIFont systemFontOfSize:14*a];
    //    _textField3.font = [UIFont systemFontOfSize:14*a];
    //    _textField4.font = [UIFont systemFontOfSize:11*a];
    
    NSArray *arr = @[@"手机号码",@"输入密码",@"确认密码"];
    NSArray *arr1 = @[@"登陆账号图标.png",@"登录密码图标.png",@"登录密码图标.png"];
    for (int i = 1; i < 4;i++) {
        
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake1(10, 40*i, 300, 1)];
        //im.backgroundColor = [UIColor colorWithRed:252/250.0 green:253/250.0 blue:252/250.0 alpha:1];
        im.backgroundColor = [UIColor grayColor];
        
        [_neirongView addSubview:im];
        
        
        UITextField *textFielf = [[UITextField alloc]initWithFrame:CGRectMake1(50, -35+i*41, 240, 30)];
        textFielf.delegate = self;
        textFielf.placeholder = arr[i-1];
        textFielf.tag = i;
        textFielf.font = [UIFont systemFontOfSize:12*self.bili];
        if (i!=1) {
            //设置密文输入
            textFielf.secureTextEntry = YES;
        }
        textFielf.borderStyle = UITextBorderStyleNone;
        textFielf.font = [UIFont systemFontOfSize:14*self.bili];
        [_neirongView addSubview:textFielf];
        
        UIImageView *viv = [[UIImageView alloc]initWithFrame:CGRectMake1(30, -28+i*41, 13, 16)];
        viv.image = [UIImage imageNamed:arr1[i-1]];
        [_neirongView addSubview:viv];
    }
    //设置验证码输入框
//    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake1(30, 153, 120, 30)];
//    textField1.placeholder = @" 输入验证码";
//    textField1.delegate = self;
//    textField1.font = [UIFont systemFontOfSize:13*self.bili];
//    
//    textField1.borderStyle = UITextBorderStyleRoundedRect;
//    //textField1.background = [UIImage imageNamed:@"输入.png"];
//    textField1.backgroundColor = [UIColor colorWithRed:230/250.0 green:229/250.0 blue:230/250.0 alpha:1];
//    
//    [_neirongView addSubview:textField1];
    //设置获取验证码按钮
//    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake1(170, 153, 120, 30)];
//    [bu setTitle:@"获取短信校验" forState:UIControlStateNormal];
//    [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [bu setBackgroundColor:[UIColor colorWithRed:246/250.0 green:123/250.0 blue:3/250.0 alpha:1]];
//    bu.titleLabel.font = [UIFont systemFontOfSize:12*self.bili];
//    bu.layer.cornerRadius = 6*self.bili;
//    [_neirongView addSubview:bu];
//    bu.titleLabel.font = [UIFont systemFontOfSize:16*self.bili];
    
    //设置同意条款栏
//    _tongyiButton = [[UIButton alloc]initWithFrame:CGRectMake1(66, 202, 23, 23)];
    _tongyiButton = [[UIButton alloc]initWithFrame:CGRectMake1(66, 153, 23, 23)];
    _tongyiButton.selected = NO;
    _tongyiButton.layer.cornerRadius = 23*self.bili/2;
    [_tongyiButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    [_tongyiButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
    [_tongyiButton addTarget:self action:@selector(tongyiButton:) forControlEvents:UIControlEventTouchDown];
    
    
    [_neirongView addSubview:_tongyiButton];
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(98, 206, 98, 15)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(98, 157, 98, 15)];
    //label.text = @"同意      和";
    label.text = @"同意服务条款和";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14*self.bili];
    [_neirongView addSubview:label];
    NSArray *arr2 = @[@"服务条款",@"隐私政策"];
    for (int i = 0; i<2;i++ ) {
//        UIButton *bu2 = [[UIButton alloc]initWithFrame:CGRectMake1(125+i*71, 206, 58, 15)];
        UIButton *bu2 = [[UIButton alloc]initWithFrame:CGRectMake1(125+i*71, 157, 58, 15)];
        [bu2 setTitle:arr2[i] forState:UIControlStateNormal];
        [bu2 setTitleColor:[UIColor colorWithRed:46/250.0 green:174/250.0 blue:228/250.0 alpha:1] forState:UIControlStateNormal];
        bu2.titleLabel.font = [UIFont systemFontOfSize:14*self.bili];
        [bu2 addTarget: self action:@selector(chakanTiaokuan:) forControlEvents:UIControlEventTouchUpInside];
        bu2.tag = (i+1) *111;
        [_neirongView addSubview:bu2];
        
//        UIImageView *iim = [[UIImageView alloc]initWithFrame:CGRectMake1(125+i*72, 221, 58, 1)];
        UIImageView *iim = [[UIImageView alloc]initWithFrame:CGRectMake1(125+i*72, 172, 58, 1)];
        iim.backgroundColor = [UIColor colorWithRed:46/250.0 green:174/250.0 blue:228/250.0 alpha:1];
        [_neirongView addSubview:iim];
    }
    //设置注册按钮
    UIButton *zhuceButton = [[UIButton alloc]initWithFrame:CGRectMake1(20, 240, 280, 38)];
    [zhuceButton setTitle:@"注 册" forState:UIControlStateNormal];
    [zhuceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhuceButton setBackgroundColor:[UIColor colorWithRed:46/250.0 green:174/250.0 blue:228/250.0 alpha:1]];

    [zhuceButton addTarget:self action:@selector(zhuceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    zhuceButton.layer.cornerRadius = 6*self.bili;
    [_neirongView addSubview:zhuceButton];
}
#pragma mark - 设置同意按钮点击事件
-(void)tongyiButton:(UIButton *)button{
    button.selected = !button.isSelected;
    
}


#pragma mark - 设置隐私点击事件
-(void)chakanTiaokuan:(UIButton *)button{
    YueduViewController *yuedu = [[YueduViewController alloc]init];
    
    [self presentViewController:yuedu animated:YES completion:nil];
    
}

// 输入框将要输入内容回调方法(参数为textField本身，返回参数决定textField能否编辑)
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    _jianpaView = [UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, ScreenHight-64-);
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
    
    if (textField.tag == 1) {
        _LoginName = textField.text;
        //self.change.NumberStr = _LoginName;
        NSLog(@"--账号%@",_LoginName);
    }else if(textField.tag == 2) {
        _Password = textField.text;
    }else if(textField.tag == 3){
        _Password1 = textField.text;
        if (![_Password isEqualToString:_Password1]) {
            
        }
    }
    
    return YES;
}
//回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //回收键盘
    [self.view endEditing:YES];
    NSLog(@"回收键盘");
}













#pragma mark - 设置注册按钮点击事件
-(void)zhuceButtonClick:(UIButton *)button{
    [self.view endEditing:YES];
    
    NSString * ss = [_LoginName substringToIndex:1];
    NSLog(@"%lu",(unsigned long)_LoginName.length);
    NSLog(@"---1--%@",ss);
    
    BOOL o = [self isPureNumandCharacters:_LoginName];
    if (o == YES) {
        NSLog(@"全是数");
    }else{
        NSLog(@"不全是数字");
    }
    
    //判断注册的信息填写情况
    if (_LoginName !=nil&&_LoginName.length == 11&&[ss isEqualToString:@"1"]&&o == YES) {
        NSLog(@"账号设置没有问题");
        if([_Password isEqualToString:_Password1]&&_Password.length>0){
            NSLog(@"密码设置没有问题");
            if (_tongyiButton.isSelected) {
                // 增加蒙板
                [MBProgressHUD showMessage:@"请稍后"];
                
                [self exist];
            }else{
                NSLog(@"没有勾选同意协议的按钮");
                [MBProgressHUD showError:@"协议没有同意"];
            }
        }else{
            NSLog(@"密码设置有问题");
            [MBProgressHUD showError:@"密码设置不正确,请重新设置"];
        }
    }else{
        [MBProgressHUD showError:@"账号设置不正确,请重新输入手机号码"];
    }
}

- (void)exist{
    
    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"Exist" forKey:@"action"];//验证
    [dict setObject:_LoginName forKey:@"LoginName"];//账号
    [dict setValue:self.lingpai forKey:@"AccessToken"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              NSInteger nu = [dic[@"IsError"] integerValue];
              NSString *Msg=dic[@"Msg"];
              
              NSInteger Result=[dic[@"Result"]integerValue];
              
              [MBProgressHUD hideHUD];
              
              NSLog(@"是否存在%ld",Result);
              NSLog(@"是否有异常%ld",(long)nu);
         
              
              
              
              if (nu == 1) {
                  NSLog(@"获取验证数据不成功，返回的消息是%@----",Msg);
                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务异常" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                  [alert show];
              }else{
                  NSLog(@"验证状态无异常");
                  
                  if (Result ==0) {
                      [self wangluo];
                      NSLog(@"可以注册。不存在");
                      
                  }else{
                      NSLog(@"不可以注册。存在");
                      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该账号已注册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                      [alert show];
                  }
                  
              }
              
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"验证请求发送不成功，错误信息%@",error);
              //请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              
          }];
}

#pragma mark - 把账号信息传上服务器
-(void)wangluo{
    
        //注册成功跳到完善信息页面
        WanshanXinxiViewController *wanshan = [[WanshanXinxiViewController alloc]init];
        wanshan.LoginName=_LoginName;
        wanshan.Passwords=_Password;
        [self.navigationController pushViewController:wanshan animated:YES];

    
    
}





-(void)fanhuiButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


//使用NSString的trimming方法判断是否是数字
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
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
