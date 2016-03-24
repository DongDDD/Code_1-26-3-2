//
//  foundFourTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//
#import "MyTableViewCell.h"
#import <UIKit/UIKit.h>

//创建一个代理
@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;

@end

@interface foundFourTableViewCell : MyTableViewCell

@property(nonatomic,retain)UIImageView *imageV;
@property(nonatomic,retain)UILabel *titeLabel;

@property(nonatomic,retain)NSArray *array;


//声明一个代码块
@property(strong,nonatomic)void(^btnClick)();



@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
