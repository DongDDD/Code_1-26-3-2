//
//  InformationDetailsTableViewController.h
//  Code_
//
//  Created by admin on 15/12/16.
//  Copyright © 2015年 东. All rights reserved.
//
#import "MyViewController.h"
#import <UIKit/UIKit.h>
#import "informationViewController.h"


@interface InformationDetailsTableViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,retain)NSString *stiTite;
@property (nonatomic,retain) UITableView *tableV;
@property(nonatomic,retain)NSString *HouseIdStr;
//创建两个数组用来装低质图链接和高质图链接
//@property(nonatomic,retain)NSMutableArray *ThumbArray;
//@property(nonatomic,retain)NSMutableArray  *HighArray;
@property(nonatomic,retain)NSTimer *time;//定时器
//Buttom
@property(nonatomic,retain)UIButton *praise;//点赞
@property(nonatomic,retain)UILabel *praiseLabel;
@property(nonatomic,retain)UIButton *share;//分享
@property(nonatomic,retain)UILabel *shareLabel;

@property(nonatomic,retain)informationViewController *information;

//@property(nonatomic,retain)NSString *HouseTitle;
//@property(nonatomic,retain)NSString *AdrTitle;





@end
