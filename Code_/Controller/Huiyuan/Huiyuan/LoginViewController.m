//
//  LoginViewController.m
//  Code_
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 lansi All rights reserved.
//

#import "LoginViewController.h"
#import "GerenZiliaoViewController.h"
#import "HuiyuanViewController.h"
#import "QuanbuDingdanViewController.h"
#import "OderListController.h"
#import "DaijinQuanViewController.h"
#import "WodeFanliViewController.h"
#import "XiaofeiJiluViewController.h"
#import "WodeJifenViewController.h"
#import "ShimingRenzhengViewController.h"
#import "AccountController.h"
#import <AFNetworking.h>
#import <YTKKeyValueStore.h>
#import "GouwucheViewController.h"
#import "MBProgressHUD+MJ.h"
#import "PersonalInformation.h"
#import "ChangePasswordController.h"

@interface LoginViewController ()
@property(nonatomic,strong)UIImageView *im;
@property (nonatomic,strong)NSDictionary *dataDict;
@property (nonatomic,assign)NSInteger tag;
@end

@implementation LoginViewController

- (void)viewWillDisappear:(BOOL)animated{
    //self.view即将在界面上消失
    NSLog(@"view 即将消失");
    if (!_im) {
        [_im removeFromSuperview];
    }
    
}
#pragma mark - 视图即将显示的时候先读取本地信息，判断用户有没有登陆
-(void)viewWillAppear:(BOOL)animated {
    //把工具栏显示出来掉
    self.hidesBottomBarWhenPushed=NO;
    self.tabBarController.tabBar.hidden=NO;

    NSLog(@"会员界面即将显示");
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    
    // 查询令牌的获取时间与数值
    NSDictionary *userDict = [store getObjectById:key fromTable:tableName];
    NSString *denglu = userDict[@"denglu"];
    _dataDict = userDict;
    
    NSLog(@"本地数据是:%@",userDict);

    if ([denglu isEqualToString:@"yes"]) {//已经登录，本地存有信息
        NSLog(@"用户已经登陆--开始下载用户数据");
        //开始下载数据

        self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        
        [self jiazaiShuju:userDict];
        
    }else{//没有登录
        NSLog(@"用户没有登陆，加载会员没有登陆的用户界面");
        UIView *vi = [[UIView alloc]init];
        vi.frame  = CGRectMake(0, 0, ScreenWidth, ScreenHight-50);
        _im = [[UIImageView alloc]init];
        _im.frame = self.view.bounds;
        _im.userInteractionEnabled = YES;
        _im.backgroundColor = [UIColor colorWithRed:242/250.0 green:242/250.0 blue:242/250.0 alpha:1];
        HuiyuanViewController *huiyuan = [[HuiyuanViewController alloc]init];
        huiyuan.view.frame = CGRectMake1(0, 0, 320, 520);
        [self.view addSubview:_im];
        [_im addSubview:huiyuan.view];
        [self addChildViewController:huiyuan];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)jiazaiShuju:(NSDictionary *)dict1{
    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"View" forKey:@"action"];//接口方式:登陆
    [dict setObject:dict1[@"MembId"] forKey:@"MembId"];//会员ID
    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    
    NSLog(@"请求的参数是:%@",dict);

    //发送POST请求使用
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
              NSLog(@"等到的数据转成字典是---dic:%@",dic);
              
              NSString *MsgStr = dic[@"Msg"];
              int nu = [dic[@"IsError"] intValue];
              
              if (nu ==1) {
                  NSLog(@"获取会员信息不成功，返回的消息是%@",MsgStr);
                  
              }else{
                  NSLog(@"-------获取会员信息成功,发送请求结果无异常  解析的数据是%@",dic);
                  
                  NSDictionary *Result = dic[@"Result"];
                  self.person = [[PersonalInformation alloc]init];
                  [self.person setValuesForKeysWithDictionary:Result];
                  NSLog(@"++++%@",self.person.NickName);
                  NSLog(@"++++%ld",self.person.Sex);
                  [self GetView];
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"000%@",error);
              //请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              
          }];
    
}


#pragma mark - 初始化视图
- (void)GetView{
    self.HeadImageView = [[UIImageView alloc]init];
    self.HeadImageView.frame = CGRectMake(0, 0, ScreenWidth, 100*ScreenWidth/375);
    self.HeadImageView.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    [self.view addSubview:self.HeadImageView];
    
    self.HeadBut = [[UIButton alloc]init];
    self.HeadBut.frame = CGRectMake((ScreenWidth-50*ScreenWidth/375)/2, 25*ScreenWidth/375, 50*ScreenWidth/375, 50*ScreenWidth/375);
    self.HeadBut.layer.cornerRadius = 25*ScreenWidth/375;
    [self.HeadBut addTarget:self action:@selector(HeadButAction) forControlEvents:UIControlEventTouchDown];
    [self.HeadBut setBackgroundImage:[UIImage imageNamed:@"分享头像.png"] forState:UIControlStateNormal];
    self.HeadBut.layer.cornerRadius = 25*ScreenWidth/375;
    self.HeadBut.layer.masksToBounds = YES;
    self.HeadBut.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.HeadBut];
    
     self.SignImageView = [[UIImageView alloc]init];
    self.SignImageView.frame = CGRectMake((ScreenWidth-50*ScreenWidth/375)/2, 80*ScreenWidth/375, 10*ScreenWidth/375, 10*ScreenWidth/375);
    if (self.person.Sex == 0) {
        self.SignImageView.image = [UIImage imageNamed:@"女图标.png"];
        
    }else{
        self.SignImageView.image = [UIImage imageNamed:@"男.png"];
    }
    self.SignImageView.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    [self.view addSubview:self.SignImageView];
    
    self.MemberL = [[UILabel alloc]init];
    self.MemberL.frame = CGRectMake((ScreenWidth-50*ScreenWidth/375)/2+20*ScreenWidth/375, 80*ScreenWidth/375, 52*ScreenWidth/375, 10*ScreenWidth/375);
    self.MemberL.text = self.person.NickName;
    self.MemberL.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    self.MemberL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
    self.MemberL.textColor = [UIColor colorWithRed:177/255.0 green:196/255.0 blue:220/255.0 alpha:1];
    self.MemberL.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    [self.view addSubview:self.MemberL];
    
//    self.MYMoneyL = [[UILabel alloc]init];
//    self.MYMoneyL.frame = CGRectMake(17*ScreenWidth/375, 104*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.MYMoneyL.text = @"我的钱包";
//    self.MYMoneyL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
//    self.MYMoneyL.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.view addSubview:self.MYMoneyL];
//    
//    self.SignView = [[UIImageView alloc]init];
//    self.SignView.frame = CGRectMake(8*ScreenWidth/375, 116*ScreenWidth/375, ScreenWidth-16*ScreenWidth/375, 1*ScreenWidth/375);
//    self.SignView.backgroundColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
//    [self.view addSubview:self.SignView];
//    
//    self.MoneyL = [[UILabel alloc]init];
//    self.MoneyL.frame = CGRectMake(17*ScreenWidth/375, 120*ScreenWidth/375, 30*ScreenWidth/375, 10*ScreenWidth/375);
//    self.MoneyL.text = @"现  金:";
//    self.MoneyL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
//    self.MoneyL.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.view addSubview:self.MoneyL];
//    self.MoneyDataL = [[UILabel alloc]init];
//    self.MoneyDataL.frame = CGRectMake(47*ScreenWidth/375, 120*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.MoneyDataL.text = @"￥123456";
//    self.MoneyDataL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
//    self.MoneyDataL.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.view addSubview:self.MoneyDataL];

//    self.GiftL = [[UILabel alloc]init];
//    self.GiftL.frame = CGRectMake(ScreenWidth/3, 120*ScreenWidth/375, 40*ScreenWidth/375, 10*ScreenWidth/375);
//    self.GiftL.text = @"礼品卡:";
//    self.GiftL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
//    self.GiftL.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.view addSubview:self.GiftL];
//    self.GiftDataL = [[UILabel alloc]init];
//    self.GiftDataL.frame = CGRectMake(ScreenWidth/3+40*ScreenWidth/375, 120*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.GiftDataL.text = @"￥123456";
//    self.GiftDataL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
//    self.GiftDataL.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.view addSubview:self.GiftDataL];
//    
//    self.ReturnMoneyL = [[UILabel alloc]init];
//    self.ReturnMoneyL.frame = CGRectMake((ScreenWidth/3)*2, 120*ScreenWidth/375, 30*ScreenWidth/375, 10*ScreenWidth/375);
//    self.ReturnMoneyL.text = @"返  现:";
//    self.ReturnMoneyL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
//    self.ReturnMoneyL.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.view addSubview:self.ReturnMoneyL];
//    self.ReturnMoneyDataL = [[UILabel alloc]init];
//    self.ReturnMoneyDataL.frame = CGRectMake((ScreenWidth/3)*2+40*ScreenWidth/375, 120*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.ReturnMoneyDataL.text = @"￥123456";
//     self.ReturnMoneyDataL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
//    self.ReturnMoneyDataL.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.view addSubview:self.ReturnMoneyDataL];
    
    self.AllOrderBut = [[UIButton alloc]init];
    //self.AllOrderBut.frame = CGRectMake(0, 136*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    self.AllOrderBut.frame = CGRectMake(0, 105*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    [self.AllOrderBut addTarget:self action:@selector(AllOrderButAction) forControlEvents:UIControlEventTouchDown];
    self.AllOrderBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.AllOrderBut];
    self.AllOrderView = [[UIImageView alloc]init];
    self.AllOrderView.frame = CGRectMake((self.AllOrderBut.frame.size.width-17*ScreenWidth/375)/2, 10*ScreenWidth/375, 17*ScreenWidth/375, 17*ScreenWidth/375);
    self.AllOrderView.image = [UIImage imageNamed:@"全部订单图标"];
    self.AllOrderView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.AllOrderBut addSubview:self.AllOrderView];
    self.AllOrderL = [[UILabel alloc]init];
    self.AllOrderL.frame = CGRectMake((self.AllOrderBut.frame.size.width-70*ScreenWidth/375)/2, self.AllOrderBut.frame.size.height-self.AllOrderView.frame.size.height+2*ScreenWidth/375, 70*ScreenWidth/375, 12*ScreenWidth/375);
    self.AllOrderL.text = @"全部订单";
    self.AllOrderL.font = [UIFont systemFontOfSize:14*ScreenWidth/375];
    self.AllOrderL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.AllOrderBut addSubview:self.AllOrderL];
    
    
    self.PayBut = [[UIButton alloc]init];
    //self.PayBut.frame = CGRectMake(ScreenWidth/4, 136*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    self.PayBut.frame = CGRectMake(ScreenWidth/4, 105*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    [self.PayBut addTarget:self action:@selector(PayButAction) forControlEvents:UIControlEventTouchDown];
    self.PayBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.PayBut];
    self.PayView = [[UIImageView alloc]init];
    self.PayView.frame = CGRectMake((self.PayBut.frame.size.width-17*ScreenWidth/375)/2, 10*ScreenWidth/375, 17*ScreenWidth/375, 17*ScreenWidth/375);
    self.PayView.image = [UIImage imageNamed:@"待支付"];
    self.PayView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.PayBut addSubview:self.PayView];
    self.PayL = [[UILabel alloc]init];
    self.PayL.frame = CGRectMake((self.PayBut.frame.size.width-50*ScreenWidth/375)/2, self.PayBut.frame.size.height-self.PayView.frame.size.height+2*ScreenWidth/375, 60*ScreenWidth/375, 12*ScreenWidth/375);
    self.PayL.text = @"待支付";
    self.PayL.font = [UIFont systemFontOfSize:14*ScreenWidth/375];
    self.PayL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.PayBut addSubview:self.PayL];

    
    self.CheckInBut = [[UIButton alloc]init];
    //self.CheckInBut.frame = CGRectMake(ScreenWidth/2, 136*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    self.CheckInBut.frame = CGRectMake(ScreenWidth/2, 105*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    [self.CheckInBut addTarget:self action:@selector(CheckInButAction) forControlEvents:UIControlEventTouchDown];
    self.CheckInBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.CheckInBut];
    self.CheckInView = [[UIImageView alloc]init];
    self.CheckInView.frame = CGRectMake((self.CheckInBut.frame.size.width-17*ScreenWidth/375)/2, 10*ScreenWidth/375, 17*ScreenWidth/375, 17*ScreenWidth/375);
    self.CheckInView.image = [UIImage imageNamed:@"带入住"];
    self.CheckInView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.CheckInBut addSubview:self.CheckInView];
    self.CheckInL = [[UILabel alloc]init];
    self.CheckInL.frame = CGRectMake((self.CheckInBut.frame.size.width-50*ScreenWidth/375)/2, self.CheckInBut.frame.size.height-self.CheckInView.frame.size.height+2*ScreenWidth/375, 60*ScreenWidth/375, 12*ScreenWidth/375);
    self.CheckInL.text = @"待入住";
    self.CheckInL.font = [UIFont systemFontOfSize:14*ScreenWidth/375];
    self.CheckInL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.CheckInBut addSubview:self.CheckInL];
    
    self.AppraiseBut = [[UIButton alloc]init];
    //self.AppraiseBut.frame = CGRectMake((ScreenWidth/4)*3, 136*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    self.AppraiseBut.frame = CGRectMake((ScreenWidth/4)*3, 105*ScreenWidth/375, ScreenWidth/4, 47*ScreenWidth/375);
    [self.AppraiseBut addTarget:self action:@selector(AppraiseButAction) forControlEvents:UIControlEventTouchDown];
    self.AppraiseBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.AppraiseBut];
    self.AppraiseView = [[UIImageView alloc]init];
    self.AppraiseView.frame = CGRectMake((self.AppraiseBut.frame.size.width-17*ScreenWidth/375)/2, 10*ScreenWidth/375, 17*ScreenWidth/375, 17*ScreenWidth/375);
    self.AppraiseView.image = [UIImage imageNamed:@"待评价"];
    self.AppraiseView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.AppraiseBut addSubview:self.AppraiseView];
    self.AppraiseL = [[UILabel alloc]init];
    self.AppraiseL.frame = CGRectMake((self.AppraiseBut.frame.size.width-50*ScreenWidth/375)/2, self.AppraiseBut.frame.size.height-self.AppraiseView.frame.size.height+2*ScreenWidth/375, 60*ScreenWidth/375, 12*ScreenWidth/375);
    self.AppraiseL.text = @"待评价";
     self.AppraiseL.font = [UIFont systemFontOfSize:14*ScreenWidth/375];
    self.AppraiseL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.AppraiseBut addSubview:self.AppraiseL];

    
    self.PasswordBut = [[UIButton alloc]init];
    self.PasswordBut.frame = CGRectMake(0, self.AllOrderBut.frame.size.height+110*ScreenWidth/375, ScreenWidth, 25*ScreenWidth/375);
    [self.PasswordBut addTarget:self action:@selector(PasswordButAction) forControlEvents:UIControlEventTouchDown];
    self.PasswordBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.PasswordBut];
    self.PasswordL = [[UILabel alloc]init];
    self.PasswordL.frame = CGRectMake(21*ScreenWidth/375, 10*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
    self.PasswordL.text = @"修改密码";
    self.PasswordL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
    self.PasswordL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.PasswordBut addSubview:self.PasswordL];
    self.PasswordL2 = [[UILabel alloc]init];
    self.PasswordL2.frame = CGRectMake(ScreenWidth-55*ScreenWidth/375, 10*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
    self.PasswordL2.text = @"修改密码";
    self.PasswordL2.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
    self.PasswordL2.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.PasswordL2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.PasswordBut addSubview:self.PasswordL2];
    self.PasswordView2 = [[UIImageView alloc]init];
    self.PasswordView2.frame = CGRectMake(ScreenWidth-10*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
    self.PasswordView2.image = [UIImage imageNamed:@"箭头.png"];
    self.PasswordView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.PasswordBut addSubview:self.PasswordView2];

    
    
    
    self.AccountsBut = [[UIButton alloc]init];
    self.AccountsBut.frame = CGRectMake(0, 187*ScreenWidth/375, ScreenWidth, 25*ScreenWidth/375);
    [self.AccountsBut addTarget:self action:@selector(AccountsButAction) forControlEvents:UIControlEventTouchDown];
    self.AccountsBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.AccountsBut];
    self.AccountsView = [[UIImageView alloc]init];
    self.AccountsView.frame = CGRectMake(8*ScreenWidth/375, 196*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
    self.AccountsView.image = [UIImage imageNamed:@"账号信息.png"];
    self.AccountsView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.AccountsView];
    self.AccountsL = [[UILabel alloc]init];
    self.AccountsL.frame = CGRectMake(21*ScreenWidth/375, 196*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
    self.AccountsL.text = @"账户信息";
    self.AccountsL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
    //self.AccountsL.textColor = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1];
    self.AccountsL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.AccountsL];
    self.AccountsL2 = [[UILabel alloc]init];
    self.AccountsL2.frame = CGRectMake(ScreenWidth-55*ScreenWidth/375, 196*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
    self.AccountsL2.text = @"信息修改";
    self.AccountsL2.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
    self.AccountsL2.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    self.AccountsL2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.AccountsL2];
    self.AccountsView2 = [[UIImageView alloc]init];
    self.AccountsView2.frame = CGRectMake(ScreenWidth-10*ScreenWidth/375, 196*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
    self.AccountsView2.image = [UIImage imageNamed:@"箭头.png"];
    self.AccountsView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.AccountsView2];
    
    
    
    self.RebateBut = [[UIButton alloc]init];
    self.RebateBut.frame = CGRectMake(0, 217*ScreenWidth/375, ScreenWidth, 25*ScreenWidth/375);
    //[self.RebateBut addTarget:self action:@selector(RebateButAction) forControlEvents:UIControlEventTouchDown];
    self.RebateBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.RebateBut];
    self.RealNameView = [[UIImageView alloc]init];
    self.RealNameView.frame = CGRectMake(8*ScreenWidth/375, 226*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
    self.RealNameView.image = [UIImage imageNamed:@"我的返利.png"];
    self.RealNameView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.RealNameView];
    self.RealNameL = [[UILabel alloc]init];
    self.RealNameL.frame = CGRectMake(21*ScreenWidth/375, 226*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
    self.RealNameL.text = @"我的返利";
    self.RealNameL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
    //self.RealNameL.textColor = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1];
    self.RealNameL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.RealNameL];
    self.RealNameView2 = [[UIImageView alloc]init];
    self.RealNameView2.frame = CGRectMake(ScreenWidth-10*ScreenWidth/375, 226*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
    self.RealNameView2.image = [UIImage imageNamed:@"箭头.png"];
    self.RealNameView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.RealNameView2];
    
//    self.ConsumeBut = [[UIButton alloc]init];
//    self.ConsumeBut.frame = CGRectMake1(0, 247*ScreenWidth/375, 320*ScreenWidth/375, 25*ScreenWidth/375);
//    [self.ConsumeBut addTarget:self action:@selector(ConsumeButAction) forControlEvents:UIControlEventTouchDown];
//    self.ConsumeBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ConsumeBut];
//    self.ConsumeView = [[UIImageView alloc]init];
//    self.ConsumeView.frame = CGRectMake1(8, 256*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
//    self.ConsumeView.image = [UIImage imageNamed:@"消费记录.png"];
//    self.ConsumeView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ConsumeView];
//    self.ConsumeL = [[UILabel alloc]init];
//    self.ConsumeL.frame = CGRectMake1(21*ScreenWidth/375, 256*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.ConsumeL.text = @"消费记录";
//    self.ConsumeL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//    self.ConsumeL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ConsumeL];
//    self.ConsumeL2 = [[UILabel alloc]init];
//    self.ConsumeL2.frame = CGRectMake1(262*ScreenWidth/375, 256*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.ConsumeL2.text = @"查看记录";
//    self.ConsumeL2.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//     self.ConsumeL2.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
//    self.ConsumeL2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ConsumeL2];
//    self.ConsumeView2 = [[UIImageView alloc]init];
//    self.ConsumeView2.frame = CGRectMake1(304*ScreenWidth/375, 256*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
//    self.ConsumeView2.image = [UIImage imageNamed:@"箭头.png"];
//    self.ConsumeView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ConsumeView2];

    
//    self.IntegrationBut = [[UIButton alloc]init];
//    self.IntegrationBut.frame = CGRectMake1(0, 277*ScreenWidth/375, 320*ScreenWidth/375, 25*ScreenWidth/375);
//    [self.IntegrationBut addTarget:self action:@selector(IntegrationButAction) forControlEvents:UIControlEventTouchDown];
//    self.IntegrationBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.IntegrationBut];
//    self.IntegrationView = [[UIImageView alloc]init];
//    self.IntegrationView.frame = CGRectMake1(8, 286*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
//    self.IntegrationView.image = [UIImage imageNamed:@"我的积分.png"];
//    self.IntegrationView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.IntegrationView];
//    self.IntegrationL = [[UILabel alloc]init];
//    self.IntegrationL.frame = CGRectMake1(21*ScreenWidth/375, 286*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.IntegrationL.text = @"我的积分";
//    self.IntegrationL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//    self.IntegrationL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.IntegrationL];
//    self.IntegrationL2 = [[UILabel alloc]init];
//    self.IntegrationL2.frame = CGRectMake1(262*ScreenWidth/375, 286*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.IntegrationL2.text = @"查看积分";
//    self.IntegrationL2.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//    self.IntegrationL2.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
//    self.IntegrationL2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.IntegrationL2];
//    self.IntegrationView2 = [[UIImageView alloc]init];
//    self.IntegrationView2.frame = CGRectMake1(304*ScreenWidth/375, 286*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
//    self.IntegrationView2.image = [UIImage imageNamed:@"箭头.png"];
//    self.IntegrationView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.IntegrationView2];
//
//
//    
//    self.RealNameBut = [[UIButton alloc]init];
//    self.RealNameBut.frame = CGRectMake1(0, 307*ScreenWidth/375, 320*ScreenWidth/375, 25*ScreenWidth/375);
//    [self.RealNameBut addTarget:self action:@selector(RealNameButAction) forControlEvents:UIControlEventTouchDown];
//    self.RealNameBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.RealNameBut];
//    self.RealNameView = [[UIImageView alloc]init];
//    self.RealNameView.frame = CGRectMake1(8, 316*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
//    self.RealNameView.image = [UIImage imageNamed:@"实名认证.png"];
//    self.RealNameView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.RealNameView];
//    self.RealNameL = [[UILabel alloc]init];
//    self.RealNameL.frame = CGRectMake1(21*ScreenWidth/375, 316*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.RealNameL.text = @"实名认证";
//    self.RealNameL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//    self.RealNameL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.RealNameL];
//    self.RealNameView2 = [[UIImageView alloc]init];
//    self.RealNameView2.frame = CGRectMake1(304*ScreenWidth/375, 316*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
//    self.RealNameView2.image = [UIImage imageNamed:@"箭头.png"];
//    self.RealNameView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.RealNameView2];
//
//
//    
//    self.ShoppingBut = [[UIButton alloc]init];
//    self.ShoppingBut.frame = CGRectMake1(0, 337*ScreenWidth/375, 320*ScreenWidth/375, 25*ScreenWidth/375);
//    [self.ShoppingBut addTarget:self action:@selector(ShoppingButAction) forControlEvents:UIControlEventTouchDown];
//    self.ShoppingBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ShoppingBut];
//    self.ShoppingView = [[UIImageView alloc]init];
//    self.ShoppingView.frame = CGRectMake1(8, 346*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
//    self.ShoppingView.image = [UIImage imageNamed:@"账号信息.png"];
//    self.ShoppingView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ShoppingView];
//    self.ShoppingL = [[UILabel alloc]init];
//    self.ShoppingL.frame = CGRectMake1(21*ScreenWidth/375, 346*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.ShoppingL.text = @"购物车";
//    self.ShoppingL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//    self.ShoppingL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ShoppingL];
//    self.ShoppingView2 = [[UIImageView alloc]init];
//    self.ShoppingView2.frame = CGRectMake1(304*ScreenWidth/375, 346*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
//    self.ShoppingView2.image = [UIImage imageNamed:@"箭头.png"];
//    self.ShoppingView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.ShoppingView2];
//
//    
//    self.CustomerBut = [[UIButton alloc]init];
//    self.CustomerBut.frame = CGRectMake1(0, 367*ScreenWidth/375, 320*ScreenWidth/375, 25*ScreenWidth/375);
//    [self.CustomerBut addTarget:self action:@selector(CustomerButAction) forControlEvents:UIControlEventTouchDown];
//    self.CustomerBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.CustomerBut];
//    self.CustomerView= [[UIImageView alloc]init];
//    self.CustomerView.frame = CGRectMake1(8, 376*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
//    self.CustomerView.image = [UIImage imageNamed:@"客服.png"];
//    self.CustomerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.CustomerView];
//    self.CustomerL = [[UILabel alloc]init];
//    self.CustomerL.frame = CGRectMake1(21*ScreenWidth/375, 376*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
//    self.CustomerL.text = @"客服";
//    self.CustomerL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//    self.CustomerL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.CustomerL];
//    self.CustomerL2 = [[UILabel alloc]init];
//    self.CustomerL2.frame = CGRectMake1(232*ScreenWidth/375, 376*ScreenWidth/375, 90*ScreenWidth/375, 10*ScreenWidth/375);
//    self.CustomerL2.text = @"400 0183 100";
//    self.CustomerL2.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
//    self.CustomerL2.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
//    self.CustomerL2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.CustomerL2];
//    self.CustomerView2= [[UIImageView alloc]init];
//    self.CustomerView2.frame = CGRectMake1(304*ScreenWidth/375, 376*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
//    self.CustomerView2.image = [UIImage imageNamed:@"箭头.png"];
//    self.CustomerView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    [self.view addSubview:self.CustomerView2];
    
        self.IntegrationBut = [[UIButton alloc]init];
        self.IntegrationBut.frame = CGRectMake(0, 247*ScreenWidth/375, ScreenWidth, 25*ScreenWidth/375);
        //[self.IntegrationBut addTarget:self action:@selector(IntegrationButAction) forControlEvents:UIControlEventTouchDown];
        self.IntegrationBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.IntegrationBut];
        self.IntegrationView = [[UIImageView alloc]init];
        self.IntegrationView.frame = CGRectMake(8*ScreenWidth/375, 256*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
        self.IntegrationView.image = [UIImage imageNamed:@"我的积分.png"];
        self.IntegrationView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.IntegrationView];
        self.IntegrationL = [[UILabel alloc]init];
        self.IntegrationL.frame = CGRectMake(21*ScreenWidth/375, 256*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
        self.IntegrationL.text = @"我的积分";
        self.IntegrationL.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
        self.IntegrationL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.IntegrationL];
        self.IntegrationL2 = [[UILabel alloc]init];
        self.IntegrationL2.frame = CGRectMake(ScreenWidth-55*ScreenWidth/375, 256*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
        self.IntegrationL2.text = @"我的积分";
        self.IntegrationL2.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
        self.IntegrationL2.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
        self.IntegrationL2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.IntegrationL2];
        self.IntegrationView2 = [[UIImageView alloc]init];
        self.IntegrationView2.frame = CGRectMake(ScreenWidth-10*ScreenWidth/375, 256*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        self.IntegrationView2.image = [UIImage imageNamed:@"箭头.png"];
        self.IntegrationView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.IntegrationView2];
    
        self.RealNameBut = [[UIButton alloc]init];
        self.RealNameBut.frame = CGRectMake(0, 277*ScreenWidth/375, ScreenWidth, 25*ScreenWidth/375);
        //[self.RealNameBut addTarget:self action:@selector(RealNameButAction) forControlEvents:UIControlEventTouchDown];
        self.RealNameBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.RealNameBut];
        self.RealNameView = [[UIImageView alloc]init];
        self.RealNameView.frame = CGRectMake(8*ScreenWidth/375, 286*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
        self.RealNameView.image = [UIImage imageNamed:@"实名认证.png"];
        self.RealNameView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.RealNameView];
        self.RealNameL = [[UILabel alloc]init];
        self.RealNameL.frame = CGRectMake(21*ScreenWidth/375, 286*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
        self.RealNameL.text = @"实名认证";
        self.RealNameL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
        self.RealNameL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.RealNameL];
        self.RealNameView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.RealNameView2];
        self.RealNameView2 = [[UIImageView alloc]init];
        self.RealNameView2.frame = CGRectMake(ScreenWidth-10*ScreenWidth/375, 286*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        self.RealNameView2.image = [UIImage imageNamed:@"箭头.png"];
        self.RealNameView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.RealNameView2];
    
        self.CustomerBut = [[UIButton alloc]init];
        self.CustomerBut.frame = CGRectMake(0, 307*ScreenWidth/375, ScreenWidth, 25*ScreenWidth/375);
        [self.CustomerBut addTarget:self action:@selector(CustomerButAction) forControlEvents:UIControlEventTouchDown];
        self.CustomerBut.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.CustomerBut];
        self.CustomerView = [[UIImageView alloc]init];
        self.CustomerView.frame = CGRectMake(8, 316*ScreenWidth/375, 10*ScreenWidth/375, 15*ScreenWidth/375);
        self.CustomerView.image = [UIImage imageNamed:@"客服.png"];
        self.CustomerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.CustomerView];
        self.CustomerL = [[UILabel alloc]init];
        self.CustomerL.frame = CGRectMake(21*ScreenWidth/375, 316*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
        self.CustomerL.text = @"客服";
        self.CustomerL.font = [UIFont systemFontOfSize:12*ScreenWidth/375];
        self.CustomerL.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.CustomerL];
        self.CustomerL2 = [[UILabel alloc]init];
        self.CustomerL2.frame = CGRectMake(ScreenWidth-55*ScreenWidth/375, 316*ScreenWidth/375, 50*ScreenWidth/375, 10*ScreenWidth/375);
        self.CustomerL2.text = @"100000";
        self.CustomerL2.font = [UIFont systemFontOfSize:10*ScreenWidth/375];
        self.CustomerL2.textColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
        self.CustomerL2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.CustomerL2];
        self.CustomerView2 = [[UIImageView alloc]init];
        self.CustomerView2.frame = CGRectMake(ScreenWidth-10*ScreenWidth/375, 316*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        self.CustomerView2.image = [UIImage imageNamed:@"箭头.png"];
        self.CustomerView2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:self.CustomerView2];

    

    





}


#pragma mark - 按钮
- (void)HeadButAction{
    
    GerenZiliaoViewController *geren = [[GerenZiliaoViewController alloc]init];
    [self presentViewController:geren animated:YES completion:nil];
   
}
- (void)AllOrderButAction{
    
    OderListController *dingdan = [[OderListController alloc]init];
    //dingdan.buttonTag = 1;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:dingdan animated:YES];
    //通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"111" object:self userInfo:@{@"123":@"456",@"WWWW":@"SSSSS"}];
    
}
- (void)PayButAction{
    
    OderListController *dingdan = [[OderListController alloc]init];
    //dingdan.buttonTag = 2;
     self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:dingdan animated:YES];
    //通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"111" object:self userInfo:@{@"123":@"456",@"WWWW":@"SSSSS"}];
    
}
- (void)CheckInButAction{
    
    OderListController *dingdan = [[OderListController alloc]init];
   // dingdan.buttonTag = 3;
     self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:dingdan animated:YES];
    //通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"111" object:self userInfo:@{@"123":@"456",@"WWWW":@"SSSSS"}];

  
}
- (void)AppraiseButAction{
    
    OderListController *dingdan = [[OderListController alloc]init];
    //dingdan.buttonTag = 3;
     self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:dingdan animated:YES];
 //通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"111" object:self userInfo:@{@"123":@"456",@"WWWW":@"SSSSS"}];

    
}

- (void)PasswordButAction{
    ChangePasswordController *change = [[ChangePasswordController alloc]init];
    [self.navigationController pushViewController:change animated:YES];
    
    NSLog(@"2222");
}

- (void)AccountsButAction{
    
    AccountController *zhanghao = [[AccountController alloc]init];
    [self.navigationController pushViewController:zhanghao animated:YES];
//    
//    CATransition *animation = [CATransition animation];
//    
//    /*
//     动画类型
//     fade 淡出效果
//     moveIn 新视图移动到旧视图
//     push   新视图推出旧视图
//     reveal 移开旧视图
//     cube   立方体翻转效果
//     oglFlip    翻转效果
//     suckEffect 收缩效果
//     rippleEffect   水滴波纹效果
//     pageCurl   向下翻页
//     pageUnCurl 向上翻页
//     */
//    animation.type = @"cube";
//    
//    // 设置动画反向
//    /**
//     kCATransitionFromRight
//     kCATransitionFromLeft
//     kCATransitionFromTop
//     kCATransitionFromBottom
//     */
//    animation.subtype = kCATransitionFromRight;
//    
//    // 动画时间
//    animation.duration = 0.6;
//    
//    // 设置动画速率(可变的)
//    /**
//     kCAMediaTimingFunctionLinear 线性（匀速）
//     kCAMediaTimingFunctionEaseIn 先慢
//     kCAMediaTimingFunctionEaseOut 后慢
//     kCAMediaTimingFunctionEaseInEaseOut 先慢 后慢 中间快
//     kCAMediaTimingFunctionDefault 默认
//     */
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    // 加载到layer中
//    [self.navigationController.view.layer addAnimation:animation forKey:nil];
 //   [self.navigationController pushViewController:zhanghao animated:YES];
    

    
}
//- (void)RebateButAction{
//    WodeFanliViewController *wodeFanli = [[WodeFanliViewController alloc]init];
//    [self presentViewController:wodeFanli animated:YES completion:nil];
//    
//}

//- (void)ConsumeButAction{
//    
//    QuanbuDingdanViewController *dingdan = [[QuanbuDingdanViewController alloc]init];
//    [self.navigationController pushViewController:dingdan animated:YES];
//    
//}

//- (void)IntegrationButAction{
//    
//    WodeJifenViewController *wodeJifen = [[WodeJifenViewController alloc]init];
//    [self.navigationController pushViewController:wodeJifen animated:YES];
//    
//}

//- (void)RealNameButAction{
//    
//    ShimingRenzhengViewController *shiming = [[ShimingRenzhengViewController alloc]init];
//    [self presentViewController:shiming animated:YES completion:nil];
//    
//}

//- (void)ShoppingButAction{
//    
//    GouwucheViewController *gouwu = [[GouwucheViewController alloc]init];
//    [self.navigationController pushViewController:gouwu animated:YES];
//    
//}
- (void)CustomerButAction{
    
}




@end
