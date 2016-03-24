 //
//  InformationDetailsTableViewController.m
//  Code_
//
//  Created by admin on 15/12/16.
//  Copyright © 2015年 东. All rights reserved.
//
#import <YTKKeyValueStore.h>
#import "MJExtension.h"//rili
#import "TicketModel.h"//rili
#import "RMCalendarController.h"//rili
#import "BaseMapViewController.h"
#import "inforFacilitiesTableViewController.h"//配套设施
#import "inforCommentsTableViewController.h"//租客评论
#import "inforDescribeTableViewController.h"//房屋描述
#import "CheckTableViewController.h"//入住须知
#import "inforSurroundingTableViewController.h"//周边
//#import "MapViewController.h"
#import "SevenTableViewCell.h"
#import "SixTableViewCell.h"
#import "FiveTableViewCell.h"
#import "FourTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "towTableViewCell.h"
#import "oneTableViewCell.h"
#import "ZeroTableViewCell.h"
#import "InformationDetailsTableViewController.h"
#import "AutoAdjustFrame.h"
#import "reserveViewController.h"
#import "InformationDetailsModer.h"
#import "PicDetailModer.h"
#import "CarouseFigureView.h"
#import "ExtDetailModer.h"
#import "MapGDViewController.h"


@interface InformationDetailsTableViewController ()
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain) InformationDetailsModer *inforModer;
@property(nonatomic,retain) PicDetailModer *picModer;
@property(nonatomic,retain) ExtDetailModer *extModer;
@property(nonatomic,retain) UILabel *BiaoTi;


@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic,strong)NSDictionary *dataDict;

@end


@implementation InformationDetailsTableViewController

@synthesize mapView     = _mapView;
@synthesize search      = _search;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    NSLog(@"FFffffff");
    
    [self tableviews];
    self.picModer=[[PicDetailModer alloc]init];
    self.inforModer=[[InformationDetailsModer alloc]init];
    self.extModer=[[ExtDetailModer alloc]init];
    //    [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/5-(ScreenWidth/5)/4, (ScreenHight/4)/6)];
    
    self.BiaoTi= [[UILabel alloc]initWithFrame:CGRectMake(25, 0, ScreenWidth-50, 44)];
    //    self.title.text = self.inforModer.HouseName;
    //    NSLog(@"----%@:houseName",self.inforModer.HouseName);
    self.BiaoTi.textAlignment = NSTextAlignmentCenter;
    self.BiaoTi.textColor = [UIColor whiteColor];
    self.BiaoTi.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
    self.navigationItem.titleView = self.BiaoTi;
    //    [self getData];
    //    UIView *addvie=[[UIView alloc]init];
    //    addvie.frame=CGRectMake(0, ScreenHight-90, ScreenWidth, 40);
    //    addvie.backgroundColor=[UIColor redColor];
    //    [self.view addSubview:addvie];
    
    [self initMapView];
    [self initSearch];
    
    UIButton *sao=[UIButton buttonWithType:UIButtonTypeSystem];
    sao.frame=CGRectMake(0, 0, 30, 30);
    [sao setBackgroundImage:[UIImage imageNamed:@"地图"] forState:UIControlStateNormal];
    [sao addTarget:self action:@selector(saoAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn=[[UIBarButtonItem alloc]initWithCustomView:sao];
    self.navigationItem.rightBarButtonItem=currentMusicBtn;
    
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 10, 17);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(fanhuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
    
}


//初始化滑动视图
-(void)initWithScrollView
{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHight/4)];
    
    _scrollView.pagingEnabled=YES;
    
    _scrollView.contentSize=CGSizeMake(ScreenWidth*3, 0);
    
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    //
    self.scrollView.delegate=self;//接收代理
    //
    //
    _scrollView.contentOffset=CGPointMake(0, 0);
    //
    //    self.curArray=[NSMutableArray arrayWithCapacity:3];//存放当前3个显示（图片名）
    //
    //
    for (int a=0; a<3; a++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*a, 0,ScreenWidth, ScreenHight/4)];
        imageView.backgroundColor = [UIColor redColor];//图片背景颜色
        
        NSURL *url = [NSURL URLWithString:self.picModer.picThumArray[a]];
        //        NSURL *url = [NSURL URLWithString:@"http://pic31.nipic.com/20130728/8821914_172637249163_2.jpg"];
        NSLog(@"---aaaa%@:Thumarr",url);
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        imageView.image = [UIImage imageWithData:imageData];
        
        
        
        [_scrollView addSubview:imageView];
    }
    
    [self.tableV addSubview:_scrollView];
    
    
}

-(void)initWithPageControl
{
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenWidth/2-35, ScreenHight/4-30, 70, 30)];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.tableV  bringSubviewToFront:self.pageControl];
    NSLog(@"qqqqqqqq");
}

//开始滑动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    关闭定时器
    [self.time invalidate];
    self.time=nil;
    
}

//开始减速
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //    打开定时器
    self.time=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}
#pragma mark -
#pragma mark -定时器调用的方法
-(void)timerAction
{
    //    偏移
    self.scrollView.contentOffset=CGPointMake(ScreenWidth*1, 0);
}


#pragma mark -每次滑动都会调用该方法  ( 代理方法 )那么设置代理咯！
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //    偏移量
//    CGFloat x=self.scrollView.contentOffset.x;
//    //    判断偏移量
//    if (x>=ScreenWidth*2) {
//        //        调用替换数据源方法
//        [self updateCurViewWithPage:_curpage+1];
//    }
//    else if (x<=0)
//    {
//        [self updateCurViewWithPage:_curpage-1];
//
//    }
//}

////开始滑动
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    //    关闭定时器
//    [self.time invalidate];
//    self.time=nil;
//
//}
//
////开始减速
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    //    打开定时器
//    self.time=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//
//}
//#pragma mark -
//#pragma mark -定时器调用的方法
//-(void)timerAction
//{
//    //    偏移
//    self.scrollView.contentOffset=CGPointMake(self.frame.size.width*2, 0);
//}


- (void)getData{
    
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
        
    }else  {
        //        [self showHudInViewhint:@"正在加载"];//显示提示框
        NSString *url = @"http://120.25.69.40:1005/API/GetViewData.ashx";
        NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];
        //        NSMutableArray *arr9 = [NSMutableArray array];
        
        [dict9 setValue:self.lingpai forKey:@"AccessToken"];//令牌
        [dict9 setValue:@"View" forKey:@"action"];
        [dict9 setValue:self.HouseIdStr forKey:@"Id"];
        
        NSLog(@"请求的参数是:%@",dict9);
        
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict9
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  NSLog(@"等到的数据转成字典是---dic:%@",dic);
                  
                  NSDictionary *dicR=dic [@"Result"];
                  
                  NSDictionary *dicInfo=dicR[@"Info"];
                  //数组类型解释json数据
                  NSArray *ArrPic=dicR[@"Pic"];
                  NSArray *ArrExt=dicR[@"Ext"];
                  
                  //                  NSArray *array1 = dic [@"Result"];//----------------------
                  //                  if (array1 == nil) {
                  //                      [self shoWHint:@"没有最新数据了"];
                  //                  }
                  
                  NSLog(@"wwwwwwww" );
                  
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  
                  if (nu == 1) {
                      [self shoWHint:@"正在努力加载数据!"];
                      //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                      NSLog(@"获取不成功，返回的消息是%@",MsgStr);
                      [self chongxinHuoquLingpai];
                      [self getData];
                      
                  }else{
                      
                      NSLog(@"yyyyyyyy" );
                      NSLog(@"发送请求结果无异常");
                      //－－－－－－－－－－－－提取info数据－－－－－－－－－－－－
                    self.inforModer=[[InformationDetailsModer alloc]init];
                      
                      self.inforModer.HouseName=dicInfo[@"HouseName"];
                      self.inforModer.CopyName=dicInfo[@"CopyName"];
                      self.inforModer.Price=dicInfo[@"Price"];
                      
                      self.inforModer.SalePrice=dicInfo[@"SalePrice"];
                      self.inforModer.HoseAddr=dicInfo[@"HoseAddr"];
                      self.inforModer.HouseId=dicInfo[@"HouseId"];
                      
                      self.inforModer.Tags=dicInfo[@"Tags"];
                      self.inforModer.Point=dicInfo[@"Point"];
                      self.inforModer.GPSInfo=dicInfo[@"GPSInfo"];
//                      NSString*sql = [NSString stringWithFormat:"select * from %@ where id='%@'",tablename,id];
//                      self.inforModer.Description=[@"一." tringByAppendingFormat:dicInfo[@"Description"]];
                      self.inforModer.Description=dicInfo[@"Description"];
                      self.inforModer.TrafficDesc=dicInfo[@"TrafficDesc"];
                      self.inforModer.RoundDesc=dicInfo[@"RoundDesc"];
                      //                      self.inforModer.GPS=dic[@"GPS"];
                      NSLog(@"GPS数据:%@",self.inforModer.GPSInfo);
                      
                      self.inforModer.InKnow=dicInfo[@"InKnow"];
                      self.inforModer.BuyNotice=dicInfo[@"BuyNotice"];
                      self.inforModer.RefundDesc=dicInfo[@"RefundDesc"];
                      
                      self.inforModer.RunStatus=dicInfo[@"RefundDesc"];
                      
                      
                      //创建两个数组用来装低质图链接和高质图链接
                      NSMutableArray *ThumbArray=[NSMutableArray array];
                      NSMutableArray *HighArray=[NSMutableArray array];
                      
                      //－－－－－－－－－－－提取pic数据－－－－－－－－－－－
                      for (int i = 0; i<[ArrPic count];i++){
                          NSDictionary *picInfo = [ArrPic objectAtIndex:i];
                          NSString *cThumbAPP = [picInfo objectForKey:@"ThumbAPP"];
                          NSString *cHighAPP = [picInfo objectForKey:@"HighAPP"];
                          
                          
                          [ThumbArray addObject:cThumbAPP];
                          [HighArray addObject:cHighAPP];
                          NSLog(@"低质图数组---ThumbArray:%@",ThumbArray);
                          NSLog(@"高质图数组---highbArray:%@",HighArray);
                          
                          NSMutableString * string = [[NSMutableString alloc] init];
                          
                          for(NSString * str in ThumbArray){
                              
                              [string stringByAppendingString:str];
                              
                          }
                           NSLog(@"afasfasfasfasf %@: 字符串",string);

                          
                          //把数据传给model
                          self.picModer.picThumArray=ThumbArray;
                          self.picModer.picHighArray=HighArray;
                          
                          
                          NSLog(@"model数组---ThumbArray:%@",self.picModer.picThumArray);
                          
                          //                          CarouseFigureView *carouseView=[[CarouseFigureView alloc]init];
                          //                          carouseView.picThumAr=ThumbArray;
                          //                          carouseView.picHighAr=HighArray;
                          //                          NSLog(@"数组:%@",carouseView.picThumAr);
                          
                          
                      }
                      
                      //创建两个数组用来装BaseId和BaseName
                      NSMutableArray *BaseIdArray=[NSMutableArray array];
                      NSMutableArray *BaseNameArray=[NSMutableArray array];
                      
                      
                      //－－－－－－－－－－提取Ext数据－－－－－－－－－－
                      for (int i = 0; i<[ArrExt count];i++){
                          NSDictionary *ExtInfo = [ArrExt objectAtIndex:i];
                          NSString *cBaseId = [ExtInfo objectForKey:@"BaseId"];
                          
                          NSString *cBaseName = [ExtInfo objectForKey:@"BaseName"];
                          
                          
                          [BaseIdArray addObject:cBaseId];
                          [BaseNameArray addObject:cBaseName];
                          NSLog(@"BaseId数组---ThumbArray:%@",BaseIdArray);
                          NSLog(@"BaseName数组---highbArray:%@",BaseNameArray);
                          
                          //把数据传给model
                          self.extModer.ExtBaseId=BaseIdArray;
                          self.extModer.ExtBaseName=BaseNameArray;
                          
                          
                          
                          //                          NSLog(@"model数组---ThumbArray:%@",self.picModer.picThumArray);
                          
                          //                          CarouseFigureView *carouseView=[[CarouseFigureView alloc]init];
                          //                          carouseView.picThumAr=ThumbArray;
                          //                          carouseView.picHighAr=HighArray;
                          //                          NSLog(@"数组:%@",carouseView.picThumAr);
                          
                          
                      }
                      
                      
                      //                      self.picModer=[[PicDetailModer alloc]init];
                      //                      self.picModer.picThumArray=ThumbArray;
                      //                      self.picModer.picHighArray=HighArray;
                      //
                      //                       NSLog(@"asdfasdfasdfasdf数组---ThumbArray:%@",self.picModer.picThumArray);
                      //
                      
                      
                      //                      NSLog(@"%@",self.inforModer.HouseName);
                      //                      NSLog(@"%@",self.inforModer.HouseId);
                      //                      for (NSDictionary *dic1 in array1) {
                      //                          informaAmode *infora=[[informaAmode alloc]init];
                      //                          [infora setValuesForKeysWithDictionary:dic1];
                      //                          [self.dataArray addObject:infora];
                      //                          NSLog(@"数组个数为%ld",self.dataArray.count);
                      //                          [self _tite];//标题
                      //                      }
                  }
                  
                  NSLog(@"---23412432134%@",self.inforModer.HouseName);
                  NSLog(@"----123412341234%@",self.picModer.picThumArray);
                  NSLog(@"----12431234124%@",self.inforModer.Description);
                  NSLog(@"----213421341243-%@",self.extModer.ExtBaseId);
                  NSLog(@"---214312341234-%@",self.extModer.ExtBaseName);
                  
                  
                  [self initWithScrollView];
                  [self initWithPageControl];
                  [self.tableV reloadData];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  [self shoWHint:@"请求失败"];
              }];
    }
    
}

- (void)tableviews{
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-40*ScreenWidth/375)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}

- (void)order{
    
    UIButton *orderBut=[UIButton buttonWithType:UIButtonTypeCustom];
    if (self.tabBarController.tabBar.hidden==YES) {
        orderBut.frame=CGRectMake(0, ScreenHight-40*ScreenWidth/375, ScreenWidth, 40*ScreenWidth/375);
    }else{
        orderBut.frame=CGRectMake(0, ScreenHight-45-45*ScreenWidth/375, ScreenWidth, 40*ScreenWidth/375);
    }
    
    [orderBut setTitle:@"立即预订" forState:UIControlStateNormal];
    [orderBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    orderBut.backgroundColor = [UIColor  colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    orderBut.titleLabel.font = [UIFont systemFontOfSize:16];
    [orderBut addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    orderBut.layer.borderWidth=1;
    orderBut.layer.borderColor=[[UIColor clearColor]CGColor];
    orderBut.layer.cornerRadius=8;
    [self.view addSubview:orderBut];
    
}

#pragma mark -预定按钮
- (void)orderAction{
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    
    // 查询令牌的获取时间与数值
    NSDictionary *userDict = [store getObjectById:key fromTable:tableName];
    NSString *denglu = userDict[@"denglu"];
    _dataDict = userDict;
    if ([denglu isEqualToString:@"yes"]){
        [self jiazaiShuju:userDict];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登陆后完成预订" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    
}
-(void)jiazaiShuju:(NSDictionary *)dict1
{
    reserveViewController *reseVC=[[reserveViewController alloc]init];
    
    reseVC.ProdName=self.inforModer.HouseName;
    reseVC.ProdPice=self.inforModer.Price;
    reseVC.CutPrice=self.inforModer.SalePrice;
    reseVC.ProdId=self.inforModer.HouseId;
    reseVC.MenbIdString=dict1[@"MembId"];
    reseVC.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:reseVC animated:YES];
}

#pragma mark -HeaderInSection
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else if (section==1){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, 0, ScreenWidth-25*ScreenWidth/375, 30*ScreenWidth/375)];
        label.text=@"｜广东省广州市从化区富力泉天下";
        label.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
        [view addSubview:label];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(360*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"查看更多"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt1) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(278*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt1) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        return view;
    }else if (section==2){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-25*ScreenWidth/375, 30*ScreenWidth/375)];
        label.text=@"租客评论( 98 条 )";
        label.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375)];
        label1.text=@"查看全部详情";
        label1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
        label1.textColor=[UIColor grayColor];
        label1.textAlignment =NSTextAlignmentRight;
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-15*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"查看更多"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt2) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt2) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        return view;
    }else if (section==3){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 0, ScreenWidth-25*ScreenWidth/375, 30*ScreenWidth/375)];
        label.text=@"房屋描述";
        label.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375)];
        label1.text=@"查看详情";
        label1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-15*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"查看更多"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt3) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt3) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        return view;
    }else if (section==4){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 0, ScreenWidth-25*ScreenWidth/375, 30*ScreenWidth/375)];
        label.text=@"配套设施";
        label.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375)];
        label1.text=@"查看全部";
        label1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-15*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"查看更多"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt4) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt4) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        return view;
    }else if (section==5){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 0, ScreenWidth-25*ScreenWidth/375, 30*ScreenWidth/375)];
        label.text=@"哪天有房 ?";
        label.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375)];
        label1.text=@"查看全部";
        label1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-15*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"查看更多"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt5) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt5) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        return view;
    }else if (section==6){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 0, ScreenWidth-25*ScreenWidth/375, 30*ScreenWidth/375)];
        label.text=@"入住须知";
        label.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375)];
        label1.text=@"查看详情";
        label1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-15*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"查看更多"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt6) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt6) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        return view;
    }
    else if (section==7){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 0, ScreenWidth-25*ScreenWidth/375, 30*ScreenWidth/375)];
        label.text=@"周边信息";
        label.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label.textColor=[UIColor colorWithRed:44/255.0 green:168/255.0 blue:223/255.0 alpha:1];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375)];
        label1.text=@"查看全部";
        label1.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-15*ScreenWidth/375, 10*ScreenWidth/375, 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"查看更多"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt7) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-97*ScreenWidth/375, 0, 70*ScreenWidth/375, 30*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt7) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        return view;
    }
    else{
        return nil;
    }
}
#pragma mark -HeaderHeight
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 30*ScreenWidth/375;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}



#pragma mark - Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        
        ZeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zer"];
        if (cell==nil) {
            
            cell=[[ZeroTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"zer"];
        }
        [self rigtTwoButton];
        
        NSLog(@"---%@:arr",self.picModer.picThumArray);
        cell.Title.text=self.inforModer.HouseName;
        cell.BTitle.text=self.inforModer.CopyName;
        cell.Arr=self.picModer.picThumArray;
        self.BiaoTi.text = self.inforModer.HouseName;
        NSLog(@"---23412432134%@",self.inforModer.HouseName);
        NSLog(@"----123412341234%@",self.picModer.picThumArray);
        NSLog(@"----12431234124%@",self.inforModer.Description);
        NSLog(@"----213421341243-%@",self.extModer.ExtBaseId);
         NSLog(@"---214312341234-%@",self.extModer.ExtBaseName);
//        NSLog(@"----%@",self.extModer)
        //        =self.[indexPath.row];
        cell.money.text=[NSString stringWithFormat:@"¥ %@元",self.inforModer.Price];
        cell.backgroundColor = [UIColor clearColor];
        [self order];
        return cell;
    }else if (indexPath.section==1){
        oneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
        if (cell==nil) {
            cell=[[oneTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"one"];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }else if (indexPath.section==2){
        towTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tow"];
        if (cell==nil) {
            cell=[[towTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tow"];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
        
        //        NSString *str=self.inforModer.
        
        //        cell.contentL.frame=CGRectMake(65*ScreenWidth/375, 35*ScreenWidth/375, ScreenWidth-70*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth-70*ScreenWidth/375]);
        //        self.contentL.textColor=[UIColor grayColor];
        //        self.contentL.numberOfLines=0;
        //        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        //        self.contentL.textAlignment =NSTextAlignmentLeft;
        //        [self.contentView addSubview:self.contentL];
        //
        
        
        return cell;
    }else if (indexPath.section==3){
        ThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
        if (cell==nil) {
            cell=[[ThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"three"];
            
        }
        NSLog(@"----%@:INFO",self.inforModer.Description);
 
             cell.backgroundColor = [UIColor clearColor];
       
            return cell;
        
//        }
    }else if (indexPath.section==4){
        FourTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
        if (cell==nil) {
            cell=[[FourTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"four"];
        }
//        NSLog(@"----%@:massage",self.extModer.ExtBaseName);
        int a=[self.extModer.ExtBaseName count];
        //第一行
        for (int i = 0; i<a;i++){
            if (i>a/2) {
                cell.BaseNameLab=[[UILabel alloc]initWithFrame:CGRectMake(100*(i-5)+30, ScreenWidth/300+ScreenWidth/9, ScreenWidth/5+30, ScreenWidth/7)];
                    cell.BaseNameLab.text=self.extModer.ExtBaseName[(i)];
//                    NSLog(@"----%@:massage",cell.BaseNameLab.text);
 

                
            }else{
             
            cell.BaseNameLab=[[UILabel alloc]initWithFrame:CGRectMake(100*i+30, ScreenWidth/300, ScreenWidth/5, ScreenWidth/7)];
            cell.BaseNameLab.text=self.extModer.ExtBaseName[i];
            
                NSLog(@"----%@:massage",self.extModer.ExtBaseName[i]);
            }
//            cell.BaseNameLab.textAlignment = UITextAlignmentCenter;
            [cell addSubview:cell.BaseNameLab];
         
         
                                 }

        
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 0, 361*ScreenWidth/375, 2*ScreenWidth/375)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.3;
        [cell addSubview:headS];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 85*ScreenWidth/375, ScreenWidth, 5*ScreenWidth/375)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.3;
        [cell addSubview:foot];
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }else if (indexPath.section==5){
        FiveTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"hehe"];
        if (cell==nil) {
            cell=[[FiveTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"hehe"];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    }else if (indexPath.section==6){
        SixTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"six"];
        if (cell==nil) {
            cell=[[SixTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"six"];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    else{
        
        SevenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sev"];
        if (cell==nil) {
            cell=[[SevenTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sev"];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
}
//点赞分享按钮
- (void)rigtTwoButton{
    UIImageView *bottom=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/5-5, 10,ScreenWidth/5, (ScreenHight/4)/6)];
    bottom.image=[UIImage imageNamed:@"底"];
    [self.tableV addSubview:bottom];
    
    self.praise=[UIButton buttonWithType:UIButtonTypeCustom];
    self.praise.frame=CGRectMake(ScreenWidth/5-(ScreenWidth/5)/4-5*ScreenWidth/375+(ScreenWidth-ScreenWidth/5-5*ScreenWidth/375), 15, (ScreenWidth/5)/4, (ScreenHight/4)/6-10);
    [self.praise setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [self.praise addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchDown];
    [self.tableV addSubview:self.praise];
    
    self.praiseLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/5-(ScreenWidth/5)/4, (ScreenHight/4)/6)];
    self.praiseLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    self.praiseLabel.textColor=[UIColor orangeColor];
    self.praiseLabel.text=@"288";
    self.praiseLabel.textAlignment =NSTextAlignmentCenter;
    [bottom addSubview:self.praiseLabel];
    
    UIButton*praise=[UIButton buttonWithType:UIButtonTypeCustom];
    praise.frame=CGRectMake(ScreenWidth-ScreenWidth/5-5*ScreenWidth/375, 10*ScreenWidth/375,ScreenWidth/5-((ScreenHight/4)/6-10*ScreenWidth/375), (ScreenHight/4)/6);
    praise.backgroundColor=[UIColor clearColor];
    [praise addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchDown];
    [self.tableV addSubview:praise];
    
    UIImageView *bottom1=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/5-5*ScreenWidth/375, (ScreenHight/4)/6+(ScreenHight/4)/6,ScreenWidth/5, (ScreenHight/4)/6)];
    bottom1.image=[UIImage imageNamed:@"底"];
    [self.tableV addSubview:bottom1];
    
    self.share=[UIButton buttonWithType:UIButtonTypeCustom];
    self.share.frame=CGRectMake(ScreenWidth/5-(ScreenWidth/5)/4-5*ScreenWidth/375+(ScreenWidth-ScreenWidth/5-5*ScreenWidth/375), 5+((ScreenHight/4)/6+(ScreenHight/4)/6), (ScreenWidth/5)/4, (ScreenHight/4)/6-10);
    [self.share setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [self.share addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
    [self.tableV addSubview:self.share];
    
    self.shareLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/5-(ScreenWidth/5)/4, (ScreenHight/4)/6)];
    self.shareLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    self.shareLabel.textColor=[UIColor orangeColor];
    self.shareLabel.text=@"288";
    self.shareLabel.textAlignment =NSTextAlignmentCenter;
    [bottom1 addSubview:self.shareLabel];
    
}
//点赞分享事件
- (void)praiseAction:(id)sender {
    NSLog(@"点击👍");
}
- (void)shareAction:(id)sender {
    NSLog(@"点击分享");
}
#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return ScreenHight/4+85*ScreenWidth/375;
    }else if (indexPath.section==1){
        return  ScreenHight/4.5+10*ScreenWidth/375;
    }else if (indexPath.section==2){
        NSString *str=@"不错哈";
        if ( [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]<50) {
            return 100*ScreenWidth/375;
        }else{
            return   [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+70*ScreenWidth/375;
        }
    }else if (indexPath.section==3){
        
        NSString *str=@"千岛湖老田庄游多多客栈，位于千岛湖上一处港湾小村落中，静谧的小山村只有十几户人家，它是避开喧嚣的都市人群，静享着田园生活的好去处，距市区约20分钟车程，老田庄有别于一些古镇上的民居，并非强调“原住”和“古味”的感觉；也非简单的“归园田居”的普通农庄，而是蕴含淳安地域文化与日常生活休闲文化若即若离的交融，既有山乡田园的野趣，又有现代的舒适温馨。“田庄以老为贵，朋友亦然”是一位老画家在老田庄有感而题写，这里有着热情的掌柜接待着您，小村落的宁静，好客皆在这里延伸着……。";//self.inforModer.Description;
//        NSLog(@"---%@:inffff",self.inforModer.Description);
        if ( [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]<50) {
            return 100*ScreenWidth/375;
        }else{
            return   [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+60*ScreenWidth/375;
        }
    }else if (indexPath.section==4){
        return 90*ScreenWidth/375;
    }else if (indexPath.section==5){
        return (ScreenWidth/5)*3 +15*ScreenWidth/375;
        
    }else if (indexPath.section==6){
        NSString *str=@"注意检查为你所配备的用品是否齐全,有无损坏,如有不全或破损,请立即向房东或导游报告";
        return   [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+35*ScreenWidth/375;
    }
    else{
        int i =3;
        return (i/2)*((355*ScreenWidth/375)/4+45*ScreenWidth/375)+5*ScreenWidth/375+(355*ScreenWidth/375)/4+35*ScreenWidth/375+10;
    }
}
#pragma mark -点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section==1) {
        BaseMapViewController *subViewController =[ [NSClassFromString(@"OpenAMapURLRequestViewController") alloc] init];
        
        subViewController.mapView = self.mapView;
        subViewController.search  = self.search;
        
        subViewController.mapLat=23.21821;
        subViewController.mapLong=113.370559;//[partss.longitude floatValue];
        subViewController.laDelta=0.02;
        subViewController.loDelta=0.02;
        
        subViewController.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden = YES;
        
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    
    
}

#pragma mark -HeaderButtonAction
-(void)partButt1{
    NSLog(@"地图查看更多");
    BaseMapViewController *subViewController =[ [NSClassFromString(@"OpenAMapURLRequestViewController") alloc] init];
    
    subViewController.mapView = self.mapView;
    subViewController.search  = self.search;
    
    subViewController.mapLat=23.20189;
    subViewController.mapLong=113.47021;//[partss.longitude floatValue];
    subViewController.laDelta=0.03;
    subViewController.loDelta=0.03;
    
    subViewController.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
}
-(void)partButt2{
    NSLog(@"租客评论");
    inforCommentsTableViewController *CommentsTC=[[inforCommentsTableViewController alloc]init];
    
    [self.navigationController pushViewController:CommentsTC animated:YES];
}
-(void)partButt3{
    NSLog(@"房屋描述");
    
    inforDescribeTableViewController *DescribeTC=[[inforDescribeTableViewController alloc]init];
    DescribeTC.houseDe=self.inforModer.Description;
    NSLog(@"-----屋描述内容:%@",self.inforModer.Description);
    
    [self.navigationController pushViewController:DescribeTC animated:YES];
}
-(void)partButt4{
    NSLog(@"配套设施");
    inforFacilitiesTableViewController*FacilitiesTC=[[inforFacilitiesTableViewController alloc]init];
    
    [self.navigationController pushViewController:FacilitiesTC animated:YES];
    
}
-(void)partButt5{
    NSLog(@"哪天有房");
    RMCalendarController *c = [RMCalendarController calendarWithDays:365 showType:CalendarShowTypeMultiple];
    c.headTite=@"查看房价";
    
    c.modelArr = [TicketModel objectArrayWithKeyValuesArray:@[@{@"year":@2016, @"month":@2, @"day":@1,
                                                                @"ticketCount":@194, @"ticketPrice":@2893},
                                                              @{@"year":@2015, @"month":@7, @"day":@7,
                                                                @"ticketCount":@91, @"ticketPrice":@223},
                                                              @{@"year":@2016, @"month":@1, @"day":@4,
                                                                @"ticketCount":@91, @"ticketPrice":@23},
                                                              @{@"year":@2016, @"month":@1, @"day":@8,
                                                                @"ticketCount":@2, @"ticketPrice":@203},
                                                              @{@"year":@2015, @"month":@12, @"day":@29,
                                                                @"ticketCount":@2, @"ticketPrice":@103},
                                                              @{@"year":@2015, @"month":@12, @"day":@30,
                                                                @"ticketCount":@2, @"ticketPrice":@153}]]; //最后一条数据ticketCount 为0时不显示
    c.isEnable = YES;
    
    c.calendarBlock = ^(RMCalendarModel *model) {
        if (model.ticketModel) {
            NSLog(@"%lu-%lu-%lu-票价%.1f",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day, model.ticketModel.ticketPrice);
        } else {
            NSLog(@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day);
        }
    };
    [self.navigationController pushViewController:c animated:YES];
}

-(void)partButt6{
    NSLog(@"入住须知");
    CheckTableViewController *CheckTC=[[CheckTableViewController alloc]init];
    
    [self.navigationController pushViewController:CheckTC animated:YES];
}
-(void)partButt7{
    NSLog(@"周边信息");
    inforSurroundingTableViewController *inforSurroundingTC=[[inforSurroundingTableViewController alloc]init];
    
    [self.navigationController pushViewController:inforSurroundingTC animated:YES];
}

#pragma mark -MapAction
-(void)saoAction{
    //    MapViewController *mapVC=[[MapViewController alloc]init];
    
    //    Partss *partss=self.dataArray[0];
    //    mapVC.mapLat=23.20189;//[partss.latitude floatValue];
    //    mapVC.mapLong=113.37011;//[partss.longitude floatValue];
    //
    
    //    [self.navigationController pushViewController:mapVC animated:YES];
    
    //
    //    BaseMapViewController *subViewController =[ [NSClassFromString(@"OpenAMapURLRequestViewController") alloc] init];
    //
    //    subViewController.mapView = self.mapView;
    //    subViewController.search  = self.search;
    //
    //    subViewController.mapLat=23.210368;
    //    subViewController.mapLong=113.36468;//[partss.longitude floatValue];
    //    subViewController.laDelta=0.05;
    //    subViewController.loDelta=0.05;
    //
    //    subViewController.hidesBottomBarWhenPushed = YES;
    //    self.tabBarController.tabBar.hidden = YES;
    //
    //    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    
    MapGDViewController *mapGD=[[NSClassFromString(@"MapGDViewController") alloc] init];
    //强转float类型
//    mapGD.latitude=[self.inforModer.GPSInfo floatValue];
    //截取字符串 再强转float类型（从第10个字符开始截取，长度为9个字符）
//    mapGD.longitude=[[self.inforModer.GPSInfo  substringWithRange:NSMakeRange(10,9)] floatValue];
   
 
    mapGD.PriceArray=[NSMutableArray array];
    mapGD.GPSarray=[NSMutableArray array];
    [mapGD.PriceArray addObject:self.inforModer.Price];
   
    
    [mapGD.GPSarray addObject:self.inforModer.GPSInfo];
   
 
    NSLog(@"----%@:GPS数据数组",mapGD.GPSarray);
    NSLog(@"----%@:price",self.inforModer.Price);
    [self.navigationController pushViewController:(UIViewController*)mapGD animated:YES];
}
-(void)fanhuAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHight-64)];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

/* 初始化search. */
- (void)initSearch
{
    [AMapSearchServices sharedServices].apiKey = @"e41eb1c7065178fc6abe86602227f966";
    self.search = [[AMapSearchAPI alloc] init];
}


@end
