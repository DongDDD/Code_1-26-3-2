//
//  OpenAMapURLRequestViewController.m
//  officialDemo2D
//
//  Created by xiaoming han on 15/6/12.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//
#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "OpenAMapURLRequestViewController.h"
#import <CoreLocation/CoreLocation.h>//定位所需要导入的框架  1.

@interface OpenAMapURLRequestViewController ()<CLLocationManagerDelegate>
{
    MAPointAnnotation *_startAnnotation;
    MAPointAnnotation *_endAnnotation;
}
@property(nonatomic,retain)CLLocationManager *mgr;
@property (nonatomic)CLLocationCoordinate2D coords;
@property(nonatomic,retain)NSString *strName;
@end

@implementation OpenAMapURLRequestViewController


#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        
        if (annotation == _startAnnotation)
        {
            annotationView.pinColor = MAPinAnnotationColorGreen;
        }
        else
        {
            annotationView.pinColor = MAPinAnnotationColorRed;
        }
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mgr=[[CLLocationManager alloc]init];
    self.mgr.delegate=self;
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0){
         [self.mgr requestAlwaysAuthorization];
    }else
    {
         [self.mgr startUpdatingLocation];
    }
    self.mgr.desiredAccuracy=kCLLocationAccuracyBest;
#pragma mark -  每隔一点距离定位一次（单位米）
        self.mgr.distanceFilter=20;
    
    [self addAnntation];
    
    
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 10, 17);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(fanhuAction1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, ScreenWidth-50, 44)];
    title.text = @"地图查看";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:17];
    self.navigationItem.titleView = title;
}


-(void)fanhuAction1
{
    [self.mgr stopUpdatingLocation];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
    
    [self clearSearch];
}

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)clearSearch
{
    self.search.delegate = nil;
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
#pragma mark -   根据返回的状态开启定位
    if (status==kCLAuthorizationStatusAuthorizedAlways ||status==kCLAuthorizationStatusAuthorizedWhenInUse) {
        //        开启定位
        [self.mgr startUpdatingLocation];
    }
}

#pragma mark -   获取定位的位置信息   4.5
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    //    获取我当前位置
    CLLocation *location=[locations lastObject];
    CLLocationCoordinate2D coord=location.coordinate;
    //    地理反编码
    //    创建反编码对象（经纬度转化为实际位置）
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks,NSError *error){
        for (CLPlacemark *pl in placemarks) {
            NSLog(@"***************name=%@",pl.name);
            
            NSLog(@"************thoroughfare=%@",pl.thoroughfare);
            
            NSLog(@"*********locality=%@",pl.locality);
            
             [self.mapView removeAnnotations:self.mapView.annotations];
            self.coords=coord;
            self.strName=pl.name;
            [self addAnntation];
        }
    }];
    
    NSLog(@"%@",locations);
//     [self.mgr stopUpdatingLocation];
}

- (void)addAnntation
{
    _startAnnotation = [[MAPointAnnotation alloc] init];
    _startAnnotation.coordinate =self.coords;
    _startAnnotation.title = @"当前位置";
    _startAnnotation.subtitle=self.strName;
    [self.mapView addAnnotation:_startAnnotation];
    
    _endAnnotation = [[MAPointAnnotation alloc] init];
    _endAnnotation.coordinate =CLLocationCoordinate2DMake(self.mapLat,self.mapLong);
    _endAnnotation.title = @"目的地";
    _endAnnotation.subtitle=@"，，";
    [self.mapView addAnnotation:_endAnnotation];
    
    MACoordinateSpan span;
    span.latitudeDelta = self.laDelta;
    span.longitudeDelta = self.loDelta;
    
    //设置显示的中心点和比例
    MACoordinateRegion region = {_endAnnotation.coordinate, span};
    [self.mapView setRegion:region];

}

@end
