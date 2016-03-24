//
//  ZeroTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//
#import "InformationDetailsModer.h"
#import "MyTableViewCell.h"
#import <UIKit/UIKit.h>

@interface ZeroTableViewCell : MyTableViewCell



//@property(nonatomic,retain)UIImageView *informationImageView;//房间图片
@property(nonatomic,retain)UILabel *Title;// 标题
@property(nonatomic,retain)UILabel *BTitle;//副标题
@property(nonatomic,retain)UILabel *bookingCount;//满7天  ¥ 168 满30天  ¥ 128
@property(nonatomic,retain)UILabel *money;//多少钱
@property(nonatomic,retain)UIImageView *hui;//惠
@property(nonatomic,retain)NSArray *Arr;//惠
//Buttom
@property(nonatomic,retain)UIButton *praise;//点赞
@property(nonatomic,retain)UILabel *praiseLabel;
@property(nonatomic,retain)UIButton *share;//分享
@property(nonatomic,retain)UILabel *shareLabel;


@end
