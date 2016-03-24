//
//  BaseMapViewController.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface BaseMapViewController : UIViewController<MAMapViewDelegate, AMapSearchDelegate,MAAnnotation>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

@property(nonatomic,assign)CGFloat mapLat;//传参
@property(nonatomic,assign)CGFloat mapLong;
@property(nonatomic,assign)CGFloat laDelta;
@property(nonatomic,assign)CGFloat loDelta;

- (void)returnAction;

- (NSString *)getApplicationName;
- (NSString *)getApplicationScheme;

@end
