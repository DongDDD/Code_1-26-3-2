//
//  AutoAdjustFrame.m
//  UITableViewSenior
//
//  Created by 东 on 15/9/4.
//  Copyright (c) 2015年 东. All rights reserved.
//

#import "AutoAdjustFrame.h"

@implementation AutoAdjustFrame

//求字符串高度
+ (CGFloat)heightForString:(NSString *)str font:(NSInteger)font width:(CGFloat)width{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
   CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
      return rect.size.height;
}











@end
