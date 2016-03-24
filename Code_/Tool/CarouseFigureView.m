//
//  CarouseFigureView.m
//  
//
//  Created by 丘东昌 on 15/2/14.
//  Copyright © 2015年 丘东昌. All rights reserved.
//

#import "CarouseFigureView.h"


@interface CarouseFigureView()<UIScrollViewDelegate>

@property(nonatomic,retain)UIScrollView *scrollView;

@property(nonatomic,retain)UIPageControl *pageControl;

@property(nonatomic,retain)UILabel *textLabel;

@property(nonatomic,assign)NSInteger curpage;

@property(nonatomic,retain)NSMutableArray *curArray;

@end

@implementation CarouseFigureView

#pragma mark -1⃣️对控件进行初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self initWithScrollView];
        [self initWithPageControl];
        [self initWithTextLabel];
        
    }
    return self;
}

//初始化滑动视图
-(void)initWithScrollView
{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/4)];
    
    _scrollView.pagingEnabled=YES;
    
    _scrollView.contentSize=CGSizeMake(self.frame.size.width*3, 0);
    
    
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
    self.scrollView.delegate=self;//接收代理
    
    
//    _scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
     _scrollView.contentOffset=CGPointMake(self.frame.size.width/2, 0);
    self.curArray=[NSMutableArray arrayWithCapacity:3];//存放当前3个显示（图片名）
    
    
    for (int a=0; a<3; a++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*a, 0, self.frame.size.width, self.frame.size.height/4)];
        imageView.backgroundColor = [UIColor redColor];//图片背景颜色
        
        [_scrollView addSubview:imageView];
    }
    
    [self addSubview:_scrollView];
    
}

//初始化下面点位置
-(void)initWithPageControl
{
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2-35, self.frame.size.height/4-30, 70, 30)];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    [self addSubview:_pageControl];
}

//初始化文字显示位置
-(void)initWithTextLabel
{
    self.textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.frame.size.width-100, 30)];
    self.textLabel.textColor=[UIColor greenColor];
    
    //    [self addSubview:self.textLabel];
}

#pragma mark -

#pragma mark -方法
//获取索引
-(NSInteger)updateCurpage:(NSInteger)page
{
    NSInteger count=self.dataArray.count;//得知道总个数
    
    return (count + page)%count;
}

#pragma mark -重写数据源的set方法
-(void)setDataArray:(NSArray *)dataArray
{
    
    _dataArray=dataArray;
    [self updateCurViewWithPage:0];
    self.pageControl.numberOfPages=[self.dataArray count];//下面点的更新
    
    //    打开定时器
    self.time=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}


//替换数据源的方法
-(void)updateCurViewWithPage:(NSInteger)page
{
    
    //    首先得获取当前显示的上一张图片的索引
    NSInteger pre=[self updateCurpage:page-1];
    _curpage=[self updateCurpage:page];//当前显示的索引
    //    获取当前显示的下一张图片的索引
    NSInteger last=[self updateCurpage:page+1];
    
    
    //    删除数据源
    [self.curArray removeAllObjects];
    //    获取当前显示的三张图片放到数组里
    [self.curArray addObject:self.dataArray[pre]];
    [self.curArray addObject:self.dataArray[_curpage]];
    [self.curArray addObject:self.dataArray[last]];
    
    
    //    获取滑动视图上的所有子视图
    NSArray *array=self.scrollView.subviews;
    //    遍历子视图
    for (int i=0; i<3; i++) {
        UIImageView *imageView=array[i];
        //        imageView.image=[UIImage imageNamed:self.curArray[i]];//从外面获取的图片名字
        
        
        [UIImageCutter cutImageAutoWithUIImageView:imageView urlString:self.curArray[i]];
        
        
        
        //        显示的都是中间图片，判断下：
        if (i==1) {
            self.textLabel.text=self.curArray[i];
        }
        
    }
    
    //    设置当前显示的位置
    self.scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
    //    显示当前显示的第几个的下标
    self.pageControl.currentPage=_curpage;
    
}

#pragma mark -每次滑动都会调用该方法  ( 代理方法 )那么设置代理咯！
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    偏移量
    CGFloat x=self.scrollView.contentOffset.x;
    //    判断偏移量
    if (x>=self.frame.size.width*2) {
        //        调用替换数据源方法
        [self updateCurViewWithPage:_curpage+1];
    }
    else if (x<=0)
    {
        [self updateCurViewWithPage:_curpage-1];
        
    }
}

//开始滑动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    关闭定时器
    [self.time invalidate];
    self.time=nil;
    
}

//开始减速
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //    打开定时器
    self.time=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}
#pragma mark -
#pragma mark -定时器调用的方法
-(void)timerAction
{
    //    偏移
    self.scrollView.contentOffset=CGPointMake(self.frame.size.width*2, 0);
}




@end
