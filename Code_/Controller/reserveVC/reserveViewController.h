//
//  reserveViewController.h
//  Code_
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 东. All rights reserved.
//
#import "MyViewController.h"
#import <UIKit/UIKit.h>
#import "accoutfangkeVC.h"
@interface reserveViewController : MyViewController<UIScrollViewDelegate,FothVCDelegate>

@property (nonatomic,retain)UIScrollView *scrV;

@property (nonatomic,retain)NSString * ProdName;
@property (nonatomic,retain)NSString * ProdPice;
@property (nonatomic,retain)NSString * CutPrice;
@property (nonatomic,retain)NSString * ProdId;

@property (nonatomic,retain)NSMutableArray * dataArray;
@property (nonatomic,retain)UIView * mainView;

@property (nonatomic,retain)NSString * MenbIdString;
@property (nonatomic,retain)UIButton * BEDateButtom;
    
@property (nonatomic,retain)UIButton *riqixuanzhebutton3;
@property (nonatomic,retain)UIButton *riqixuanzhebutton4;
@property (nonatomic,retain)UILabel *riqiDayL;

@property (nonatomic,assign) int p;
@property (nonatomic,retain)UILabel * yuDingCount;

@property (nonatomic,retain)UITextField *textF;
@property (nonatomic,retain)UITextField *textFNumber;
@property (nonatomic,assign) NSInteger days;

@property (nonatomic,retain)NSMutableArray *Arrayss3;
@property (nonatomic,retain)UILabel *labelName;

@property (nonatomic,assign)float floatString;
@end
