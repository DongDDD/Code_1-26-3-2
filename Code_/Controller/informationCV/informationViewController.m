//
//  informationViewController.m
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import <AFNetworking.h>
#import "informaAmode.h"
#import "JLDoubleSlider.h"
#import "AddressChoicePickerView.h"
//#import "MapViewController.h"
#import "DOPDropDownMenu.h"
#import "informationViewController.h"
#import "informationTableViewCell.h"
#import "InformationDetailsTableViewController.h"
#import "CalendarHomeViewController.h"

@interface informationViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>

{
    CalendarHomeViewController *chvc;
     JLDoubleSlider *_slider;
}

@property (nonatomic,retain) DOPDropDownMenu *menu;

@end

@implementation informationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if (self.WBSStr==nil) {
        self.WBSStr=@"0019.0001";
        NSLog(@"直接给的值");
    }else{
        NSLog(@"传过来的值");
    }
    
    [self VariableData];
   
    [self _tableV];
    [self addRershView];
    [self chuangjianP];
    [self timeXView];
    [self _menus];
    [self whatlong];
}

- (void)VariableData{
    self.p=1;
    self.yiJuP=8;//宜居人－不限
    self.DescIDS=@"0";
    self.BeginDatetime=nil;
    self.EndDatetime=nil;
    
}

//发布排序
- (void) timeXView{
    self.timeXuanView=[[UIView alloc]init];
    self.timeXuanView.frame=CGRectMake(0, -(64+154*ScreenWidth/375), ScreenWidth, 110*ScreenWidth/375);
    self.timeXuanView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.timeXuanView];
    
    self.timelabel0=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 5*ScreenWidth/375,ScreenWidth, 30*ScreenWidth/375)];
    self.timelabel0.text=@"最新发布";
    self.timelabel0.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.timeXuanView addSubview:self.timelabel0];
    
    UIButton*button0=[UIButton buttonWithType:UIButtonTypeCustom];
    button0.frame=CGRectMake(0, 5*ScreenWidth/375,ScreenWidth, 30*ScreenWidth/375);
    button0.backgroundColor=[UIColor clearColor];
    [button0 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(timelabel0B) forControlEvents:UIControlEventTouchDown];
    [self.timeXuanView addSubview:button0];
    
    UIView *viewww=[[UIView alloc]initWithFrame:CGRectMake(10, 35*ScreenWidth/375, ScreenWidth-20*ScreenWidth/375, 1)];
    viewww.backgroundColor=[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6];
    [self.timeXuanView addSubview:viewww];
    
    self.timelabel1=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 40*ScreenWidth/375,ScreenWidth, 30*ScreenWidth/375)];
    self.timelabel1.text=@"价格  高 － 低";
    self.timelabel1.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.timeXuanView addSubview:self.timelabel1];
    
    UIButton*button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 40*ScreenWidth/375,ScreenWidth, 30*ScreenWidth/375);
    button1.backgroundColor=[UIColor clearColor];
    [button1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(timelabel1B) forControlEvents:UIControlEventTouchDown];
    [self.timeXuanView addSubview:button1];
    
    UIView *viewww1=[[UIView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 70*ScreenWidth/375, ScreenWidth-20*ScreenWidth/375, 1)];
    viewww1.backgroundColor=[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6];
    [self.timeXuanView addSubview:viewww1];
    
    self.timelabel2=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 75*ScreenWidth/375,ScreenWidth, 30*ScreenWidth/375)];
    self.timelabel2.text=@"价格  低 － 高";
    self.timelabel2.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.timeXuanView addSubview:self.timelabel2];
    
    UIButton*button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(0, 75*ScreenWidth/375,ScreenWidth, 30*ScreenWidth/375);
    button2.backgroundColor=[UIColor clearColor];
    [button2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(timelabel2B) forControlEvents:UIControlEventTouchDown];
    [self.timeXuanView addSubview:button2];
    
    UIView *viewww2=[[UIView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 105*ScreenWidth/375, ScreenWidth-20*ScreenWidth/375, 1)];
    viewww2.backgroundColor=[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6];
    [self.timeXuanView addSubview:viewww2];
}

//选择选项
- (void)whatlong{
    self.scv=[[UIScrollView alloc]init];
    self.scv.frame=CGRectMake(0, -self.view.frame.size.height, ScreenWidth, ScreenHight-64-44*ScreenWidth/375);
    self.scv.backgroundColor=[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
    self.scv.showsHorizontalScrollIndicator = YES;
    self.scv.showsVerticalScrollIndicator = YES;
    self.scv.contentSize = CGSizeMake(0, 710*ScreenWidth/375);//570*ScreenWidth/375
    [self.view addSubview:self.scv];
    
    UILabel *jiageLabel=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 5*ScreenWidth/375, ScreenWidth-10*ScreenWidth/375, 30*ScreenWidth/375)];
    jiageLabel.text=@"价格";
     jiageLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
     jiageLabel.textColor=[UIColor grayColor];
     jiageLabel.textAlignment =NSTextAlignmentLeft;
    [self.scv addSubview: jiageLabel];
    UIView *jiageView=[[UIView alloc]initWithFrame:CGRectMake(0, 35*ScreenWidth/375, ScreenWidth, 80*ScreenWidth/375)];
    jiageView.backgroundColor=[UIColor whiteColor];
    [self.scv addSubview:jiageView];
    
    _slider = [[JLDoubleSlider alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 0, 345*ScreenWidth/375, 40*ScreenWidth/375)];
    _slider.unit = @"￥";
    _slider.minNum = 0;
    _slider.maxNum = 500;
    _slider.minTintColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
    _slider.maxTintColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
    _slider.mainTintColor = [UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    [jiageView addSubview:_slider];
    
    UILabel *jiage1Label=[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 60*ScreenWidth/375, 50*ScreenWidth/375, 20*ScreenWidth/375)];
    jiage1Label.text=@"￥0";
    jiage1Label.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    jiage1Label.textColor=[UIColor grayColor];
    jiage1Label.textAlignment =NSTextAlignmentLeft;
    [jiageView addSubview: jiage1Label];
    
    UILabel *jiage2Label=[[UILabel alloc]initWithFrame:CGRectMake(325*ScreenWidth/375, 60*ScreenWidth/375,50*ScreenWidth/375, 20*ScreenWidth/375)];
    jiage2Label.text=@"不限";
    jiage2Label.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    jiage2Label.textColor=[UIColor grayColor];
    jiage2Label.textAlignment =NSTextAlignmentCenter;
    [jiageView addSubview: jiage2Label];
    
    UILabel *jiage3Label=[[UILabel alloc]initWithFrame:CGRectMake(59*ScreenWidth/375, 60*ScreenWidth/375,50*ScreenWidth/375, 20*ScreenWidth/375)];
    jiage3Label.text=@"￥100";
    jiage3Label.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    jiage3Label.textColor=[UIColor grayColor];
    jiage3Label.textAlignment =NSTextAlignmentCenter;
    [jiageView addSubview: jiage3Label];
    
    UILabel *jiage4Label=[[UILabel alloc]initWithFrame:CGRectMake(128*ScreenWidth/375, 60*ScreenWidth/375,50*ScreenWidth/375, 20*ScreenWidth/375)];
    jiage4Label.text=@"￥200";
    jiage4Label.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    jiage4Label.textColor=[UIColor grayColor];
    jiage4Label.textAlignment =NSTextAlignmentCenter;
    [jiageView addSubview: jiage4Label];
    
    UILabel *jiage5Label=[[UILabel alloc]initWithFrame:CGRectMake(197*ScreenWidth/375, 60*ScreenWidth/375,50*ScreenWidth/375, 20*ScreenWidth/375)];
    jiage5Label.text=@"￥300";
    jiage5Label.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    jiage5Label.textColor=[UIColor grayColor];
    jiage5Label.textAlignment =NSTextAlignmentLeft;
    [jiageView addSubview: jiage5Label];
    
    UILabel *jiage6Label=[[UILabel alloc]initWithFrame:CGRectMake(266*ScreenWidth/375, 60*ScreenWidth/375,50*ScreenWidth/375, 20*ScreenWidth/375)];
    jiage6Label.text=@"￥400";
    jiage6Label.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    jiage6Label.textColor=[UIColor grayColor];
    jiage6Label.textAlignment =NSTextAlignmentLeft;
    [jiageView addSubview: jiage6Label];
    
    UILabel *chuzuLabel=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 120*ScreenWidth/375, ScreenWidth-10*ScreenWidth/375, 30*ScreenWidth/375)];
    chuzuLabel.text=@"出租类型";
    chuzuLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    chuzuLabel.textColor=[UIColor grayColor];
    chuzuLabel.textAlignment =NSTextAlignmentLeft;
    [self.scv addSubview: chuzuLabel];
    UIView *chuzuView=[[UIView alloc]initWithFrame:CGRectMake(0, 150*ScreenWidth/375, ScreenWidth, 60*ScreenWidth/375)];
    chuzuView.backgroundColor=[UIColor whiteColor];
    [self.scv addSubview:chuzuView];
    
    self.chuzuLabel1=[[UILabel alloc]initWithFrame:CGRectMake(40.5*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];//25+15
    self.chuzuLabel1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.chuzuLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.chuzuLabel1.text=@"整套出租";
    [chuzuView addSubview:self.chuzuLabel1];
    
    self.strImageN1chuzu=@"checkbox_no_sel";
    self.chuzuLabel1ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(25*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.chuzuLabel1ImageV.image=[UIImage imageNamed:self.strImageN1chuzu];
    [chuzuView addSubview:self.chuzuLabel1ImageV];
    
    self.chuzuButton1=[UIButton buttonWithType:UIButtonTypeSystem];
    self.chuzuButton1.frame=CGRectMake(25*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.chuzuButton1.backgroundColor=[UIColor clearColor];
    [self.chuzuButton1 addTarget:self action:@selector(chuzuButton1Action) forControlEvents:UIControlEventTouchUpInside];
    [chuzuView addSubview:self.chuzuButton1];
    
    self.chuzuLabel2=[[UILabel alloc]initWithFrame:CGRectMake(165.5*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];//25+15
    self.chuzuLabel2.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.chuzuLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.chuzuLabel2.text=@"独立单间";
    [chuzuView addSubview:self.chuzuLabel2];
    
    self.strImageN2chuzu=@"checkbox_no_sel";
    self.chuzuLabel2ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(150*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.chuzuLabel2ImageV.image=[UIImage imageNamed:self.strImageN2chuzu];
    [chuzuView addSubview:self.chuzuLabel2ImageV];
    
    self.chuzuButton2=[UIButton buttonWithType:UIButtonTypeSystem];
    self.chuzuButton2.frame=CGRectMake(150*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.chuzuButton2.backgroundColor=[UIColor clearColor];
    [self.chuzuButton2 addTarget:self action:@selector(chuzuButton2Action) forControlEvents:UIControlEventTouchUpInside];
    [chuzuView addSubview:self.chuzuButton2];
    
    self.chuzuLabel3=[[UILabel alloc]initWithFrame:CGRectMake(290.5*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];//25+15
    self.chuzuLabel3.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.chuzuLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.chuzuLabel3.text=@"合住房间";
    [chuzuView addSubview:self.chuzuLabel3];
    
    self.strImageN3chuzu=@"checkbox_no_sel";
    self.chuzuLabel3ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(275*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.chuzuLabel3ImageV.image=[UIImage imageNamed:self.strImageN3chuzu];
    [chuzuView addSubview:self.chuzuLabel3ImageV];
    
    self.chuzuButton3=[UIButton buttonWithType:UIButtonTypeSystem];
    self.chuzuButton3.frame=CGRectMake(275*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.chuzuButton3.backgroundColor=[UIColor clearColor];
    [self.chuzuButton3 addTarget:self action:@selector(chuzuButton3Action) forControlEvents:UIControlEventTouchUpInside];
    [chuzuView addSubview:self.chuzuButton3];
    
    UILabel *huxingLabel=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 215*ScreenWidth/375, ScreenWidth-10*ScreenWidth/375, 30*ScreenWidth/375)];
    huxingLabel.text=@"户型";
    huxingLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    huxingLabel.textColor=[UIColor grayColor];
    huxingLabel.textAlignment =NSTextAlignmentLeft;
    [self.scv addSubview: huxingLabel];
    UIView *huxingView=[[UIView alloc]initWithFrame:CGRectMake(0, 245*ScreenWidth/375, ScreenWidth, 60*ScreenWidth/375)];
    huxingView.backgroundColor=[UIColor whiteColor];
    [self.scv addSubview:huxingView];
    
//    self.huxingLabel1=[[UILabel alloc]initWithFrame:CGRectMake(30.5*ScreenWidth/375,  15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
     self.huxingLabel1=[[UILabel alloc]initWithFrame:CGRectMake(40.5*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];
    self.huxingLabel1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.huxingLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.huxingLabel1.text=@"一居";
    [huxingView addSubview:self.huxingLabel1];
    
    self.strImageN1huxing=@"checkbox_no_sel";
//    self.huxingLabel1ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.huxingLabel1ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(25*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.huxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1huxing];
    [huxingView addSubview:self.huxingLabel1ImageV];
    
    self.huxingButton1=[UIButton buttonWithType:UIButtonTypeSystem];
//    self.huxingButton1.frame=CGRectMake(15*ScreenWidth/375, 0, 45*ScreenWidth/375, 60*ScreenWidth/375);
    self.huxingButton1.frame=CGRectMake(25*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.huxingButton1.backgroundColor=[UIColor clearColor];
    [self.huxingButton1 addTarget:self action:@selector(huxingButton1Action) forControlEvents:UIControlEventTouchUpInside];
    [huxingView addSubview:self.huxingButton1];
    
//    self.huxingLabel2=[[UILabel alloc]initWithFrame:CGRectMake(105.5*ScreenWidth/375,  15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.huxingLabel2=[[UILabel alloc]initWithFrame:CGRectMake(165.5*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];
    self.huxingLabel2.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.huxingLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.huxingLabel2.text=@"二居";
    [huxingView addSubview:self.huxingLabel2];
    
    self.strImageN2huxing=@"checkbox_no_sel";
//    self.huxingLabel2ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(90*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.huxingLabel2ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(150*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.huxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2huxing];
    [huxingView addSubview:self.huxingLabel2ImageV];
    
    self.huxingButton2=[UIButton buttonWithType:UIButtonTypeSystem];
//    self.huxingButton2.frame=CGRectMake(90*ScreenWidth/375, 0, 45*ScreenWidth/375, 60*ScreenWidth/375);
    self.huxingButton2.frame=CGRectMake(150*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.huxingButton2.backgroundColor=[UIColor clearColor];
    [self.huxingButton2 addTarget:self action:@selector(huxingButton2Action) forControlEvents:UIControlEventTouchUpInside];
    [huxingView addSubview:self.huxingButton2];
    
//    self.huxingLabel3=[[UILabel alloc]initWithFrame:CGRectMake(180.5*ScreenWidth/375,  15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.huxingLabel3=[[UILabel alloc]initWithFrame:CGRectMake(290.5*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];
    self.huxingLabel3.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.huxingLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.huxingLabel3.text=@"三居";
    [huxingView addSubview:self.huxingLabel3];
    
    self.strImageN3huxing=@"checkbox_no_sel";
//    self.huxingLabel3ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(165*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.huxingLabel3ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(275*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.huxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3huxing];
    [huxingView addSubview:self.huxingLabel3ImageV];
    
    self.huxingButton3=[UIButton buttonWithType:UIButtonTypeSystem];
//    self.huxingButton3.frame=CGRectMake(165*ScreenWidth/375, 0, 45*ScreenWidth/375, 60*ScreenWidth/375);
    self.huxingButton3.frame=CGRectMake(275*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.huxingButton3.backgroundColor=[UIColor clearColor];
    [self.huxingButton3 addTarget:self action:@selector(huxingButton3Action) forControlEvents:UIControlEventTouchUpInside];
    [huxingView addSubview:self.huxingButton3];
    
//    self.huxingLabel4=[[UILabel alloc]initWithFrame:CGRectMake(255.5*ScreenWidth/375,  15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
//    self.huxingLabel4.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
//    self.huxingLabel4.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
//    self.huxingLabel4.text=@"四居";
//    [huxingView addSubview:self.huxingLabel4];
//    
//    self.strImageN4huxing=@"checkbox_no_sel";
//    self.huxingLabel4ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(240*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
//    self.huxingLabel4ImageV.image=[UIImage imageNamed:self.strImageN4huxing];
//    [huxingView addSubview:self.huxingLabel4ImageV];
//    
//    self.huxingButton4=[UIButton buttonWithType:UIButtonTypeSystem];
//    self.huxingButton4.frame=CGRectMake(240*ScreenWidth/375, 0, 45*ScreenWidth/375, 60*ScreenWidth/375);
//    self.huxingButton4.backgroundColor=[UIColor clearColor];
//    [self.huxingButton4 addTarget:self action:@selector(huxingButton4Action) forControlEvents:UIControlEventTouchUpInside];
//    [huxingView addSubview:self.huxingButton4];
    
//    self.huxingLabel5=[[UILabel alloc]initWithFrame:CGRectMake(330.5*ScreenWidth/375,  15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
//    self.huxingLabel5.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
//    self.huxingLabel5.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
//    self.huxingLabel5.text=@"其它";
//    [huxingView addSubview:self.huxingLabel5];
//    
//    self.strImageN5huxing=@"checkbox_no_sel";
//    self.huxingLabel5ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(315*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
//    self.huxingLabel5ImageV.image=[UIImage imageNamed:self.strImageN5huxing];
//    [huxingView addSubview:self.huxingLabel5ImageV];
//    
//    self.huxingButton5=[UIButton buttonWithType:UIButtonTypeSystem];
//    self.huxingButton5.frame=CGRectMake(315*ScreenWidth/375, 0, 45*ScreenWidth/375, 60*ScreenWidth/375);
//    self.huxingButton5.backgroundColor=[UIColor clearColor];
//    [self.huxingButton5 addTarget:self action:@selector(huxingButton5Action) forControlEvents:UIControlEventTouchUpInside];
//    [huxingView addSubview:self.huxingButton5];
    
    
    UILabel *fangxingLabel=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 310*ScreenWidth/375, ScreenWidth-10*ScreenWidth/375, 30*ScreenWidth/375)];
    fangxingLabel.text=@"房型";
    fangxingLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    fangxingLabel.textColor=[UIColor grayColor];
    fangxingLabel.textAlignment =NSTextAlignmentLeft;
    [self.scv addSubview: fangxingLabel];
    UIView *fangxingView=[[UIView alloc]initWithFrame:CGRectMake(0, 340*ScreenWidth/375, ScreenWidth, 60*ScreenWidth/375)];
    fangxingView.backgroundColor=[UIColor whiteColor];
    [self.scv addSubview:fangxingView];
    
    self.fangxingLabel1=[[UILabel alloc]initWithFrame:CGRectMake(33.75*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];//25+15
    self.fangxingLabel1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.fangxingLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.fangxingLabel1.text=@"砖房";
    [fangxingView addSubview:self.fangxingLabel1];
    
    self.strImageN1fangxing=@"checkbox_no_sel";
    self.fangxingLabel1ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(19.25*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.fangxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1fangxing];
    [fangxingView addSubview:self.fangxingLabel1ImageV];
    
    self.fangxingButton1=[UIButton buttonWithType:UIButtonTypeSystem];
    self.fangxingButton1.frame=CGRectMake(18.75*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.fangxingButton1.backgroundColor=[UIColor clearColor];
    [self.fangxingButton1 addTarget:self action:@selector(fangxingButton1Action) forControlEvents:UIControlEventTouchUpInside];
    [fangxingView addSubview:self.fangxingButton1];
    
    self.fangxingLabel2=[[UILabel alloc]initWithFrame:CGRectMake(128*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];//25+15
    self.fangxingLabel2.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.fangxingLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.fangxingLabel2.text=@"土房";
    [fangxingView addSubview:self.fangxingLabel2];
    
    self.strImageN2fangxing=@"checkbox_no_sel";
    self.fangxingLabel2ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(112.5*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.fangxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2fangxing];
    [fangxingView addSubview:self.fangxingLabel2ImageV];
    
    self.fangxingButton2=[UIButton buttonWithType:UIButtonTypeSystem];
    self.fangxingButton2.frame=CGRectMake(112.5*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.fangxingButton2.backgroundColor=[UIColor clearColor];
    [self.fangxingButton2 addTarget:self action:@selector(fangxingButton2Action) forControlEvents:UIControlEventTouchUpInside];
    [fangxingView addSubview:self.fangxingButton2];
    
    self.fangxingLabel3=[[UILabel alloc]initWithFrame:CGRectMake(221.75*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];//25+15
    self.fangxingLabel3.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.fangxingLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.fangxingLabel3.text=@"木房";
    [fangxingView addSubview:self.fangxingLabel3];
    
    self.strImageN3fangxing=@"checkbox_no_sel";
    self.fangxingLabel3ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(206.25*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.fangxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3fangxing];
    [fangxingView addSubview:self.fangxingLabel3ImageV];
    
    self.fangxingButton3=[UIButton buttonWithType:UIButtonTypeSystem];
    self.fangxingButton3.frame=CGRectMake(206.25*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.fangxingButton3.backgroundColor=[UIColor clearColor];
    [self.fangxingButton3 addTarget:self action:@selector(fangxingButton3Action) forControlEvents:UIControlEventTouchUpInside];
    [fangxingView addSubview:self.fangxingButton3];
    
    self.fangxingLabel4=[[UILabel alloc]initWithFrame:CGRectMake(315.5*ScreenWidth/375,  15*ScreenWidth/375, 60*ScreenWidth/375, 30*ScreenWidth/375)];//25+15
    self.fangxingLabel4.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
    self.fangxingLabel4.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    self.fangxingLabel4.text=@"独栋别墅";
    [fangxingView addSubview:self.fangxingLabel4];
    
    self.strImageN4fangxing=@"checkbox_no_sel";
    self.fangxingLabel4ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(300*ScreenWidth/375, 22.5*ScreenWidth/375, 15*ScreenWidth/375, 15*ScreenWidth/375)];
    self.fangxingLabel4ImageV.image=[UIImage imageNamed:self.strImageN4fangxing];
    [fangxingView addSubview:self.fangxingLabel4ImageV];
    
    self.fangxingButton4=[UIButton buttonWithType:UIButtonTypeSystem];
    self.fangxingButton4.frame=CGRectMake(300*ScreenWidth/375, 0, 75*ScreenWidth/375, 60*ScreenWidth/375);
    self.fangxingButton4.backgroundColor=[UIColor clearColor];
    [self.fangxingButton4 addTarget:self action:@selector(fangxingButton4Action) forControlEvents:UIControlEventTouchUpInside];
    [fangxingView addSubview:self.fangxingButton4];
    
    UILabel *peitaoLabel=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 400*ScreenWidth/375, ScreenWidth-10*ScreenWidth/375, 30*ScreenWidth/375)];
    peitaoLabel.text=@"配套设施";
    peitaoLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    peitaoLabel.textColor=[UIColor grayColor];
    peitaoLabel.textAlignment =NSTextAlignmentLeft;
    [self.scv addSubview: peitaoLabel];
    UIView *peitaoView=[[UIView alloc]initWithFrame:CGRectMake(0, 430*ScreenWidth/375, ScreenWidth, 120*ScreenWidth/375)];
    peitaoView.backgroundColor=[UIColor whiteColor];
    [self.scv addSubview:peitaoView];
    
    UIButton*sheshiButton1=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton1.frame=CGRectMake(31.875*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
    sheshiButton1.backgroundColor=[UIColor clearColor];
    [sheshiButton1 addTarget:self action:@selector(sheshiButton1) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton1];
    
    self.strImageN1=@"search_result_showerXXXyy_off";
    self.sheshiButton1ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(31.875*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton1ImageV.image=[UIImage imageNamed:self.strImageN1];
    [peitaoView addSubview:self.sheshiButton1ImageV];

    UIButton*sheshiButton2=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton2.frame=CGRectMake(125.625*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
    sheshiButton2.backgroundColor=[UIColor clearColor];
    [sheshiButton2 addTarget:self action:@selector(sheshiButton2) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton2];
    
    self.strImageN2=@"search_result_showerBBBXXX_off";
    self.sheshiButton2ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(125.625*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton2ImageV.image=[UIImage imageNamed:self.strImageN2];
    [peitaoView addSubview:self.sheshiButton2ImageV];
    
    UIButton*sheshiButton3=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton3.frame=CGRectMake(219.375*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
   sheshiButton3.backgroundColor=[UIColor clearColor];
    [sheshiButton3 addTarget:self action:@selector(sheshiButton3) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton3];
    
    self.strImageN3=@"search_result_kitchen_off";
    self.sheshiButton3ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(219.375*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton3ImageV.image=[UIImage imageNamed:self.strImageN3];
    [peitaoView addSubview:self.sheshiButton3ImageV];
    
    UIButton*sheshiButton4=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton4.frame=CGRectMake(313.125*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
    sheshiButton4.backgroundColor=[UIColor clearColor];
    [sheshiButton4 addTarget:self action:@selector(sheshiButton4) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton4];
    
    self.strImageN4=@"search_result_heating_off";
    self.sheshiButton4ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(313.125*ScreenWidth/375, 15*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton4ImageV.image=[UIImage imageNamed:self.strImageN4];
    [peitaoView addSubview:self.sheshiButton4ImageV];
    
    UIButton*sheshiButton5=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton5.frame=CGRectMake(31.875*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
    sheshiButton5.backgroundColor=[UIColor clearColor];
    [sheshiButton5 addTarget:self action:@selector(sheshiButton5) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton5];
    
    self.strImageN5=@"search_result_tv_off";
    self.sheshiButton5ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(31.875*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton5ImageV.image=[UIImage imageNamed:self.strImageN5];
    [peitaoView addSubview:self.sheshiButton5ImageV];
    
    UIButton*sheshiButton6=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton6.frame=CGRectMake(125.625*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
    sheshiButton6.backgroundColor=[UIColor clearColor];
    [sheshiButton6 addTarget:self action:@selector(sheshiButton6) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton6];
    
    self.strImageN6=@"search_result_toilet_off";
    self.sheshiButton6ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(125.625*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton6ImageV.image=[UIImage imageNamed:self.strImageN6];
    [peitaoView addSubview:self.sheshiButton6ImageV];
    
    UIButton*sheshiButton7=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton7.frame=CGRectMake(219.375*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
    sheshiButton7.backgroundColor=[UIColor clearColor];
    [sheshiButton7 addTarget:self action:@selector(sheshiButton7) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton7];
    
    self.strImageN7=@"search_result_netwwwwlllll_off";
    self.sheshiButton7ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(219.375*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton7ImageV.image=[UIImage imageNamed:self.strImageN7];
    [peitaoView addSubview:self.sheshiButton7ImageV];
    
    UIButton*sheshiButton8=[UIButton buttonWithType:UIButtonTypeSystem];
    sheshiButton8.frame=CGRectMake(313.125*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375);
    sheshiButton8.backgroundColor=[UIColor clearColor];
    [sheshiButton8 addTarget:self action:@selector(sheshiButton8) forControlEvents:UIControlEventTouchUpInside];
    [peitaoView addSubview:sheshiButton8];
    
    self.strImageN8=@"search_result_net_off";
    self.sheshiButton8ImageV=[[UIImageView alloc]initWithFrame:CGRectMake(313.125*ScreenWidth/375, 75*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    self.sheshiButton8ImageV.image=[UIImage imageNamed:self.strImageN8];
    [peitaoView addSubview:self.sheshiButton8ImageV];
    
    UILabel *yijuLabel=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 560*ScreenWidth/375, ScreenWidth-10*ScreenWidth/375, 30*ScreenWidth/375)];
    yijuLabel.text=@"宜居人数";
    yijuLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    yijuLabel.textColor=[UIColor grayColor];
   yijuLabel.textAlignment =NSTextAlignmentLeft;
    [self.scv addSubview: yijuLabel];
    UIView *yijuView=[[UIView alloc]initWithFrame:CGRectMake(0, 590*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375)];
    yijuView.backgroundColor=[UIColor whiteColor];
    [self.scv addSubview:yijuView];
    
    UIImageView *yijuImageleft=[[UIImageView alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 20*ScreenWidth/375, 9*ScreenWidth/375, 15*ScreenWidth/375)];
    yijuImageleft.image=[UIImage imageNamed:@"arrow_left"];
    [yijuView addSubview:yijuImageleft];
    UIButton *yijuImageleftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    yijuImageleftButton.frame=CGRectMake(0, 0, 50*ScreenWidth/375, 50*ScreenWidth/375);
    yijuImageleftButton.backgroundColor=[UIColor clearColor];
    yijuImageleftButton.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [yijuImageleftButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [yijuImageleftButton addTarget:self action:@selector(yijuImageleftButtonAction) forControlEvents:UIControlEventTouchDown];
    [yijuView addSubview:yijuImageleftButton];
    
    self.yijuxuanzheLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50*ScreenWidth/375)];
    if (self.yiJuP==8){
        self.yijuxuanzheLabel.text=@"不限";
    }else{
        self.yijuxuanzheLabel.text=[NSString stringWithFormat:@"%ld",(long)self.yiJuP];
    }
    self.yijuxuanzheLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    self.yijuxuanzheLabel.textColor=[UIColor blackColor];
    self.yijuxuanzheLabel.textAlignment =NSTextAlignmentCenter;
    [yijuView addSubview: self.yijuxuanzheLabel];
    
    UIImageView *yijuImageright=[[UIImageView alloc]initWithFrame:CGRectMake(351*ScreenWidth/375, 20*ScreenWidth/375, 9*ScreenWidth/375, 15*ScreenWidth/375)];
    yijuImageright.image=[UIImage imageNamed:@"arrow_right"];
    [yijuView addSubview:yijuImageright];
    UIButton *yijuImagerightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    yijuImagerightButton.frame=CGRectMake(325*ScreenWidth/375, 0, 50*ScreenWidth/375, 50*ScreenWidth/375);
    yijuImagerightButton.backgroundColor=[UIColor clearColor];
    yijuImagerightButton.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [yijuImagerightButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [yijuImagerightButton addTarget:self action:@selector(yijuImagerightButtonAction) forControlEvents:UIControlEventTouchDown];
    [yijuView addSubview:yijuImagerightButton];
    
    self.saiXuanZView=[[UIView alloc]init];
    self.saiXuanZView.frame=CGRectMake(0, ScreenHight+50*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375);
   self.saiXuanZView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.saiXuanZView];
   
    UIView *saiView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    saiView.backgroundColor=[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6];
    [self.saiXuanZView addSubview:saiView];
    
    self.qingchuanButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.qingchuanButton.frame=CGRectMake(17.5*ScreenWidth/375, 6*ScreenWidth/375,152.5*ScreenWidth/375, 38*ScreenWidth/375);
    self.qingchuanButton.backgroundColor=[UIColor whiteColor];
    self.qingchuanButton.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.qingchuanButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.qingchuanButton setTitle:@"清除筛选" forState:UIControlStateNormal];
    [self.qingchuanButton addTarget:self action:@selector(qingchuanAction) forControlEvents:UIControlEventTouchDown];
    self.qingchuanButton.layer.borderWidth=1;
    self.qingchuanButton.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
    [self.saiXuanZView addSubview:self.qingchuanButton];
    
    self.quedingButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.quedingButton.frame=CGRectMake(205*ScreenWidth/375, 6*ScreenWidth/375,152.5*ScreenWidth/375, 38*ScreenWidth/375);
    self.quedingButton.backgroundColor=[UIColor whiteColor];
    self.quedingButton.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.quedingButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.quedingButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.quedingButton addTarget:self action:@selector(quedingAction) forControlEvents:UIControlEventTouchDown];
    self.quedingButton.layer.borderWidth=1;
    self.quedingButton.layer.borderColor=[[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1]CGColor];
    [self.saiXuanZView addSubview:self.quedingButton];
}

- (void)chuangjianP{
    dataArray=[[NSMutableArray alloc] init];
    
    chvc = [[CalendarHomeViewController alloc]init];
    chvc.view.frame=CGRectMake(0,-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:chvc.view];
   
    
    [chvc setAirPlaneToDay:90 ToDateforString:nil];//飞机初始化方法
    
    [self mainViewClass:0];
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        
        NSLog(@"%@",[model toString]);
        
        if(model.style==CellDayTypeClick)
        {
            [dataArray addObject:model.toString];
            
            NSSet *set = [NSSet setWithArray:dataArray];
            dataArray=[[set allObjects] mutableCopy];
            
            [dataArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
                return [obj1 compare:obj2];
            }];
            
        }
        else
        {
            [dataArray removeObject:model.toString];
            
        }
        
        [self mainViewClass:dataArray.count];
        
    };
}



-(void)addRershView
{
    //    下拉刷新
    [self.tableV addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableV headerBeginRefreshing];//刷新
    //    上拉加载
    [self.tableV addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)footerRereshing{
    //延迟时间
    [self getData1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableV reloadData];
        [self.tableV footerEndRefreshing];
    });
}
//下拉刷新调用的方法
- (void)headerRereshing{
    [self getData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableV reloadData];//刷新
        [self.tableV headerEndRefreshing];//结束刷新
    });
}


- (void)_tableV{
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 44*ScreenWidth/375, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-48*ScreenWidth/375)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    UIButton *calendar=[UIButton buttonWithType:UIButtonTypeSystem];
    calendar.frame=CGRectMake(0, 0, 30, 30);
    [calendar setBackgroundImage:[UIImage imageNamed:@"地图"] forState:UIControlStateNormal];
    [calendar addTarget:self action:@selector(mapAtion) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn=[[UIBarButtonItem alloc]initWithCustomView:calendar];
    self.navigationItem.rightBarButtonItem=currentMusicBtn;
    
  
        UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
        fanhu.frame=CGRectMake(0, 0, 10, 17);
        [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
        [fanhu addTarget:self action:@selector(aButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
        self.navigationItem.leftBarButtonItem=currentMusicBtn1;
    
    
    
//    UIButton *calendar=[UIButton buttonWithType:UIButtonTypeSystem];
//    calendar.frame=CGRectMake(0, 0, 30, 30);
//    [calendar setBackgroundImage:[UIImage imageNamed:@"日历"] forState:UIControlStateNormal];
//    [calendar addTarget:self action:@selector(calendarAtion) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *calendarButton=[[UIBarButtonItem alloc]initWithCustomView:calendar];
//    UIButton *mapBotton=[UIButton buttonWithType:UIButtonTypeSystem];
//    mapBotton.frame=CGRectMake(0, 0, 30, 30);
//    [mapBotton setBackgroundImage:[UIImage imageNamed:@"地图"] forState:UIControlStateNormal];
//    [mapBotton addTarget:self action:@selector(mapAtion) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *mapBottons=[[UIBarButtonItem alloc]initWithCustomView:mapBotton];
//    NSArray * btnArr = @[mapBottons,calendarButton];
//    self.navigationItem.rightBarButtonItems=btnArr;
    
    
}

- (void)aButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//下拉栏
- (void)_menuse{
    
    self.button1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button1.frame=CGRectMake(0, 0,93.75*ScreenWidth/375, 44*ScreenWidth/375);
    self.button1.backgroundColor=[UIColor whiteColor];
    self.button1.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.button1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.button1 setTitle:@"入住时间" forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchDown];
    self.button1.layer.borderWidth=1;
    self.button1.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
    [self.menu addSubview:self.button1];
    
    self.button2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame=CGRectMake(93.75*ScreenWidth/375, 0,93.75*ScreenWidth/375, 44*ScreenWidth/375);
    self.button2.backgroundColor=[UIColor whiteColor];
    self.button2.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.button2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.button2 setTitle:@"区域" forState:UIControlStateNormal];
    [self.button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchDown];
    self.button2.layer.borderWidth=1;
    self.button2.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
    [self.menu addSubview:self.button2];
    
    self.button3=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.frame=CGRectMake(93.75*2*ScreenWidth/375, 0,93.75*ScreenWidth/375, 44*ScreenWidth/375);
    self.button3.backgroundColor=[UIColor whiteColor];
    self.button3.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.button3 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.button3 setTitle:@"更多筛选" forState:UIControlStateNormal];
    [self.button3 addTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchDown];
    self.button3.layer.borderWidth=1;
    self.button3.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
    [self.menu addSubview:self.button3];

    self.button4=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button4.frame=CGRectMake(93.75*3*ScreenWidth/375, 0,93.75*ScreenWidth/375, 44*ScreenWidth/375);
    self.button4.backgroundColor=[UIColor whiteColor];
    self.button4.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.button4 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.button4 setTitle:@"推荐选择" forState:UIControlStateNormal];
    [self.button4 addTarget:self action:@selector(button4Action:) forControlEvents:UIControlEventTouchDown];
    self.button4.layer.borderWidth=1;
    self.button4.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
    [self.menu addSubview:self.button4];

    
}

- (void)_tite{
    
    if (ScreenWidth>414) {
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        self.label1=[[UILabel alloc] initWithFrame:CGRectMake(-30, 3, ScreenWidth/2-30, 44)];
        self.label2=[[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+30, 3, ScreenWidth/2-30, 44)];
        self.label1.textAlignment = NSTextAlignmentRight ;
        self.label2.textAlignment = NSTextAlignmentLeft;
    }else{
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100*ScreenWidth/375, 44)];
        self.label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 3, 100*ScreenWidth/375, 24)];
        self.label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 24, 100*ScreenWidth/375, 20)];
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label2.textAlignment = NSTextAlignmentCenter;
    }
    self.label1.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    self.label2.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
    self.label1.text=@"广州";
    self.label2.text=[NSString stringWithFormat:@"共%ld个结果",self.RoCount];
    self.label1.textColor = [UIColor whiteColor];
    self.label2.textColor = [UIColor whiteColor];
    self.view1.backgroundColor = [UIColor clearColor];
    [self.view1 addSubview:self.label1];
    [self.view1 addSubview:self.label2];
    self.navigationItem.titleView = self.view1;
}

//没多大卵
- (void)_menus{
#pragma mark -  下拉数据
    self.classifys = @[@"价格不限",@"111~555",@"666~888",@"1~80"];//
    self.hostels =@[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];//
    self.areas =@[@"房型",@"小田小屋",@"呵呵呵",@"高规",@"😁"];//
    self.sorts = @[@"区域",@"天河区",@"白云区",@"景秀区",@"番禺区",@"岳麓区"];//
    
    // 添加下拉菜单
    self.menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44*ScreenWidth/375];
    
    self.menu.delegate = self;
    self.menu.dataSource = self;
    [self.view addSubview:self.menu];
    [self _menuse];
}


#pragma mark -地图 日历 button

#pragma mark - mapButtonAction
- (void)mapAtion{
//    MapViewController *mapVC=[[MapViewController alloc]init];
//    
////    Partss *partss=self.dataArray[0];
//    mapVC.mapLat=23.217318;//[partss.latitude floatValue];
//    mapVC.mapLong=113.371687;//[partss.longitude floatValue];
//    
//    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)getData1 {
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
        [self.tableV headerEndRefreshing];
    }else  {
        //        [self showHudInViewhint:@"正在加载"];//显示提示框
        NSString *url = @"http://120.25.69.40:1005/API/GetListData.ashx";
        NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];
        self.p++;
        
        [dict9 setValue:self.lingpai forKey:@"AccessToken"];//令牌
        [dict9 setValue:@"List" forKey:@"action"];//首页推荐
        [dict9 setValue:self.WBSStr forKey:@"WBS"];//区域关联标识－－－第二个选择区域
        [dict9 setValue:self.DescIDS forKey:@"Desc"];//0默认排序(按最新发布时间)  1 价格 高-低  2 价格 低-高   －－－－第三个选择排序
        [dict9 setValue:@"10" forKey:@"psize"];//每页显示多少条，默认10
        [dict9 setValue:[NSString stringWithFormat:@"%ld",self.p] forKey:@"pid"];//当前页码，默认值1
                                                           //        第二个选择时间

            [dict9 setValue:self.BeginDatetime forKey:@"BeginDate"];//入住日期
            [dict9 setValue:self.EndDatetime forKey:@"EndDate"];//退房日期

        
        [dict9 setValue:self.BaseID forKey:@"Keys"];//第四个选择多个属性
        //    NSLog(@"请求的参数是:%@",dict9);
        NSLog( @"===========%@",dict9);
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict9
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
//                                NSLog(@"---%@", responseObject);
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  //              NSLog(@"等到的数据转成字典是---dic:%@",dic);
                  
                  
                  NSArray *array1 = dic [@"Result"];
                  if (array1 == nil) {
                      [self shoWHint:@"没有最新数据了"];
                  }
                  if (10*self.p>self.RoCount) {
                      [self shoWHint:@"没有最新数据了"];
                  }
                  
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  
                  if (nu ==1) {
                      
                      //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                      NSLog(@"获取不成功，返回的消息是%@",MsgStr);
                      [self chongxinHuoquLingpai];
                      [self getData1];
                      
                  }else{
                      NSLog(@"发送请求结果无异常");
                      
                      for (NSDictionary *dic1 in array1) {
                          informaAmode *infora=[[informaAmode alloc]init];
                          [infora setValuesForKeysWithDictionary:dic1];
                          [self.dataArray addObject:infora];
                          //                      [self showhide];//隐
                          //                      [self.tableV reloadData];
                          //                      [self.tableV headerEndRefreshing];//结束刷新
                      }
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  //              [self showhide];//隐藏菊花
                  [self shoWHint:@"请求失败"];
              }];
    }
}

- (void)getData{

    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
        [self.tableV headerEndRefreshing];
    }else  {
//        [self showHudInViewhint:@"正在加载"];//显示提示框
    NSString *url = @"http://120.25.69.40:1005/API/GetListData.ashx";
    NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];
        self.p=1;
        
    [dict9 setValue:self.lingpai forKey:@"AccessToken"];//令牌
    [dict9 setValue:@"List" forKey:@"action"];//首页推荐
    [dict9 setValue:self.WBSStr forKey:@"WBS"];//区域关联标识
    [dict9 setValue:self.DescIDS forKey:@"Desc"];//0默认排序(按最新发布时间)  1 价格 高-低  2 价格 低-高
    [dict9 setValue:@"10"  forKey:@"psize"];//每页显示多少条，默认10
    [dict9 setValue:[NSString stringWithFormat:@"%ld",self.p] forKey:@"pid"];//当前页码，默认值1
        

        [dict9 setValue:self.BeginDatetime forKey:@"BeginDate"];//入住日期
        [dict9 setValue:self.EndDatetime forKey:@"EndDate"];//退房日期

        [dict9 setValue:self.BaseID forKey:@"Keys"];//第四个选择多个属性
//    NSLog(@"请求的参数是:%@",dict9);
    
    //发送POST请求使用
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict9
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // 请求成功的时候调用这个block
              
//              NSLog(@"---%@", responseObject);
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
//              NSLog(@"等到的数据转成字典是---dic:%@",dic);
              
              NSArray *array1 = dic [@"Result"];
              self.RoCount= [dic[@"RowCount"]integerValue];
              NSLog(@"结果个数%ld",self.RoCount);
              if (array1 == nil) {
                  [self shoWHint:@"没有最新数据了"];
              }
             
              
              NSString *MsgStr = dic[@"Msg"];
              NSInteger nu = [dic[@"IsError"] integerValue];
              
              if (nu ==1) {

                  //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                  NSLog(@"获取不成功，返回的消息是%@",MsgStr);
                  [self chongxinHuoquLingpai];
                  [self getData];
                  
              }else{
                  NSLog(@"发送请求结果无异常");
                  
                  for (NSDictionary *dic1 in array1) {
                      informaAmode *infora=[[informaAmode alloc]init];
                      [infora setValuesForKeysWithDictionary:dic1];
                      [self.dataArray addObject:infora];
                      NSLog(@"数组个数为%ld",self.dataArray.count);
                       [self _tite];

                      
                  }
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              [self showhide];//隐藏菊花
             [self shoWHint:@"请求失败"];
          }];
}
}

#pragma mark--2.点击详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击详情");
    InformationDetailsTableViewController *inforTC=[[InformationDetailsTableViewController alloc]init];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    inforTC.stiTite=@"从化温泉富力泉天下独栋豪华度假";
    
    informaAmode *infora=self.dataArray[indexPath.row];
    inforTC.HouseIdStr=infora.HouseId;

    [self.navigationController pushViewController:inforTC animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
#pragma mark - 2. 设置单元表格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
#pragma mark -配置数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   informationTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"xixi"];
    if (cell==nil) {
        cell=[[informationTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"xixi"];
    }
//    UIView *view_bg = [[UIView alloc]initWithFrame:cell.frame];
//    view_bg.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:0.5];
//    cell.selectedBackgroundView = view_bg;
    if (self.dataArray.count == 0) {
        NSLog(@"meiyoushuju");
    }else{
        
        cell.informa=self.dataArray[indexPath.row];
                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    }
    
     cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 表格视图单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return ScreenHight/4+70*ScreenWidth/375;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray=[NSMutableArray array];
    }
    return _dataArray;
}





#pragma mark -
- (void) button1Action:(UIButton *)but{
    [self yinchang4];
    [self yinchang3];
    if (but.selected==NO) {//用选中状态判断
        [self CCTime];
        [but setTitle:@"选择时间" forState:UIControlStateNormal];
        but.selected = YES;//改为选中状态
    }else
    {
        [self CSCTime];
        [but setTitle:@"入住时间" forState:UIControlStateNormal];
        but.selected = NO;
    }
}

- (void)CCTime{
    self.tabBarController.tabBar.hidden = YES;
     chvc.view.frame=CGRectMake(0,64+44*ScreenWidth/375, self.view.frame.size.width, self.view.frame.size.height);
    mainView.frame=CGRectMake(0, self.view.frame.size.height-50*ScreenWidth/320,self.view.frame.size.width,50*ScreenWidth/320);
}
- (void)CSCTime{
    self.tabBarController.tabBar.hidden = NO;
    chvc.view.frame=CGRectMake(0,-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    mainView.frame=CGRectMake(0, -self.view.frame.size.height,self.view.frame.size.width,50*ScreenWidth/320);
}
- (void)yinchang1{
    [self CSCTime];
    self.button1.selected = NO;
}

- (void) button2Action:(UIButton *)but{
    [self yinchang1];
    [self yinchang4];
    [self yinchang3];
//    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc]init];
//    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
//        [but setTitle: [NSString stringWithFormat:@"%@",locate] forState:UIControlStateNormal];
//    };
//    [addressPickerView show];
}

- (void) button3Action:(UIButton *)but{
    [self yinchang1];
    [self yinchang4];
    if (but.selected==NO) {//用选中状态判断
        
        self.tabBarController.tabBar.hidden = YES;
        self.scv.frame=CGRectMake(0, 64+44*ScreenWidth/375, ScreenWidth, ScreenHight-64-44*ScreenWidth/375);
        self.saiXuanZView.frame=CGRectMake(0, ScreenHight-50*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375);
        [but setTitle:@"更多选择" forState:UIControlStateNormal];
        but.selected = YES;//改为选中状态
    }else
    {
        self.tabBarController.tabBar.hidden = NO;
        self.scv.frame=CGRectMake(0, -self.view.frame.size.height, ScreenWidth, ScreenHight-64-44*ScreenWidth/375);
        self.saiXuanZView.frame=CGRectMake(0, ScreenHight+50*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375);
        [but setTitle:@"选择" forState:UIControlStateNormal];
        but.selected = NO;
    }
}
- (void)yinchang3{
    self.scv.frame=CGRectMake(0, -self.view.frame.size.height, ScreenWidth, ScreenHight-64-44*ScreenWidth/375);
    self.saiXuanZView.frame=CGRectMake(0, ScreenHight+50*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375);
    self.button3.selected=NO;
}


- (void) button4Action:(UIButton *)but{
    [self yinchang1];
    [self yinchang3];
    if (but.selected==NO) {//用选中状态判断
        self.timeXuanView.frame=CGRectMake(0, 64+44*ScreenWidth/375, ScreenWidth, 110*ScreenWidth/375);
        but.selected = YES;//改为选中状态
        
    }else
    {
        self.timeXuanView.frame=CGRectMake(0, -(64+154*ScreenWidth/375), ScreenWidth, 110*ScreenWidth/375);
        but.selected = NO;
    }
}
- (void)yinchang4{
    self.timeXuanView.frame=CGRectMake(0, -(64+154*ScreenWidth/375), ScreenWidth, 110*ScreenWidth/375);
    self.button4.selected = NO;
}


- (void)timelabel0B{
    [self.button4 setTitle:@"推荐选择" forState:UIControlStateNormal];
    self.timeXuanView.frame=CGRectMake(0, -(64+154*ScreenWidth/375), ScreenWidth, 110*ScreenWidth/375);
    self.DescIDS=@"0";
    [self addRershView];
}
- (void)timelabel1B{
    [self.button4 setTitle:@"价格  高 － 低" forState:UIControlStateNormal];
    self.timeXuanView.frame=CGRectMake(0, -(64+154*ScreenWidth/375), ScreenWidth, 110*ScreenWidth/375);
    self.DescIDS=@"1";
    [self addRershView];
}
- (void)timelabel2B{
    [self.button4 setTitle:@"价格  低 － 高" forState:UIControlStateNormal];
    self.timeXuanView.frame=CGRectMake(0, -(64+154*ScreenWidth/375), ScreenWidth, 110*ScreenWidth/375);
    self.DescIDS=@"2";
    [self addRershView];
}




#pragma mark -
//列数
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 4;
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else if (column == 2){
        return self.hostels.count;
    }else {
        return self.sorts.count;
    }
}
//列数的标题
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];//当前点击的内容
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    }else if (indexPath.column == 2){
        return self.hostels[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}
//二极列表
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{

    return 0;
}
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}



- (void)mainViewClass:(NSInteger)num
{
    
    [mainView removeFromSuperview];
    
    mainView=[[UIView alloc] init];
    mainView.frame=CGRectMake(0, -self.view.frame.size.height,self.view.frame.size.width,50*ScreenWidth/320);
    mainView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:mainView];
    
    self.BEDateButtom=[UIButton buttonWithType:UIButtonTypeSystem];
    self.BEDateButtom.frame=CGRectMake(0, 500, 2,5);
    self.BEDateButtom.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:141.0/255.0 blue:26/255.0 alpha:1];
    [self.BEDateButtom addTarget:self action:@selector(BEDateButtomAction) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:self.BEDateButtom];
    
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lable.font=[UIFont systemFontOfSize:14.0f*ScreenWidth/320];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [mainView addSubview:lable];
    
    self.BeginDatetime=nil;
    self.EndDatetime=nil;
    
    if(num==0)
    {
        lable.text=@"请选择入住时间";
    }
    if(num==1)
    {
        mainView.frame=CGRectMake(0, self.view.frame.size.height-50*ScreenWidth/320,self.view.frame.size.width,50*ScreenWidth/320);
        lable.text=@"请选择离店时间";
        
    }
    if(num==2)
    {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate* date1 = [formatter dateFromString:[dataArray objectAtIndex:0]];
        NSDate* date2 = [formatter dateFromString:[dataArray objectAtIndex:1]];
        
        
        NSLog(@"%@",date1);
        NSLog(@"%@",date2);
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date1 toDate:date2  options:0];
        
        int days = [comps day]+1;
        
        mainView.frame=CGRectMake(0, self.view.frame.size.height-50*ScreenWidth/320,self.view.frame.size.width,50*ScreenWidth/320);
        self.BEDateButtom.frame=CGRectMake(0, 0, self.view.frame.size.width,50*ScreenWidth/320);
        lable.text=[NSString stringWithFormat:@"%@入住---%@离开 共%d天",[dataArray objectAtIndex:0],[dataArray objectAtIndex:1],days];
        self.BeginDatetime=[dataArray objectAtIndex:0];
        self.EndDatetime=[dataArray objectAtIndex:1];
        
    }
}

- (void)BEDateButtomAction{
    
    [self CSCTime];
    [self.button1 setTitle:[NSString stringWithFormat:@"%@至%@",[dataArray objectAtIndex:0],[dataArray objectAtIndex:1]] forState:UIControlStateNormal];
    self.button1.selected = NO;
    [self addRershView];
}

#pragma mark - 清除清除筛选
- (void)qingchuanAction{
    NSLog(@"清除筛选");
    
    self.yiJuP=8;
    self.yijuxuanzheLabel.text=@"不限";
    
    self.strImageN1chuzu=@"checkbox_no_sel";
    self.chuzuLabel1ImageV.image=[UIImage imageNamed:self.strImageN1chuzu];
    self.chuzuLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN2chuzu=@"checkbox_no_sel";
    self.chuzuLabel2ImageV.image=[UIImage imageNamed:self.strImageN2chuzu];
    self.chuzuLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN3chuzu=@"checkbox_no_sel";
    self.chuzuLabel3ImageV.image=[UIImage imageNamed:self.strImageN3chuzu];
    self.chuzuLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN1fangxing=@"checkbox_no_sel";
    self.fangxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1fangxing];
    self.fangxingLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN2fangxing=@"checkbox_no_sel";
    self.fangxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2fangxing];
    self.fangxingLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN3fangxing=@"checkbox_no_sel";
    self.fangxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3fangxing];
    self.fangxingLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN4fangxing=@"checkbox_no_sel";
    self.fangxingLabel4ImageV.image=[UIImage imageNamed:self.strImageN4fangxing];
    self.fangxingLabel4.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN3huxing=@"checkbox_no_sel";
    self.huxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3huxing];
    self.huxingLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN2huxing=@"checkbox_no_sel";
    self.huxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2huxing];
    self.huxingLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN1huxing=@"checkbox_no_sel";
    self.huxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1huxing];
    self.huxingLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    
    self.strImageN8=@"search_result_net_off";
    self.sheshiButton8ImageV.image=[UIImage imageNamed:self.strImageN8];
    
    self.strImageN7=@"search_result_netwwwwlllll_off";
    self.sheshiButton7ImageV.image=[UIImage imageNamed:self.strImageN7];
    
    self.strImageN6=@"search_result_toilet_off";
    self.sheshiButton6ImageV.image=[UIImage imageNamed:self.strImageN6];
    
    self.strImageN5=@"search_result_tv_off";
    self.sheshiButton5ImageV.image=[UIImage imageNamed:self.strImageN5];
    
    self.strImageN4=@"search_result_heating_off";
    self.sheshiButton4ImageV.image=[UIImage imageNamed:self.strImageN4];
    
    self.strImageN3=@"search_result_kitchen_off";
    self.sheshiButton3ImageV.image=[UIImage imageNamed:self.strImageN3];
    
    self.strImageN2=@"search_result_showerBBBXXX_off";
    self.sheshiButton2ImageV.image=[UIImage imageNamed:self.strImageN2];
    
    self.strImageN1=@"search_result_showerXXXyy_off";
    self.sheshiButton1ImageV.image=[UIImage imageNamed:self.strImageN1];
    
}
#pragma mark - 确定筛选
- (void)quedingAction{
    NSLog(@"确定");
//    最多宜居人    self.yiJuP
    if (self.yiJuP==8){
       self.ID19=nil;
    }else if (self.yiJuP==1){
        self.ID19=@",9d3142a7-0a81-4b83-b12d-f0964d66c49d";
    }else if (self.yiJuP==2){
        self.ID19=@",7377ea39-744c-4c67-a7ff-be47b90b24e7";
    }else if (self.yiJuP==3){
        self.ID19=@",cd51eb87-df94-450a-ad33-5e2fb2733e0f";
    }else if (self.yiJuP==4){
        self.ID19=@",7b037e48-657f-45fa-98ea-7bc2ce3295e6";
    }else if (self.yiJuP==5){
        self.ID19=@",99748b7b-c3eb-4ec5-936e-c619f9e848fb";
    }else if (self.yiJuP==6){
        self.ID19=@",9a8daf97-a07b-4e62-be9c-9b6c871df10b";
    }else if (self.yiJuP==7){
        self.ID19=@",e135d78b-580e-495e-8de7-d36caddde8cf";
    }else{
        self.ID19=nil;
    }
    
//    整套出租
    if ([self.strImageN1chuzu isEqualToString:@"checkbox_sel"]){
        
        self.ID1=@",a4598143-280a-4b22-b857-29b124a5e383";
    }else{
        self.ID1=nil;
    }
//    独立单间
    if ([self.strImageN2chuzu isEqualToString:@"checkbox_sel"]){
        self.ID2=@",3c48d0c6-34c8-4295-a75b-84ee21866c95";
    }else{
        self.ID2=nil;
    }
//    合住房间
    if ([self.strImageN3chuzu isEqualToString:@"checkbox_sel"]){
        self.ID3=@",b3096492-b2e9-4b3f-9f55-4043df0639eb";
    }else{
        self.ID3=nil;
    }
//    一居
    if ([self.strImageN1huxing isEqualToString:@"checkbox_sel"]){
        self.ID4=@",3d9186b8-2789-4d0f-b4df-f6aa55cf1aea";
    }else{
        self.ID4=nil;
    }
//    二居
    if ([self.strImageN2huxing isEqualToString:@"checkbox_sel"]){
        self.ID5=@",b0e8d6ae-59c3-43c2-a6d8-afd437fff4a6";
    }else{
        self.ID5=nil;
    }
//    三
    if ([self.strImageN3huxing isEqualToString:@"checkbox_sel"]){
        self.ID6=@",11c448c8-395d-4ca5-8097-0d521643d944";
    }else{
        self.ID6=nil;
    }
//    砖房
    if ([self.strImageN1fangxing isEqualToString:@"checkbox_sel"]){
        self.ID7=@",5bd89679-e396-4c6c-8838-a0529d6d3432";
    }else{
        self.ID7=nil;
    }
    
//    土
    if ([self.strImageN2fangxing isEqualToString:@"checkbox_sel"]){
        self.ID8=@",3f9d3d98-db12-4579-bf63-ef61e44445a3";
    }else{
        self.ID8=nil;
    }
//    木
    if ([self.strImageN3fangxing isEqualToString:@"checkbox_sel"]){
        self.ID9=@",e9ae2b8f-7a7a-4716-9f15-d9536cd607ec";
    }else{
        self.ID9=nil;
    }
//    别墅
    if ([self.strImageN4fangxing isEqualToString:@"checkbox_sel"]){
        self.ID10=@",5974e5a8-dbfd-4b1a-b7fe-8a4f8582ebe3";
    }else{
        self.ID10=nil;
    }
//    配套
    if ([self.strImageN1 isEqualToString:@"search_result_showerXXXyy_on"]) {
        self.ID11=@",f7f862fd-983b-4519-9b3b-eb30fb8f18fc";
    }else{
        self.ID11=nil;
    }
    
    if ([self.strImageN2 isEqualToString:@"search_result_showerBBBXXX_on"]) {
        self.ID12=@",ce7b6905-fc42-41a3-9361-dc0416296968";
    }else{
        self.ID12=nil;
    }
    
    if ([self.strImageN3 isEqualToString:@"search_result_kitchen_on"]) {
        self.ID13=@",c60ef7ab-108d-4fde-b87b-92be2bfe1d3c";
    }else{
        self.ID13=nil;
    }
    
    if ([self.strImageN4 isEqualToString:@"search_result_heating_on"]) {
        self.ID14=@",5c59bcf7-9add-4ae8-8913-3e2c6c92a1d2";
    }else{
        self.ID14=nil;
    }
    if ([self.strImageN5 isEqualToString:@"search_result_tv_on"]) {
        self.ID15=@",14159915-e27f-40d1-b0e2-2474b55e0c94";
    }else{
        self.ID15=nil;
    }
    if ([self.strImageN6 isEqualToString:@"search_result_toilet_on"]) {
        self.ID16=@",8c1fe02b-b7b7-47c6-a2a7-ec91c06f613f";
    }else{
        self.ID16=nil;
    }
    if ([self.strImageN7 isEqualToString:@"search_result_netwwwwlllll_on"]) {
        self.ID17=@",15558fed-20ae-4c48-ba2e-26c839a41f0a";
    }else{
        self.ID17=nil;
    }
    if ([self.strImageN8 isEqualToString:@"search_result_net_on"]) {
        self.ID18=@",494ce809-8f3e-46d6-b634-0d98df86c052";
    }else{
        self.ID18=nil;
    }
    
    
    if (_slider.currentMaxValue<100) {
        NSLog(@"100以下");
        self.ID20=@",eaa5fc4b-9eac-4a56-8bf0-7f457434a34b";
    }
    else if (100<_slider.currentMinValue&_slider.currentMaxValue<200){
        NSLog(@"100-200");
        self.ID20=@",d849870b-97e4-4279-bef9-122ced5c101f";
    }else if (200<_slider.currentMinValue&_slider.currentMaxValue<300){
        NSLog(@"200-300");
        self.ID20=@",18d04576-e625-48ff-92ea-59cac9661a4e";
    }else if (300<_slider.currentMinValue&_slider.currentMaxValue<500){
        NSLog(@"300-500");
        self.ID20=@",0006479d-be00-4a14-975a-5a30ec37aa07";
    }else if (500==_slider.currentMinValue){
        NSLog(@"500+");
        self.ID20=@",a5914511-70c1-4917-a101-1df94ee05a6b";
    }else{
        self.ID20=nil;
        NSLog(@"kong");
    }
    
   NSString *baseiiDD=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",self.ID1,self.ID2,self.ID3,self.ID4,self.ID5,self.ID6,self.ID7,self.ID8,self.ID9,self.ID10,self.ID11,self.ID12,self.ID13,self.ID14,self.ID15,self.ID16,self.ID17,self.ID18,self.ID19,self.ID20];
    self.BaseID=[baseiiDD substringFromIndex:1];
    
   
    
//    价格区间    _slider.currentMinValue   _slider.currentMaxValue
     NSLog(@" \n min %f \n max %f",_slider.currentMinValue,_slider.currentMaxValue);
    
    
//    收起选择栏
    self.tabBarController.tabBar.hidden = NO;
    self.scv.frame=CGRectMake(0, -self.view.frame.size.height, ScreenWidth, ScreenHight-64-44*ScreenWidth/375);
    self.saiXuanZView.frame=CGRectMake(0, ScreenHight+50*ScreenWidth/375, ScreenWidth, 50*ScreenWidth/375);
    [self.button3 setTitle:@"选择" forState:UIControlStateNormal];
    self.button3.selected = NO;
    [self addRershView];
}


#pragma mark - 最多宜居
- (void)yijuImagerightButtonAction{
    NSLog(@"加一");
    if (self.yiJuP<8) {
        self.yiJuP++;
    }
    if (self.yiJuP==8){
        self.yijuxuanzheLabel.text=@"不限";
    }else if (self.yiJuP==7){
        self.yijuxuanzheLabel.text=@"7+";
    }
    else{
        self.yijuxuanzheLabel.text=[NSString stringWithFormat:@"%ld",(long)self.yiJuP];
    }
}
- (void)yijuImageleftButtonAction{
    NSLog(@"减一");
    if (self.yiJuP>1) {
        self.yiJuP--;
    }
    if (self.yiJuP==8){
        self.yijuxuanzheLabel.text=@"不限";
    }else if (self.yiJuP==7){
        self.yijuxuanzheLabel.text=@"7+";
    }
    else{
        self.yijuxuanzheLabel.text=[NSString stringWithFormat:@"%ld",(long)self.yiJuP];
    }
    
}

#pragma mark - 配套设施
- (void)sheshiButton1{

    if ([self.strImageN1 isEqualToString:@"search_result_showerXXXyy_on"]) {
        self.strImageN1=@"search_result_showerXXXyy_off";
        self.sheshiButton1ImageV.image=[UIImage imageNamed:self.strImageN1];
    }else{
        self.strImageN1=@"search_result_showerXXXyy_on";
        self.sheshiButton1ImageV.image=[UIImage imageNamed:self.strImageN1];
    }
}

- (void)sheshiButton2{
    
    if ([self.strImageN2 isEqualToString:@"search_result_showerBBBXXX_on"]) {
       self.strImageN2=@"search_result_showerBBBXXX_off";
        self.sheshiButton2ImageV.image=[UIImage imageNamed:self.strImageN2];
    }else{
        self.strImageN2=@"search_result_showerBBBXXX_on";
        self.sheshiButton2ImageV.image=[UIImage imageNamed:self.strImageN2];
    }
    
}
- (void)sheshiButton3{
    
    if ([self.strImageN3 isEqualToString:@"search_result_kitchen_on"]) {
        self.strImageN3=@"search_result_kitchen_off";
        self.sheshiButton3ImageV.image=[UIImage imageNamed:self.strImageN3];
    }else{
        self.strImageN3=@"search_result_kitchen_on";
        self.sheshiButton3ImageV.image=[UIImage imageNamed:self.strImageN3];
    }
    
}
- (void)sheshiButton4{
    
    if ([self.strImageN4 isEqualToString:@"search_result_heating_on"]) {
        self.strImageN4=@"search_result_heating_off";
        self.sheshiButton4ImageV.image=[UIImage imageNamed:self.strImageN4];
    }else{
        self.strImageN4=@"search_result_heating_on";
        self.sheshiButton4ImageV.image=[UIImage imageNamed:self.strImageN4];
    }
}//
- (void)sheshiButton5{
    
    if ([self.strImageN5 isEqualToString:@"search_result_tv_on"]) {
        self.strImageN5=@"search_result_tv_off";
        self.sheshiButton5ImageV.image=[UIImage imageNamed:self.strImageN5];
    }else{
        self.strImageN5=@"search_result_tv_on";
        self.sheshiButton5ImageV.image=[UIImage imageNamed:self.strImageN5];
    }
    
}
- (void)sheshiButton6{
    
    if ([self.strImageN6 isEqualToString:@"search_result_toilet_on"]) {
        self.strImageN6=@"search_result_toilet_off";
        self.sheshiButton6ImageV.image=[UIImage imageNamed:self.strImageN6];
    }else{
        self.strImageN6=@"search_result_toilet_on";
        self.sheshiButton6ImageV.image=[UIImage imageNamed:self.strImageN6];
    }
    
}
- (void)sheshiButton7{
    
    if ([self.strImageN7 isEqualToString:@"search_result_netwwwwlllll_on"]) {
        self.strImageN7=@"search_result_netwwwwlllll_off";
        self.sheshiButton7ImageV.image=[UIImage imageNamed:self.strImageN7];
    }else{
        self.strImageN7=@"search_result_netwwwwlllll_on";
        self.sheshiButton7ImageV.image=[UIImage imageNamed:self.strImageN7];
    }
}
- (void)sheshiButton8{
    
    if ([self.strImageN8 isEqualToString:@"search_result_net_on"]) {
        self.strImageN8=@"search_result_net_off";
        self.sheshiButton8ImageV.image=[UIImage imageNamed:self.strImageN8];
    }else{
        self.strImageN8=@"search_result_net_on";
        self.sheshiButton8ImageV.image=[UIImage imageNamed:self.strImageN8];
    }
}

#pragma mark - 房屋户型
- (void)huxingButton1Action{
    
    if ([self.strImageN1huxing isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN1huxing=@"checkbox_sel";
        self.huxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1huxing];
        self.huxingLabel1.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN1huxing=@"checkbox_no_sel";
        self.huxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1huxing];
        self.huxingLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
    
}
- (void)huxingButton2Action{
    
    if ([self.strImageN2huxing isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN2huxing=@"checkbox_sel";
        self.huxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2huxing];
        self.huxingLabel2.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN2huxing=@"checkbox_no_sel";
        self.huxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2huxing];
        self.huxingLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
    
}
- (void)huxingButton3Action{
    
    if ([self.strImageN3huxing isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN3huxing=@"checkbox_sel";
        self.huxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3huxing];
        self.huxingLabel3.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN3huxing=@"checkbox_no_sel";
        self.huxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3huxing];
        self.huxingLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
    
}
//- (void)huxingButton4Action{
//    
//    if ([self.strImageN4huxing isEqualToString:@"checkbox_no_sel"]) {
//        self.strImageN4huxing=@"checkbox_sel";
//        self.huxingLabel4ImageV.image=[UIImage imageNamed:self.strImageN4huxing];
//        self.huxingLabel4.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
//    }else{
//        self.strImageN4huxing=@"checkbox_no_sel";
//        self.huxingLabel4ImageV.image=[UIImage imageNamed:self.strImageN4huxing];
//        self.huxingLabel4.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
//    }
//    
//}
//- (void)huxingButton5Action{
//    
//    if ([self.strImageN5huxing isEqualToString:@"checkbox_no_sel"]) {
//        self.strImageN5huxing=@"checkbox_sel";
//        self.huxingLabel5ImageV.image=[UIImage imageNamed:self.strImageN5huxing];
//        self.huxingLabel5.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
//    }else{
//        self.strImageN5huxing=@"checkbox_no_sel";
//        self.huxingLabel5ImageV.image=[UIImage imageNamed:self.strImageN5huxing];
//        self.huxingLabel5.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
//    }
//}

#pragma mark - 出租类型
- (void)chuzuButton1Action{
    
    if ([self.strImageN1chuzu isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN1chuzu=@"checkbox_sel";
        self.chuzuLabel1ImageV.image=[UIImage imageNamed:self.strImageN1chuzu];
        self.chuzuLabel1.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN1chuzu=@"checkbox_no_sel";
        self.chuzuLabel1ImageV.image=[UIImage imageNamed:self.strImageN1chuzu];
        self.chuzuLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
}
- (void)chuzuButton2Action{
    
    if ([self.strImageN2chuzu isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN2chuzu=@"checkbox_sel";
        self.chuzuLabel2ImageV.image=[UIImage imageNamed:self.strImageN2chuzu];
        self.chuzuLabel2.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN2chuzu=@"checkbox_no_sel";
        self.chuzuLabel2ImageV.image=[UIImage imageNamed:self.strImageN2chuzu];
        self.chuzuLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
}
- (void)chuzuButton3Action{
    
    if ([self.strImageN3chuzu isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN3chuzu=@"checkbox_sel";
        self.chuzuLabel3ImageV.image=[UIImage imageNamed:self.strImageN3chuzu];
        self.chuzuLabel3.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN3chuzu=@"checkbox_no_sel";
        self.chuzuLabel3ImageV.image=[UIImage imageNamed:self.strImageN3chuzu];
        self.chuzuLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
}

#pragma mark - 房型
- (void)fangxingButton1Action{
    
    if ([self.strImageN1fangxing isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN1fangxing=@"checkbox_sel";
        self.fangxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1fangxing];
        self.fangxingLabel1.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN1fangxing=@"checkbox_no_sel";
        self.fangxingLabel1ImageV.image=[UIImage imageNamed:self.strImageN1fangxing];
        self.fangxingLabel1.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
}
- (void)fangxingButton2Action{
    
    if ([self.strImageN2fangxing isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN2fangxing=@"checkbox_sel";
        self.fangxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2fangxing];
        self.fangxingLabel2.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN2fangxing=@"checkbox_no_sel";
        self.fangxingLabel2ImageV.image=[UIImage imageNamed:self.strImageN2fangxing];
        self.fangxingLabel2.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
}
- (void)fangxingButton3Action{
    
    if ([self.strImageN3fangxing isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN3fangxing=@"checkbox_sel";
        self.fangxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3fangxing];
        self.fangxingLabel3.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN3fangxing=@"checkbox_no_sel";
        self.fangxingLabel3ImageV.image=[UIImage imageNamed:self.strImageN3fangxing];
        self.fangxingLabel3.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
}
- (void)fangxingButton4Action{
    
    if ([self.strImageN4fangxing isEqualToString:@"checkbox_no_sel"]) {
        self.strImageN4fangxing=@"checkbox_sel";
        self.fangxingLabel4ImageV.image=[UIImage imageNamed:self.strImageN4fangxing];
        self.fangxingLabel4.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
    }else{
        self.strImageN4fangxing=@"checkbox_no_sel";
        self.fangxingLabel4ImageV.image=[UIImage imageNamed:self.strImageN4fangxing];
        self.fangxingLabel4.textColor=[UIColor colorWithRed:39.0/255.0 green:54.0/255.0 blue:70.0/255.0 alpha:1];
    }
}


@end
