//
//  foundtowTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//

#import "foundtowTableViewCell.h"

@implementation foundtowTableViewCell

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
       self.mengpiaoV=[[UIImageView alloc]initWithFrame:CGRectMake(6*ScreenWidth/375, 10*ScreenWidth/375, ScreenWidth/3.5, (ScreenWidth/3.5)*0.7)];
        [UIImageCutter cutImageAutoWithUIImageView:self.mengpiaoV urlString:@"http://pic31.nipic.com/20130728/8821914_172637249163_2.jpg"];
        [self.contentView addSubview:self.mengpiaoV];
        
        self.Title=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3.5+((6+8)*ScreenWidth/375), 10*ScreenWidth/375, ScreenWidth-ScreenWidth/3.5-((6+8)*ScreenWidth/375), 15*ScreenWidth/375)];
        self.Title.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        self.Title.textColor=[UIColor blackColor];
        self.Title.text=@"特色海鲜生态园";
        [self.contentView addSubview:self.Title];
        
        self.openTime=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3.5+(6+8*ScreenWidth/375), (10+15+8)*ScreenWidth/375, ScreenWidth-ScreenWidth/3.5-(6+8)*ScreenWidth/375, 15*ScreenWidth/375)];
        self.openTime.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        self.openTime.textColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
        self.openTime.text=@"开放时间 :  09:00 - 18 : 00";
        [self.contentView addSubview:self.openTime];
        
        self.mony=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3.5+((6+8)*ScreenWidth/375), (10+15+8+15+8)*ScreenWidth/375, ScreenWidth-ScreenWidth/3.5-((6+8)*ScreenWidth/375), 15*ScreenWidth/375)];
        self.mony.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        self.mony.textColor=[UIColor orangeColor];
        self.mony.text=@"价格 :  ¥ 289";
        [self.contentView addSubview:self.mony];
        
    }
    return self;
}

@end
