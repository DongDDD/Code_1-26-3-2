//
//  AppDelegate.m
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import "XNTabBarController.h"
#import <MAMapKit/MAMapKit.h>
#import "MyTabBarController.h"
#import "AppDelegate.h"
#import "TuiJianPage.h"

#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
//
////修改CGRectMake
//CG_INLINE CGRect
//CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//{
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    CGRect rect;
//    rect.origin.x = x * myDelegate.autoSizeScaleX; rect.origin.y = y * myDelegate.autoSizeScaleY;
//    rect.size.width = width * myDelegate.autoSizeScaleX; rect.size.height = height * myDelegate.autoSizeScaleY;
//    return rect;
//}


@interface AppDelegate ()

@end

@implementation AppDelegate



- (void)configureAPIKey
{
    
    [MAMapServices sharedServices].apiKey = @"e41eb1c7065178fc6abe86602227f966";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    int a=375;
    int b=667;
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];//设置全局状态栏颜色
    [application setStatusBarHidden:NO]; //启动的时候设置显示, 启动后要打开
    
    //    应用程序一开始来获取比例系数
    self.autoSizeScaleX=ScreenWidth/a;
    self.autoSizeScaleY=ScreenHight/b;
    
    [self configureAPIKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
#pragma mark -初始化TabBarController----
//    MyTabBarController *tabBarC=[[MyTabBarController alloc]init];
//    self.window.rootViewController=tabBarC;
    
    
    
    XNTabBarController *tabBarC=[[XNTabBarController alloc]init];
    self.window.rootViewController=tabBarC;
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if(ScreenHight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    
    
    //向微信注册
    [WXApi registerApp:@"wx6f380c6efd03d7cb" withDescription:@"demo 2.0"];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}




- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"返回的支付结果1 result = %@",resultDic);//返回的支付结果
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"返回的支付结果3  result = %@",resultDic);
        }];
    }
    return YES;
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

@end
