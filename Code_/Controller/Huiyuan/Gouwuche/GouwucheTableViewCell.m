//
//  GouwucheTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 东. All rights reserved.
//

#import "GouwucheTableViewCell.h"

@implementation GouwucheTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setTheCell:(NSDictionary *)dict{
    
    _duoxuanButton.selected = _xuanze;
    _dict = dict;
    
    
    // 设置选择项
    _jiajianSegmented.selectedSegmentIndex = 1;
    [_jiajianSegmented addTarget:self action:@selector(segmentChang:) forControlEvents:UIControlEventValueChanged];
    [_duoxuanButton addTarget:self action:@selector(duoxuanButtonClick:) forControlEvents:UIControlEventTouchDown];
    
//    if (_quanxuanButtonSelected) {
//        _duoxuanButton.selected = YES;
//    }
    
    
    [self fuzhi:dict];
    
    
    
    
}
- (void)segmentChang:(UISegmentedControl *)segment{
    // 获取设置选择项的值
    
    if (segment.selectedSegmentIndex == 0) {
        if (_shuliang!=1) {
            _shuliang--;
            //[_jiajianSegmented setTitle:[NSString stringWithFormat:@"%.0f",_shuliang] forSegmentAtIndex:1];//设置指定索引的题目
            NSLog(@"现在是减少数量，原总金额是%@",_jiaqianLabel.text);
           // _jiaqianLabel.text = [NSString stringWithFormat:@"总金额:￥%.2f",(_shuliang * _danjia)];
        }
    }else if(segment.selectedSegmentIndex == 2){
        _shuliang++;
                NSLog(@"现在是增加数量，原总金额是%@",_jiaqianLabel.text);
       
    }
    _dict = @{@"1":[NSString stringWithFormat:@"%.2f",_shuliang*_danjia],
                           @"geshu":[NSString stringWithFormat:@"%.0f",_shuliang],
                           @"danjia":[NSString stringWithFormat:@"%.2f",_danjia]};
    
    [_jiajianSegmented setTitle:_dict[@"geshu"] forSegmentAtIndex:1];//设置显示更改后的数量
     _jiaqianLabel.text = _dict[@"1"];//设置显示更改后的总价
    
    // 设置选择项
    _jiajianSegmented.selectedSegmentIndex = 1;
    
   [self.delegate xiugaiShuliang:_dict withTag:_indexPathRow withButtonSelected:_duoxuanButton.selected];
    //[self.delegate fanhuiXuanzeDeShangpin:_dict withTag:_indexPathRow withButtonSelected:_duoxuanButton.isSelected];
    
    NSLog(@"segment:%ld",(long)segment.selectedSegmentIndex);
}



#pragma mark - 设置选择商品后的方法
-(void)duoxuanButtonClick:(UIButton *)button{
       _duoxuanButton.selected = !_duoxuanButton.isSelected;
    int a;
    if (_duoxuanButton.selected == YES) {
        a = 1;
    }else{
        a = 0;
    }

    NSLog(@"修改后的数据:%@,返回的地标:%ld,选择按钮的状态:%d",_dict,(long)_indexPathRow,a);
    
    NSLog(@"点击了选择商品的按钮");
    [self.delegate fanhuiXuanzeDeShangpin:_dict withTag:_indexPathRow withButtonSelected:_duoxuanButton.isSelected];

    
    
}

#pragma mark - 给cell赋值
-(void)fuzhi:(NSDictionary *)dict{
    NSLog(@"赋值");
    [_jiajianSegmented setTitle:dict[@"geshu"] forSegmentAtIndex:1];//设置指定索引的题目
    _jiaqianLabel.text = [NSString stringWithFormat:@"总金额:￥%@",dict[@"1"]];
    _shuliang = [dict[@"geshu"] floatValue];
    _danjia = [dict[@"danjia"] floatValue];
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
