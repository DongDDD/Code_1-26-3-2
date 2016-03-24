//
//  SevenTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//

#import "SevenTableViewCell.h"

@implementation SevenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {            //(ScreenWidth-20)/2, (ScreenWidth-20)/4)
        for (int i = 0; i < 4; i++) {
            
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(9*ScreenWidth/375+(i%2)*(370*ScreenWidth/375)/2, (i/2)*((355*ScreenWidth/375)/4+45*ScreenWidth/375)+5*ScreenWidth/375, (355*ScreenWidth/375)/2, (355*ScreenWidth/375)/4+35*ScreenWidth/375+5)];
            view.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
            [self.contentView addSubview:view];
            
            self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (355*ScreenWidth/375)/2, (355*ScreenWidth/375)/4)];
            self.imageV.tag=i+1;
            [UIImageCutter cutImageAutoWithUIImageView:self.imageV urlString:@"http://pic31.nipic.com/20130728/8821914_172637249163_2.jpg"];
            [view addSubview:self.imageV];
            
            self.Titelabel= [[UILabel alloc]initWithFrame:CGRectMake(2*ScreenWidth/375, (ScreenWidth-20)/4, (ScreenWidth-20)/2-4*ScreenWidth/375, 15*ScreenWidth/375)];
            self.Titelabel.textAlignment = NSTextAlignmentLeft;
            self.Titelabel.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
            self.Titelabel.tag=i+1;
            self.Titelabel.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
            self.Titelabel.text=@"广东省是生生世世生生世世";
            [view addSubview:self.Titelabel];
            
            self.citLabel= [[UILabel alloc]initWithFrame:CGRectMake(2*ScreenWidth/375, (ScreenWidth-20)/4+20*ScreenWidth/375, (ScreenWidth-20)/2-44*ScreenWidth/375, 10*ScreenWidth/375+3)];
            self.citLabel.textAlignment = NSTextAlignmentLeft;
            self.citLabel.textColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            self.citLabel.tag=i+1;
            self.citLabel.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
            self.citLabel.text=@"广东省是";
            [view addSubview:self.citLabel];
            
            self.monyLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-20)/2-44*ScreenWidth/375, (ScreenWidth-20)/4+20*ScreenWidth/375, 40*ScreenWidth/375, 10*ScreenWidth/375)];
            self.monyLabel.textAlignment = NSTextAlignmentLeft;
            self.monyLabel.textColor=[UIColor orangeColor];
            self.monyLabel.tag=i+1;
            self.monyLabel.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
            self.monyLabel.text=@"¥ 128 ";
            [view addSubview:self.monyLabel];
            
            UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
            butt.tag=i+1;
            butt.frame=CGRectMake(9+(i%2)*(ScreenWidth-5)/2, (i/2)*((ScreenWidth-20)/4+40)+5, (ScreenWidth-20)/2, (ScreenWidth-20)/4+35*ScreenWidth/375);
            butt.backgroundColor=[UIColor clearColor];
            [butt addTarget:self action:@selector(selectButtionWithTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:butt];
            
            
        }
    }
    return self;
}


- (void)selectButtionWithTag:(UIButton*)butt{
    NSLog(@"点击了%ld",butt.tag);
//   NSLog(@"点击了图片%@",_photoArr[butt.tag]);
}

@end
