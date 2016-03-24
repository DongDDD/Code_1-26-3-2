//
//  accoutfangkeVC.h
//  Code_
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 东. All rights reserved.
//
#import "MyViewController.h"
#import <UIKit/UIKit.h>

@protocol FothVCDelegate <NSObject>

-(void)passValue:(NSMutableArray *)str;

-(void)passValues:(NSString *)strt;
@end

@interface accoutfangkeVC : MyViewController

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIButton *But;


@property (nonatomic,retain)NSMutableArray *ResultArray;

@property (nonatomic,retain)NSMutableArray *fangwuArray;

@property (nonatomic,retain)NSMutableArray *fangwuArrayss;

@property (nonatomic,retain)NSString *stringL;
@property (nonatomic,retain)UILabel *labelName;
@property (nonatomic,assign) id<FothVCDelegate>delegate;

@end
