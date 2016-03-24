//
//  PersonalInformation.m
//  Code_
//
//  Created by admin on 16/3/4.
//  Copyright © 2016年 lansi All rights reserved.
//

#import "PersonalInformation.h"

@implementation PersonalInformation

+ (instancetype)PersonInfoWithDictionary:(NSDictionary *)dictionary{
    
    PersonalInformation *personal = [[PersonalInformation alloc]init];
    personal.MembId = [dictionary valueForKey:@"MembId"];
    personal.LoginName = [dictionary valueForKey:@"LoginName"];
    personal.NickName = [dictionary valueForKey:@"NickName"];
    
    personal.IDCard = [dictionary valueForKey:@"IDCard"];
    personal.RealName = [dictionary valueForKey:@"RealName"];
   // personal.Sex = [dictionary valueForKey:@"Sex"];
    personal.Tel = [dictionary valueForKey:@"Tel"];
    return personal;
    
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



@end
