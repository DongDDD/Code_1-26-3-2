//
//  MyTableViewController.h
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "shareMethod.h"//单例
#import "UIViewController+HUD.h"//花

CG_INLINE
CGRect CGRectMakeWithScreen(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    CGFloat w = app.autoSizeScaleX;
    CGFloat h = app.autoSizeScaleY;
    return CGRectMake(x * w, y * h, width * w, height * h);
}

@interface MyTableViewController : UITableViewController

#pragma mark - 当令牌失效调用这个方法重新获取令牌
-(void)chongxinHuoquLingpai;


@property(nonatomic,copy)NSString *lingpai;//调用接口必要的令牌

@end
