//
//  MyTabBarController.m
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import "HomeViewController.h"
#import "FoundViewController.h"
#import "informationViewController.h"
#import "MemberViewController.h"


#import "MyTabBarController.h"
#define width  self.view.bounds.size.width/4
@interface MyTabBarController ()

@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation MyTabBarController

- (void)_Controller{
    HomeViewController *HomeVC=[[HomeViewController alloc]init];
    FoundViewController *FoundVC=[[FoundViewController alloc]init];
    informationViewController *informationVC=[[informationViewController alloc]init];
    MemberViewController *MemberVC=[[MemberViewController alloc]init];
   
#pragma mark - 3.   把视图控制器放在导航栏上
    UINavigationController *HomeNavC=[[UINavigationController alloc]initWithRootViewController:HomeVC];
    
    UINavigationController *FoundC=[[UINavigationController alloc]initWithRootViewController:FoundVC];
    
    UINavigationController *informationNavC=[[UINavigationController alloc]initWithRootViewController:informationVC];
    
    UINavigationController *MemberNavC=[[UINavigationController alloc]initWithRootViewController:MemberVC];
    
     self.viewControllers=@[HomeNavC,informationNavC,FoundC,MemberNavC];
}

- (void)_careTabBarController{
    UITabBar *tabbar=self.tabBar;
    tabbar.backgroundColor=[UIColor whiteColor];
//    手动移除标签栏上的子视图
    NSArray *subviews=tabbar.subviews;
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
//    自定义
    for (int i = 0; i<4; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(width *i, 0, width, 49);
        NSString *imageName=[NSString stringWithFormat:@"标签%d",i+1];
        [but setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        but.tag= i +1;
        [tabbar addSubview:but];
        
              //设置刚进入时,第一个按钮为选中状态
              if (0 == i) {
                  but.selected = YES;
                  self.selectedBtn = but;  //设置该按钮为选中的按钮
              }
       
    }
//    创建选中视图
    
    
}




- (void)butAction:(UIButton *)button{
    
   
    
      //1.先将之前选中的按钮设置为未选中
      self.selectedBtn.selected = NO;
      //2.再将当前按钮设置为选中
      button.selected = YES;
      //3.最后把当前按钮赋值为之前选中的按钮
      self.selectedBtn = button;
    
        //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
        self.selectedIndex = button.tag-1;
    
    if (button.selected==NO) {
     
         [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",button.tag+1]] forState:UIControlStateNormal];
        button.selected=YES;
        
    }else{
          [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",button.tag-1]] forState:UIControlStateSelected];
        button.selected=NO;
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1]];
    
    
    [self _Controller];
    [self _careTabBarController];
    
//#pragma mark - 2. 加上 tabBarItem
//#pragma mark -.tabBar外观设置
//        self.tabBar.tintColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
//        
//        self.tabBar.barTintColor=[UIColor whiteColor];
//        
//        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1]];
//        
//        
//#pragma mark - 1.  初始化。
//        HomeViewController *HomeVC=[[HomeViewController alloc]init];
//        FoundViewController *FoundVC=[[FoundViewController alloc]init];
//        informationViewController *informationVC=[[informationViewController alloc]init];
//        MemberViewController *MemberVC=[[MemberViewController alloc]init];
//        
//
//        #pragma mark - 2. 加上 tabBarItem
//        HomeVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"修改首页"] tag:10];
//
//        
//        
//        FoundVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"修改发现"] tag:11];
//        //    FoundVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"发现选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        
//        informationVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"信息" image:[UIImage imageNamed:@"修改列表"] tag:9];
//        //    informationVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"信息选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        
//        MemberVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"会员" image:[UIImage imageNamed:@"修改会员"] tag:8];
//        //    MemberVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"会员选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        
//        [HomeVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                   [UIColor blackColor], UITextAttributeTextColor,
//                                                   [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                   [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                         forState:UIControlStateNormal];
//        [HomeVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                   [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1], UITextAttributeTextColor,
//                                                   [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                   [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                         forState:UIControlStateSelected];
//        
//        [FoundVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                    [UIColor blackColor], UITextAttributeTextColor,
//                                                    [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                    [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                          forState:UIControlStateNormal];
//        [FoundVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                    [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1], UITextAttributeTextColor,
//                                                    [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                    [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                          forState:UIControlStateSelected];
//        
//        [informationVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                          [UIColor blackColor], UITextAttributeTextColor,
//                                                          [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                          [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                                forState:UIControlStateNormal];
//        [informationVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                          [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1], UITextAttributeTextColor,
//                                                          [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                          [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                                forState:UIControlStateSelected];
//        
//        [MemberVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                     [UIColor blackColor], UITextAttributeTextColor,
//                                                     [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                     [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                           forState:UIControlStateNormal];
//        [MemberVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                     [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1], UITextAttributeTextColor,
//                                                     [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
//                                                     [UIFont fontWithName:@"Helvetica" size:14.0*ScreenWidth/375], UITextAttributeFont, nil]
//                                           forState:UIControlStateSelected];
//        
//#pragma mark - 3.   把视图控制器放在导航栏上
//        UINavigationController *HomeNavC=[[UINavigationController alloc]initWithRootViewController:HomeVC];
//        
//        UINavigationController *FoundC=[[UINavigationController alloc]initWithRootViewController:FoundVC];
//        
//        UINavigationController *informationNavC=[[UINavigationController alloc]initWithRootViewController:informationVC];
//        
//        UINavigationController *MemberNavC=[[UINavigationController alloc]initWithRootViewController:MemberVC];
//        
//#pragma mark - 4. 将导航栏加入标签视图
//        self.viewControllers=@[HomeNavC,informationNavC,FoundC,MemberNavC];
//        
//        self.delegate=self;
//        

    }
//}
//
//#pragma mark -代理
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    
//#pragma mark -
//    viewController.tabBarItem.badgeValue=nil;
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}




@end
