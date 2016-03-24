//
//  oneTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//

#import "oneTableViewCell.h"

@implementation oneTableViewCell

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
        
        self.mapImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 0, ScreenWidth-20*ScreenWidth/375, ScreenHight/4.5)];
        [UIImageCutter cutImageAutoWithUIImageView:self.mapImageView urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        [self.contentView addSubview:self.mapImageView];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHight/4.5+5*ScreenWidth/375, ScreenWidth, 5*ScreenWidth/375)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.3;
        [self.contentView addSubview:foot];
    }
    return self;
}

@end
