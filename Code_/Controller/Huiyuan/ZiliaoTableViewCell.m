//
//  ZiliaoTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 东. All rights reserved.
//

#import "ZiliaoTableViewCell.h"

@implementation ZiliaoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setTheCell:(NSDictionary *)dict{
    
    
    _dataDict = dict;
    
    [self changeTheFrame];
    if ([dict[@"1"]isEqualToString:@""]) {
        
        
        self.backgroundColor = [UIColor colorWithRed:45/255.0 green:102/255.0 blue:105/255.0 alpha:0.12];
        _imageView2.backgroundColor = [UIColor clearColor];
        
        
    }else if([dict[@"1"] isEqualToString:@"会员等级"]||[dict[@"1"] isEqualToString:@"修改密码"]){
        
         _imageView2.backgroundColor = [UIColor clearColor];
        
    }else if([dict[@"1"] isEqualToString:@"修改密码"]){
        
    }else{
        
    }
    _Label1.text = dict[@"1"];
    _Label2.text = dict[@"2"];
    _imageView1.image = [UIImage imageNamed:dict[@"3"]];
  
    
}


-(void)changeTheFrame{
    
    if ([_dataDict[@"1"] isEqualToString:@"头像"]) {
        _Label1.frame = CGRectMake(17*_bili, 20*_bili, 60*_bili, 14*_bili);
        
        _imageView1.frame = CGRectMake(241*_bili, 6*_bili, 42*_bili, 42*_bili);
        _imageView1.backgroundColor = [UIColor colorWithRed:45/255.0 green:102/255.0 blue:105/255.0 alpha:0.12];
        
        _imageView2.frame = CGRectMake(0, 54*_bili, 300*_bili, 1);
        
        _imageView1.layer.cornerRadius=21*_bili;
        NSLog(@"touxiangshezhi");
        
    }else{
        _Label1.frame = CGRectMake(17*_bili, 10*_bili, 60*_bili, 14*_bili);
        
        _Label2.frame = CGRectMake(225*_bili, 12*_bili, 40*_bili, 10*_bili);
        
        _imageView1.frame = CGRectMake(276*_bili, 9*_bili, 9*_bili, 14*_bili);
        
        _imageView2.frame = CGRectMake(0, 35*_bili, 300*_bili, 1);
    }
    
    
    _Label1.font = [UIFont systemFontOfSize:15.0*_bili];
    _Label2.font = [UIFont systemFontOfSize:10.0*_bili];
      
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
