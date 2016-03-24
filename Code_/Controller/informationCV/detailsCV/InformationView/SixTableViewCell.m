//
//  SixTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AutoAdjustFrame.h"
#import "SixTableViewCell.h"

@implementation SixTableViewCell

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
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 0, 361*ScreenWidth/375, 2*ScreenWidth/375)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.3;
        [self.contentView addSubview:headS];
        
        NSString *str=@"注意检查为你所配备的用品是否齐全,有无损坏,如有不全或破损,请立即向有关服务人员报告";
        self.contentL=[[UILabel alloc]init];
        self.contentL.text=[str stringByReplacingOccurrencesOfString:@"<br />" withString:@" "];
        self.contentL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
        self.contentL.frame=CGRectMake(15*ScreenWidth/375, 20*ScreenWidth/375, 345*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]);
        self.contentL.textColor=[UIColor grayColor];
        self.contentL.numberOfLines=0;
        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.contentL.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.contentL];
        
//        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+30*ScreenWidth/375, ScreenWidth, 5*ScreenWidth/375)];
//        foot.backgroundColor=[UIColor grayColor];
//        foot.alpha=0.3;
//        [self.contentView addSubview:foot];
    }
    return self;
}

@end
