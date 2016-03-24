//
//  AccountViewCell.m
//  Code_
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 lansi All rights reserved.
//

#import "AccountViewCell.h"
#import "MyTableViewCell.h"

@implementation AccountViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.Name = [[UILabel alloc]init];
        self.Name.frame = CGRectMake(10*ScreenWidth/375, 0, 60*ScreenWidth/375, 40*ScreenWidth/375);
        self.Name.text = @"用户名";
        self.Name.textColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
        [self.Name setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:18*ScreenWidth/375]];
        //self.Name.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.Name];
        self.NameL = [[UILabel alloc]init];
        self.NameL.frame = CGRectMake(80*ScreenWidth/375, 0, 200*ScreenWidth/375, 40*ScreenWidth/375);
        self.NameL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
        //self.NameL.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.NameL];
        
        self.Sex = [[UILabel alloc]init];
        self.Sex.frame = CGRectMake(10*ScreenWidth/375, 40*ScreenWidth/375, 60*ScreenWidth/375, 40*ScreenWidth/375);
        self.Sex.text = @"性    别";
        self.Sex.textColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
        [self.Sex setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:18*ScreenWidth/375]];
        self.Sex.textColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
        //self.Sex.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.Sex];
        self.SexL = [[UILabel alloc]init];
        self.SexL.frame = CGRectMake(80*ScreenWidth/375, 40*ScreenWidth/375, 200*ScreenWidth/375, 40*ScreenWidth/375);
        self.SexL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
        //self.SexL.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.SexL];
        
        self.Phone = [[UILabel alloc]init];
        self.Phone.frame = CGRectMake(10*ScreenWidth/375, 80*ScreenWidth/375, 60*ScreenWidth/375, 40*ScreenWidth/375);
        [self.Phone setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:18*ScreenWidth/375]];
        self.Phone.text = @"手    机";
        self.Phone.textColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
        //self.Phone.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.Phone];
        self.PhoneL = [[UILabel alloc]init];
        self.PhoneL.frame = CGRectMake(80*ScreenWidth/375, 80*ScreenWidth/375, 200*ScreenWidth/375, 40*ScreenWidth/375);
        self.PhoneL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
        //self.PhoneL.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.PhoneL];
        
        self.Card = [[UILabel alloc]init];
        self.Card.frame = CGRectMake(10*ScreenWidth/375, 120*ScreenWidth/375, 60*ScreenWidth/375, 40*ScreenWidth/375);
        self.Card.text = @"身份证";
        self.Card.textColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
        [self.Card setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:18*ScreenWidth/375]];
        //self.Card.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.Card];
        self.CardL = [[UILabel alloc]init];
        self.CardL.frame = CGRectMake(80*ScreenWidth/375, 120*ScreenWidth/375, 200*ScreenWidth/375, 40*ScreenWidth/375);
        self.CardL.font = [UIFont systemFontOfSize:18*ScreenWidth/375];
        //self.CardL.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.CardL];
        

        
    }
    return self;
}

- (void)setInfo:(PersonalInformation *)info{
    if (_info != info) {
        self.NameL.text = info.RealName;
        self.CardL.text = info.IDCard;
        self.PhoneL.text = info.Tel;
        if (info.Sex == 0) {
            self.SexL.text = @"男";
        }else{
            self.SexL.text = @"女";
        }
        
        
    }
}


@end
