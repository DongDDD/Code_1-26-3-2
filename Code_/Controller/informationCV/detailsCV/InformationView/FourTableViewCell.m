//
//  FourTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//

#import "FourTableViewCell.h"

@implementation FourTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7, 0, ScreenWidth-14, 2)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.3;
        [self.contentView addSubview:headS];
        
        
        
        
        //
        
        //            [BaseIdArray addObject:cBaseId];
        //            [BaseNameArray addObject:cBaseName];
        //            NSLog(@"BaseId数组---ThumbArray:%@",BaseIdArray);
        //            NSLog(@"BaseName数组---highbArray:%@",BaseNameArray);
        //
        
        
        
        
        
        
        
        
        //       self.WCImageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 2*ScreenWidth/375,ScreenWidth, 85*ScreenWidth/375)];
        //       self.WCImageV.image=[UIImage imageNamed:@"零时图"];
        //        [self.contentView addSubview:self.WCImageV];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 85, ScreenWidth, 5)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.3;
        [self.contentView addSubview:foot];
        
    }
    return self;
}

@end
