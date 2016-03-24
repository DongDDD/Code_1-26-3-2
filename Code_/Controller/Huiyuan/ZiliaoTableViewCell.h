//
//  ZiliaoTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiliaoTableViewCell : UITableViewCell


@property(nonatomic,strong)NSDictionary *dataDict;


@property(nonatomic,assign)float bili;


@property (weak, nonatomic) IBOutlet UILabel *Label1;

@property (weak, nonatomic) IBOutlet UILabel *Label2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;


@property (weak, nonatomic) IBOutlet UIImageView *imageView2;


-(void)setTheCell:(NSDictionary *)dict;







@end
