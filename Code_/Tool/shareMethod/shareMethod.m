//
//  shareMethod.m
//  上下拉-刷新和加载
//
//  Created by 丘东昌 on 15/10/28.
//  Copyright © 2015年 丘东昌. All rights reserved.
//
#import <AFNetworking.h>
#import "shareMethod.h"
#import <Reachability.h>//网络监测


@implementation shareMethod


+(instancetype)shareManger
{
    static shareMethod *share=nil;
    @synchronized(self){
        if (share==nil) {
            share=[[shareMethod alloc]init];
        }
    }
    
    return share;
}


//判断网络状态
- (BOOL)isNetWork{
    BOOL isNetWork = NO;
    //创建网络监测对象
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
        {
            NSLog(@"当前没有网络");
            isNetWork = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"当前为WiFi状态下");
            isNetWork = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"当前为2G/3G网络");
            isNetWork = YES;
            break;
        }
            
            
        default:
            break;
    }
    return isNetWork;//将监测的bool值返回出去。
    
}





@end
