//
//  XNTabBarController.m
//
//  Created by neng on 14-6-19.
//  Copyright (c) 2014年 neng. All rights reserved.
//
#import "Common.h"
#import "XNTabBarController.h"
#import "XNTabBarButton.h"
#import "XNTabBar.h"

#import "HomeViewController.h"
#import "FoundViewController.h"
#import "OrderlistViewController.h"
//#import "MemberViewController.h"
#import "LoginViewController.h"
@interface XNTabBarController () <XNTabBarDelegate>
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation XNTabBarController

- (void)viewDidLoad {
	[super viewDidLoad];


    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1]];
    
    [self _Controller];
	//删除现有的tabBar
	CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    LogFrame(self.tabBar);
//	[self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条

	//测试添加自己的视图
	XNTabBar *myView = [[XNTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
	myView.delegate = self; //设置代理
	myView.frame = rect;
	[self.tabBar addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    
    //为控制器添加按钮
    for (int i=0; i<self.viewControllers.count; i++) { //根据有多少个子视图控制器来进行添加按钮
        if (ScreenHight>736) {
            NSString *imageName = [NSString stringWithFormat:@"标签%d", i + 5];
            NSString *imageNameSel = [NSString stringWithFormat:@"1标签%d", i + 5];
            UIImage *image = [UIImage imageNamed:imageName];
            UIImage *imageSel = [UIImage imageNamed:imageNameSel];
            [myView addButtonWithImage:image selectedImage:imageSel];
        }else{
            
            NSString *imageName = [NSString stringWithFormat:@"标签%d", i + 1];
            NSString *imageNameSel = [NSString stringWithFormat:@"1标签%d", i + 1];
            UIImage *image = [UIImage imageNamed:imageName];
            UIImage *imageSel = [UIImage imageNamed:imageNameSel];
            [myView addButtonWithImage:image selectedImage:imageSel];
        }
        
        
        
    }
    

}

/**永远别忘记设置代理*/
- (void)tabBar:(XNTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
	self.selectedIndex = to;
}


- (void)_Controller{
    HomeViewController *HomeVC=[[HomeViewController alloc]init];
    FoundViewController *FoundVC=[[FoundViewController alloc]init];
    OrderlistViewController *informationVC=[[OrderlistViewController alloc]init];
    LoginViewController *MemberVC=[[LoginViewController alloc]init];
    
#pragma mark - 3.   把视图控制器放在导航栏上
    UINavigationController *HomeNavC=[[UINavigationController alloc]initWithRootViewController:HomeVC];
    
    UINavigationController *FoundC=[[UINavigationController alloc]initWithRootViewController:FoundVC];
    
    UINavigationController *informationNavC=[[UINavigationController alloc]initWithRootViewController:informationVC];
    
    UINavigationController *MemberNavC=[[UINavigationController alloc]initWithRootViewController:MemberVC];
    
    self.viewControllers=@[HomeNavC,FoundC,informationNavC,MemberNavC];
}

@end
