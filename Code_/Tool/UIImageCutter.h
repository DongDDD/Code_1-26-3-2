//
//  UIImageCutter.h
//  CutImageView
//
//  Created by admin on 15/10/20.
//  Copyright © 2015年 东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageCutter : UIView


+ (void)cutImageWithUIImageView:(UIImageView *)imageView urlString:(NSString *)urlString;
+ (void)cutImageAutoWithUIImageView:(UIImageView *)imageView urlString:(NSString *)urlString;

@end
