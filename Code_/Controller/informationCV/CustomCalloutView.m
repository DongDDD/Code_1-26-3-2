//
//  CustomCalloutView.m
//  Code_
//
//  Created by 潘伟东 on 16/3/11.
//  Copyright © 2016年 东. All rights reserved.
//

#define kArrorHeight        10
#import "CustomCalloutView.h"
#import "InformationDetailsTableViewController.h"

@implementation CustomCalloutView


 - (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
     self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
     if (self) {
         self.frame=CGRectMake(0, 0, 80, 50);
         self.backgroundColor=[UIColor clearColor];
         [self setLabel];
         
     }
     
     return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    if (self.selected == selected) {
        return;
    }
    
    if (selected) {
        NSLog(@"点击详情");
        InformationDetailsTableViewController *inforTC=[[InformationDetailsTableViewController alloc]init];
        
        
        
        
        //<<<<<<< .mine
        //    //    inforTC.stiTite=@"从化温泉富力泉天下独栋豪华度假";
        //=======
        ////    inforTC.stiTite=@"从化温泉富力泉天下独栋豪华度假";
        //>>>>>>> .r1245
        
//        informaAmode *infora=self.dataArray[indexPath.row];
//        inforTC.HouseIdStr=infora.HouseId;
//        inforTC.stiTite=infora.HouseName;
//        [self pushViewController:inforTC animated:YES];
    }
//    if (self.selected == selected)
//    {
//        return;
//    }
//    
//    if (selected)
//    {
//        if (self.calloutView == nil)
//        {
//            /* Construct custom callout. */
//            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            btn.frame = CGRectMake(10, 10, 40, 40);
//            [btn setTitle:@"Test" forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//            [btn setBackgroundColor:[UIColor whiteColor]];
//            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.calloutView addSubview:btn];
//            
//            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
//            name.backgroundColor = [UIColor clearColor];
//            name.textColor = [UIColor whiteColor];
//            name.text = @"Hello Amap!";
//            [self.calloutView addSubview:name];
//        }
//        
//        [self addSubview:self.calloutView];
//    }
//    else
//    {
//        [self.calloutView removeFromSuperview];
//    }
//    
    [super setSelected:selected animated:animated];
}
//重写UIView的drawRect方法，绘制弹出气泡的背景
- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:249 green:255 blue:249 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 8.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}




-(void)setLabel{
    
    self.imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.imageView1.backgroundColor=[UIColor redColor];
    [self addSubview:self.imageView1];
    
    
    
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
//    button.backgroundColor=[UIColor Color];
//    [button setTitle:@"ptptptptt" forState:UIControlStateNormal];
    self.priceLabel.textColor=[UIColor blackColor];
//    [button addTarget:self action:@selector(houseInformation) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.priceLabel];
    
    
    
}

-(void)setLabelText:(NSString *)text{
    
    
    self.priceLabel.text = text;
    NSLog(@"---",self.priceLabel.text);
 

}

//-(void)setButtonText:(NSString *)text {
////    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:text forState:UIControlStateNormal];
//    
//    
//}


-(void)houseInformation{
    
    NSLog(@"---houseDetail---");
    
    
}





@end
