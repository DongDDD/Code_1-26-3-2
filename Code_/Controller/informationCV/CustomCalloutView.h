//
//  CustomCalloutView.h
//  Code_
//
//  Created by 潘伟东 on 16/3/11.
//  Copyright © 2016年 东. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomCalloutView :MAAnnotationView <MAAnnotation>
//@property(nonatomic,retain)NSString *price;

@property(nonatomic,retain)UILabel * priceLabel;
@property(nonatomic,retain)UIImageView *imageView1;

 
//-(void)setButton:(NSString *)text;
@end
