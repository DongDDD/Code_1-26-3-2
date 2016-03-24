//
//  ZhanghaoXinxiTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 东. All rights reserved.
//

#import "ZhanghaoXinxiTableViewCell.h"

@implementation ZhanghaoXinxiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}





-(void)setTheCell{
    
//    UILabel *label = [[UILabel alloc]init];
//    label.frame = CGRectMake(17, 0, 300, 20);
    [self changTheFont];
    switch (_buttonTag/10) {
        case 1:
            [self setTheChangyongZhuke];
            break;
        case 2:
            [self setTheDizhi];
            break;
        case 3:
            [self setTheFapiao];
            break;
        default:
            break;
    }
}

-(void)changTheFont{
    _label11.font = [UIFont systemFontOfSize:13*_bili];
    _label12.font = [UIFont systemFontOfSize:11*_bili];
    _label2.font = [UIFont systemFontOfSize:11*_bili];
    _label31.font = [UIFont systemFontOfSize:11*_bili];
    _label32.font = [UIFont systemFontOfSize:11*_bili];

}

#pragma mark - 设置常用住客显示
-(void)setTheChangyongZhuke{
    
    
    
    
}
#pragma mark - 设置常用地址显示
-(void)setTheDizhi{
    
    _label31.text = @"邮政编码";
    _label32.text = @"0269";
    _label2.text = @"广东省广州市天河区龙东路北320号";
    _label11.text = @"李轻水";
    _label12.text = @"135****6789";
}
#pragma mark - 设置发票抬头显示
-(void)setTheFapiao{

    _label2.text = @"广州和普信息科技有限公司";
    
    [_label11 removeFromSuperview];
    [_label12 removeFromSuperview];
    [_label31 removeFromSuperview];
    [_label32 removeFromSuperview];
    
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
