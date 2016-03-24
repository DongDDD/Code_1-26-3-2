//
//  ThreeTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AutoAdjustFrame.h"
#import "ThreeTableViewCell.h"
#import "InformationDetailsModer.h"

@implementation ThreeTableViewCell

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
        
        self.headImageV=[[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 10*ScreenWidth/375, 50*ScreenWidth/375, 50*ScreenWidth/375)];
        [UIImageCutter cutImageAutoWithUIImageView:self.headImageV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        self.headImageV.layer.borderWidth=0;
        self.headImageV.layer.cornerRadius=25*ScreenWidth/375;
        self.headImageV.layer.masksToBounds = YES;
        self.headImageV.layer.borderColor=[[UIColor redColor]CGColor];
        [self.contentView addSubview:self.headImageV];
        
        UIView *dian=[[UIView alloc]initWithFrame:CGRectMake(65*ScreenWidth/375, 18*ScreenWidth/375, 6*ScreenWidth/375, 6*ScreenWidth/375)];
        dian.backgroundColor=[UIColor blackColor];
        dian.layer.borderWidth=0;
        dian.layer.cornerRadius=3*ScreenWidth/375;
        dian.layer.borderColor=[[UIColor whiteColor]CGColor];
        [self.contentView addSubview:dian];
        
        self.nameL=[[UILabel alloc]initWithFrame:CGRectMake(72*ScreenWidth/375, 17*ScreenWidth/375, 303*ScreenWidth/375, 11*ScreenWidth/375)];
        self.nameL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
        self.nameL.textColor=[UIColor blackColor];
        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.nameL.text=@"一楼 :";
        self.nameL.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameL];
        //-----------房屋描述
//        InformationDetailsModer *infomodel=[[InformationDetailsModer alloc]init];   
//        NSString *str=infomodel.Description;
//        NSLog(@"＝＝＝＝房屋描述:%@",infomodel.Description);
        NSString *str=@"千岛湖老田庄游多多客栈，位于千岛湖上一处港湾小村落中，静谧的小山村只有十几户人家，它是避开喧嚣的都市人群，静享着田园生活的好去处，距市区约20分钟车程，老田庄有别于一些古镇上的民居，并非强调“原住”和“古味”的感觉；也非简单的“归园田居”的普通农庄，而是蕴含淳安地域文化与日常生活休闲文化若即若离的交融，既有山乡田园的野趣，又有现代的舒适温馨。“田庄以老为贵，朋友亦然”是一位老画家在老田庄有感而题写，这里有着热情的掌柜接待着您，小村落的宁静，好客皆在这里延伸着……";
        self.contentL=[[UILabel alloc]init];
        self.contentL.text=[str stringByReplacingOccurrencesOfString:@"<br />" withString:@" "];
        self.contentL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
        self.contentL.frame=CGRectMake(65*ScreenWidth/375, 35*ScreenWidth/375, 305*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+5);
        
        self.contentL.textColor=[UIColor grayColor];
        self.contentL.numberOfLines=0;
        self.contentL.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.contentL];

 
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+55*ScreenWidth/375, ScreenWidth, 5*ScreenWidth/375)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.3;
        [self.contentView addSubview:foot];
    }
    return self;
}

@end
