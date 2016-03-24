//
//  HomeViewController.m
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import "LBXScanView.h"
#import "SubLBXScanViewController.h"

#import "carousel.h"
#import <CoreLocation/CoreLocation.h>
#import "HomeViewController.h"
#import "guanggaoXunhuan.h"
#import "JingxuanTableViewCell.h"
#import "XiangcunFenxiangTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking.h>
#import<CommonCrypto/CommonDigest.h>
#import "LingpaiYuWangluoQingqiu.h"
#import "SousuooViewController.h"//搜索页
#import "InformationDetailsTableViewController.h"
#import "informaAmode.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AVCaptureMetadataOutputObjectsDelegate,CLLocationManagerDelegate,guanggaoDelegate>

@property(nonatomic,strong)AVCaptureSession *session;//输入输出的中间桥梁
@property(nonatomic,retain) NSMutableArray *GuangGaoArray;//广告解析的数据
@property(nonatomic,retain) NSMutableArray *tuijianArray;//精选推荐解析的数据
@property(nonatomic,retain) NSMutableArray *fenxiangArray;//家分享解析的数据
@property(nonatomic,copy)NSString *dangqianDibiaoStr;//当前位置的WBS
@property(nonatomic,strong)UITableView *jingxuanTableView;
@property(nonatomic,strong)UITableView *fenxiangTableView;
@property(nonatomic,strong)UIView *iim;

//手势范围
@property(nonatomic,strong)UIImageView *ima;
//当前屏幕的宽
@property(nonatomic,assign)int widht;
//当前屏幕的高
@property(nonatomic,assign)int hight;

//@property(nonatomic,assign)float bili;

@property(nonatomic,retain)CLLocationManager *mgr;//定位管理
@end

@implementation HomeViewController
- (NSMutableArray *) GuangGaoArray
{
    if (!_GuangGaoArray) {
        self.GuangGaoArray=[NSMutableArray array];
    }
    return _GuangGaoArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sss=1;
//    self.navigationController.navigationBar.hidden = YES;
    
//    UIButton *calendar=[UIButton buttonWithType:UIButtonTypeSystem];
//    calendar.frame=CGRectMake(0, 0, 30, 30);
//    [calendar setBackgroundImage:[UIImage imageNamed:@"地图"] forState:UIControlStateNormal];
//    [calendar addTarget:self action:@selector(qqStyle) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *currentMusicBtn=[[UIBarButtonItem alloc]initWithCustomView:calendar];
//    self.navigationItem.rightBarButtonItem=currentMusicBtn;
    
    self.dangqianDibiaoStr = @"0019";//当前的WBS
#pragma mark - map
    self.mgr=[[CLLocationManager alloc]init];
    self.mgr.delegate=self;
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0) {
        [self.mgr requestAlwaysAuthorization];
    }else{
        [self.mgr startUpdatingLocation];
    }
    self.mgr.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
#pragma mark -
    NSLog(@"self.bili是：%f,ScreenWidth是%f，高是:%f",self.bili,ScreenWidth,ScreenHight);
    //设置下载数据
    //[self getData];
    //广告循环数据下载
    //[self getDataGuangGao];
    //改变坐标
    [self changeTheFrame];
    //设置整个界面的滑动
    [self setZhenggeShouyeScrollView];
    
    //设置tableView
    [self getData];//下载数据
    //设置搜索栏
    [self setTheSousuolan];
    //设置二维码
    [self setTheErweimaImageView];
    [self setTheTableView];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 下载数据
-(void)getData{
    _GuangGaoArray = [NSMutableArray array];
    _tuijianArray = [NSMutableArray array];
    _fenxiangArray = [NSMutableArray array];
    //下载数据。。。
    [self getShouyeGuanggaoData];//广告
    [self getTuijianData];//精选推荐
    //[self getFenxiangData];
    
}
//哈希加密
- (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
#pragma mark - 下载首页数据

-(void)getShouyeGuanggaoData{//拼接首页广告选推荐的数据的参数
    NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];
    
    [dict9 setValue:self.lingpai forKey:@"AccessToken"];
    [dict9 setValue:@"Slide" forKey:@"action"];
    [dict9 setValue:@"0019" forKey:@"WBS"];
    
    // NSLog(@"首页广告请求的参数是:%@",dict9);
    [self wangluQingqiu:dict9 withNumber:1];
}
-(void)getTuijianData{//拼接下载精选推荐的数据的参数
    NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];
    
    [dict9 setValue:self.lingpai forKey:@"AccessToken"];
    [dict9 setValue:@"Remb" forKey:@"action"];
    [dict9 setValue:@"0019" forKey:@"WBS"];
    //NSLog(@"精选推荐请求的参数是:%@",dict9);
    [self wangluQingqiu:dict9 withNumber:2];
}
-(void)getFenxiangData{//拼接家分享推荐的数据的参数
    NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];
    
    [dict9 setValue:self.lingpai forKey:@"AccessToken"];
    [dict9 setValue:@"DevArea" forKey:@"action"];
    //[dict9 setValue:@"0019" forKey:@"WBS"];
    NSLog(@"aaaaaa精选推荐请求的参数是:%@",dict9);
    [self wangluQingqiu:dict9 withNumber:3];
    
}

#pragma mark - 网络请求
- (void)wangluQingqiu:(NSDictionary *)dict withNumber:(int)num
{
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
    }else  {
        //        [self showHudInViewhint:@"正在加载"];//显示提示框
        NSString *url = @"http://120.25.69.40:1005/API/GetIndexData.ashx";
        
        
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                  // NSLog(@"登陆请求成功---%@", responseObject);
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  // NSLog(@"等到的数据转成字典是---dic:%@",dic);
                  
                  NSArray *array1 = dic [@"Result"];
                  NSLog(@"=========%@",array1);
                  
                  for (NSDictionary *dic1 in array1) {
                      informaAmode *infora=[[informaAmode alloc]init];
                      [infora setValuesForKeysWithDictionary:dic1];
                      NSLog(@"1111111%@",dic1);
                      [self.dataArray addObject:infora];
                      //                      [self showhide];//隐
                      //                      [self.tableV reloadData];
                      //                      [self.tableV headerEndRefreshing];//结束刷新
                       NSLog(@"22222%@",self.dataArray);
                  }

                  
                  //NSLog(@"解析后的数据是:%@\n开始设置广告循环",array1);
                  
                  
                  
                  
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  
                  
                  if (nu == 1) {
                      //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                      NSLog(@"获取会员信息不成功，返回的消息是%@----%d",MsgStr,num);
                      [self chongxinHuoquLingpai];
                      [self getData];
                      
                  }else{
                      NSLog(@"获取数据结果成功,开始加载数据");
                      if(num == 1 ){
//                          for (NSDictionary *dic1 in array1) {
//                              carousel *carous=[[carousel alloc]init];
//                              [carous setValuesForKeysWithDictionary:dic1];
//                              
//                              [self.GuangGaoArray addObject:carous.ThumbAPP];
//                                                     }
                          NSLog(@"广告循环数据解析是:%@",array1);
                          
                          
                          [self.GuangGaoArray addObjectsFromArray:array1];
                          NSLog(@"ddddddd广告循环数据解析是:%@",_GuangGaoArray);
                          //设置广告循环
                          [self setGuanggaoScrollView];

                      }else if(num == 2){
                          [_tuijianArray addObjectsFromArray:array1];
                          NSLog(@"精选推荐:%@",_tuijianArray);
                          
                          [_jingxuanTableView reloadData];
                          
                      }else if(num == 3){
                          [_fenxiangArray addObjectsFromArray:array1];
                          NSLog(@"33333333333333:%@",_fenxiangArray);
                          
                      }
                      
                      
                      
                  }
                  
                  [self showhide];//隐
                  
                  //              [self setGuanggaoScrollView];
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"000%@",error);
                  [self showhide];//隐
                  //请求失败的时候调用调用这个block
                  for (self.sss; self.sss<5; self.sss++) {
                      [self getData ];
                       [self shoWHint:@"请求失败"];
                  }
                 
                  
              }];
    }
    
}


#pragma mark -  设置整个界面的滑动
-(void)setZhenggeShouyeScrollView{
    // 内容大小
    float a = self.bili;
    _ZhenggeShouyeScrollView.contentSize = CGSizeMake(ScreenWidth, (ScreenHight-114)+(675*self.bili));
    NSLog(@"宽%d,高%d",_widht,_hight);
    // 取消水平滚动条
    _ZhenggeShouyeScrollView.showsHorizontalScrollIndicator = NO;
    // 取消垂直滚动条
    _ZhenggeShouyeScrollView.showsVerticalScrollIndicator = NO;
    // 取消弹簧效果
    _ZhenggeShouyeScrollView.bounces = NO;
    
}
#pragma mark -  改变坐标
-(void)changeTheFrame{
    
    float a = self.bili;
    float e = (ScreenHight-114)*1.0/454;
    _ZhenggeShouyeScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHight);
    _daohanglanImageView.userInteractionEnabled = YES;
    _daohanglanImageView.frame = CGRectMake(0, 0, ScreenWidth, 64);
    _SousuoTextField.frame = CGRectMake(90, 26, ScreenWidth-150, 30);
    _ErweimaButton.frame = CGRectMake(ScreenWidth-50, 20, 40, 40);
    
    _HuiyuanButton.frame = CGRectMake(10*a, 138*e, 300*a, 42*e);
    _HuodongImage.frame = CGRectMake(10*a, 187*e, 300*a,46*e);
    _ChoujiangButton.frame = CGRectMake(10*a, 233*e, 300*a, 132*e);
    
    _QiandaoButton.frame = CGRectMake(10*a, 365*e, 150*a, 90*e);
    _ZhuceButton.frame = CGRectMake(160*a, 365*e, 150*a, 90*e);
    
}


#pragma mark - 设置顶部 - 搜索栏
-(void)setTheSousuolan{
    
    //顶部中间按钮，点击跳到搜索页
    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-200, 30)];
    [bu setTitle:@"广州" forState:UIControlStateNormal];//当前城市名
    [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bu.backgroundColor = [UIColor  whiteColor];//colorWithRed:255/250.0 green:62/250.0 blue:68/250.0 alpha:1];
    bu.titleLabel.font = [UIFont systemFontOfSize:16];
    [bu addTarget:self action:@selector(sousuoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    bu.layer.borderWidth=1;
    bu.layer.borderColor=[[UIColor whiteColor]CGColor];
    bu.layer.cornerRadius=8;
    _SousuoTextField.delegate = self;
    
    self.navigationItem.titleView = bu;

}

-(void)sousuoButtonClick:(UIButton *)button{//搜索按钮点击事件
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
    }else  {
        SousuooViewController *sousuo = [[SousuooViewController alloc]init];
        sousuo.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden = YES;
        self.navigationController.navigationBar.hidden = NO;
        
        [self.navigationController pushViewController:sousuo animated:YES];
    }
    
}



-(void)xuanzeChengshiClick:(UIButton *)button{
    float a = self.bili;
    self.iim = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
    self.iim.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.iim];
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(30*a, 60, 260*a, ScreenHight-120)];
    vv.backgroundColor = [UIColor whiteColor];
    [self.iim addSubview:vv];
    UIButton *xiaoshiButton = [[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 60, 40)];
    [xiaoshiButton setTitle:@"取消" forState:UIControlStateNormal];
    [xiaoshiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    xiaoshiButton.backgroundColor = [UIColor redColor];
    xiaoshiButton.titleLabel.font = [UIFont systemFontOfSize:16*self.bili];
    [xiaoshiButton addTarget:self action:@selector(xiaoshiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:xiaoshiButton];
    
    
}
-(void)xiaoshiButtonClick:(UIButton *)button{
    [self.iim removeFromSuperview];
}



#pragma mark - UITextField协议方法实现
//在键盘将要编辑时调用的方法
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textField即将开始编辑");
    
    SousuooViewController *sousuo = [[SousuooViewController alloc]init];
    
    [self.navigationController pushViewController:sousuo animated:YES];
       //默认的情况是可以输入
    return YES;
}
-(void)tapClick:(UITapGestureRecognizer *)tap{
    //回收键盘
    //[self.view endEditing:YES];
    [_SousuoTextField resignFirstResponder];
    [_ima removeFromSuperview];
    NSLog(@"键盘已经回收");
    
}

// 点击键盘的return调用的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"输入的内容是:%@",textField.text);
    //回收键盘
    //[self.view endEditing:YES];
    [_SousuoTextField resignFirstResponder];
    [_ima removeFromSuperview];
    return YES;
}






-(void)setTheErweimaImageView{
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 2, 24 , 24 )];
//    imageView.image = [UIImage imageNamed:@"扫一扫.png"];
//    [_ErweimaButton addSubview:imageView];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, 40, 10)];
//    label.text = @"扫一扫";
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:10];
//    [_ErweimaButton addSubview:label];
    
    
    
    UIButton *calendar=[UIButton buttonWithType:UIButtonTypeSystem];
    calendar.frame=CGRectMake(0, 0, 30, 30);
    [calendar setBackgroundImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    [calendar addTarget:self action:@selector(SaomiaoErweimaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn=[[UIBarButtonItem alloc]initWithCustomView:calendar];
    self.navigationItem.rightBarButtonItem=currentMusicBtn;
    
    UIButton *calendar1=[UIButton buttonWithType:UIButtonTypeSystem];
    calendar1.frame=CGRectMake(0, 17.5,87.5, 26.5);
    [calendar1 setBackgroundImage:[UIImage imageNamed:@"xinLogo"] forState:UIControlStateNormal];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:calendar1];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
}



#pragma mark - 点击扫描二维码按钮点击方法
- (void)SaomiaoErweimaButtonClick:(id)sender {
    NSLog(@"点击了二维码扫描");
   
    [self qqStyle];
    
}

#pragma mark -模仿qq界面
- (void)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  设置广告循环
-(void)setGuanggaoScrollView{
    float e = (ScreenHight-114)*1.0/454;
    guanggaoXunhuan *guanggaoScrollView = [[guanggaoXunhuan alloc]init];
    guanggaoScrollView.delegate = self;
    
    CGSize ss = CGSizeMake(320*self.bili, 137*e);
    [guanggaoScrollView setGuanggaoXunhuanWithImageArray:_GuangGaoArray withUIView:_ZhenggeShouyeScrollView withCGSize:ss];
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 2)];
    im.backgroundColor = [UIColor whiteColor];
    [_ZhenggeShouyeScrollView addSubview:im];
    
//    UIView *vierr=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320*self.bili, 137*e)];
//    vierr.backgroundColor=[UIColor redColor];
//    [_ZhenggeShouyeScrollView addSubview:vierr];
}
#pragma mark - 广告点击事件在这里写
-(void)guanggaoDianji:(NSDictionary *)dict withTag:(NSInteger)tag{
    //dict :图片的信息   tag可以不要管，只是记录点击的是第几个
    NSLog(@"点击的广告图的字典是:%@",dict);
//    
    InformationDetailsTableViewController *inforTC=[[InformationDetailsTableViewController alloc]init];
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];


////    informaAmode *infora=self.dataArray[indexPath.row];
     inforTC.HouseIdStr=dict[@"RelationId"];
    
    [self.navigationController pushViewController:inforTC animated:YES];

    
    
}



#pragma mark - 设置tabelView
-(void)setTheTableView{
    float b = self.bili;
    for (int a; a <2; a++) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10*b, ScreenHight-114+345*b*a, 300*b, 20*b)];//创建一个视图（v_headerView）
        [_ZhenggeShouyeScrollView addSubview:headerView];
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake1(5, 3, 2, 14)];//创建一个UIimageView
        [headerView addSubview:headerImageView];//添加到创建的视图中
        
        UILabel *headerLab = [[UILabel alloc] initWithFrame:CGRectMake1(10, 6, 70, 12)];//创建一个UILable用来显示标题
        headerLab.font = [UIFont systemFontOfSize:12*self.bili];//设置v_headerLab的字体样式和大小
        
        [headerView addSubview:headerLab];//将标题添加到创建的视图
        
        if (a == 0) {
            headerImageView.image = [UIImage imageNamed:@"jingxuanTuijian.png"];//设置图片
            headerLab.text = @"精选推荐";
            headerLab.textColor = [UIColor colorWithRed:242/250.0 green:36/250.0 blue:3/250.0 alpha:1];//设置v_headerLab的字体颜色
            
        }
//        else{
//            headerImageView.image = [UIImage imageNamed:@"jiaTuijian.png"];//设置图片
//            headerLab.text = @"乡村.家推荐";
//            headerLab.textColor = [UIColor colorWithRed:255/250.0 green:125/250.0 blue:63/250.0 alpha:1];//设置v_headerLab的字体颜色
//        }
        
    }
    
    
    _jingxuanTableView = [[UITableView alloc]init];
    
    float a = self.bili;
    
//    NSLog(@"%f",a);
    _jingxuanTableView.frame = CGRectMake(10*a, ScreenHight-114+20*b, 300*a, 695*a);
    NSLog(@"---%f,---%f,---%f",ScreenWidth*self.bili,ScreenWidth,self.bili);
    
    _jingxuanTableView.dataSource = self;
    _jingxuanTableView.delegate = self;
    //取消弹簧效果
    _jingxuanTableView.bounces = NO;
    [_ZhenggeShouyeScrollView addSubview:_jingxuanTableView];
    
    
    
//    _fenxiangTableView = [[UITableView alloc]init];
//    
//    _fenxiangTableView.frame = CGRectMake(10*a, ScreenHight-114+20*b+695*a, 600*a,370*a);
//    NSLog(@"111111--%f",390*self.bili);
//    _fenxiangTableView.dataSource = self;
//    _fenxiangTableView.delegate =self;
//    _fenxiangTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    //取消弹簧效果
//    _fenxiangTableView.bounces = NO;
    
//    [_ZhenggeShouyeScrollView addSubview:_fenxiangTableView];
    
    [_jingxuanTableView registerNib:[UINib nibWithNibName:@"JingxuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
//    [_fenxiangTableView registerNib:[UINib nibWithNibName:@"XiangcunFenxiangTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
}

#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_jingxuanTableView]) {
        
        return 162*self.bili;
    }
    else if ([tableView isEqual:_fenxiangTableView])
    {
        
        return 175*self.bili;
    }else{
        
        return 0;
    }
    
    
}
#pragma mark - 具体设置Cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"555");
    
    NSLog(@"点击详情");
    InformationDetailsTableViewController *inforTC=[[InformationDetailsTableViewController alloc]init];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //<<<<<<< .mine
    //    //    inforTC.stiTite=@"从化温泉富力泉天下独栋豪华度假";
    //=======
    ////    inforTC.stiTite=@"从化温泉富力泉天下独栋豪华度假";
    //>>>>>>> .r1245
    
    informaAmode *infora=self.dataArray[indexPath.row];
    NSLog(@"---%@",infora);
//    NSLog(@"--%@",self.dataArray[1]);
    inforTC.HouseIdStr=infora.HouseId;
    inforTC.stiTite=infora.HouseName;
    NSLog(@"--%@",infora.HouseId);
    [self.navigationController pushViewController:inforTC animated:YES];
}

#pragma mark - 设置cell的层数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_jingxuanTableView]) {
        return _tuijianArray.count;
        //return 6;
    }
    else if ([tableView isEqual:_fenxiangTableView])
    {
        //return _fenxiangArray.count;
        return 0;
    }else{
        
        return 0;
    }
    
    
}
#pragma mark - 具体设置tabelView
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_jingxuanTableView]) {
        static NSString *str = @"cell1";
        
        JingxuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (cell == nil) {
            cell = [[JingxuanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        }
        cell.bili = self.bili;
        cell.selectionStyle = NO;
        //赋值
        //[cell setTheJingxuanTuijianTableView:_jingxuanArray[indexPath.row]];
        
        
        if (_tuijianArray.count == 0) {
            
        }else{
            [cell setTheJingxuanTuijianTableView:_tuijianArray[indexPath.row]];
        }
        
        return cell;
    }
    else if ([tableView isEqual:_fenxiangTableView])
    {
        static NSString *str = @"cell2";
        
        XiangcunFenxiangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (cell == nil) {
            cell = [[XiangcunFenxiangTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        }
        cell.selectionStyle = NO;
        cell.bili = self.bili;
        //赋值
        //[cell setTheFenxiangTableViewCell:_fenxiangArray[indexPath.row]];
        [cell setTheFenxiangTableViewCell:nil];
        return cell;
        
    }
    else{
        return  nil;
    }
    
}






//会员招募按钮点击事件
- (IBAction)HuiyuanZhaomuButtonClick:(id)sender {
}
//抽奖按钮点击事件
- (IBAction)ChoujiangButtonClick:(id)sender {
}
//签到按钮点击事件
- (IBAction)QiandaoButtonClick:(id)sender {
}
//注册按钮点击事件
- (IBAction)ZhuceButtonClick:(id)sender {
}



- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray=[NSMutableArray array];
    }
    return _dataArray;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Map
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
    CLLocation *location=[locations lastObject];
    
    //    地理反编码
    //    创建反编码对象（经纬度转化为实际位置）
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks,NSError *error){
        for (CLPlacemark *pl in placemarks) {
            NSLog(@"***************name=%@",pl.name);
            
            NSLog(@"************thoroughfare=%@",pl.thoroughfare);
            
            NSLog(@"*********locality=%@",pl.locality);
        }
    }];
    
    NSLog(@"%@",locations);
    
    //     startUpdatingLocation
    [self.mgr stopUpdatingLocation];
}

@ end