//
//  LingpaiYuWangluoQingqiu.h
//  Code_
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AppDelegate.h"
#import <Foundation/Foundation.h>

@interface LingpaiYuWangluoQingqiu : NSObject

@property (nonatomic,copy)NSString *lingpaiStr;
@property (nonatomic,strong)id data;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,assign)NSInteger lingpaiNum;

-(id)qingqiushujuWithUrlString:(NSString *)url withNSDictionary:(NSDictionary *)dict;
/** 获取令牌，1是获取，0是令牌失效再获取*/
-(NSString *)lingpai:(int)num;//获取令牌，1是获取，0是令牌失效再获取
-(NSString *)chongxinHuoquLingpai;//令牌失效，重新获取令牌

@end
