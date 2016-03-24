//
//  FiveTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//
#import "FiveTableViewCell.h"
#import "GYZCalendarView.h"
#import "DefineConst.h"
@implementation FiveTableViewCell

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
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7, 0, ScreenWidth-14, 2)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.3;
        [self.contentView addSubview:headS];

        self.timeYearV=[[UIView alloc]initWithFrame:CGRectMake(0, 2, ScreenWidth,(ScreenWidth/5)*3 )];
       
        
        GYZCalendarView *calendarView = [GYZCalendarView calendarWithDays:365 showType:CalendarShowTypeSingle frame:self.timeYearV.frame selectEnable:YES showChineseCalendar:NO];
        
        [self.timeYearV addSubview:calendarView];
        [self.contentView addSubview:self.timeYearV];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0,  (ScreenWidth/5)*3 +10*ScreenWidth/375, ScreenWidth, 5)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.3;
        [self.contentView addSubview:foot];
    }
    return self;
}
@end
