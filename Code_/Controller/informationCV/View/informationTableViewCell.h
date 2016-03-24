//
//  informationTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 东. All rights reserved.
//
#import "informaAmode.h"
#import "MyTableViewCell.h"
#import <UIKit/UIKit.h>

@interface informationTableViewCell : MyTableViewCell

@property(nonatomic,retain) informaAmode *informa;

@property(nonatomic,retain) UIImageView *informationImageView;//房间图片 HighImg
@property(nonatomic,retain) UILabel *Title;// 标题    HouseName
@property(nonatomic,retain) UILabel *BTitle;//副标题  HoseAddr
@property(nonatomic,retain) UILabel *rooms;//几人间－－－
@property(nonatomic,retain) UILabel *bookingCount;//已经订了多少次－－－
@property(nonatomic,retain) UILabel *money;//多少钱     SalePrice

@property(nonatomic,retain) UIImageView *mapRoom;//地图房间定位

//Buttom
@property(nonatomic,retain) UIButton *praise;//点赞
@property(nonatomic,retain) UIButton *share;//分享
@property(nonatomic,retain) UILabel *praiseLabel;
@property(nonatomic,retain) UILabel *shareLabel;

@end
