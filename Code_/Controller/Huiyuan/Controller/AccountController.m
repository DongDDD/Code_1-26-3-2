//
//  AccountController.m
//  Code_
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 东. All rights reserved.
//

#import "AccountController.h"
#import "AccountViewCell.h"
#import "BianjiYeViewController.h"
#import "MBProgressHUD+MJ.h"
#import <YTKKeyValueStore.h>
#import "PersonalInformation.h"

@interface AccountController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AccountController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self zidingyiDaohanglan];
    self.tabBarController.tabBar.hidden=YES;
    self.titleLabel.text = @"账户信息";
    [self GetView];
    
   
}
- (void)viewWillAppear:(BOOL)animated{
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    
    // 查询令牌的获取时间与数值
   NSMutableDictionary *UrlDict = [store getObjectById:key fromTable:tableName];
    [self GetData:UrlDict];
    
}


- (void)GetView{
    self.But = [[UIButton alloc]init];
    self.But.frame = CGRectMake((ScreenWidth-150*ScreenWidth/375)/2, 80*ScreenWidth/375, 150*ScreenWidth/375, 40*ScreenWidth/375);
    self.But.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    [self.But addTarget:self action:@selector(ButAction) forControlEvents:UIControlEventTouchUpInside];
    self.But.layer.cornerRadius  = 6*ScreenWidth/375;
    self.But.layer.masksToBounds = YES;
    [self.view addSubview:self.But];
    UIImageView *imi = [[UIImageView alloc]initWithFrame:CGRectMake1(8*ScreenWidth/375, 7*ScreenWidth/375, 21*ScreenWidth/375, 21*ScreenWidth/375)];
    imi.image = [UIImage imageNamed:@"添加图标.png"];
    [self.But addSubview:imi];
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(35*ScreenWidth/375, 8*ScreenWidth/375, 120*ScreenWidth/375, 21*ScreenWidth/375);
    label.text = @"添加常用住客";
    label.font = [UIFont systemFontOfSize:16*ScreenWidth/375];
    label.textColor = [UIColor whiteColor];
    [self.But addSubview:label];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 140*ScreenWidth/375, ScreenWidth, ScreenHight-130*ScreenWidth/375);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
- (void)ButAction{
    
    BianjiYeViewController *bianji = [[BianjiYeViewController alloc]init];
    bianji.buttonTag = 1000;
    [self.navigationController pushViewController:bianji animated:YES];
}

- (void)GetData:(NSDictionary *)dict1{
    
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
    }else  {
    NSString *url = @"http://120.25.69.40:1005/API/RoomerData.ashx";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"List" forKey:@"action"];//接口方式
    [dict setObject:dict1[@"MembId"] forKey:@"MembId"];//会员ID
    [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
    NSLog(@"请求的参数是:%@",dict);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
              NSLog(@"获取列表的数据转成字典是---dic:%@",dic);
              NSArray *ResultArr = dic[@"Result"];
              NSLog(@"Result=%@",ResultArr);
              
              NSString *MsgStr = dic[@"Msg"];
              NSInteger nu = [dic[@"IsError"] integerValue];
              
              if (nu =='1') {
                  NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
              }else{
                  NSLog(@"888888发送请求结果无异常");
                  
                  for (NSMutableDictionary *resultDict in ResultArr) {
                      PersonalInformation *person = [[PersonalInformation alloc]init];
                      [person setValuesForKeysWithDictionary:resultDict];
                      [self.ResultArray addObject:person];
                      NSLog(@"/////%ld",self.ResultArray.count);
                      
                     [self.tableView reloadData];
                      
                  }
   
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"000%@",error);
              
              //请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              [MBProgressHUD hideHUD];
          }];
    
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"[[[[[[[%ld",self.ResultArray.count);
    return self.ResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[AccountViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    NSLog(@"gggggg%ld",self.ResultArray.count);
    cell.info = self.ResultArray[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
    
}




#pragma mark - 懒加载
- (NSMutableArray *)ResultArray{
    if (!_ResultArray) {
        self.ResultArray = [NSMutableArray array];
    }
    return _ResultArray;
}



@end




