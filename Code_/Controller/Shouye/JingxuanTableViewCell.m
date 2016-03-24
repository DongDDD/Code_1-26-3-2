//
//  JingxuanTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 东. All rights reserved.
//

#import "JingxuanTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation JingxuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//精选推荐tableView内容赋值
-(void)setTheJingxuanTuijianTableView:(NSDictionary *)dict{
    
   
    
    
    
    
    
    
    _tuijianJiyuLabel.text = dict[@"HouseName"];
    _jiaqianLabel.text = dict[@"SalePrice"];
    _huodongJianjieLabel.text = dict[@"HouseName"];
    _fangyuanShuliangLabel.text = dict[@"HoseAddr"];
    
    [_beijinImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"ThumbImg"]] placeholderImage:[UIImage imageNamed:@"7.png"]];
    //[_beijinImageView.sd_imageURL:[NSURL URLWithString:dict[@"ThumbImg"]]];
    [self changeTheFrame];
    
}

-(void)changeTheFrame{
    
    //_xiahuaxianImageView.frame = CGRectMake(0, 161*_bili, 320*_bili-20, 1*_bili);
    _tuijianJiyuLabel.frame = CGRectMake(60*_bili, 60*_bili, 180*_bili, 18*_bili);
    _jiaqianLabel.frame = CGRectMake(120*_bili, 80*_bili, 60*_bili, 18*_bili);
    
    _beijinImageView.frame = CGRectMake(0, 1, 320*_bili-20, 133*_bili);
    
    _huodongJianjieLabel.frame = CGRectMake(21*_bili, 136*_bili, 101*_bili, 19*_bili);
    
    _jiyuDituImageView.frame = CGRectMake(60*_bili, 60*_bili, 180*_bili, 18*_bili);
    _fangyuanShuliangLabel.frame = CGRectMake(122*_bili, 136*_bili, 49*_bili, 19*_bili);
    _xingxingImageView.frame = CGRectMake(0, 138*_bili, 17*_bili, 17*_bili);
    _chakanButton.frame = CGRectMake(240*_bili, 137*_bili, 43*_bili, 19*_bili);
    _youbianImageView.frame = CGRectMake(284*_bili, 141*_bili, 9*_bili, 9*_bili);
    _xiahuaxianImageView.frame = CGRectMake(0,157*_bili , 300*_bili, 1*_bili);
    
    _tuijianJiyuLabel.font = [UIFont systemFontOfSize:12*_bili];
    
    _jiaqianLabel.font = [UIFont systemFontOfSize:12*_bili];
    
    _huodongJianjieLabel.font = [UIFont systemFontOfSize:10*_bili];
    
    _fangyuanShuliangLabel.font = [UIFont systemFontOfSize:10*_bili];
    
    _chakanButton.titleLabel.font = [UIFont systemFontOfSize:10*_bili];
    
}








//查看更多按钮点击事件
- (IBAction)ChakanGengduoButtonClick:(id)sender {
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
