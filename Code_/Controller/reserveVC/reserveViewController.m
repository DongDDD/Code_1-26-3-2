//
//  reserveViewController.m
//  Code_
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 东. All rights reserved.
//
#import "CalendarHomeViewController.h"
#import "reserveViewController.h"
#import "OrderlistViewController.h"
@interface reserveViewController ()

{
    
    CalendarHomeViewController *chvc;
    
}

@property(nonatomic,retain)UILabel * lanbe100;

@end

@implementation reserveViewController

// 点击触摸－屏幕键盘回收
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.self.textFNumber resignFirstResponder];
    [self.self.textF resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)fanhu1Action
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self navigButton];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.scrV = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrV.backgroundColor=[UIColor colorWithRed:233/255.0 green:237/255.0 blue:239/255.0 alpha:1];
    self.scrV.contentSize = CGSizeMake(ScreenWidth, 911*ScreenWidth/375);
    self.scrV.pagingEnabled = NO;
    self.scrV.bounces = YES;
    self.scrV.showsHorizontalScrollIndicator = NO;
    self.scrV.showsVerticalScrollIndicator = NO;
//    self.scrV.contentOffset = CGPointMake(ScreenWidth, 0);
    self.scrV.delegate = self;
    [self.view addSubview:self.scrV];
    
    UIView *view1=[[UIView alloc]init];
    view1.frame=CGRectMake(0, 0, ScreenWidth, 100*ScreenWidth/375);
    view1.backgroundColor=[UIColor whiteColor];
    [self.scrV addSubview:view1];
    
    UILabel * lanbe1=[[UILabel alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth, 50*ScreenWidth/375)];
    lanbe1.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    lanbe1.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe1.text=self.ProdName;
    lanbe1.numberOfLines=0;
    lanbe1.textAlignment =NSTextAlignmentCenter;
    [view1 addSubview:lanbe1];
    
    UILabel * lanbe2=[[UILabel alloc]initWithFrame:CGRectMake(0,  50*ScreenWidth/375, ScreenWidth/2, 50*ScreenWidth/375)];
    lanbe2.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    lanbe2.textColor=[UIColor orangeColor];
    lanbe2.text=[NSString stringWithFormat:@"单价¥ %@元",self.ProdPice];
    lanbe2.textAlignment =NSTextAlignmentCenter;
    [view1 addSubview:lanbe2];
    
    UILabel * lanbe3=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2,  50*ScreenWidth/375, ScreenWidth/2, 50*ScreenWidth/375)];
    lanbe3.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    lanbe3.textColor=[UIColor colorWithRed:228/255.0 green:56/255.0 blue:84/255.0 alpha:1];
    lanbe3.text=[NSString stringWithFormat:@"马上预订¥ %@元",self.CutPrice];
    lanbe3.textAlignment =NSTextAlignmentCenter;
    [view1 addSubview:lanbe3];
    
   
    
    [self backV];
    [self SubmitView];
     [self fangxingview2];
     [self fangxingview3];
     [self fangxingview4];
     [self fangxingview5];
     [self fangxingview6];
    [self chuangjianP];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先选择入住时间段" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [self riqixuanzheAction];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigButton{
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 10, 17);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(fanhu1Action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
}

#pragma mark - Header
- ( void)backV{
    UILabel * lanbe3=[[UILabel alloc]initWithFrame:CGRectMake(0,  100*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375)];
    lanbe3.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    lanbe3.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe3.text=@"入住时间段";
    lanbe3.textAlignment =NSTextAlignmentCenter;
    [self.scrV addSubview:lanbe3];
    
    UILabel * lanbe4=[[UILabel alloc]initWithFrame:CGRectMake(0,  230*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375)];
    lanbe4.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    lanbe4.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe4.text=@"预定数量";
    lanbe4.textAlignment =NSTextAlignmentCenter;
    [self.scrV addSubview:lanbe4];
    
    UILabel * lanbe5=[[UILabel alloc]initWithFrame:CGRectMake(0,  400*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375)];
    lanbe5.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    lanbe5.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe5.text=@"入住人信息";
    lanbe5.textAlignment =NSTextAlignmentCenter;
    [self.scrV addSubview:lanbe5];

    UILabel * lanbe6=[[UILabel alloc]initWithFrame:CGRectMake(0,  530*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375)];
    lanbe6.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    lanbe6.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe6.text=@"住宿意外险";
    lanbe6.textAlignment =NSTextAlignmentCenter;
    [self.scrV addSubview:lanbe6];
    
    UILabel * lanbe7=[[UILabel alloc]initWithFrame:CGRectMake(0,  660*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375)];
    lanbe7.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    lanbe7.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe7.text=@"预定人信息";
    lanbe7.textAlignment =NSTextAlignmentCenter;
    [self.scrV addSubview:lanbe7];
}




#pragma mark - 提交订单
- (void)SubmitView{
    UIView *SubmitV=[[UIView alloc]init];
    SubmitV.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-60*ScreenWidth/375, ScreenWidth, 60*ScreenWidth/375);
    SubmitV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:SubmitV];
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-120*ScreenWidth/375-2,1*ScreenWidth/375)];
    view3.backgroundColor=[UIColor colorWithRed:233/255.0 green:237/255.0 blue:239/255.0 alpha:1];
    [SubmitV addSubview:view3];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-120*ScreenWidth/375, 0,120*ScreenWidth/375, 60*ScreenWidth/375);
    button3.backgroundColor=[UIColor colorWithRed:228/255.0 green:56/255.0 blue:84/255.0 alpha:1];
    button3.titleLabel.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    [button3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [button3 setTitle:@"提交订单" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(SubmitAction) forControlEvents:UIControlEventTouchDown];
    [SubmitV addSubview:button3];
    
    self.lanbe100=[[UILabel alloc]initWithFrame:CGRectMake(2,  0, [UIScreen mainScreen].bounds.size.width-120*ScreenWidth/375-2, 60*ScreenWidth/375)];
    self.lanbe100.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    self.lanbe100.textColor=[UIColor colorWithRed:228/255.0 green:56/255.0 blue:84/255.0 alpha:1];
    self.lanbe100.text=@"订单总金额: 500";
    [SubmitV addSubview:self.lanbe100];
    
}

#pragma mark - 添加入住人信息
- (void)ruzhuAction
{
    NSLog(@"添加入住信息");
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"需要添加您以外的人，提交后与房东联系！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alert show];
    
    accoutfangkeVC *zhanghao = [[accoutfangkeVC alloc]init];
    [self.navigationController pushViewController:zhanghao animated:YES];
    
    zhanghao.delegate=self;
    
//    UIView *vie=[[UIView alloc]init];
//    vie.frame=CGRectMake(0, 0, ScreenWidth, 5000);
//    vie.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:vie];
//    
//    accoutfangkeVC *huiyuan = [[accoutfangkeVC alloc]init];
//    huiyuan.view.frame = CGRectMake(0, 0, 320, 520);
//    [vie addSubview:huiyuan.view];
//    [self addChildViewController:huiyuan];
}
- (void)passValue:(NSMutableArray *)str{
    NSLog(@"%@--------",str);
    self.Arrayss3=str;
}

- (void)passValues:(NSString *)strt
{
    NSLog(@"%@--------",strt);
    self.labelName.text=strt;
}

- (void)SubmitAction{
    
    NSLog(@"提交订单");
    
    if ([self.textF.text isEqualToString:@""]|[self.textFNumber.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"填写信息不全!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        NSLog(@"会员ID");
        NSLog(@"支付方式");
        NSLog(@"订单总价");
        NSLog(@"发票类型");
        NSLog(@"商品总金额");
        NSLog(@"房屋id为：%@",self.ProdId);
        NSLog(@"房屋名称为：%@",self.ProdName);
        NSLog(@"房屋单价");
        NSLog(@"成交价格");
        NSLog(@"预订数量");
        NSLog(@"金额合计");
        NSLog(@"%@入住---%@离开",[_dataArray objectAtIndex:0],[_dataArray objectAtIndex:1]);
        NSLog(@"共住%ld天,订%ld间,预订价格%@,单价%@",(long)self.days,(long)self.p,self.CutPrice,self.ProdPice);
        NSLog(@"身份证号码");
        NSLog(@"姓名为：%@",self.textF.text);
        NSLog(@"性别");
        
        //    可以不填的
        NSLog(@"订单备注");
        NSLog(@"发票抬头－不写默认个人");
        NSLog(@"发票内容");
        NSLog(@"发票税金");
        NSLog(@"房屋积分");
        NSLog(@"积分合计");
        
        
        
        NSLog(@"手机号为：%@",self.textFNumber.text);
        
//        float floatString = [ self.CutPrice floatValue];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *dict1= [NSMutableDictionary dictionary];
        [dict1 setObject:self.MenbIdString forKey:@"MenbId"];//会员id
        [dict1 setObject:@"1551ad08-906f-4993-b440-13ee7052c7da" forKey:@"PayWay"];//支付方式
        [dict1 setObject:@500 forKey:@"OrderTotalPrice"];//订单总价
        [dict1 setObject:@1 forKey:@"BillType"];//发票类型
        [dict1 setObject:@200 forKey:@"ProdTotalPrice"];//商品总金额
        [dict1 setObject:@"最好提供接送服务" forKey:@"Remark"];//订单备注---－－－－－－－
        [dict1 setObject:@20 forKey:@"BillRate"];//发票税金－－－－－－
        [dict1 setObject:@"heheh" forKey:@"BillContent"];//发票内容----
        [dict1 setObject:@"heheh" forKey:@"BillTitle"];//发票抬头----
        NSData  * jsonData1=[NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *strdata1=[[NSString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        NSLog(@"请求的参数1是:%@",strdata1);
        NSString *ecodeStr1=[self URLEncodedString:strdata1];
        NSLog(@"readyEcodeStr=%@  ecodeStr=%@",strdata1,ecodeStr1);
        
        NSMutableDictionary *dict2= [NSMutableDictionary dictionary];
        [dict2 setObject:self.ProdId forKey:@"ProdId"];//房屋ID
        [dict2 setObject:self.ProdName forKey:@"ProdName"];//房屋名称
        [dict2 setObject:self.ProdPice forKey:@"ProdPice"];//房屋单价
        [dict2 setObject:self.CutPrice forKey:@"CutPrice"];//成交价格
        [dict2 setObject:[NSString stringWithFormat:@"%ld",(long)self.p] forKey:@"BuyNum"];//预订数量
        [dict2 setObject:@200 forKey:@"PriceCount"];//金额合计
        [dict2 setObject:[_dataArray objectAtIndex:0] forKey:@"CheckInTime"];//入住时间
        [dict2 setObject:[_dataArray objectAtIndex:1] forKey:@"CheckOutTime"];//退房时间
        [dict2 setObject:@200 forKey:@"Integral"];//房屋积分
        [dict2 setObject:@200 forKey:@"IntegralCount"];//积分合计
        NSData  * jsonData2=[NSJSONSerialization dataWithJSONObject:dict2 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *strdata2=[[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        NSLog(@"请求的参数2是:%@",strdata2);
        NSString *ecodeStr2=[self URLEncodedString:strdata2];
        NSLog(@"readyEcodeStr=%@  ecodeStr=%@",strdata2,ecodeStr2);
        
//        NSMutableDictionary *dict3= [NSMutableDictionary dictionary];
//        [dict3 setObject:self.textFNumber.text forKey:@"IDCard"];//身份证号码
//        [dict3 setObject:self.textF.text forKey:@"RealName"];//姓名
//        [dict3 setObject:@0 forKey:@"Sex"];//性别
//        NSMutableArray *array3=[[NSMutableArray alloc]initWithObjects:dict3, nil];
        NSData  * jsonData3=[NSJSONSerialization dataWithJSONObject:self.Arrayss3 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *strdata3=[[NSString alloc]initWithData:jsonData3 encoding:NSUTF8StringEncoding];
        NSLog(@"请求的参数3是:%@",strdata3);
        NSString *ecodeStr3=[self URLEncodedString:strdata3];
        NSLog(@"readyEcodeStr=%@  ecodeStr=%@",strdata3,ecodeStr3);
        
        [dict setObject:@"Add" forKey:@"action"];
        [dict setObject:ecodeStr1 forKey:@"Order"];
        [dict setObject:ecodeStr2 forKey:@"Prod"];
        [dict setObject:ecodeStr3 forKey:@"HC"];
        [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
        
        NSLog(@"－－－－－－－－－－－－－请求的参数是:%@",dict);
        
        NSString *url2= [NSString stringWithFormat:@"http://120.25.69.40:1005/API/OrdersData.ashx?AccessToken=%@&action=Add&HC=%@&Prod=%@&Order=%@",self.lingpai,ecodeStr3,ecodeStr2,ecodeStr1];
        
        NSLog(@"url2=%@",url2);
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url2 parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  
                  NSLog(@"--------------dic:%@",dic);
                  
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  NSString *Msg=dic[@"Msg"];
                  
                  if (nu==1) {
                      NSLog(@"%@不成功",Msg);
                      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:Msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                      [alert show];
                  }else{
                      NSLog(@"成功%@",Msg);
                      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                      [alert show];
                      
                      OrderlistViewController *inforTC=[[OrderlistViewController alloc]init];
                      self.tabBarController.tabBar.hidden = YES;
                      inforTC.AccessToken=self.lingpai;
                      [self.navigationController pushViewController:inforTC animated:YES];
                      
                  }
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"请求发送不成功，错误信息%@",error);
                  //请求失败的时候调用调用这个block
                  NSLog(@"请求失败");
                  
              }];
        

    }
    

}

-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

-(NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

#pragma mark - 界面
- (void)fangxingview2{
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 150*ScreenWidth/375, ScreenWidth, 80*ScreenWidth/375)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.scrV addSubview:view2];
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-1*ScreenWidth/375, 10*ScreenWidth/375, 2*ScreenWidth/375,60*ScreenWidth/375)];
    view3.backgroundColor=[UIColor colorWithRed:233/255.0 green:237/255.0 blue:239/255.0 alpha:1];
    [view2 addSubview:view3];
    
    self.riqixuanzhebutton3=[UIButton buttonWithType:UIButtonTypeCustom];
    self.riqixuanzhebutton3.frame=CGRectMake(0, 0,ScreenWidth/2-1*ScreenWidth/375, 80*ScreenWidth/375);
    self.riqixuanzhebutton3.titleLabel.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
    [self.riqixuanzhebutton3 setTitleColor:[UIColor colorWithRed:228/255.0 green:56/255.0 blue:84/255.0 alpha:1] forState:UIControlStateNormal];
    [self.riqixuanzhebutton3 setTitle:@"入住日期" forState:UIControlStateNormal];
    [self.riqixuanzhebutton3 addTarget:self action:@selector(riqixuanzheAction) forControlEvents:UIControlEventTouchDown];
    [view2 addSubview:self.riqixuanzhebutton3];
    
    self.riqixuanzhebutton4=[UIButton buttonWithType:UIButtonTypeCustom];
    self.riqixuanzhebutton4.frame=CGRectMake(ScreenWidth/2, 0,ScreenWidth/2-1*ScreenWidth/375, 80*ScreenWidth/375);
    self.riqixuanzhebutton4.titleLabel.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
    [self.riqixuanzhebutton4 setTitleColor:[UIColor colorWithRed:228/255.0 green:56/255.0 blue:84/255.0 alpha:1] forState:UIControlStateNormal];
    [self.riqixuanzhebutton4 setTitle:@"离开日期" forState:UIControlStateNormal];
    [self.riqixuanzhebutton4 addTarget:self action:@selector(riqixuanzheAction) forControlEvents:UIControlEventTouchDown];
    [view2 addSubview:self.riqixuanzhebutton4];
    
    self.riqiDayL=[[UILabel alloc]initWithFrame:CGRectMake(0, 150*ScreenWidth/375, ScreenWidth, 80*ScreenWidth/375)];
    self.riqiDayL.font=[UIFont systemFontOfSize:18*ScreenWidth/375];
    self.riqiDayL.textColor=[UIColor orangeColor];//colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    self.riqiDayL.textAlignment =NSTextAlignmentCenter;
    [self.scrV addSubview:self.riqiDayL];
}

- (void)riqixuanzheAction{
    
    chvc.view.frame=CGRectMake(0,64+44*ScreenWidth/375, self.view.frame.size.width, self.view.frame.size.height);
    _mainView.frame=CGRectMake(0, self.view.frame.size.height-50*ScreenWidth/320,self.view.frame.size.width,50*ScreenWidth/320);
}

- (void)fangxingview3{
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 280*ScreenWidth/375, ScreenWidth, 120*ScreenWidth/375)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.scrV addSubview:view2];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 80*ScreenWidth/375, ScreenWidth,1*ScreenWidth/375)];
    view3.backgroundColor=[UIColor colorWithRed:233/255.0 green:237/255.0 blue:239/255.0 alpha:1];
    [view2 addSubview:view3];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake(15*ScreenWidth/375, 25*ScreenWidth/375,30*ScreenWidth/375, 30*ScreenWidth/375);
    button3.titleLabel.font=[UIFont systemFontOfSize:21*ScreenWidth/375];
    [button3 setTitleColor:[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1] forState:UIControlStateNormal];
    [button3 setTitle:@"一" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(jianAction) forControlEvents:UIControlEventTouchDown];
    [view2 addSubview:button3];
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame=CGRectMake(ScreenWidth-45*ScreenWidth/375, 25*ScreenWidth/375,30*ScreenWidth/375, 30*ScreenWidth/375);
    button4.titleLabel.font=[UIFont systemFontOfSize:21*ScreenWidth/375];
    [button4 setTitleColor:[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1] forState:UIControlStateNormal];
    [button4 setTitle:@"＋" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(jiaAction) forControlEvents:UIControlEventTouchDown];
    [view2 addSubview:button4];
    
    self.p=1;
    self.yuDingCount=[[UILabel alloc]initWithFrame:CGRectMake(45*ScreenWidth/375,  0, ScreenWidth-90*ScreenWidth/375, 80*ScreenWidth/375)];
    self.yuDingCount.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
    self.yuDingCount.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    self.yuDingCount.text=[NSString stringWithFormat:@"%ld间",(long)self.p];
    self.yuDingCount.textAlignment =NSTextAlignmentCenter;
    [view2 addSubview:self.yuDingCount];
    
    UILabel * lanbe3=[[UILabel alloc]initWithFrame:CGRectMake(0,  80*ScreenWidth/375, ScreenWidth, 40*ScreenWidth/375)];
    lanbe3.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
    lanbe3.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:0.5];
    lanbe3.text=@"根据您的入住时间段选择，房间预订";
    lanbe3.textAlignment =NSTextAlignmentCenter;
    [view2 addSubview:lanbe3];
    
    
}

- (void)fangxingview4{
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 450*ScreenWidth/375, ScreenWidth, 80*ScreenWidth/375)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.scrV addSubview:view2];
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame=CGRectMake(0, 0,ScreenWidth, 80*ScreenWidth/375);
    button4.titleLabel.font=[UIFont systemFontOfSize:25*ScreenWidth/375];
    [button4 setTitleColor:[UIColor colorWithRed:228/255.0 green:56/255.0 blue:84/255.0 alpha:1] forState:UIControlStateNormal];
    [button4 setTitle:@"＋添加入住人" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(ruzhuAction) forControlEvents:UIControlEventTouchDown];
    [view2 addSubview:button4];
    
    self.labelName=[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 65*ScreenWidth/375, 310*ScreenWidth/375, 11*ScreenWidth/375)];
    self.labelName.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.labelName.textColor=[UIColor blackColor];
//    self.labelName.text=self.stringL;
    self.labelName.textAlignment =NSTextAlignmentCenter;
    [view2 addSubview:self.labelName];
}

- (void)fangxingview5{
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 580*ScreenWidth/375, ScreenWidth, 80*ScreenWidth/375)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.scrV addSubview:view2];
    
    UILabel * lanbe3=[[UILabel alloc]initWithFrame:CGRectMake(20*ScreenWidth/375,  0, ScreenWidth-20*ScreenWidth/375, 80*ScreenWidth/375)];
    lanbe3.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
    lanbe3.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:0.5];
    lanbe3.text=@"可以免费赠送一人";
    lanbe3.numberOfLines=0;
    lanbe3.textAlignment =NSTextAlignmentLeft;
    [view2 addSubview:lanbe3];
}

- (void)fangxingview6{
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 710*ScreenWidth/375, ScreenWidth, 121*ScreenWidth/375)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.scrV addSubview:view2];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 60*ScreenWidth/375, ScreenWidth,1*ScreenWidth/375)];
    view3.backgroundColor=[UIColor colorWithRed:233/255.0 green:237/255.0 blue:239/255.0 alpha:1];
    [view2 addSubview:view3];
    
    UILabel * lanbe3=[[UILabel alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth/3, 60*ScreenWidth/375)];
    lanbe3.font=[UIFont systemFontOfSize:17*ScreenWidth/375];
    lanbe3.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe3.text=@"真实姓名 :";
    lanbe3.textAlignment =NSTextAlignmentCenter;
    [view2 addSubview:lanbe3];
    
    self.textF = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/3, 2*ScreenWidth/375, ScreenWidth-ScreenWidth/3, 56*ScreenWidth/375)];
    self.textF.backgroundColor = [UIColor whiteColor];
    self.textF.placeholder = @"请输入您的真实姓名";
    [view2 addSubview:self.textF];
    
    UILabel * lanbe4=[[UILabel alloc]initWithFrame:CGRectMake(0,  60*ScreenWidth/375, ScreenWidth/3, 60*ScreenWidth/375)];
    lanbe4.font=[UIFont systemFontOfSize:17*ScreenWidth/375];
    lanbe4.textColor=[UIColor colorWithRed:39/255.0 green:54/255.0 blue:70/255.0 alpha:1];
    lanbe4.text=@"身份证号码 :";
    lanbe4.textAlignment =NSTextAlignmentCenter;
    [view2 addSubview:lanbe4];
    
    self.textFNumber= [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/3, 62*ScreenWidth/375, ScreenWidth-ScreenWidth/3, 56*ScreenWidth/375)];
    self.textFNumber.backgroundColor = [UIColor whiteColor];
    self.textFNumber.placeholder = @"请输入您的身份证号码";
    [view2 addSubview:self.textFNumber];
    
}






#pragma mark - 
- (void)chuangjianP{
    _dataArray=[[NSMutableArray alloc] init];
    
    chvc = [[CalendarHomeViewController alloc]init];
    chvc.view.frame=CGRectMake(0,-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:chvc.view];
    
    
    [chvc setAirPlaneToDay:90 ToDateforString:nil];//飞机初始化方法
    
    [self mainViewClass:0];
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        
        NSLog(@"%@",[model toString]);
        
        if(model.style==CellDayTypeClick)
        {
            [_dataArray addObject:model.toString];
            
            NSSet *set = [NSSet setWithArray:_dataArray];
            _dataArray=[[set allObjects] mutableCopy];
            
            [_dataArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
                return [obj1 compare:obj2];
            }];
            
        }
        else
        {
            [_dataArray removeObject:model.toString];
            
        }
        
        [self mainViewClass:_dataArray.count];
        
    };
}


- (void)mainViewClass:(NSInteger)num
{
    
    [_mainView removeFromSuperview];
    
    _mainView=[[UIView alloc] init];
    _mainView.frame=CGRectMake(0, -self.view.frame.size.height,self.view.frame.size.width,50*ScreenWidth/320);
    _mainView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:_mainView];
    
    self.BEDateButtom=[UIButton buttonWithType:UIButtonTypeSystem];
    self.BEDateButtom.frame=CGRectMake(0, 500, 2,5);
    self.BEDateButtom.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:141.0/255.0 blue:26/255.0 alpha:1];
    [self.BEDateButtom addTarget:self action:@selector(BEDateButtomAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:self.BEDateButtom];
    
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lable.font=[UIFont systemFontOfSize:14.0f*ScreenWidth/320];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [_mainView addSubview:lable];
    
//    self.BeginDatetime=nil;
//    self.EndDatetime=nil;
    
    if(num==0)
    {
        lable.text=@"请选择入住时间";
        
    }
    if(num==1)
    {
        _mainView.frame=CGRectMake(0, self.view.frame.size.height-50*ScreenWidth/320,self.view.frame.size.width,50*ScreenWidth/320);
        lable.text=@"请选择离店时间";
        
    }
    if(num==2)
    {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate* date1 = [formatter dateFromString:[_dataArray objectAtIndex:0]];
        NSDate* date2 = [formatter dateFromString:[_dataArray objectAtIndex:1]];
        
        
        NSLog(@"%@",date1);
        NSLog(@"%@",date2);
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date1 toDate:date2  options:0];
        
        self.days = [comps day]+1;
        
        _mainView.frame=CGRectMake(0, self.view.frame.size.height-50*ScreenWidth/320,self.view.frame.size.width,50*ScreenWidth/320);
        self.BEDateButtom.frame=CGRectMake(0, 0, self.view.frame.size.width,50*ScreenWidth/320);
        lable.text=[NSString stringWithFormat:@"%@入住---%@离开 共%ld天",[_dataArray objectAtIndex:0],[_dataArray objectAtIndex:1],(long)self.days];
       
        
        self.riqiDayL.text=[NSString stringWithFormat:@"共%ld天",(long)self.days];
        
    }
}

- (void)BEDateButtomAction{
    chvc.view.frame=CGRectMake(0,-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
   _mainView.frame=CGRectMake(0, -self.view.frame.size.height,self.view.frame.size.width,50*ScreenWidth/320);
    
    [self.riqixuanzhebutton3 setTitle:[_dataArray objectAtIndex:0] forState:UIControlStateNormal];
   [self.riqixuanzhebutton4 setTitle:[_dataArray objectAtIndex:1] forState:UIControlStateNormal];
    
    
}


- (void)jiaAction{
    if (self.p<4) {
        self.p++;
        
        if (self.p==4){
            self.yuDingCount.text=[NSString stringWithFormat:@"整套"];
        }else{
            self.yuDingCount.text=[NSString stringWithFormat:@"%ld间",(long)self.p];
        }
    }
}

- (void)jianAction{
    if (self.p>1) {
        self.p--;
        
        if (self.p==4){
            self.yuDingCount.text=[NSString stringWithFormat:@"整套"];
        }
        else{
            self.yuDingCount.text=[NSString stringWithFormat:@"%ld间",(long)self.p];
        }
    }
}
@end
