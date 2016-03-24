//
//  shareMethod.h
//  上下拉-刷新和加载
//
//  Created by 丘东昌 on 15/10/28.
//  Copyright © 2015年 丘东昌. All rights reserved.
//
#import "UIViewController+HUD.h"

#import <Foundation/Foundation.h>

//typedef void(^Block)(id);

@interface shareMethod : NSObject

+(instancetype)shareManger;//创建个单例

- (BOOL)isNetWork;

@property(nonatomic,retain)NSString * str;



@end
