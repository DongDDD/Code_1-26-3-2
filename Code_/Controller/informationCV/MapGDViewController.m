//
//  MapGDViewController.m
//  Code_
//
//  Created by 潘伟东 on 16/3/8.
//  Copyright © 2016年 东. All rights reserved.
//
#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "MapGDViewController.h"
#import "MAMapKit/MAMapKit.h"
#import <CoreLocation/CoreLocation.h>//定位所需要导入的框架
#import "TuDing.h"
#import "CustomCalloutView.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "CommonUtility.h"
#import "GeocodeAnnotation.h"

@interface MapGDViewController ()<MAMapViewDelegate,CLLocationManagerDelegate,AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
}

@property(nonatomic,readwrite,assign)int pointIndex;
@property(nonatomic,retain)AMapGeocodeSearchRequest *geo;
@property(nonatomic,retain)UIView *tuView;
//@property(nonatomic,retain)NSMutableArray *jsjArr;


@end

@implementation MapGDViewController

//- (NSMutableArray *)dataArray
//{
//    if (!_jsjArr) {
//        self.jsjArr=[NSMutableArray array];
//    }
//    return _jsjArr;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"e41eb1c7065178fc6abe86602227f966";
    [AMapSearchServices sharedServices].apiKey = @"e41eb1c7065178fc6abe86602227f966";
     //导入高德地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
//----指南针----默认是开启状态，显示在地图的右上角。
    _mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
    
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 80); //设置指南针位置
    
//-----比例尺-----
    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
    
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 80);  //设置比例尺位置
    
    //NO表示禁用倾斜手势，YES表示开启
     _mapView.rotateCameraEnabled= NO;
    
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    //定位用户位置按钮
    [self setButton];
    
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    

//    self.jsjArr=[NSArray arrayWithObjects:@"¥100",@"¥150",@"¥100",@"¥120",@"¥268",@"¥198",@"¥350",@"¥318",@"¥208",@"¥208",@"¥169",nil];
    
//    若自定义定位经度圈样式，需将 MAMapView 的customizeUserLocationAccuracyCircleRepresentation 属性设置为 YES
    //构造AMapDistrictSearchRequest对象，keywords为必选项
    AMapDistrictSearchRequest *districtRequest = [[AMapDistrictSearchRequest alloc] init];
     districtRequest.keywords = self.strAdr;
    districtRequest.requireExtension = YES;
    
    //发起行政区划查询
    [_search AMapDistrictSearch:districtRequest];
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    self.geo = [[AMapGeocodeSearchRequest alloc] init];
    self.geo.address =@"从化";
//    [_search AMapGeocodeSearch:_geo];
    
    
    
}

//创建一个转化成图钉image的   view
//-(void)TuDingView{
//    self.tuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)]];
//    self.tuView.backgroundColor=
//    
//    
//    
//}







#pragma mark -   地理编码
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    //    NSLog(@"%i",response.geocodes.count);
    NSMutableArray *annotations = [NSMutableArray array];
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
//        NSLog(@"请求成功经纬度%f %f", obj.location.latitude,obj.location.longitude);
//        
        
        [annotations addObject:geocodeAnnotation];
    }];
    
    if (annotations.count == 1)
    {
        [_mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
        
    }
    
    
}
//------实现行政区划查询的回调函数
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response
{
    NSLog(@"response: %@", response);
    [self handleDistrictResponse:response];
}
- (void)handleDistrictResponse:(AMapDistrictSearchResponse *)response
{
    if (response == nil)
    {
        return;
    }
    //通过AMapDistrictSearchResponse对象处理搜索结果
    for (AMapDistrict *dist in response.districts)
    {
        MAPointAnnotation *poiAnnotation = [[MAPointAnnotation alloc] init];
        
        poiAnnotation.coordinate = CLLocationCoordinate2DMake(dist.center.latitude, dist.center.longitude);
        poiAnnotation.title      = dist.name;
        poiAnnotation.subtitle   = dist.adcode;
        
//        [_mapView addAnnotation:poiAnnotation];
        
        if (dist.polylines.count > 0)
        {
            MAMapRect bounds = MAMapRectZero;
            
            for (NSString *polylineStr in dist.polylines)
            {
                MAPolyline *polyline = [CommonUtility polylineForCoordinateString:polylineStr];
                [_mapView addOverlay:polyline];
                
                bounds = MAMapRectUnion(bounds, polyline.boundingMapRect);
            }
            
            [_mapView setVisibleMapRect:bounds animated:YES];
        }
    }
}
//

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
    _mapView.delegate = self;
    //开启定位
    _mapView.showsUserLocation = YES;   //YES 为打开定位，NO为关闭定位
    
////    在地图上添加大头针标注
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];

   
//     NSLog(@"----%@地图页面GPS数组",self.GPSarray);
     NSLog(@"----%@地图页面price数组",self.PriceArray);
//     NSLog(@"----%i:GPS数组成员数量",[self.GPSarray count]);

    NSMutableArray *gpsAR = [[NSMutableArray alloc] init];
    for (int index; index<self.alArray.count; index++) {
    
       
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        //         NSLog(@"----%i:GPS数组成员数量",[self.GPSarray count]);
        //         mapGD.latitude=[[self.GPSarray[a]  substringWithRange:NSMakeRange(10,9)] floatValue];
        //截取字符串
        CGFloat longitude=[[self.alArray[index][@"GPSInfo"] substringWithRange:NSMakeRange(0,9)] floatValue];
        CGFloat latitude=[[self.alArray[index][@"GPSInfo"] substringWithRange:NSMakeRange(10,9)] floatValue];
        
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        NSLog(@"---wwwwww%f",longitude);
        
        
        
        [_mapView addAnnotation:pointAnnotation];
        
    }
  
   
}


#pragma mark - MAAnnotation Protocol自定义的图钉
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomCalloutView *custom = (CustomCalloutView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (custom == nil)
        {
           
            custom = [[CustomCalloutView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//
        }
        
        NSMutableArray *gpsAR = [[NSMutableArray alloc] init];
        for (int index; index<self.alArray.count; index++) {
            
            [gpsAR addObject:self.alArray[index][@"Price"]];
        }
        
        
        NSMutableArray *priceArray = [[NSMutableArray alloc] init];
        for (int pIndex=0; pIndex<self.alArray.count; pIndex++) {
            
            MAPointAnnotation *maAnnotation = (MAPointAnnotation *)annotation;
            NSString *coordinateString = [NSString stringWithFormat:@"%f,%f", maAnnotation.coordinate.longitude, maAnnotation.coordinate.latitude];
            NSDictionary *dic = self.alArray[pIndex];
            [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSLog(@"key: %@, value: %@", key, obj);
                
                if ([obj isEqualToString:coordinateString]) {
                    
                    custom.priceLabel.text = gpsAR[pIndex][@"SalePrice"];
                }
            }];
            
            
            
//            [priceArray addObject:self.alArray[pIndex][@"SalePrice"]];
        }
        
        

        
        
        custom.imageView1.image = [UIImage imageNamed:@"price"];
        
        
        
//        custom.tag++;
//            NSLog(@"222当前custom.tag的值：%i",self.pointIndex);
            NSLog(@"222当前priceLabel的值：%@",custom.priceLabel.text);
        
           return custom;
        
    }
    
    return nil;
     
    
//    NSLog(@"-----%@",self.PriceArray);
}
#pragma mark - MAAnnotation Protocol点击气泡事件
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"%f ",view.annotation.coordinate.latitude);
    
    NSArray *array = [NSArray arrayWithArray:mapView.annotations];
    
    for (int i=0; i<array.count; i++)
    {
        
        if (view.annotation.coordinate.latitude==((MAPointAnnotation *)array[i]).coordinate.latitude)
        {
            NSLog(@"点击详情%f",view.annotation.coordinate.latitude);
//            InformationDetailsTableViewController *inforTC=[[InformationDetailsTableViewController alloc]init];
//            
//            
            
            
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
    
//        [self imageWithUIView:<#(UIView *)#>]
    }
     
    
    
    
    
    
    
}
#pragma mark - MAAnnotation Protocol气泡


- (UIImage*) imageWithUIView:(UIView*) view

{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
    
}
////官网提供的图钉
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout = YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
//        annotationView.enabled = YES; //默认为YES，当为NO时view忽略触摸事件
//        
//        annotationView.pinColor = MAPinAnnotationColorRed;
//        return annotationView;
//    }
//    return nil;
//}
//当位置更新时，会进行定位回调，通过回调函数，能获取到定位点的经纬度坐标
//-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
//updatingLocation:(BOOL)updatingLocation
//{
//    if(updatingLocation)
//    {
////        取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//    }
//}

-(void)setButton{
 
    UIButton * loctionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loctionButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/9-50, ScreenHight-80, ScreenWidth/5-5, ScreenHight/10)];
    loctionButton.backgroundColor=[UIColor whiteColor];
    
     //设置圆角
    loctionButton.layer.cornerRadius = 30;
    loctionButton.layer.masksToBounds = YES;
    //设置 按钮名称 和 点击事件。
     [loctionButton setImage:[UIImage imageNamed:@"dw"] forState:UIControlStateNormal];//给button添加image
//    [loctionButton setImage forState:];
    [loctionButton addTarget:self action:@selector(setUserLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loctionButton];
    
}
-(void)setUserLocation{
   
    //追踪用户位置.
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //显示模式
        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着用户位置移动
    NSLog(@"%@",self.strAdr);

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
