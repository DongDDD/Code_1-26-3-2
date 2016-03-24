//
//  ZhanghaoXinxiTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhanghaoXinxiTableViewCell : UITableViewCell


@property (nonatomic,assign)NSInteger buttonTag;
@property (nonatomic,assign)float bili;

@property (weak, nonatomic) IBOutlet UIView *beurongView;


@property (weak, nonatomic) IBOutlet UILabel *label11;

@property (weak, nonatomic) IBOutlet UILabel *label12;

@property (weak, nonatomic) IBOutlet UILabel *label2;


@property (weak, nonatomic) IBOutlet UILabel *label31;
@property (weak, nonatomic) IBOutlet UILabel *label32;


-(void)setTheCell;


@end
