//
//  informationViewController.h
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import "MyViewController.h"
#import <UIKit/UIKit.h>

@interface informationViewController : MyViewController<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray * dataArray;
    
    UIView * mainView;
    
    
}

#pragma mark -  下拉栏数据
@property (nonatomic, strong) NSArray *classifys;//
@property (nonatomic, strong) NSArray *hostels;//
@property (nonatomic, strong) NSArray *areas;//
@property (nonatomic, strong) NSArray *sorts;//

@property (nonatomic,retain)   NSMutableArray *dataArray;
#pragma mark -
@property (nonatomic,assign) NSInteger p;//定义个p
@property (nonatomic,assign) NSInteger  RoCount;
@property (nonatomic,retain) UITableView *tableV;
@property (nonatomic,retain) UIView *view1;
@property (nonatomic,retain) UILabel *label1;
@property (nonatomic,retain) UILabel *label2;
@property (nonatomic,retain) UIView *timeXuanView;

@property (nonatomic,retain) UIButton*button1;
@property (nonatomic,retain) UIButton*button2;
@property (nonatomic,retain) UIButton*button3;
@property (nonatomic,retain) UIButton*button4;
@property (nonatomic,retain) UILabel *timelabel0;
@property (nonatomic,retain) UILabel *timelabel1;
@property (nonatomic,retain) UILabel *timelabel2;

@property (nonatomic,retain)  UIScrollView *scv;
@property (nonatomic,retain)  UIView *saiXuanZView;
@property (nonatomic,retain) UIButton*qingchuanButton;
@property (nonatomic,retain) UIButton*quedingButton;
@property (nonatomic,assign) NSInteger yiJuP;
@property (nonatomic,retain)UILabel *yijuxuanzheLabel;
@property (nonatomic,retain) UIImageView *sheshiButton1ImageV;
@property (nonatomic,retain) UIImageView *sheshiButton2ImageV;
@property (nonatomic,retain)UIImageView *sheshiButton3ImageV;
@property (nonatomic,retain)UIImageView *sheshiButton4ImageV;
@property (nonatomic,retain) UIImageView *sheshiButton5ImageV;
@property (nonatomic,retain) UIImageView *sheshiButton6ImageV;
@property (nonatomic,retain) UIImageView *sheshiButton7ImageV;
@property (nonatomic,retain) UIImageView *sheshiButton8ImageV;
@property (nonatomic,retain) NSString *strImageN1;
@property (nonatomic,retain) NSString *strImageN2;
@property (nonatomic,retain) NSString *strImageN3;
@property (nonatomic,retain) NSString *strImageN4;
@property (nonatomic,retain) NSString *strImageN5;
@property (nonatomic,retain) NSString *strImageN6;
@property (nonatomic,retain) NSString *strImageN7;
@property (nonatomic,retain) NSString *strImageN8;
@property (nonatomic,retain)UILabel *huxingLabel1;
@property (nonatomic,retain)UILabel *huxingLabel2;
@property (nonatomic,retain)UILabel *huxingLabel3;
//@property (nonatomic,retain)UILabel *huxingLabel4;
//@property (nonatomic,retain)UILabel *huxingLabel5;
@property (nonatomic,retain) UIImageView *huxingLabel1ImageV;
@property (nonatomic,retain) UIImageView *huxingLabel2ImageV;
@property (nonatomic,retain) UIImageView *huxingLabel3ImageV;
//@property (nonatomic,retain) UIImageView *huxingLabel4ImageV;
//@property (nonatomic,retain) UIImageView *huxingLabel5ImageV;
@property (nonatomic,retain) NSString *strImageN1huxing;
@property (nonatomic,retain) NSString *strImageN2huxing;
@property (nonatomic,retain) NSString *strImageN3huxing;
//@property (nonatomic,retain) NSString *strImageN4huxing;
//@property (nonatomic,retain) NSString *strImageN5huxing;
@property (nonatomic,retain) UIButton*huxingButton1;
@property (nonatomic,retain) UIButton*huxingButton2;
@property (nonatomic,retain) UIButton*huxingButton3;
//@property (nonatomic,retain) UIButton*huxingButton4;
//@property (nonatomic,retain) UIButton*huxingButton5;
@property (nonatomic,retain)UILabel *chuzuLabel1;
@property (nonatomic,retain)UILabel *chuzuLabel2;
@property (nonatomic,retain)UILabel *chuzuLabel3;
@property (nonatomic,retain) NSString *strImageN1chuzu;
@property (nonatomic,retain) NSString *strImageN2chuzu;
@property (nonatomic,retain) NSString *strImageN3chuzu;
@property (nonatomic,retain) UIImageView *chuzuLabel1ImageV;
@property (nonatomic,retain) UIImageView *chuzuLabel2ImageV;
@property (nonatomic,retain) UIImageView *chuzuLabel3ImageV;
@property (nonatomic,retain) UIButton*chuzuButton1;
@property (nonatomic,retain) UIButton*chuzuButton2;
@property (nonatomic,retain) UIButton*chuzuButton3;
@property (nonatomic,retain)UILabel *fangxingLabel1;
@property (nonatomic,retain)UILabel *fangxingLabel2;
@property (nonatomic,retain)UILabel *fangxingLabel3;
@property (nonatomic,retain)UILabel *fangxingLabel4;
@property (nonatomic,retain) UIImageView *fangxingLabel1ImageV;
@property (nonatomic,retain) UIImageView *fangxingLabel2ImageV;
@property (nonatomic,retain) UIImageView *fangxingLabel3ImageV;
@property (nonatomic,retain) UIImageView *fangxingLabel4ImageV;
@property (nonatomic,retain) NSString *strImageN1fangxing;
@property (nonatomic,retain) NSString *strImageN2fangxing;
@property (nonatomic,retain) NSString *strImageN3fangxing;
@property (nonatomic,retain) NSString *strImageN4fangxing;
@property (nonatomic,retain) UIButton*fangxingButton1;
@property (nonatomic,retain) UIButton*fangxingButton2;
@property (nonatomic,retain) UIButton*fangxingButton3;
@property (nonatomic,retain) UIButton*fangxingButton4;
@property (nonatomic,retain) NSString *BaseID;
@property (nonatomic,retain) NSString *ID1;
@property (nonatomic,retain) NSString *ID2;
@property (nonatomic,retain) NSString *ID3;
@property (nonatomic,retain) NSString *ID4;
@property (nonatomic,retain) NSString *ID5;
@property (nonatomic,retain) NSString *ID6;
@property (nonatomic,retain) NSString *ID7;
@property (nonatomic,retain) NSString *ID8;
@property (nonatomic,retain) NSString *ID9;
@property (nonatomic,retain) NSString *ID10;
@property (nonatomic,retain) NSString *ID11;
@property (nonatomic,retain) NSString *ID12;
@property (nonatomic,retain) NSString *ID13;
@property (nonatomic,retain) NSString *ID14;
@property (nonatomic,retain) NSString *ID15;
@property (nonatomic,retain) NSString *ID16;
@property (nonatomic,retain) NSString *ID17;
@property (nonatomic,retain) NSString *ID18;
@property (nonatomic,retain) NSString *ID19;
@property (nonatomic,retain) NSString *ID20;
@property (nonatomic,retain) NSString *DescIDS;
@property (nonatomic,retain) UIButton*BEDateButtom;
@property (nonatomic,retain) NSString *BeginDatetime;
@property (nonatomic,retain) NSString *EndDatetime;
@property (nonatomic,retain) NSString *WBSStr;
@end
