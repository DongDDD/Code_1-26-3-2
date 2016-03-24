//
//  DingdanTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol fanhuiXuanzeDeDingdanDelegate <NSObject>


-(void)fanhuiXuanzeDeDingdan:(NSDictionary *)dict withTag:(NSInteger)tag;
@end







@interface DingdanTableViewCell : UITableViewCell

@property(nonatomic,weak)id <fanhuiXuanzeDeDingdanDelegate>delegate;

@property(nonatomic,assign)BOOL chakanOrZhifu;//是否显示按钮

@property(nonatomic,assign)float bili;

/** 把字典传给cell进行赋值*/
-(void)jiazaiShuju:(NSDictionary *)dict;




@property (nonatomic,assign)NSInteger xianshiLan;

@property (nonatomic,assign)NSInteger zhifuButtonTag;



@property (weak, nonatomic) IBOutlet UIImageView *tupianImageView;

@property (weak, nonatomic) IBOutlet UILabel *mingchengLabel;

@property (weak, nonatomic) IBOutlet UIButton *dizhiButton;

@property (weak, nonatomic) IBOutlet UILabel *jiageLabel;

@property (weak, nonatomic) IBOutlet UILabel *jutiJiageLabel;


@property (weak, nonatomic) IBOutlet UIButton *pingjiaButton;

@property (weak, nonatomic) IBOutlet UIImageView *xiahuaxianImageView;






@end
