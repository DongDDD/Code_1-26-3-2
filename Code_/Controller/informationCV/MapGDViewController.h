//
//  MapGDViewController.h
//  Code_
//
//  Created by 潘伟东 on 16/3/8.
//  Copyright © 2016年 东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "TuDing.h"
 
@interface MapGDViewController : UIViewController

//@property(nonatomic,retain)NSString *houseTitle;
//@property(nonatomic,retain)NSString *adrTitle;
@property(nonatomic,retain)TuDing *mapTD;
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;

@property(nonatomic,retain)NSMutableArray *GPSarray;

@property(nonatomic,retain)NSMutableArray *PriceArray;
@property(nonatomic,retain)NSString *strAdr;
@property(nonatomic,retain)NSMutableArray *alArray;
//@property(nonatomic,retain)NSArray *jsjPriceArr;
@end
