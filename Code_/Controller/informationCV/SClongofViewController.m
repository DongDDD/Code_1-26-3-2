//
//  SClongofViewController.m
//  Code_
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 东. All rights reserved.
//
#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "SClongofViewController.h"

@interface SClongofViewController ()

@end

@implementation SClongofViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrV = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.scrV];
    //设置scrV滚动范围
    self.scrV.contentSize = CGSizeMake(ScreenWidth, ScreenHight+10);
    
//    self.scrV.bounces = YES;
    //设置横竖方向指示条
    self.scrV.showsHorizontalScrollIndicator = NO;
    self.scrV.showsVerticalScrollIndicator = NO;
    
    //为ScrV设置代理
    self.scrV.delegate = self;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
