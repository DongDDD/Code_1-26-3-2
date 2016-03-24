//
//  foundFiveTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//
#import "MyTableViewCell.h"
#import <UIKit/UIKit.h>

@interface foundFiveTableViewCell : MyTableViewCell

@property(nonatomic,retain)UIImageView *HeadImageView;
@property(nonatomic,retain)UIImageView *sexV;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *timeLabel;//分钟
@property(nonatomic,retain)UILabel *yeartimeLabel;//时间年月日
@property(nonatomic,retain)UILabel *addressLabel;//地址
@property(nonatomic,retain)UILabel *sayLabel;//说说
@property(nonatomic,retain)UIImageView *sayImageView;//说说图

@property(nonatomic,retain)UIButton *zanButton;
@property(nonatomic,retain)UIButton *pingButton;
@property(nonatomic,retain)UILabel *zanLabel;
@property(nonatomic,retain)UILabel *pingLabel;


@end
