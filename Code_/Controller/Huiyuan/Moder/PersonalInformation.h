//
//  PersonalInformation.h
//  Code_
//
//  Created by admin on 16/3/4.
//  Copyright © 2016年 lansi All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInformation : NSObject

@property (nonatomic,retain) NSString *MembId;//会员ID
@property (nonatomic,retain) NSString *LoginName;
@property (nonatomic,retain) NSString *NickName;
@property (nonatomic,retain) NSString *RealName;//真实名字
@property (nonatomic,assign) NSInteger Sex;//性别
@property (nonatomic,retain) NSString *IDCard;//身份证
@property (nonatomic,retain) NSString *Email;
@property (nonatomic,retain) NSString *Tel;//电话号码
@property (nonatomic,retain) NSString *Phone;
@property (nonatomic,retain) NSString *QQ;
@property (nonatomic,retain) NSString *FacePic;//头像
@property (nonatomic,retain) NSString *BirthDay;//兴趣爱好
@property (nonatomic,retain) NSString *Address;
@property (nonatomic,retain) NSString *Hobbies;
@property (nonatomic,retain) NSString *AddrCode;
@property (nonatomic,retain) NSString *Grade;
@property (nonatomic,retain) NSString *RegTime;
@property (nonatomic,retain) NSString *LastLoginTime;
@property (nonatomic,retain) NSString *LastLoginIP;
@property (nonatomic,retain) NSString *Status;
@property (nonatomic,retain) NSString *MembType;
@property (nonatomic,retain) NSString *TotalIntegral;
@property (nonatomic,retain) NSString *TotalMoney;

@property (nonatomic,retain) NSString *Str;

+ (instancetype)PersonInfoWithDictionary:(NSDictionary *)dictionary;

@end
