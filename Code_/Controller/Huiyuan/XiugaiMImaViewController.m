//
//  XiugaiMImaViewController.m
//  Code_
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 东. All rights reserved.
//

#import "XiugaiMImaViewController.h"
#import <AFNetworking.h>
#import "NSString+Hash.h"
#import "MBProgressHUD+MJ.h"
@interface XiugaiMImaViewController ()<UITextFieldDelegate>

@property (nonatomic,copy)NSString *yuanMimaStr;
@property (nonatomic,copy)NSString *xinMimaStr1;
@property (nonatomic,copy)NSString *xinMimaStr2;
@property (nonatomic,copy)NSString *yanzhengStr;
@property (nonatomic,assign)NSInteger textFieldTag;
@end

@implementation XiugaiMImaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"0000000000000000000000000000000000-1");
    
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"修改密码";
    //设置短信验证
    //[self setTheView1];
    [self changTheFrame1];
   [self setTheTextField1];
    //[self setTheTextField1];
    _textFieldTag = 0 ;
    
    
    // Do any additional setup after loading the view from its nib.
}





//设置新密码的输入
-(void)setTheTextField1{
    
    _textField1.delegate = self;
    _textField2.delegate = self;
        _textField4.delegate = self;
    //float bili = ScreenWidth/320.0;
    // 输入框左边图片
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake1(30,80,13,16)];
    imageView1.image = [UIImage imageNamed:@"登录密码图标.png"];
    [self.view addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake1(30,115,13,16)];
    imageView2.image = [UIImage imageNamed:@"登录密码图标.png"];
    [self.view addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake1(30,152,13,16)];
    imageView3.image = [UIImage imageNamed:@"关于.png"];
    [self.view addSubview:imageView3];
    
    
    //设置做图片的一个显示情景
    //_textField1.leftViewMode = UITextFieldViewModeAlways;
    _textField1.clearButtonMode = UITextFieldViewModeAlways;
    _textField2.clearButtonMode = UITextFieldViewModeAlways;
    
    _textField1.secureTextEntry = YES;
    _textField2.secureTextEntry = YES;
    
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
    
    if (textField.tag == 111) {
        _xinMimaStr1 = _textField1.text;
        NSLog(@"--原密码%@",_yuanMimaStr);
    }else if(textField.tag == 222) {
        _xinMimaStr2 = _textField2.text;
    }
    return YES;
}
//回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //回收键盘
    [self.view endEditing:YES];
    NSLog(@"回收键盘");
}

-(void)setTheTishi:(NSString *)str{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.message = str;
    [alertView addButtonWithTitle:@"取消"];
    [alertView show];
}
#pragma mark - 设置获取验证码按钮点击事件
- (IBAction)huoquYanzhengMaButtonClick:(id)sender {
    NSLog(@"获取短信验证码");
}

#pragma mark - 设置修改密码按钮点击事件
- (IBAction)dengluButtonClick:(id)sender {
    
    if ([_xinMimaStr2 isEqualToString:_xinMimaStr1]&&![_xinMimaStr2 isEqualToString:@""]) {
        [self wangluo];
    }else{
        [self setTheTishi:@"密码设置有误，请修改后再登陆"];
    }
 
}

#pragma mark - 把修改后的密码上传上服务器
-(void)wangluo{
    //密码md5加密
    NSString *Md5str = _textField2.text;
    Md5str = [Md5str md5String];
    
    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"EditPass" forKey:@"action"];//接口方式:登陆
    [dict setObject:@"11111111110" forKey:@"LoginName"];//账号
    [dict setObject:Md5str forKey:@"Password"];//密码
    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    
    NSLog(@"请求的参数是:%@",dict);
    // 增加蒙板
    [MBProgressHUD showMessage:@"请稍后"];
    
    //发送POST请求使用
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // 请求成功的时候调用这个block
              
              NSLog(@"登陆请求成功---%@", responseObject);
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
              NSLog(@"等到的数据转成字典是---dic:%@",dic);
              
              NSString *MsgStr = dic[@"Msg"];
              NSInteger nu = [dic[@"IsError"] integerValue];
              
              if (nu == '1') {
                  NSLog(@"有异常");
              }else{
                  NSLog(@"nu:%lu,异常信息:%@",(long)nu,MsgStr);
              }
              
              if (nu =='1') {
                  NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
              }else{
                  NSLog(@"发送请求结果无异常");
                  BOOL chenggongOrShibai = dic[@"Result"];
                  NSInteger trueOrFalse = [dic[@"Result"] integerValue];
                  NSLog(@"trueOrFalse :%lu",trueOrFalse);
                  NSLog(@"%d",chenggongOrShibai);
                  if (chenggongOrShibai == YES) {
                      NSLog(@"登陆成功");
//                      YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
//                      NSString *tableName = @"user_table";
//                      // 创建名为user_table的表，如果已存在，则忽略该操作
//                      [store createTableWithName:tableName];
//                      
//                      // 保存账号信息到本地
//                      NSString *key = @"user";
//                      NSDictionary *userDict = @{@"denglu": @"yes",@"LoginName":_zhanghaoTextField.text,@"Password":ss};
//                      [store putObject:userDict withId:key intoTable:tableName];
//                      NSLog(@"userDict:%@",userDict);
                      
                      NSString *sss = dic[@"Msg"];
                      NSLog(@"Msg:%@",sss);
                      
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
              // 隐藏蒙板
              [MBProgressHUD hideHUD];
          }];
    
    
    

    
    
}



-(void)changTheFrame1{
    
    self.titleLabel.text = @"修改密码";
    float a = ScreenWidth/320.0;
    NSLog(@"a = %f",a);
    _textField1.frame = CGRectMake1(50, 75, 240, 30);
    _textField2.frame = CGRectMake1(50, 110, 240, 30);
   
    _label3.frame = CGRectMake1(50, 145, 240, 30);
    _textField4.frame = CGRectMake1(30, 196, 120, 30);
    
    _huoquButton.frame = CGRectMake1(170, 196, 120, 30);
    _dengluButton.frame = CGRectMake1(30, 240, 260, 35);
    
    _imageView1.frame = CGRectMake1(10, 105, 300, 1);
    _imageView2.frame = CGRectMake1(10, 140, 300, 1);
    _imageView3.frame = CGRectMake1(10, 175, 300, 1);
    
    _textField1.font = [UIFont systemFontOfSize:14*a];
    _textField2.font = [UIFont systemFontOfSize:14*a];
    _label3.font = [UIFont systemFontOfSize:14*a];
    _textField4.font = [UIFont systemFontOfSize:11*a];
    
    _huoquButton.titleLabel.font = [UIFont systemFontOfSize:11*a];
    _dengluButton.titleLabel.font = [UIFont systemFontOfSize:14*a];
    
    _huoquButton.layer.cornerRadius = 4*a;
    _dengluButton.layer.cornerRadius = 4*a;
//    
//    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake1(0, 75, 320, 30)];
//    vi.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:vi];
//    UIView *vi1 = [[UIView alloc]initWithFrame:CGRectMake1(0, 196, 320, 30)];
//    vi1.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:vi1];

    
    
    
    
}
-(void)fanhuiButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
