//
//  MyViewController.m
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//

#import "MyViewController.h"
#import "NSString+hash.h"
#import "LingpaiYuWangluoQingqiu.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bili = ScreenWidth/320.0;
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"亲当前网络异常,请检查网络!"];
        
    }else{
    
    LingpaiYuWangluoQingqiu *lingpai = [[LingpaiYuWangluoQingqiu alloc]init];
    _lingpai = [lingpai lingpai:1];
    NSLog(@"获取的令牌是%@",_lingpai);
}
    // Do any additional setup after loading the view.
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
-(void)zidingyiDaohanglan{
    _daohanglanBeijingImageView = [[UIImageView alloc]init];
    _daohanglanBeijingImageView.frame = CGRectMake(0, 0, ScreenWidth, 64);
    
    _daohanglanBeijingImageView.backgroundColor = [UIColor colorWithRed:38/255.0 green:173/255.0 blue:252/255.0 alpha:1];
    [self.view addSubview:_daohanglanBeijingImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2, 33, 200, 17)];
    _titleLabel.text = @"个人资料";
    
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:_titleLabel];
    
    _fanhuiButton = [[UIButton alloc]init];
    _fanhuiButton.frame = CGRectMake(13, 30, 15, 20);
    //_fanhuiButton.backgroundColor = [UIColor redColor];
    [_fanhuiButton setImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    
    [_fanhuiButton addTarget:self action:@selector(fanhuiButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_fanhuiButton];
}


/** 当令牌失效调用这个方法重新获取令牌*/
-(void)chongxinHuoquLingpai{
     if ([@"" isEqualToString:@""]) {
        LingpaiYuWangluoQingqiu *lingpai = [[LingpaiYuWangluoQingqiu alloc]init];
        
        _lingpai = [lingpai chongxinHuoquLingpai];
    }

}


-(void)fanhuiButtonClick{
 
    //把工具栏显示出来
    self.hidesBottomBarWhenPushed=NO;
    self.tabBarController.tabBar.hidden=NO;
    
 
    [self.navigationController popViewControllerAnimated:YES];
}
@end
