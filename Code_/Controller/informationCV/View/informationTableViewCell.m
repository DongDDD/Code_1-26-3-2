//
//  informationTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 东. All rights reserved.
//
#import "informationTableViewCell.h"

@implementation informationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.informationImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight/4)];
        
        [self.contentView addSubview:self.informationImageView];
        
        UIImageView *bottom=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/5-5, 10,ScreenWidth/5, (ScreenHight/4)/6)];
        bottom.image=[UIImage imageNamed:@"底"];
        [self.contentView addSubview:bottom];
        
        self.praise=[UIButton buttonWithType:UIButtonTypeCustom];
        self.praise.frame=CGRectMake(ScreenWidth/5-(ScreenWidth/5)/4-5+(ScreenWidth-ScreenWidth/5-5), 15, (ScreenWidth/5)/4, (ScreenHight/4)/6-10);
        [self.praise setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
         [self.praise addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:self.praise];

        self.praiseLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/5-(ScreenWidth/5)/4, (ScreenHight/4)/6)];
        self.praiseLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
        self.praiseLabel.textColor=[UIColor orangeColor];
        self.praiseLabel.text=@"288";
        self.praiseLabel.textAlignment =NSTextAlignmentCenter;
        [bottom addSubview:self.praiseLabel];
        
        UIButton*praise=[UIButton buttonWithType:UIButtonTypeCustom];
        praise.frame=CGRectMake(ScreenWidth-ScreenWidth/5-5, 10,ScreenWidth/5-((ScreenHight/4)/6-10), (ScreenHight/4)/6);
        praise.backgroundColor=[UIColor clearColor];
        [praise addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:praise];
        
        UIImageView *bottom1=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/5-5, (ScreenHight/4)/6+(ScreenHight/4)/6,ScreenWidth/5, (ScreenHight/4)/6)];
        bottom1.image=[UIImage imageNamed:@"底"];
        [self.contentView addSubview:bottom1];
        
        self.share=[UIButton buttonWithType:UIButtonTypeCustom];
        self.share.frame=CGRectMake(ScreenWidth/5-(ScreenWidth/5)/4-5+(ScreenWidth-ScreenWidth/5-5), 5+((ScreenHight/4)/6+(ScreenHight/4)/6), (ScreenWidth/5)/4, (ScreenHight/4)/6-10);
        [self.share setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [self.share addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:self.share];
        
        self.shareLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/5-(ScreenWidth/5)/4, (ScreenHight/4)/6)];
        self.shareLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
        self.shareLabel.textColor=[UIColor orangeColor];
        self.shareLabel.text=@"288";
        self.shareLabel.textAlignment =NSTextAlignmentCenter;
        [bottom1 addSubview:self.shareLabel];
        
        UIButton*praise1=[UIButton buttonWithType:UIButtonTypeCustom];
        praise1.frame=CGRectMake(ScreenWidth-ScreenWidth/5-5, (ScreenHight/4)/6+(ScreenHight/4)/6,ScreenWidth/5-((ScreenHight/4)/6-10), (ScreenHight/4)/6);
        praise1.backgroundColor=[UIColor clearColor];
        [praise1 addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:praise1];
        
        self.Title=[[UILabel alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, ScreenHight/4+5*ScreenWidth/375, ScreenWidth-85*ScreenWidth/375, 15*ScreenWidth/375)];
        self.Title.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
        self.Title.textColor=[UIColor blackColor];
        
        [self.contentView addSubview:self.Title];
        
        self.money=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-80*ScreenWidth/375, ScreenHight/4+5*ScreenWidth/375, 80*ScreenWidth/375, 15*ScreenWidth/375)];
        self.money.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
        self.money.textColor=[UIColor orangeColor];
       
        self.money.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:self.money];
        
        self.BTitle=[[UILabel alloc]initWithFrame:CGRectMake(25*ScreenWidth/375, ScreenHight/4+30*ScreenWidth/375, ScreenWidth-25*ScreenWidth/375, 13*ScreenWidth/375)];
        self.BTitle.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        self.BTitle.textColor=[UIColor grayColor];
        
        [self.contentView addSubview:self.BTitle];
        
        self.mapRoom=[[UIImageView alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, ScreenHight/4+25*ScreenWidth/375, 15*ScreenWidth/375, 20*ScreenWidth/375)];
        self.mapRoom.image=[UIImage imageNamed:@"地点图标 222"];
        [self.contentView addSubview:self.mapRoom];
        
        self.rooms=[[UILabel alloc]initWithFrame:CGRectMake(5*ScreenWidth/375,  ScreenHight/4+50*ScreenWidth/375, 50*ScreenWidth/375, 13*ScreenWidth/375)];
        self.rooms.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        self.rooms.textColor=[UIColor orangeColor];
        self.rooms.text=@"单间";
        [self.contentView addSubview:self.rooms];
        
        self.bookingCount=[[UILabel alloc]initWithFrame:CGRectMake(75*ScreenWidth/375, ScreenHight/4+50*ScreenWidth/375, ScreenWidth-75*ScreenWidth/375, 13*ScreenWidth/375)];
        self.bookingCount.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        self.bookingCount.textColor=[UIColor orangeColor];
//        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.bookingCount.text=@"已经订50次";
        [self.contentView addSubview:self.bookingCount];
        
        
    }
    return self;
}

- (void)setInforma:(informaAmode *)informa{
    if (_informa !=informa) {
        
    }
    [UIImageCutter cutImageAutoWithUIImageView:self.informationImageView urlString:informa.HighImg];
    self.Title.text=informa.HouseName;
    self.money.text=informa.SalePrice;
    self.BTitle.text=informa.HoseAddr;
}

- (void)praiseAction:(id)sender {
    NSLog(@"点击👍");
}
- (void)shareAction:(id)sender {
    NSLog(@"点击分享");
}





@end
