//
//  HomeViewController.h
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MyViewController.h"

@interface HomeViewController : MyViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//整个界面的滑动－－上下滑动
@property (weak, nonatomic) IBOutlet UIScrollView *ZhenggeShouyeScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *daohanglanImageView;


@property (weak, nonatomic) IBOutlet UITextField *SousuoTextField;

@property (weak, nonatomic) IBOutlet UIButton *ErweimaButton;

@property (nonatomic,retain)   NSMutableArray *dataArray;



@property (weak, nonatomic) IBOutlet UIButton *HuiyuanButton;
@property (weak, nonatomic) IBOutlet UIImageView *HuodongImage;

@property (weak, nonatomic) IBOutlet UIButton *ChoujiangButton;

@property (weak, nonatomic) IBOutlet UIButton *QiandaoButton;

@property (weak, nonatomic) IBOutlet UIButton *ZhuceButton;

@property (nonatomic,assign) NSInteger sss;
-(void)getShouyeGuanggaoData;

@end
