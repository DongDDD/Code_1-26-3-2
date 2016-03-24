//
//  MemberViewController.m
//  Code_
//
//  Created by admin on 15/12/18.
//  Copyright © 2015年 东. All rights reserved.
//

#import "MemberViewController.h"
#import "GerenZiliaoViewController.h"
#import "HuiyuanViewController.h"
#import "QuanbuDingdanViewController.h"
#import "DaijinQuanViewController.h"
#import "WodeFanliViewController.h"
#import "XiaofeiJiluViewController.h"
#import "WodeJifenViewController.h"
#import "ShimingRenzhengViewController.h"
#import "ZhanghaoXinxiViewController.h"
#import <AFNetworking.h>
#import <YTKKeyValueStore.h>
#import "GouwucheViewController.h"
#import "MBProgressHUD+MJ.h"

@interface MemberViewController ()
@property(nonatomic,strong)UIImageView *im;
@property (nonatomic,strong)NSDictionary *dataDict;
@end

@implementation MemberViewController




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
        [self changTheFrame];
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
    
    
    NSLog(@"会员界面初始化");
    
    //[self panduanShifouDenglule];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)jiazaiShuju:(NSDictionary *)dict1{
    NSString *url = @"http://120.25.69.40:1005/API/GetSysLoginData.ashx";
//    NSString *url = @"http://192.168.1.125:1005/API/GetListData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"View" forKey:@"action"];//接口方式:登陆
    [dict setObject:dict1[@"MembId"] forKey:@"MembId"];//会员ID
    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    
//    [dict9 setValue:self.lingpai forKey:@"AccessToken"];
//    [dict9 setValue:@"List" forKey:@"action"];
//    [dict9 setValue:@"0019" forKey:@"WBS"];
//    [dict9 setValue:@"0" forKey:@"Desc"];
//    [dict9 setValue:@"10" forKey:@"psize"];
//    [dict9 setValue:@"1" forKey:@"pid"];
//    [dict9 setValue:@"%@" forKey:@"BeginDate"];
//    [dict9 setValue:@"%@" forKey:@"EndDate"];
    
    
    
    
    NSLog(@"请求的参数是:%@",dict);
//    // 增加蒙板
//    [MBProgressHUD showMessage:@"登录中"];
    
    
    
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
              int nu = [dic[@"IsError"] intValue];
              
              if (nu == 1) {
                  NSLog(@"有异常");
              }else{
                  NSLog(@"nu:%d,异常信息:%@",nu,MsgStr);
              }
              
              if (nu ==1) {
                  //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                  NSLog(@"获取会员信息不成功，返回的消息是%@",MsgStr);

              }else{
                  NSLog(@"发送请求结果无异常");
                  //BOOL chenggongOrShibai = dic[@"Result"][@"State"];
                  //NSInteger trueOrFalse = [dic[@"Result"][@"State"] integerValue];
                  //NSLog(@"trueOrFalse :%lu",trueOrFalse);
                  //NSLog(@"%d",chenggongOrShibai);
                  //if (chenggongOrShibai == YES) {
                      NSLog(@"获取会员信息成功");
                     
                      NSLog(@"解析的数据是%@",dic);
                      
                      //NSString *sss = dic[@"Msg"];
                      //NSLog(@"Msg:%@",sss);
                      
                      
                  //}else{
                  
                      //[MBProgressHUD showError:MsgStr];
                  //}
                  NSLog(@"----------------");
              }
//              // 隐藏蒙板
//              [MBProgressHUD hideHUD];
          
     
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"000%@",error);
              //请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              // 隐藏蒙板
              //[MBProgressHUD hideHUD];
          }];
    
}










#pragma mark - 跳转到全部订单
- (IBAction)dingdanButtonClick:(id)sender {
    QuanbuDingdanViewController *dingdan = [[QuanbuDingdanViewController alloc]init];
    
    dingdan.buttonTag = 1;
    [self.navigationController pushViewController:dingdan animated:YES];
    
    
}
#pragma mark - 设置代付款按钮点击事件
- (IBAction)daifukuanButtonClick:(id)sender {
    QuanbuDingdanViewController *dingdan = [[QuanbuDingdanViewController alloc]init];
    
    dingdan.buttonTag = 2;
    [self.navigationController pushViewController:dingdan animated:YES];
    
    
    
}
#pragma mark - 设置代支付按钮点击事件
- (IBAction)dairuZhuButtonClick:(id)sender {
    QuanbuDingdanViewController *dingdan = [[QuanbuDingdanViewController alloc]init];
    dingdan.buttonTag = 3;
    [self.navigationController pushViewController:dingdan animated:YES];
}
#pragma mark - 设置代评价按钮点击事件
- (IBAction)daipinjiaButtonClick:(id)sender {
    QuanbuDingdanViewController *dingdan = [[QuanbuDingdanViewController alloc]init];
    
    dingdan.buttonTag = 3;
    [self.navigationController pushViewController:dingdan animated:YES];
}
#pragma mark - 设置个人资料跳转按钮
- (IBAction)zhanghaoXinxiButtonClick:(id)sender {
    
    //GerenZiliaoViewController *geren = [[GerenZiliaoViewController alloc]init];
    ZhanghaoXinxiViewController *zhanghao = [[ZhanghaoXinxiViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    
    /*
     动画类型
     fade 淡出效果
     moveIn 新视图移动到旧视图
     push   新视图推出旧视图
     reveal 移开旧视图
     cube   立方体翻转效果
     oglFlip    翻转效果
     suckEffect 收缩效果
     rippleEffect   水滴波纹效果
     pageCurl   向下翻页
     pageUnCurl 向上翻页
     */
    animation.type = @"cube";
    
    // 设置动画反向
    /**
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     */
    animation.subtype = kCATransitionFromRight;
    
    // 动画时间
    animation.duration = 0.6;
    
    // 设置动画速率(可变的)
    /**
     kCAMediaTimingFunctionLinear 线性（匀速）
     kCAMediaTimingFunctionEaseIn 先慢
     kCAMediaTimingFunctionEaseOut 后慢
     kCAMediaTimingFunctionEaseInEaseOut 先慢 后慢 中间快
     kCAMediaTimingFunctionDefault 默认
     */
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 加载到layer中
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    
    
    
    //[self presentViewController:geren animated:YES completion:nil];
    
    //[self.navigationController pushViewController:zhanghao animated:YES];
    
    [self.navigationController pushViewController:zhanghao animated:YES];
    //[self presentViewController:zhanghao animated:YES completion:nil];
    
}
#pragma mark - 设置我的返利按钮点击事件
- (IBAction)wodeFanLiButtonClick:(id)sender {
    WodeFanliViewController *wodeFanli = [[WodeFanliViewController alloc]init];
    [self presentViewController:wodeFanli animated:YES completion:nil];
}
#pragma mark - 设置消费记录按钮点击事件
- (IBAction)xiaofeiJiluButtonClick:(id)sender {
    QuanbuDingdanViewController *dingdan = [[QuanbuDingdanViewController alloc]init];
    dingdan.buttonTag = 4;
    [self.navigationController pushViewController:dingdan animated:YES];
    //XiaofeiJiluViewController *xiaofei = [[XiaofeiJiluViewController alloc]init];
    //[self presentViewController:xiaofei animated:YES completion:nil];
    
}
#pragma mark - 设置我的积分按钮点击事件
- (IBAction)wodeJifenButtonClick:(id)sender {
    
    WodeJifenViewController *wodeJifen = [[WodeJifenViewController alloc]init];
    //[self.navigationController pushViewController:wodeJifen animated:YES];
    [self.navigationController pushViewController:wodeJifen animated:YES];
    //[self presentViewController:wodeJifen animated:YES completion:nil];
}
#pragma mark - 设置实名认证按钮点击事件
- (IBAction)shimingRenzhengButtonClick:(id)sender {
    
    ShimingRenzhengViewController *shiming = [[ShimingRenzhengViewController alloc]init];
    [self presentViewController:shiming animated:YES completion:nil];
}
#pragma mark - 设置代金券按钮点击事件
- (IBAction)daijinquanButtonClick:(id)sender {
    
    //DaijinQuanViewController *daijin = [[DaijinQuanViewController alloc]init];
    
    //暂时改为购物车
    GouwucheViewController *gouwu = [[GouwucheViewController alloc]init];
    
    [self.navigationController pushViewController:gouwu animated:YES];
    
    //[self presentViewController:gouwu animated:YES completion:nil];
    
    
    //[self presentViewController:daijin animated:YES completion:nil];
    
    
}
#pragma mark - 设置客服按钮点击事件
- (IBAction)kefuButtonClick:(id)sender {
    
    //    NSString *str =@"4000183100";
    //
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //
    //    NSLog(@"点击了电话");
    
    //    QuanbuShoucangViewController *shoucang = [[QuanbuShoucangViewController alloc]init];
    //    [self presentViewController:shoucang animated:YES completion:nil];
    
}

#pragma mark - 点击跳到会员页面
- (IBAction)huiyuanButtonClick:(id)sender {
    
    GerenZiliaoViewController *geren = [[GerenZiliaoViewController alloc]init];
    
    //geren.dict =
    
    //[]
    
    [self presentViewController:geren animated:YES completion:nil];
    
    
    
    
    
}















-(void)changTheFrame{
    //float bili = ScreenWidth/320.0;
    _beijingImageView.frame = CGRectMake1(0, 0, 320, 100);
    _huiyuanTouxiangImageView.frame = CGRectMake1(135, 25, 50, 50);
    _huiyuanXiaotubiaoImageView.frame = CGRectMake1(128, 80, 10, 10);
    _huiyuanLabel.frame = CGRectMake1(140, 80, 51, 10);
    _qianbaoLabel.frame = CGRectMake1(17, 104, 40, 10);
    _qianbaoXiaImageView.frame = CGRectMake1(8, 116, 304, 1);
    _dingdanButton.frame = CGRectMake1(0, 136, 79, 47);
    _daifukuanButton.frame = CGRectMake1(80, 136, 79, 47);
    _dairuzhuButton.frame = CGRectMake1(160, 136, 79, 47);
    _daipingjiaButton.frame = CGRectMake1(240, 136, 80, 47);
    
    
    _xianjinLabel.frame = CGRectMake1(17, 120, 40, 10);
    _xianjinShuziLabel.frame = CGRectMake1(57, 120, 60, 10);
    _liPinLabel.frame = CGRectMake1(123, 120, 51, 10);
    _lipinShuziLabel.frame = CGRectMake1(175, 120, 50, 10);
    
    _fanxianLabel.frame = CGRectMake1(221, 120, 40, 10);
    _fanxianShuziLabel.frame = CGRectMake1(261, 120, 42, 10);
    
    
    _dingdanImageView.frame = CGRectMake1(31 , 145, 17, 17);
    _daifukuanImageView.frame = CGRectMake1(111 , 145, 17, 17);
    _dairuzhuImageView.frame = CGRectMake1(191 , 145, 17, 17);
    _daipinjiaImageView.frame = CGRectMake1(271 , 145, 17, 17);
    
    _dingbanLabel.frame = CGRectMake1(0 , 166, 79, 12);
    _daifukuanLabel.frame = CGRectMake1(80 , 166, 79, 12);
    _dairuzhuLabel.frame = CGRectMake1(160 , 166, 79, 12);
    _daipinjiaLabel.frame = CGRectMake1(240 , 166, 80, 12);
    
    _zhanghaoXinxiButton.frame = CGRectMake1(0, 187, 320, 25);
    _wodeFanliButton.frame = CGRectMake1(0, 217, 320, 25);
    _xiaofeiJiluButton.frame = CGRectMake1(0, 247, 320, 25);
    _wodeJifenButton.frame = CGRectMake1(0, 277, 320, 25);
    _shimingRenzhengButton.frame = CGRectMake1(0, 307, 320, 25);
    _daijinquanButton.frame = CGRectMake1(0, 337, 320, 25);
    _kefuButton.frame = CGRectMake1(0, 367, 320, 25);
    
    _imageView1.frame = CGRectMake1(8, 196, 10, 10);
    _imageView2.frame = CGRectMake1(8, 226, 10, 10);
    _imageView3.frame = CGRectMake1(8, 256, 10, 10);
    _imageView4.frame = CGRectMake1(8, 286, 10, 10);
    _imageView5.frame = CGRectMake1(8, 316, 10, 10);
    _imageView6.frame = CGRectMake1(8, 346, 10, 10);
    _imageView7.frame = CGRectMake1(8, 376, 10, 10);
    _imageView01.frame = CGRectMake1(304, 196, 6, 10);
    _imageView02.frame = CGRectMake1(304, 226, 6, 10);
    _imageView03.frame = CGRectMake1(304, 256, 6, 10);
    _imageView04.frame = CGRectMake1(304, 286, 6, 10);
    _imageView05.frame = CGRectMake1(304, 316, 6, 10);
    _imageView06.frame = CGRectMake1(304, 346, 6, 10);
    _imageView07.frame = CGRectMake1(304, 376, 6, 10);
    
    _Label1.frame = CGRectMake1(21, 196, 40, 10);
    _Label2.frame = CGRectMake1(21, 226, 40, 10);
    _Label3.frame = CGRectMake1(21, 256, 40, 10);
    _Label4.frame = CGRectMake1(21, 286, 40, 10);
    _Label5.frame = CGRectMake1(21, 316, 40, 10);
    _Label6.frame = CGRectMake1(21, 346, 40, 10);
    _Label7.frame = CGRectMake1(21, 376, 40, 10);
    _Label01.frame = CGRectMake1(262, 196, 40, 10);
    _Label03.frame = CGRectMake1(262, 256, 40, 10);
    _Label04.frame = CGRectMake1(262, 286, 40, 10);
    _Label06.frame = CGRectMake1(262, 346, 40, 10);
    _Label07.frame = CGRectMake1(212, 376, 90, 10);
    
    //_huiyuanLabel.font = [UIFonts ]
    
    float a = ScreenWidth/320.0;
    
    _huiyuanLabel.font = [UIFont systemFontOfSize:10*a];
    _qianbaoLabel.font = [UIFont systemFontOfSize:10*a];
    _xianjinLabel.font = [UIFont systemFontOfSize:10*a];
    _xianjinShuziLabel.font = [UIFont systemFontOfSize:10*a];
    _liPinLabel.font = [UIFont systemFontOfSize:10*a];
    _lipinShuziLabel.font = [UIFont systemFontOfSize:10*a];
    _fanxianLabel.font = [UIFont systemFontOfSize:10*a];
    _fanxianShuziLabel.font = [UIFont systemFontOfSize:10*a];
    
    _dingbanLabel.font = [UIFont systemFontOfSize:12*a];
    _daifukuanLabel.font = [UIFont systemFontOfSize:12*a];
    _dairuzhuLabel.font = [UIFont systemFontOfSize:12*a];
    _daipinjiaLabel.font = [UIFont systemFontOfSize:12*a];
    
    
    _Label1.font = [UIFont systemFontOfSize:10*a];
    _Label2.font = [UIFont systemFontOfSize:10*a];
    _Label3.font = [UIFont systemFontOfSize:10*a];
    _Label4.font = [UIFont systemFontOfSize:10*a];
    _Label5.font = [UIFont systemFontOfSize:10*a];
    _Label6.font = [UIFont systemFontOfSize:10*a];
    _Label7.font = [UIFont systemFontOfSize:10*a];
    _Label01.font = [UIFont systemFontOfSize:10*a];
    _Label03.font = [UIFont systemFontOfSize:10*a];
    _Label04.font = [UIFont systemFontOfSize:10*a];
    _Label06.font = [UIFont systemFontOfSize:10*a];
    _Label07.font = [UIFont systemFontOfSize:10*a];
    
    _huiyuanTouxiangImageView.layer.cornerRadius = 25*a;
    
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
