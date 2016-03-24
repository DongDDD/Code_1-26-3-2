//
//  WodeJifenViewController.m
//  Code_
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 东. All rights reserved.
//

#import "WodeJifenViewController.h"
//#import "MemberViewController.h"
#import "LoginViewController.h"
@interface WodeJifenViewController ()

@end

@implementation WodeJifenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"我的积分";
    
    //把工具栏隐藏掉
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    //把工具栏显示出来
    self.hidesBottomBarWhenPushed=NO;
    self.tabBarController.tabBar.hidden=NO;

//    
//    self.navigationController.toolbarHidden = NO;
//    //self.tabBarController.hidesBottomBarWhenPushed = NO;
//    self.navigationController.tabBarController.hidesBottomBarWhenPushed = NO;
    
    //self.hidesBottomBarWhenPushed
    //self.tabBarController.tabBar
    // 显示工具栏
    
}


-(void)fanhuiButtonClick{
    LoginViewController *meber = [[LoginViewController alloc]init];
    
    //把工具栏显示出来
    self.hidesBottomBarWhenPushed=NO;
    self.tabBarController.tabBar.hidden=NO;

    [self.navigationController pushViewController:meber animated:YES];
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
