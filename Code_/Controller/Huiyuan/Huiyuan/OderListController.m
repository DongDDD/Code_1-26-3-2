//
//  OderListController.m
//  Code_
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 东. All rights reserved.
//

#import "OderListController.h"
#import "OrderListTableViewCell.h"
#import "WSJOrderListTableViewCell.h"
#import "OrderlistMode.h"
#import "OrderlistSSTableViewController.h"//XIANGQINBG
#import <YTKKeyValueStore.h>



@interface OderListController ()

@property(nonatomic,strong)UIImageView *im;
@property (nonatomic,strong)NSDictionary *dataDict;


@end

@implementation OderListController

- (void)viewWillDisappear:(BOOL)animated{
    //self.view即将在界面上消失
    NSLog(@"view 即将消失");
    if (!_im) {
        [self.im removeFromSuperview];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    
    // 查询令牌的获取时间与数值
    NSDictionary *userDict = [store getObjectById:key fromTable:tableName];
    NSString *denglu = userDict[@"denglu"];
    _dataDict = userDict;
    
    NSLog(@"本地数据是:%@",userDict);
    
    if ([denglu isEqualToString:@"yes"]) {//已经登录，本地存有信息
        NSLog(@"用户已经登陆--开始下载用户数据");
        
        //开始下载数据
        self.RRR=0;
        NSLog(@"0000000000000==%@",userDict[@"MembId"]);
        self.dataArray=nil;
        [self jiazaiShuju:userDict];
        [self NanButtonAction];
        
    }else{//没有登录
        NSLog(@"用户没有登陆，加载会员没有登陆的用户界面");
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:233/255.0 green:237/255.0 blue:239/255.0 alpha:1];
    self.tableView.separatorColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    
    
    
}

-(void)jiazaiShuju:(NSDictionary *)dict1{
    
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
        //        [self.tableV headerEndRefreshing];
    }else  {
        [self showHudInViewhint:@"正在加载"];//显示提示框
        NSString *url = @"http://120.25.69.40:1005/API/OrdersData.ashx";
        NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];
        
        if (self.StateStr==nil) {
            self.StateStr=@"1";
            NSLog(@"空空");
        }else{
            
        }
        
        [dict9 setValue:@"List" forKey:@"action"];
        [dict9 setValue:self.lingpai forKey:@"AccessToken"];//令牌
        [dict9 setValue:self.StateStr forKey:@"State"];//
        [dict9 setValue:@"1"  forKey:@"pid"];//每页显示多少条，默认10
        [dict9 setValue:dict1[@"MembId"] forKey:@"MembId"];//
        [dict9 setValue:[NSString stringWithFormat:@"10"] forKey:@"psize"];//当前页码，默认值1
        NSLog(@"请求的参数是:%@",dict9);
        self.MembIdStr=dict1[@"MembId"];
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict9
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                  //              NSLog(@"---%@", responseObject);
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  //              NSLog(@"等到的数据转成字典是---dic:%@",dic);
                  
                  NSArray *array1 = dic [@"Result"];
                  
                  NSLog(@"0000000==%@",array1);
                  if (array1 == nil) {
                      [self shoWHint:@"没有最新数据了"];
                  }
                  NSLog(@"===+++++%@",array1);
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  if (nu ==1) {
                      
                      //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                      NSLog(@"获取不成功，返回的消息是%@",MsgStr);
                      //                      [self chongxinHuoquLingpai];
                      //                      [self getData];
                      
                  }else{
                      NSLog(@"发送请求结果无异常");
                      
                      for (NSDictionary *dic1 in array1) {
                          OrderlistMode *Orfora=[[OrderlistMode alloc]init];
                          [Orfora setValuesForKeysWithDictionary:dic1];
                          [self.dataArray addObject:Orfora];
                          
                          
                          NSLog(@"数组个数为%ld",self.dataArray.count);
                          NSLog(@"%@",dic1);
                          
                      }
                  }
                  [self showhide];
                  [self.tableView reloadData];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [self showhide];//隐藏菊花
                  [self shoWHint:@"请求失败"];
              }];
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)ORDEArray
{
    if (!_ORDEArray) {
        self.ORDEArray=[NSMutableArray array];
    }
    return _ORDEArray;
}

- (void)NanButtonAction{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44*ScreenWidth/375)];
    title.text = @"订单列表";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    self.navigationItem.titleView = title;
    

        UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
        fanhu.frame=CGRectMake(0, 0, 10, 17);
        [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
        [fanhu addTarget:self action:@selector(fanhu1Action) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
        self.navigationItem.leftBarButtonItem=currentMusicBtn1;
    
    
}

#pragma mark -HeaderInSection
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.RRR==0) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor yellowColor];
        
        self.ordeButton1=[UIButton buttonWithType:UIButtonTypeCustom];
        self.ordeButton1.frame=CGRectMake(0, 0,187.5*ScreenWidth/375, 50*ScreenWidth/375);
        self.ordeButton1.backgroundColor=[UIColor whiteColor];
        self.ordeButton1.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
        [self.ordeButton1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [self.ordeButton1 setTitle:@"当前订单" forState:UIControlStateNormal];
        [self.ordeButton1 addTarget:self action:@selector(ordeButton1Action:) forControlEvents:UIControlEventTouchDown];
        self.ordeButton1.layer.borderWidth=1;
        self.ordeButton1.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
        [view addSubview:self.ordeButton1];
        
        self.ordeButton2=[UIButton buttonWithType:UIButtonTypeCustom];
        self.ordeButton2.frame=CGRectMake(187.5*ScreenWidth/375, 0,187.5*ScreenWidth/375, 50*ScreenWidth/375);
        self.ordeButton2.backgroundColor=[UIColor whiteColor];
        self.ordeButton2.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
        [self.ordeButton2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [self.ordeButton2 setTitle:@"已完成订单" forState:UIControlStateNormal];
        [self.ordeButton2 addTarget:self action:@selector(ordeButton2Action:) forControlEvents:UIControlEventTouchDown];
        self.ordeButton2.layer.borderWidth=1;
        self.ordeButton2.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
        [view addSubview:self.ordeButton2];
        
        self.redview =[[UIView alloc]init];
        if ([self.StateStr isEqualToString:@"1"]) {
            self.redview.frame=CGRectMake(0, 48*ScreenWidth/375, 187.5*ScreenWidth/375, 2*ScreenWidth/375);
        }else{
            self.redview.frame=CGRectMake(187.5*ScreenWidth/375, 48*ScreenWidth/375, 187.5*ScreenWidth/375, 2*ScreenWidth/375);
        }
        
        
        self.redview.backgroundColor= [UIColor  colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
        [view addSubview:self.redview];
        return view;
    }else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30*ScreenWidth/375)];
        view.backgroundColor=[UIColor clearColor];
        return view;
    }
    
}

#pragma mark -HeaderHeight
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.RRR==0) {
        
        return 50*ScreenWidth/375;
    }else{
        return 0;
    }
    
}

- (void)ordeButton1Action:but
{
    self.redview.frame=CGRectMake(0, 48*ScreenWidth/375, 187.5*ScreenWidth/375, 2*ScreenWidth/375);
    self.StateStr=@"1";
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    
    // 查询令牌的获取时间与数值
    NSDictionary *userDict = [store getObjectById:key fromTable:tableName];
    NSString *denglu = userDict[@"denglu"];
    _dataDict = userDict;
    
    NSLog(@"本地数据是:%@",userDict);
    
    if ([denglu isEqualToString:@"yes"]) {//已经登录，本地存有信息
        NSLog(@"用户已经登陆--开始下载用户数据");
        
        //开始下载数据
        self.RRR=0;
        NSLog(@"0000000000000==%@",userDict[@"MembId"]);
        self.dataArray=nil;
        [self jiazaiShuju:userDict];
        [self NanButtonAction];
        
    }else{//没有登录
        NSLog(@"用户没有登陆，加载会员没有登陆的用户界面");
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
- (void)ordeButton2Action:but
{
    self.redview.frame=CGRectMake(187.5*ScreenWidth/375, 48*ScreenWidth/375, 187.5*ScreenWidth/375, 2*ScreenWidth/375);
    self.StateStr=@"2";
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    
    // 查询令牌的获取时间与数值
    NSDictionary *userDict = [store getObjectById:key fromTable:tableName];
    NSString *denglu = userDict[@"denglu"];
    _dataDict = userDict;
    
    NSLog(@"本地数据是:%@",userDict);
    
    if ([denglu isEqualToString:@"yes"]) {//已经登录，本地存有信息
        NSLog(@"用户已经登陆--开始下载用户数据");
        
        //开始下载数据
        self.RRR=0;
        NSLog(@"0000000000000==%@",userDict[@"MembId"]);
        self.dataArray=nil;
        [self jiazaiShuju:userDict];
        [self NanButtonAction];
        
    }else{//没有登录
        NSLog(@"用户没有登陆，加载会员没有登陆的用户界面");
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (self.dataArray.count==0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count == 0) {
        NSLog(@"meiyoushuju");
        WSJOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"on8e"];
        if (cell==nil) {
            cell=[[WSJOrderListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"on8e"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        OrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
        if (cell==nil) {
            cell=[[OrderListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"one"];
        }
        
        
        cell.OrderlistM=self.dataArray[indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}



#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        
        return ScreenHight;
    }else{
        return 115*ScreenWidth/375;
    }
    
}

#pragma mark -点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"点击详情");
    OrderlistSSTableViewController *inforTC=[[OrderlistSSTableViewController alloc]init];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    inforTC.MembIdsStr=self.MembIdStr;
    
    OrderlistMode*infora=self.dataArray[indexPath.row];
    inforTC.OrderIdsStr=infora.OrderId;
    
    [self.navigationController pushViewController:inforTC animated:YES];
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

- (void)fanhu1Action
{
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
