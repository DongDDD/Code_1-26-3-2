//
//  UpFaceView.m
//  Code_
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 lansi All rights reserved.
//

#import "UpFaceView.h"

@implementation UpFaceView


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.blackView = [[UIView alloc]initWithFrame:frame];
        self.blackView.backgroundColor = [UIColor blackColor];
        self.blackView.alpha = 0;
        [self addSubview:self.blackView];
        
        self.whiteView = [[UIView alloc]init];
        self.whiteView.frame = CGRectMake((ScreenWidth/6)*2, (ScreenWidth/375/6)*2, (ScreenWidth/6)*2, (ScreenWidth/375/6)*2);
        self.whiteView.center = self.center;
        self.whiteView.alpha = 0;
        self.whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteView];
        
        self.TakeFaceBut = [[UIButton alloc]init];
        self.TakeFaceBut.frame = CGRectMake(0, self.whiteView.frame.size.height/3, 40, 30);
        self.TakeFaceBut.backgroundColor = [UIColor yellowColor];
        [self.whiteView addSubview:self.TakeFaceBut];
        
        self.LocalFaceBut = [[UIButton alloc]init];
        self.LocalFaceBut.frame = CGRectMake(self.whiteView.frame.size.width/2, self.whiteView.frame.size.height/3, 40, 30);
        self.LocalFaceBut.backgroundColor = [UIColor redColor];
        [self.whiteView addSubview:self.LocalFaceBut];
        
        self.CancelBut = [[UIButton alloc]init];
        self.CancelBut.frame = CGRectMake(self.whiteView.frame.size.width/3, (self.whiteView.frame.size.height/3)*2, 40, 30);
        self.CancelBut.backgroundColor = [UIColor redColor];
        [self.whiteView addSubview:self.CancelBut];
        
    }
    return self;
}



 
@end
