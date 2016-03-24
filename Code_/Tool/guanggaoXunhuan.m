//
//  guanggaoXunhuan.m
//  shiyanFengzhuang
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "guanggaoXunhuan.h"
#import <SDWebImage/UIButton+WebCache.h>
@interface UIScrollView ()<UIScrollViewDelegate>


@end
@implementation guanggaoXunhuan



-(void)setGuanggaoXunhuanWithImageArray:(NSArray *)array withPageNumber:(int)num withImageView:(UIImageView *)imageView{

    [self setMyScrollview];
    
    [self setScrolTimer];
    
    [self setPageControl];
  
}
-(void)setGuanggaoXunhuanWithImageArray:(NSArray *)array withPageNumber:(int)num withUIScrollView:(UIScrollView *)Scrollview withUIPageControl:(UIPageControl *)scrolPageControl{
    
    self.myScrollview = Scrollview;
    
    self.scrolPageControl = scrolPageControl;
    
    [self setMyScrollview];
    [self setScrolTimer];
    [self setPageControl];
}

-(void)setGuanggaoXunhuanWithImageArray:(NSArray *)array withUIView:(UIView *)View withCGSize:(CGSize)CGSize{
    
    //_imageArray = array;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:array[array.count-1]];
    [arr addObjectsFromArray:array];
    [arr addObject:array[0]];
    
    _imageArray = arr;
    
    
    _pageNumber = _imageArray.count;
    _width = CGSize.width;
    NSLog(@"现在的宽是%d",_width);
    _height = CGSize.height;
    
    
    //创建一个scrollview
    self.myScrollview = [[UIScrollView alloc]init];
    
    self.myScrollview.frame = CGRectMake(0, 0, _width, _height);
    
    self.myScrollview.delegate = self;
    
    self.myScrollview.backgroundColor = [UIColor greenColor];
    
    [View addSubview:self.myScrollview];
    
    self.scrolPageControl = [[UIPageControl alloc]init];
    
    self.scrolPageControl.frame = CGRectMake((_width-120)/2, _height-50, 120, 50);
    
    [View addSubview:self.scrolPageControl];
    
    
    [self setMyScrollview];
    [self setPageControl];
    [self setScrolTimer];
    
}



-(void)setMyScrollview{
    
    //设置按钮内容图片
    for (int i = 0; i < self.pageNumber; i ++) {
        
        UIButton *button = [[UIButton alloc]init];
        
        button.frame = CGRectMake(i * _width, 0, _width, _height);
        
        button.tag = i+1;
        
       // [button setBackgroundImage:[UIImage imageNamed:_imageArray[i]] forState:UIControlStateNormal];
        //button下载网络图片做背景图
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:_imageArray[i][@"ThumbAPP"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"7.png"]];
        //设置按钮点击的方法
        [button addTarget:self action:@selector(guanggaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.myScrollview addSubview:button];
    }
    
    //设置scrollView的实际内容大小
    [self.myScrollview setContentSize:CGSizeMake(_width * _pageNumber, _height)];
    
    //设置分页
    self.myScrollview.pagingEnabled = YES;
    
    self.myScrollview.bounces = NO;
    
    //设置初始显示位置
    [self.myScrollview setContentOffset:CGPointMake(_width, 0)];
}

-(void)setScrolTimer{
    //每隔两秒滚动ScrollView
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(scrolMainScrollView) userInfo:nil repeats:YES];
}

-(void)setPageControl{
    
    //设置pageControl属性
    //设置page的总页数
    self.scrolPageControl.numberOfPages = self.pageNumber-2;
    //设置当前页数
    self.scrolPageControl.currentPage = 0;
    
    //当pageControl的值改变时调用这个方法（用户触发）
    [self.scrolPageControl addTarget:self action:@selector(pageControlValueChage) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - 通过pageControl改变scrollView的当前位置
-(void)pageControlValueChage{
    
    [self.myScrollview scrollRectToVisible:CGRectMake((self.scrolPageControl.currentPage + 1) * _width, 0, _width, _height) animated:YES];
    
    //关掉时间
    //[self.timer invalidate];
    
    //在重新生成timer前，把之前使用的timer销毁
//    if (self.delayTimer2) {
//        [self.delayTimer2 invalidate];
//        self.delayTimer2 = nil;
//    }
    
    //相隔0.7秒重新恢复时间滚动scrollView
    //self.delayTimer2 = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(setScrolTimer) userInfo:nil repeats:NO];
}

-(void)scrolMainScrollView{
    float currentX = self.myScrollview.contentOffset.x + _width;
    //滚动到某个位置
    //CGRect设置将要滚动到的地方
    //animated设置是否需要滚动动画
    [self.myScrollview scrollRectToVisible:CGRectMake(currentX, 0, _width, _height) animated:YES];
    
    
    //制作一个延时改变timer
    
    //在重新生成timer前，把之前使用的timer销毁
//    if (self.delayTimer) {
//        [self.delayTimer invalidate];
//        self.delayTimer = nil;
//    }
    
    //self.delayTimer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(delayTimerValueChange) userInfo:nil repeats:NO];
    
    
    //当他跑到第6张图片时，在动画开始前，直接把scrollView的位置返回到第1张图片中
    if(currentX >= _width * (_pageNumber-1)){
        [self.myScrollview setContentOffset:CGPointMake(0, 0)];
    }
    //调用改变页码的方法
    [self changePageValue];
}

-(void)delayTimerValueChange{
    [self changePageValue];
}

#pragma mark - scrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //在拖拽时，销毁滚动视图的时间timer
    //[self.timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //设置到最后一个界面(假1)时返回到第一个界面（真1）
    
    if (scrollView.contentOffset.x >= _width * (_pageNumber-1)) {
        if (decelerate == NO) {
            //回到第一个界面
            [scrollView setContentOffset:CGPointMake(_width, 0)];
        }
    }
    
    if (scrollView.contentOffset.x <= 0) {
        if (decelerate == NO) {
            //回到最后一个界面
            [scrollView setContentOffset:CGPointMake(_width * (_pageNumber-2), 0)];
        }
    }
    
    [self changePageValue];
    
    //重新开启时间滚动scrollView
    //[self setScrolTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.x >= _width * (_pageNumber-1)) {
        //回到第一个界面
        [scrollView setContentOffset:CGPointMake(_width, 0)];
    }
    
    if (scrollView.contentOffset.x <= 0) {
        //回到最后一个界面
        [scrollView setContentOffset:CGPointMake(_width * (_pageNumber-2), 0)];
    }
    
    //调用改变页码的方法
    [self changePageValue];
}

#pragma mark -计算页码的方法
-(void)changePageValue{
    //计算当前的页码
    int page = self.myScrollview.contentOffset.x / _width;
    
    if (page == 0) {
        page = (int)(_pageNumber-3);
    }
    else if(page == (_pageNumber-1)){
        page = 0;
    }
    else{
        page --;
    }
    
    //currentPage取值0~4
    self.scrolPageControl.currentPage = page;
}
#pragma mark - 按钮点击事件
-(void)guanggaoButtonClick:(UIButton *)button{
    NSLog(@"点击了广告循环");
    
    NSDictionary *dic = _imageArray[button.tag-1];
    NSLog(@"=======%@",dic);
    
    [self.delegate guanggaoDianji:dic withTag:button.tag];
    
    //[self.delegate  guanggaoDianji:nil withTag:button.tag];
     
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
