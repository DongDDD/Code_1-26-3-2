//
//  XiangcunFenxiangTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 东. All rights reserved.
//

#import "XiangcunFenxiangTableViewCell.h"

@implementation XiangcunFenxiangTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//乡村.家分享tableView内容赋值
-(void)setTheFenxiangTableViewCell:(NSDictionary *)dict{
    
    
    
    
    
    // _fangdongFenxiangLabel.text = dict[@""];
    // _fangdongTouxiangImageView.image = ;
    // _fangdongBeijingImageView.image = ;
    
    
    
    
    
    
    [self changeTheFrame];
    
    
    
}

-(void)changeTheFrame{
    _fangdongShangLabel.frame = CGRectMake(15*_bili, 3*_bili, 50*_bili, 18*_bili);
    _fangdongTouxiangImageView.frame = CGRectMake(13*_bili, 20*_bili, 50*_bili, 50*_bili);
    _fangdongFenxiangLabel.frame = CGRectMake(73*_bili, 0, 220*_bili, 40*_bili);
    _fangdongBeijingImageView.frame = CGRectMake(0, 40*_bili, 320*_bili-20, 135*_bili);
    _fangdongShangLabel.font = [UIFont systemFontOfSize:11*_bili];
    _fangdongFenxiangLabel.font = [UIFont systemFontOfSize:8*_bili];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
