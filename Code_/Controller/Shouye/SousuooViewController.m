//
//  SousuooViewController.m
//  Code_
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 东. All rights reserved.
//

#import "SousuooViewController.h"
#import "informationViewController.h"
#import "cityView.h"
#import <AFNetworking.h>
@interface SousuooViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UIScrollView *sousuoScrollView;//首页滑动ScrollView
@property(nonatomic,strong)UITextField *sousuoTextField;//搜索输入行
@property(nonatomic,strong)UITableView *tabelView1;//城市列表
@property(nonatomic,strong)UITableView *tabelView2;//模糊搜索结果显示
@property(nonatomic,strong)NSArray *dataArr1;//城市列表的数据
@property(nonatomic,strong)NSArray *dataArr2;//模糊搜索的数据
@property(nonatomic,strong)NSMutableArray *dataArr21;//模糊搜索的现实数据
@property(nonatomic,strong)NSArray *dataArr3;//热门城市数据
@property(nonatomic,assign)long heig;//tabelView的起始高度


@end

@implementation SousuooViewController

-(void)fanhuAction
{
     
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self fanhuideanniu];
    [self setTheSousuolan];
    [self geRemenData];
    
//    [self gefenleiData];
//    [self zidingyiDaohanglan];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)fanhuideanniu{
    //把工具栏隐藏起来
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    self.titleLabel.text = @"请输入城市或目的地";
    
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 10, 17);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(fanhuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
}

-(void)setTheSousuolan{
    self.sousuoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
    self.sousuoScrollView.backgroundColor = [UIColor colorWithRed:230/250.0 green:230/250.0 blue:230/250.0 alpha:1];
    // 取消弹簧效果
    self.sousuoScrollView.bounces = NO;
    [self.view addSubview:self.sousuoScrollView];
    
    _sousuoTextField = [[UITextField alloc]init];
    _sousuoTextField.frame = CGRectMake1(0, 0, 320, 40);
    _sousuoTextField.delegate = self;
    //设置空白输入提示
    _sousuoTextField.placeholder = @"请输入城市或目的地";
   // _sousuoTextField.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    _sousuoTextField.backgroundColor = [UIColor whiteColor];
    // 边框类型
    self.sousuoTextField.borderStyle = UITextBorderStyleNone;//没边框
    self.sousuoTextField.textAlignment = NSTextAlignmentCenter;
    [self.sousuoScrollView addSubview:_sousuoTextField];
    
    //改变return 键的显示效果
    _sousuoTextField.returnKeyType = UIReturnKeyGo;
    // 空白提示文本颜色
//    [_sousuoTextField setValue:[UIColor yellowColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //实时获得TextField输入框的内容
    [_sousuoTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
}

-(void)textFieldChanged:(UITextField *)textField{
    NSLog(@"************************%@",textField.text);
    NSString *str = textField.text;
    if (str.length>=2) {
        if (_tabelView2) {
            NSLog(@"已经创建tabelView2");
            _tabelView2.frame = CGRectMake1(0, 40, ScreenWidth,ScreenHight-64-40*self.bili );
        }else{
            NSLog(@"开始创建tabelView2");
            _tabelView2 = [[UITableView alloc]initWithFrame:CGRectMake1(0, 40*self.bili, ScreenWidth,ScreenHight-64-40*self.bili )];
            _tabelView2.dataSource = self;
            _tabelView2.delegate = self;
            [self.sousuoScrollView addSubview:_tabelView2];
            _dataArr21 = [NSMutableArray array];
            
        }
        [_dataArr21 removeAllObjects];
        
        for (NSDictionary *dic in _dataArr2) {
            NSLog(@"%@ = =%@",dic[@"AreaName"],str);
            NSString *str1 = dic[@"AreaName"];
            //查看子串的范围
            NSRange rang = [str1 rangeOfString:str];
            if (rang.location != NSNotFound) {
                NSLog(@"存在");
                [_dataArr21 addObject:dic];
            }else{
                NSLog(@"不存在");
                
            }
        }
        NSLog(@"模糊返回的结果是:%@",_dataArr21);
        [_tabelView2 reloadData];//刷新显示
        NSLog(@"6666666666");
    }else{
        _tabelView2.frame = CGRectMake(0,0 , 0, 0);
    }
    
    
}

// 点击屏幕键盘回收
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    // 方法一 回收键盘
    [self.view endEditing:YES];
//
//    // 方法二
//    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    // 取消第一响应值
    [self.sousuoTextField resignFirstResponder];
    
    NSLog(@"回收键盘");
}


// 点击触摸－屏幕键盘回收
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.sousuoTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// 能否被编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

#pragma mark - 设置热门城市
-(void)setTheRemenChengshi{
    
    //NSArray *arr = @[@"广州",@"深圳",@"荷兰",@"日本",@"驻马店",@"广州塔"];
    int a = (int)self.dataArr3.count;
    //NSLog(@"arr.count%lu,%d",(unsigned long)arr.count,a/4*31 +90);
    for (int i = 0; i < self.dataArr3.count; i++) {
        UIButton *Button = [[UIButton alloc]initWithFrame:CGRectMake1(0+i%4*80, 80+i/4*31, 80, 30)];
        [Button setTitle:self.dataArr3[i][@"AreaName"] forState:UIControlStateNormal];
        [Button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        Button.backgroundColor = [UIColor whiteColor];
        Button.titleLabel.font = [UIFont systemFontOfSize:11*self.bili];
        [Button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        Button.tag = i+1;
        
        [self.sousuoScrollView addSubview:Button];
    }
    UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake1(80, 80, 1, a/4*31+30)];
    im1.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    [self.sousuoScrollView addSubview:im1];
    UIImageView *im2 = [[UIImageView alloc]initWithFrame:CGRectMake1(160, 80, 1, a/4*31+30)];
    im2.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    [self.sousuoScrollView addSubview:im2];
    UIImageView *im3 = [[UIImageView alloc]initWithFrame:CGRectMake1(240, 80, 1, a/4*31+30)];
    im3.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    [self.sousuoScrollView addSubview:im3];
    
    
    self.heig = (a/4)*31 +110;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(0, 40, 320, 40)];
    label.backgroundColor = [UIColor colorWithRed:200/250.0 green:200/250.0 blue:200/250.0 alpha:1];
    //label.backgroundColor = [UIColor grayColor];
    label.text = @"热门城市";
    label.font = [UIFont systemFontOfSize:16*self.bili];
    label.textAlignment = NSTextAlignmentCenter;
    [self.sousuoScrollView addSubview:label];
    NSLog(@"----%ld",self.heig);
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake1(0, self.heig, 320, 40)];
    label1.backgroundColor = [UIColor colorWithRed:200/250.0 green:200/250.0 blue:200/250.0 alpha:1];
    //label1.backgroundColor = [UIColor grayColor];
    label1.text = @"城市分类";
    label1.font = [UIFont systemFontOfSize:16*self.bili];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.sousuoScrollView addSubview:label1];
//    _heig = _heig +40;
    self.heig = self.heig +40;
    // 内容大小
    self.sousuoScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHight-64);
    //_sousuoScrollView.
    [self gefenleiData];
}

//按钮点击方法
-(void)ButtonClick:(UIButton *)button{
    informationViewController *inf = [[informationViewController alloc]init];
    
    NSLog(@"－－点击了%ld,%@",(long)button.tag,self.dataArr3[button.tag-1][@"AreaWBS"]);
    inf.WBSStr=self.dataArr3[button.tag-1][@"AreaWBS"];
    NSLog(@"传过%@",inf.WBSStr);
     [self.navigationController pushViewController:inf animated:YES];
}
#pragma mark - 下载数据
-(void)geRemenData{//设置拼接热门城市的请求参数
    //NSMutableDictionary *remenDict = [NSMutableDictionary dictionary];
    NSDictionary *dict = @{@"action":@"HotArea",@"AccessToken":self.lingpai};
    [self getDatawithNum:1 withDict:dict];
}
-(void)gefenleiData{//设置拼接已开发城市的请求参数
    //NSMutableDictionary *remenDict = [NSMutableDictionary dictionary];
    NSDictionary *dict = @{@"action":@"DevArea",@"AccessToken":self.lingpai};
    [self getDatawithNum:2 withDict:dict];
}
-(void)getCengjiData:(NSString *)WBS{//设置子级区域数据的请求参数
    
    NSDictionary *dict = @{@"action":@"Lv",@"AccessToken":self.lingpai,@"WBS":WBS};
    [self getDatawithNum:3 withDict:dict];
}
#pragma mark - 网络获取数据
-(void)getDatawithNum:(int)num withDict:(NSDictionary *)dict{
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
    }else  {
        NSString *url = @"http://120.25.69.40:1005/API/GetAreaData.ashx";
        //NSDictionary *dict = @{@"action":@"HotArea",@"AccessToken":self.lingpai};
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  // NSLog(@"等到的数据转成字典是---dic:%@",dic);
                  //NSLog(@"解析后的数据是:%@\n开始设置广告循环",array1);
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  
                  
                  if (nu == 1) {
                      //NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                      NSLog(@"获取区域数据信息不成功，返回的消息是%@----",MsgStr);
                      [self chongxinHuoquLingpai];
                      //[self getData];
                      
                  }else{
                      NSLog(@"获取数据结果成功,开始加载数据");
                      if (num == 1) {
//                          NSArray *array1 = dic [@"Result"];
                          //NSLog(@"--%@====%@",array1,array1[0][@"AreaName"]);
                          self.dataArr3 = dic[@"Result"];
                          [self setTheRemenChengshi];
                          
                      }else if(num == 2){
                          NSArray *cityArr1 = @[@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[],@[]];
                          NSMutableArray *cityArr = [NSMutableArray arrayWithArray:cityArr1];
                                                  NSString *str = @"";
                          NSArray *arrr = @[];
                          _dataArr2 = dic[@"Result"];//模糊搜索的数据
                          for (NSDictionary *di in _dataArr2) {
                              NSLog(@"模糊搜索的数据是:%@",di[@"AreaName"]);
                              str = di[@"FullName"];
                              arrr = [str componentsSeparatedByString:@","];
                              if (arrr.count == 2) {
                                  NSLog(@"这是一个市级的数据，开始添加");
                                  //将OC的字符串转成C的字符串
                                  const char * p = [di[@"ZM"] UTF8String];
                                  char a = *p;//接收
                                  //i = [di[@"ZM"] charValue];
                                  NSLog(@"---%s-----%d-----%d",[di[@"ZM"] UTF8String],a - 65,'A');
                                  NSMutableArray *ARR = [NSMutableArray arrayWithArray:cityArr[a-65]];
                                  [ARR addObject:di];
                                  //3.替换
                                  [cityArr replaceObjectAtIndex:a-65 withObject:ARR];
                              }
                          }
                          NSMutableArray *aarr = [NSMutableArray array];
                          NSLog(@"市级数据有:%@",cityArr);
                          for (NSInteger q1 = 0;q1<cityArr.count;q1++){
                              NSArray *aaa = cityArr[q1];
                              if (aaa.count == 0) {
                                  //[cityArr removeObjectAtIndex:q1];//删除指定索引的元素
                              }else{
                                  [aarr addObject:aaa];
                              }
                          }
                          
                          
                          NSLog(@"现在是市级数据有:%@",aarr);
                          _dataArr1 = aarr;
                          
                          [self setTabelView];
                          
                          
                      }else{
                          
                      }
 
                  }
                  
                  [self showhide];//隐
                  
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"000%@",error);
                  [self showhide];//隐
                  //请求失败的时候调用调用这个block
                  [self shoWHint:@"请求失败"];
                  
              }];
    }
  
}
-(void)setTabelView{
    
    _tabelView1 = [[UITableView alloc]initWithFrame:CGRectMake1(0,self.heig, ScreenWidth, ScreenHight-self.heig-64)];
    _tabelView1.dataSource = self;
    _tabelView1.delegate = self;
    [self.sousuoScrollView addSubview:_tabelView1];
}
// 返回组数, 告诉tableView要显示多少组
// 细节: 要是这个方法不写, 默认是一组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        if (tableView == _tabelView1) {
            return _dataArr1.count;
        }else{
            return 1;
        }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tabelView1) {
        NSDictionary *dic = _dataArr1[section][0];
        UILabel *lanb=[[UILabel alloc]initWithFrame:CGRectMake(5*self.bili, 0, ScreenWidth-5*self.bili, 20*self.bili)];
        lanb.text=dic[@"ZM"];
         lanb.font = [UIFont systemFontOfSize:14*self.bili];
        lanb.textAlignment = UITextAlignmentLeft;
        UIView *vieee=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20*self.bili)];
        vieee.backgroundColor=[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        [vieee addSubview:lanb];
        
        return vieee;
    }else{
        return nil;
    }

}
// 分组标题，表格视图分组类型时显示
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//        if (tableView == _tabelView1) {
//            NSDictionary *dic = _dataArr1[section][0];
//            UILabel *lanb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//            lanb.text=dic[@"ZM"];
//            
//            UIView *vieee=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//            
//            
//        return vieee;
//    }else{
//        return nil;
//    }
//}

// 分组标题的行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20*self.bili;
}
// 作用: 返回行数
//  参数section: 表示到底要返回哪一组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //先根据section获取到子数组
       if (tableView == _tabelView1) {
        NSArray *subArray = _dataArr1[section];
        return subArray.count;
    }else{
        NSLog(@"%ld",_dataArr21.count);
        return _dataArr21.count;
    }
}
// 确定Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44*self.bili;
}



// 处理某行的点击事件
#pragma mark - 设置cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tabelView1) {//这里设置城市列表的cell点击事件
        
        NSLog(@"要传过去的数据是:%@",_dataArr1[indexPath.section][indexPath.row]);
        
        cityView *city = [[cityView alloc]init];
        
//        city.backgroundColor = [UIColor whiteColor];
        city.dict = _dataArr1[indexPath.section][indexPath.row];
       // NSLog(@"%@",_dataArr1[indexPath.row][@"FullName"]);
       // NSDictionary *dic = @{@"ni":@"wo",@"wo":@"ni"};
//        NSLog(@"%@",dic);
        
        city.lingpai = self.lingpai;
//        [city setTheFenji];
        
         [self.navigationController pushViewController:city animated:YES];

        
    }else{//这里设置模糊搜索列表的cell点击事件
        cityView *city = [[cityView alloc]init];
//        city.backgroundColor = [UIColor whiteColor];
        city.dict =  _dataArr21[indexPath.row];
       
        city.lingpai = self.lingpai;
//        [city setTheFenji];
        
        [self.navigationController pushViewController:city animated:YES];

    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tabelView1) {
        static NSString *ID = @"Cell1";
        // 1 去缓存池查找可重用的单元格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 2 如果没找到
        if (cell == nil) {
            // 实例化新的单元格
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
//        [cell setLayoutMargins:UIEdgeInsetsZero];
        cell.textLabel.text = _dataArr1[indexPath.section][indexPath.row][@"AreaName"];
        //cell.textLabel.text = @"哈哈";
         cell.textLabel.font = [UIFont systemFontOfSize:16*self.bili];
        cell.textAlignment = UITextAlignmentCenter;
        return cell;
    }else{
        static NSString *ID = @"Cell2";
        // 1 去缓存池查找可重用的单元格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 2 如果没找到
        if (cell == nil) {
            // 实例化新的单元格
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
//        [cell setLayoutMargins:UIEdgeInsetsZero];
        cell.textLabel.text = _dataArr21[indexPath.row][@"AreaName"];
         cell.textLabel.font = [UIFont systemFontOfSize:16*self.bili];
        cell.textAlignment = UITextAlignmentCenter;
        return cell;
    }
    
    
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

@end
