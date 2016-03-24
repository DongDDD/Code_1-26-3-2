//
//  youJiTuiJianTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 东. All rights reserved.
//

#import "youJiTuiJianTableViewCell.h"

@implementation youJiTuiJianTableViewCell

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
        
        self.sayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10,ScreenWidth-20,(ScreenWidth-20)*0.47)];
        
        [UIImageCutter cutImageAutoWithUIImageView:self.sayImageView urlString:@"http://pic8.nipic.com/20100724/4704297_112542897536_2.jpg"];
        [self.contentView addSubview:self.sayImageView];
        
        UIView *titeView=[[UIView alloc]initWithFrame:CGRectMake(0, (355*0.47-53)*ScreenWidth/375, ScreenWidth-20, 52*ScreenWidth/375)];
        titeView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.35];
        [self.sayImageView addSubview:titeView];
        
        self.HeadImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, -(ScreenWidth/13), (ScreenWidth/13)*2, (ScreenWidth/13)*2)];
        [UIImageCutter cutImageAutoWithUIImageView:self.HeadImageView urlString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2531583001,1422407153&fm=116&gp=0.jpg"];
        self.HeadImageView.layer.borderWidth=1;
        self.HeadImageView.layer.cornerRadius=ScreenWidth/13;
        self.HeadImageView.layer.masksToBounds = YES;
        self.HeadImageView.layer.borderColor=[[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]CGColor];
        [titeView addSubview:self.HeadImageView];
        
        self.Title=[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375+(ScreenWidth/13)*2, 8, 355*ScreenWidth/375-(15*ScreenWidth/375+(ScreenWidth/13)*2), 13*ScreenWidth/375)];
        self.Title.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
        self.Title.textColor=[UIColor whiteColor];
        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.Title.text=@"冬菇鸡腿－王 ／ 2015－12-20";
        self.Title.textAlignment =NSTextAlignmentLeft;
        [titeView addSubview:self.Title];
        
        UIImageView *mapRoom=[[UIImageView alloc]initWithFrame:CGRectMake(15*ScreenWidth/375+(ScreenWidth/13)*2, 28*ScreenWidth/375, 15+2*ScreenWidth/375, 20+2*ScreenWidth/375)];
        mapRoom.image=[UIImage imageNamed:@"地点图标"];
        [titeView addSubview:mapRoom];
        
        self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(35*ScreenWidth/375+(ScreenWidth/13)*2, 28*ScreenWidth/375,80*ScreenWidth/375, 25+2*ScreenWidth/375)];
        self.addressLabel.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
        self.addressLabel.textColor=[UIColor whiteColor];
        self.addressLabel.text=@"广州从化";
        self.addressLabel.textAlignment =NSTextAlignmentLeft;
        [titeView addSubview:self.addressLabel];
    }
    return self;
}


@end
