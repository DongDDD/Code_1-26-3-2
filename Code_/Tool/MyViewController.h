//
//  MyViewController.h
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "UIImageView+WebCache.h"
#import "UIImageCutter.h"
#import "shareMethod.h"//单例
#import "UIViewController+HUD.h"//花
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>

CG_INLINE //添加CGRectMake1
CGRect CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX; rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX; rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}


CG_INLINE
CGRect CGRectMakeWithScreen1(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    CGFloat w = app.autoSizeScaleX;
    CGFloat h = app.autoSizeScaleY;
    return CGRectMake(x * w, y * h, width * w, height * h);
}

CG_INLINE
CGSize CGSizeMakeWithScreen2(CGFloat width,CGFloat height){
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    CGFloat w1 = app.autoSizeScaleX;
    CGFloat h1 = app.autoSizeScaleY;
    return CGSizeMake(w1*width, h1*height);
    
}

CG_INLINE
CGPoint CGPointMakeWithScreen3(CGFloat x,CGFloat y){
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    CGFloat w2 = app.autoSizeScaleX;
    CGFloat h2 = app.autoSizeScaleY;
    return CGPointMake(w2*x, h2*y);
    
}



@interface MyViewController : UIViewController

@property(nonatomic,assign)float bili;
@property(nonatomic,strong)UIImageView *daohanglanBeijingImageView;
@property(nonatomic,copy)UILabel *titleLabel;
@property(nonatomic,copy)NSString *lingpai;//调用接口必要的令牌
@property(nonatomic,strong)UIButton *fanhuiButton;


#pragma mark - 自定义导航栏
-(void)zidingyiDaohanglan;
#pragma mark - 导航栏左键点击方法
-(void)fanhuiButtonClick;
#pragma mark - 当令牌失效调用这个方法重新获取令牌
-(void)chongxinHuoquLingpai;
@end
