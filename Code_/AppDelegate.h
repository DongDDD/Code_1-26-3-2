//
//  AppDelegate.h
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import "shareMethod.h"//单例
#import "UIViewController+HUD.h"//花
#import "MJRefreshHeaderView.h"//头
#import "MJRefreshFooterView.h"//尾
#import "MJRefresh.h"//刷新
#import <UIKit/UIKit.h>

#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign)float autoSizeScaleX;
@property (nonatomic,assign)float autoSizeScaleY;

@end

