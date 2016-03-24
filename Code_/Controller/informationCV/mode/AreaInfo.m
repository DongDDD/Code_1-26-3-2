//
//  AreaInfo.m
//  Code_
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 东. All rights reserved.
//

#import "AreaInfo.h"

@implementation AreaInfo

+ (instancetype)AreaInfoWithDictionary:(NSDictionary *)dictionary{
    AreaInfo *area = [[AreaInfo alloc]init];
    area.AreaName = [dictionary valueForKey:@"AreaName"];
    area.AreaId = [dictionary valueForKey:@"AreaId"];
    area.AreaWBS = [dictionary valueForKey:@"AreaWBS"];
    area.SearchKey = [dictionary valueForKey:@"SearchKey"];
    area.ZM = [dictionary valueForKey:@"ZM"];
    return area;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
