//
//  OderListController.h
//  Code_
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 东. All rights reserved.
//

#import "MyTableViewController.h"

@interface OderListController : MyTableViewController
@property (nonatomic,retain)   NSMutableArray *dataArray;
@property (nonatomic,retain)   NSMutableArray *ORDEArray;
@property(nonatomic,copy)NSString *AccessToken;

@property (nonatomic,assign) NSInteger RRR;

@property (nonatomic,retain) UIButton*ordeButton1;
@property (nonatomic,retain) UIButton*ordeButton2;

@property (nonatomic,retain) UIView *redview;

@property(nonatomic,copy)NSString *MembIdStr;

@property(nonatomic,copy)NSString *StateStr;

@end
