//
//  guanggaoXunhuan.h
//  shiyanFengzhuang
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol guanggaoDelegate <NSObject>


-(void)guanggaoDianji:(NSDictionary *)dict withTag:(NSInteger)tag;
@end





@interface guanggaoXunhuan : UIScrollView

@property(nonatomic,weak)id <guanggaoDelegate>delegate;
@property(nonatomic,strong)NSArray *dataArr;//传来的数据






//制作一个全局的timer，来定时滚动scrollView
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSTimer *delayTimer;

@property(nonatomic,strong)NSTimer *delayTimer2;

@property(nonatomic,strong)UIScrollView *myScrollview;

//设置页面控制器˜
@property(nonatomic,strong)UIPageControl *scrolPageControl;

@property(nonatomic,assign)NSInteger pageNumber;
//传入的图片数组
@property(nonatomic,copy)NSArray *imageArray;

@property(nonatomic,assign)int height;

@property(nonatomic,assign)int width;

-(void)setGuanggaoXunhuanWithImageArray:(NSArray *)array withPageNumber:(int)num withImageView:(UIImageView *)imageView;

-(void)setGuanggaoXunhuanWithImageArray:(NSArray *)array withPageNumber:(int)num withUIScrollView:(UIScrollView *)Scrollview withUIPageControl:(UIPageControl *)scrolPageControl;

/** 传入一个图片的数组与一个UIView类与CGSize(大小)，自动生成循环播放的广告*/
-(void)setGuanggaoXunhuanWithImageArray:(NSArray *)array withUIView:(UIView *)UIView withCGSize:(CGSize)CGSize;

@property(nonatomic,retain)UIImageView *informationImageView;
@end
