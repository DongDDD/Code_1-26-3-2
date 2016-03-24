//
//  WSJOrderListTableViewCell.m
//  Code_
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 东. All rights reserved.
//

#import "WSJOrderListTableViewCell.h"

@implementation WSJOrderListTableViewCell

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
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
        view.backgroundColor=[UIColor clearColor];
        [self .contentView addSubview:view];
        
        
        UILabel *labelrrr =[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, ScreenHight/2, 340*ScreenWidth/375, 30*ScreenWidth/375)];
        labelrrr.font=[UIFont systemFontOfSize:20*ScreenWidth/375];
        labelrrr.textColor=[UIColor grayColor];
        labelrrr.text=@"亲! 赶快下单吧！";
        labelrrr.textAlignment =NSTextAlignmentCenter;
        [view addSubview:labelrrr];
    }
    return self;
}

@end
