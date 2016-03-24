//
//  AreaInfo.h
//  Code_
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaInfo : NSObject

@property(nonatomic,assign)NSString * AreaId;
@property(nonatomic,retain)NSString * AreaName;//区域名称
@property(nonatomic,assign)NSString * FullName;
@property(nonatomic,assign)NSString * AreaWBS;
@property(nonatomic,assign)NSString * SearchKey;
@property(nonatomic,assign)NSString * ZM;
@property(nonatomic,assign)NSInteger * Items;//子级数据字段，如果大于0则有子级数据，一层一层嵌套

+ (instancetype)AreaInfoWithDictionary:(NSDictionary *)dictionary;

@end
