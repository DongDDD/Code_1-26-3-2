//
//  XiangcunFenxiangTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiangcunFenxiangTableViewCell : UITableViewCell

@property(nonatomic,assign)float bili;


@property (weak, nonatomic) IBOutlet UILabel *fangdongShangLabel;


@property (weak, nonatomic) IBOutlet UILabel *fangdongFenxiangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fangdongTouxiangImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fangdongBeijingImageView;


-(void)setTheFenxiangTableViewCell:(NSDictionary *)dict;



@end
