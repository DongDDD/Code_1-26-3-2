//
//  CarouseFigureView.h
//  
//
//  Created by 丘东昌 on 15/2/14.
//  Copyright © 2015年 丘东昌. All rights reserved.
//
#import "UIImageCutter.h"
#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import <UIKit/UIKit.h>

@interface CarouseFigureView : UIView

@property(nonatomic,retain)NSArray *dataArray;

//@property(nonatomic,retain)NSMutableArray *picThumAr;
//
//@property(nonatomic,retain)NSMutableArray *picHighAr;

@property(nonatomic,retain)NSTimer *time;//定时器


@end
