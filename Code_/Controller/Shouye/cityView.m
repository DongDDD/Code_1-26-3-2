//
//  cityView.m
//  Code_
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 东. All rights reserved.
//

#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


#import "cityView.h"
#import <AFNetworking.h>
#import "informationViewController.h"
@implementation cityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.bili = ScreenWidth/320.0;
    NSLog(@"sssssssssss%@",_dict);
    
    [self tablevvvie];
}

- (void)tablevvvie{
    //设置显示选择的地点
    _label  = [[UILabel alloc]initWithFrame:CGRectMake(45*self.bili, 64, ScreenWidth-90*self.bili, 40*self.bili)];
    _label.text = _dict[@"FullName"];
    _label.backgroundColor = [UIColor grayColor];
    _label.textColor = [UIColor whiteColor];
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:14*self.bili];
    _label.layer.borderWidth=1*self.bili;
    _label.layer.borderColor=[[UIColor clearColor]CGColor];
    _label.layer.cornerRadius=8*self.bili;
    _label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_label];
    
    //设置搜索按钮
    UIButton *Button = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-42*self.bili, 64, 40*self.bili, 40*self.bili)];
    [Button setTitle:@"搜索" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Button.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:0.8];
    Button.layer.borderWidth=1*self.bili;
    Button.layer.borderColor=[[UIColor clearColor]CGColor];
    Button.layer.cornerRadius=8*self.bili;
    Button.titleLabel.font = [UIFont systemFontOfSize:13*self.bili];
    [Button addTarget:self action:@selector(dsousuoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Button];
    //加载第一级数据
    NSLog(@"----%@",_dict);
    [self getDatawithNum:1 withDict:@{@"action":@"Lv",@"WBS":_dict[@"AreaWBS"],@"AccessToken":self.lingpai}];
    
    //设置取消按钮
    UIButton *aButton = [[UIButton alloc]initWithFrame:CGRectMake(2*self.bili, 64, 40*self.bili, 40*self.bili)];
    [aButton setTitle:@"取消" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    aButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:0.8];
    aButton.titleLabel.font = [UIFont systemFontOfSize:13*self.bili];
    aButton.layer.borderWidth=1*self.bili;
    aButton.layer.borderColor=[[UIColor clearColor]CGColor];
    aButton.layer.cornerRadius=8*self.bili;
    [aButton addTarget:self action:@selector(aButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 10, 17);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(aButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
}

#pragma mark - 点击取消按钮点击事件
- (void)aButtonClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 点击搜索按钮跳到搜索页面的实现方法
- (void)dsousuoButtonClick:(UIButton *)button{//点击搜索按钮跳到搜索页面
    // 选择的城市的字典在这里面  _dict
    informationViewController *inf = [[informationViewController alloc]init];
    
    NSString *adc= _dict[@"AreaWBS"];
    NSLog(@"传到列表页页的WBS是%@",adc);
    inf.WBSStr=adc;
    [self.navigationController pushViewController:inf animated:YES];
    
}

#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44*self.bili;
}

#pragma mark - 设置cell的层数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_tabelView1]) {
        return _dataArr1.count;
    }
    else if ([tableView isEqual:_tabelView2])
    {
        return _dataArr2.count;
    }else{
        return _dataArr3.count;
    }
}
#pragma mark - 具体设置tabelView
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_tabelView1]) {
        static NSString *ID1 = @"Cell1";
        // 1 去缓存池查找可重用的单元格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        // 2 如果没找到
        if (cell == nil) {
            // 实例化新的单元格
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID1];
        }
        //cell.backgroundColor = [UIColor yellowColor];
        cell.textLabel.text = _dataArr1[indexPath.row][@"AreaName"];
        UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43*self.bili, ScreenWidth/3.0, 1*self.bili)];
        
        im1.backgroundColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16*self.bili];
        [cell addSubview:im1];
        
        return cell;
    }
    else if ([tableView isEqual:_tabelView2])
    {
        static NSString *ID2 = @"Cell2";
        // 1 去缓存池查找可重用的单元格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        // 2 如果没找到
        if (cell == nil) {
            // 实例化新的单元格
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID2];
        }
        //cell.backgroundColor = [UIColor redColor];
        cell.textLabel.text = _dataArr2[indexPath.row][@"AreaName"];
       cell.textLabel.font = [UIFont systemFontOfSize:16*self.bili];
        UIImageView *im2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43*self.bili, ScreenWidth/3.0, 1*self.bili)];
        
        im2.backgroundColor = [UIColor grayColor];
        
        [cell addSubview:im2];
        
        return cell;
        
    }else{
        static NSString *ID3 = @"Cell3";
        // 1 去缓存池查找可重用的单元格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID3];
        // 2 如果没找到
        if (cell == nil) {
            // 实例化新的单元格
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID3];
        }
        
        
        cell.textLabel.text = _dataArr3[indexPath.row][@"AreaName"];
        UIImageView *im3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43*self.bili, ScreenWidth/3.0, 1*self.bili)];
        cell.textLabel.font = [UIFont systemFontOfSize:16*self.bili];
        im3.backgroundColor = [UIColor grayColor];
        
        [cell addSubview:im3];
        
        return cell;
        
    }
    
}


// 处理某行的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tabelView1]) {//点击了第一级，下载第二级数据，展示第二级
        
        _dict = _dataArr1[indexPath.row];
        _label.text = _dataArr1[indexPath.row][@"FullName"];
        NSDictionary *dict = @{@"action":@"Lv",@"WBS":_dataArr1[indexPath.row][@"AreaWBS"],@"AccessToken":self.lingpai};
        NSLog(@"点击的是%@",_dataArr1[indexPath.row][@"FullName"]);
        
        [self getDatawithNum:2 withDict:dict];
        if(_tabelView3){//如果tabelView3已经创建，那就已到其他地方
            _tabelView3.frame = CGRectMake(0, 0, 0, 0);
        }
    }
    else if ([tableView isEqual:_tabelView2]){//点击了第二级，下载第三级数据，展示第三级
        _dict = _dataArr2[indexPath.row];
        
        _label.text = _dataArr2[indexPath.row][@"FullName"];
        NSLog(@"点击的是%@",_dataArr2[indexPath.row][@"FullName"]);
        NSDictionary *dict = @{@"action":@"Lv",@"WBS":_dataArr2[indexPath.row][@"AreaWBS"],@"AccessToken":self.lingpai};
        [self getDatawithNum:3 withDict:dict];
    }else{                                  //点击了第三级，下载第三级数据，展示第三级
        _dict = _dataArr3[indexPath.row];
        _label.text = _dataArr3[indexPath.row][@"FullName"];
        NSLog(@"点击的是%@",_dataArr3[indexPath.row][@"FullName"]);
        
    }
}



#pragma mark -下载数据
-(void)getDatawithNum:(int)num withDict:(NSDictionary *)dict{//
    
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
//        [self shoWHint:@"当前网络异常!"];
    }else  {
        NSString *url = @"http://120.25.69.40:1005/API/GetAreaData.ashx";
        //NSDictionary *dict = @{@"action":@"HotArea",@"AccessToken":self.lingpai};
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                  // NSLog(@"登陆请求成功---%@", responseObject);
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  // NSLog(@"等到的数据转成字典是---dic:%@",dic);
                  //NSLog(@"解析后的数据是:%@\n开始设置广告循环",array1);
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  
                  
                  if (nu == 1) {
                      //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                      NSLog(@"获取区域数据信息不成功，返回的消息是%@----",MsgStr);
                      //[self chongxinHuoquLingpai];
                      
                      
                  }else{
                      NSLog(@"获取数据结果成功,开始加载数据");
                      if (num == 1) {
                          _dataArr1 = dic[@"Result"];
                          if (_tabelView1) {
                              NSLog(@"已经创建_tabelView1，不用再创建");
                              
                              [_tabelView1 reloadData];//刷新_tabelView1数据
                          }else{
                              NSLog(@"_tabelView1还没创建，现在创建");
                              _tabelView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+40*self.bili, ScreenWidth/3.0, ScreenHight-64-40*self.bili)];//创建_tabelView1
                              _tabelView1.separatorStyle = UITableViewCellSeparatorStyleNone;
                              _tabelView1.dataSource = self;
                              _tabelView1.delegate = self;
                              [self.view addSubview:_tabelView1];
                          }
                          
                          
                      }else if(num == 2){
                          _dataArr2 = dic[@"Result"];
                          if (_tabelView2) {
                              NSLog(@"已经创建_tabelView2，不用再创建");
                              _tabelView2.frame = CGRectMake(ScreenWidth/3.0, 64+40*self.bili, ScreenWidth/3.0, ScreenHight-64-40*self.bili);//将_tabelView2显示在正中
                              [_tabelView2 reloadData];//刷新_tabelView2数据
                          }else{
                              NSLog(@"_tabelView2还没创建，现在创建");
                              _tabelView2 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/3.0, 64+40*self.bili, ScreenWidth/3.0, ScreenHight-64-40*self.bili)];
                              _tabelView2.separatorStyle = UITableViewCellSeparatorStyleNone;
                              _tabelView2.dataSource = self;
                              _tabelView2.delegate = self;
                              [self.view addSubview:_tabelView2];
                          }
                          
                      }else if(num == 3){
                          _dataArr3 = dic[@"Result"];
                          if (_tabelView3) {
                              NSLog(@"已经创建_tabelView3，不用再创建");
                              _tabelView3.frame = CGRectMake(ScreenWidth/3.0*2, 64+40*self.bili, ScreenWidth/3.0, ScreenHight-64-40*self.bili);//将_tabelView3显示在右侧
                              
                              [_tabelView3 reloadData];//刷新_tabelView3数据
                          }else{
                              NSLog(@"_tabelView3还没创建，现在创建");
                              
                              _tabelView3 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/3.0*2, 64+40*self.bili, ScreenWidth/3.0, ScreenHight-64-40*self.bili)];
                              _tabelView3.separatorStyle = UITableViewCellSeparatorStyleNone;
                              _tabelView3.dataSource = self;
                              _tabelView3.delegate = self;
                              [self.view addSubview:_tabelView3];
                          }
                          
                          
                      }
                      
                  }
                  
                  //[self showhide];//隐
                  
                  
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"000%@",error);
                  //[self showhide];//隐
                  //请求失败的时候调用调用这个block
                  //[self shoWHint:@"请求失败"];
                  
              }];
    }
}








@end
