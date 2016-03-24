//
//  AccountViewCell.h
//  Code_
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 lansi All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInformation.h"

@interface AccountViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *Name;
@property (nonatomic,retain)UILabel *NameL;
@property (nonatomic,retain)UILabel *Card;
@property (nonatomic,retain)UILabel *CardL;
@property (nonatomic,retain)UILabel *Phone;
@property (nonatomic,retain)UILabel *PhoneL;
@property (nonatomic,retain)UILabel *Sex;
@property (nonatomic,retain)UILabel *SexL;
@property (nonatomic,retain)PersonalInformation *info;

@end
