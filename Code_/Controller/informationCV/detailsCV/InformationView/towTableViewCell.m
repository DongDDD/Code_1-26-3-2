//
//  towTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AutoAdjustFrame.h"
#import "towTableViewCell.h"

@implementation towTableViewCell

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
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 0, ScreenWidth-14*ScreenWidth/375, 2*ScreenWidth/375)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.3;
        [self.contentView addSubview:headS];
        
        self.headImageV=[[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 10*ScreenWidth/375, 50*ScreenWidth/375, 50*ScreenWidth/375)];
        [UIImageCutter cutImageAutoWithUIImageView:self.headImageV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        self.headImageV.layer.borderWidth=0;
        self.headImageV.layer.cornerRadius=25*ScreenWidth/375;
        self.headImageV.layer.masksToBounds = YES;
        self.headImageV.layer.borderColor=[[UIColor clearColor]CGColor];
        [self.contentView addSubview:self.headImageV];
        
        self.nameL=[[UILabel alloc]initWithFrame:CGRectMake(65*ScreenWidth/375, 18*ScreenWidth/375, ScreenWidth-65*ScreenWidth/375, 11*ScreenWidth/375)];
        self.nameL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
        self.nameL.textColor=[UIColor grayColor];
        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.nameL.text=@"黄牛东       2015年11月11日入住";
        self.nameL.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameL];
        
        NSString *str=@"第一次入住，就得到了非常棒的入住体验，房间非常温馨，有一种回家的感觉。";
        self.contentL=[[UILabel alloc]init];
        self.contentL.text=[str stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        self.contentL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
        self.contentL.frame=CGRectMake(65*ScreenWidth/375, 35*ScreenWidth/375, ScreenWidth-70*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth-70*ScreenWidth/375]);
        self.contentL.textColor=[UIColor grayColor];
        self.contentL.numberOfLines=0;
        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.contentL.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.contentL];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+65*ScreenWidth/375, ScreenWidth, 5*ScreenWidth/375)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.3;
        [self.contentView addSubview:foot];
    }
    return self;
}


@end
