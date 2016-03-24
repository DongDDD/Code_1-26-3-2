//
//  JingxuanTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JingxuanTableViewCell : UITableViewCell

@property(nonatomic,assign)float bili;



@property (weak, nonatomic) IBOutlet UIImageView *xiahuaxianImageView;
@property (weak, nonatomic) IBOutlet UIImageView *jiyuDituImageView;

@property (weak, nonatomic) IBOutlet UILabel *tuijianJiyuLabel;

@property (weak, nonatomic) IBOutlet UILabel *jiaqianLabel;


@property (weak, nonatomic) IBOutlet UILabel *huodongJianjieLabel;


@property (weak, nonatomic) IBOutlet UILabel *fangyuanShuliangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beijinImageView;


@property (weak, nonatomic) IBOutlet UIImageView *xingxingImageView;

@property (weak, nonatomic) IBOutlet UIButton *chakanButton;

@property (weak, nonatomic) IBOutlet UIImageView *youbianImageView;






-(void)setTheJingxuanTuijianTableView:(NSDictionary *)dict;


@end
