//
//  UIViewController+HUD.m
//  LOMusic
//
//  Created by 丘东昌 on 15/9/29.
//  Copyright (c) 2015年 丘东昌. All rights reserved.
//
#import "MBProgressHUD.h"
#import "UIViewController+HUD.h"

@implementation UIViewController (HUD)


//显示菊花的效果
-(void)showHudInViewhint:(NSString *)string
{
    UIView *View=[[UIApplication sharedApplication].delegate window];//创建个window
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:View];
    HUD.tag=1000;
    HUD.labelText=string;
    [View addSubview:HUD];
    [HUD show:YES];
}


//隐藏菊花
-(void)showhide
{
//    获取所有的子视图,移除HUD
    NSArray *array=[[UIApplication sharedApplication].delegate window].subviews;
    for (UIView *view in array) {
        if (view.tag==1000) {
            [view removeFromSuperview];
        }
    }
    
}


//显示提示框
-(void)shoWHint:(NSString *)string
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    设置显示类型
    hud.mode=MBProgressHUDModeText;//枚举，好多类型
    hud.labelText=string;
    hud.yOffset=150.f;//距离底部的距离是多少
    [hud hide:YES afterDelay:2];//设置隐藏
    
}



@end
