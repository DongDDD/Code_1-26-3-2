//
//  founfOneTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//

#import "founfOneTableViewCell.h"

@implementation founfOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.HeadFounfmageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight/5)];
        [UIImageCutter cutImageAutoWithUIImageView:self.HeadFounfmageView urlString:@"http://pic31.nipic.com/20130728/8821914_172637249163_2.jpg"];
        [self.contentView addSubview:self.HeadFounfmageView];
        
#pragma mark -one
        self.travelsV=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2)];
        [UIImageCutter cutImageAutoWithUIImageView:self.travelsV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        self.travelsV.layer.borderWidth=0;
        self.travelsV.layer.cornerRadius=ScreenWidth/13;
        self.travelsV.layer.masksToBounds = YES;
        self.travelsV.layer.borderColor=[[UIColor redColor]CGColor];
        [self.contentView addSubview:self.travelsV];
        
        self.travelsLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/13, ScreenHight/4.6+(ScreenWidth/13)*2+(5*ScreenWidth/375), (ScreenWidth/13)*2, 20*ScreenWidth/375)];
        self.travelsLabel.font=[UIFont systemFontOfSize:17*ScreenWidth/375];
        self.travelsLabel.textColor=[UIColor grayColor];
        self.travelsLabel.text=@"游记";
        self.travelsLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:self.travelsLabel];
    
        UIButton*praise1=[UIButton buttonWithType:UIButtonTypeCustom];
        praise1.frame=CGRectMake(ScreenWidth/13, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2);
        praise1.backgroundColor=[UIColor clearColor];
        praise1.layer.borderWidth=0;
        praise1.layer.cornerRadius=ScreenWidth/13;
        praise1.layer.masksToBounds = YES;
        [praise1 addTarget:self action:@selector(travelsAction) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:praise1];
        
        #pragma mark -tow
        self.foodV=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth/13)*4, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2)];
        [UIImageCutter cutImageAutoWithUIImageView:self.foodV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        self.foodV.layer.borderWidth=0;
        self.foodV.layer.cornerRadius=ScreenWidth/13;
        self.foodV.layer.masksToBounds = YES;
        self.foodV.layer.borderColor=[[UIColor redColor]CGColor];
        [self.contentView addSubview:self.foodV];
        
        self.foodLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/13)*4, ScreenHight/4.6+(ScreenWidth/13)*2+(5*ScreenWidth/375), (ScreenWidth/13)*2, 20*ScreenWidth/375)];
        self.foodLabel.font=[UIFont systemFontOfSize:17*ScreenWidth/375];
        self.foodLabel.textColor=[UIColor grayColor];
        self.foodLabel.text=@"美食";
        self.foodLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:self.foodLabel];
        
        UIButton*praise2=[UIButton buttonWithType:UIButtonTypeCustom];
        praise2.frame=CGRectMake((ScreenWidth/13)*4, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2);
        praise2.backgroundColor=[UIColor clearColor];
        praise2.layer.borderWidth=0;
        praise2.layer.cornerRadius=ScreenWidth/13;
        praise2.layer.masksToBounds = YES;
        [praise2 addTarget:self action:@selector(foodAction) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:praise2];
        
        #pragma mark -three
        self.strategyV=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth/13)*7, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2)];
        [UIImageCutter cutImageAutoWithUIImageView:self.strategyV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        self.strategyV.layer.borderWidth=0;
        self.strategyV.layer.cornerRadius=ScreenWidth/13;
        self.strategyV.layer.masksToBounds = YES;
        self.strategyV.layer.borderColor=[[UIColor redColor]CGColor];
        [self.contentView addSubview:self.strategyV];
        
        self.strategyLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/13)*7, ScreenHight/4.6+(ScreenWidth/13)*2+(5*ScreenWidth/375), (ScreenWidth/13)*2, 20*ScreenWidth/375)];
        self.strategyLabel.font=[UIFont systemFontOfSize:17*ScreenWidth/375];
        self.strategyLabel.textColor=[UIColor grayColor];
        self.strategyLabel.text=@"攻略";
        self.strategyLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:self.strategyLabel];
        
        UIButton*praise3=[UIButton buttonWithType:UIButtonTypeCustom];
        praise3.frame=CGRectMake((ScreenWidth/13)*7, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2);
        praise3.backgroundColor=[UIColor clearColor];
        praise3.layer.borderWidth=0;
        praise3.layer.cornerRadius=ScreenWidth/13;
        praise3.layer.masksToBounds = YES;
        [praise3 addTarget:self action:@selector(strategyAction) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:praise3];
        
        #pragma mark -four
        self.forumV=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth/13)*10, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2)];
        [UIImageCutter cutImageAutoWithUIImageView:self.forumV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        self.forumV.layer.borderWidth=0;
        self.forumV.layer.cornerRadius=ScreenWidth/13;
        self.forumV.layer.masksToBounds = YES;
        self.forumV.layer.borderColor=[[UIColor redColor]CGColor];
        [self.contentView addSubview:self.forumV];
        
        self.forumLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/13)*10, ScreenHight/4.6+(ScreenWidth/13)*2+(5*ScreenWidth/375), (ScreenWidth/13)*2, 20*ScreenWidth/375)];
        self.forumLabel.font=[UIFont systemFontOfSize:17*ScreenWidth/375];
        self.forumLabel.textColor=[UIColor grayColor];
        self.forumLabel.text=@"论坛";
        self.forumLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:self.forumLabel];
        
        UIButton*praise4=[UIButton buttonWithType:UIButtonTypeCustom];
        praise4.frame=CGRectMake((ScreenWidth/13)*10, ScreenHight/4.6, (ScreenWidth/13)*2, (ScreenWidth/13)*2);
        praise4.backgroundColor=[UIColor clearColor];
        praise4.layer.borderWidth=0;
        praise4.layer.cornerRadius=ScreenWidth/13;
        praise4.layer.masksToBounds = YES;
        [praise4 addTarget:self action:@selector(forumAction) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:praise4];
        
//        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHight/4.6+(ScreenWidth/13)*2+5+25, ScreenWidth, 5)];
//        foot.backgroundColor=[UIColor grayColor];
//        foot.alpha=0.3;
//        [self.contentView addSubview:foot];
    }
    return self;
}

-(void)travelsAction{
    NSLog(@"youji");
}

-(void)foodAction{
    NSLog(@"美食");
}

-(void)strategyAction{
    NSLog(@"攻略");
}

-(void)forumAction{
    NSLog(@"论坛");
}

@end
