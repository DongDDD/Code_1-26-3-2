//
//  LineDashPolyline.h
//  Code_
//
//  Created by 潘伟东 on 16/3/14.
//  Copyright © 2016年 东. All rights reserved.
//
#import <MAMapKit/MAPolyline.h>
#import <MAMapKit/MAOverlay.h>
#import <Foundation/Foundation.h>

@interface LineDashPolyline : NSObject

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly) MAMapRect boundingMapRect;

@property (nonatomic, retain)  MAPolyline *polyline;

- (id)initWithPolyline:(MAPolyline *)polyline;

@end
