//
//  TijiaoDingdanViewController.m
//  Code_
//
//  Created by admin on 15/12/25.
//  Copyright © 2015年 东. All rights reserved.
//

#import "TijiaoDingdanViewController.h"
#import "ZhanghaoXinxiViewController.h"
#import "ZhanghaoXinxiTableViewCell.h"
#import "BianjiYeViewController.h"
#import "DingdanTableViewCell.h"
#import "DingdanZhifuViewController.h"

@interface TijiaoDingdanViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,assign)float zongjine;

@property(nonatomic,strong)UITableView *tabelView;

@property(nonatomic,strong)UIView *tianjiaZhuhuView;//添加住户的View

@end

@implementation TijiaoDingdanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"提交订单";
    
    
    //把工具栏隐藏掉
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    
      
    
    [self setTheNeirongView];
    [self setTheTabelView];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 设置内容显示
-(void)setTheNeirongView{
    
    // 内容大小
    _neirongView.contentSize = CGSizeMake(ScreenWidth, (130+76*_dingdanArray.count)*self.bili);

    // 取消水平滚动条
    //_neirongView.showsHorizontalScrollIndicator = NO;
    // 取消垂直滚动条
    _neirongView.showsVerticalScrollIndicator = NO;
    // 取消弹簧效果
    _neirongView.bounces = NO;
    
    UIButton *tianjiaButton = [[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [tianjiaButton setTitle:@"添加住户" forState:UIControlStateNormal];
    [tianjiaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tianjiaButton.backgroundColor = [UIColor redColor];
    tianjiaButton.titleLabel.font = [UIFont systemFontOfSize:16*self.bili];
    [tianjiaButton addTarget:self action:@selector(tianjiaZhukeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_neirongView addSubview:tianjiaButton];
    
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake1(0, 50, 320, 76*_dingdanArray.count)];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    [_tabelView registerNib:[UINib nibWithNibName:@"DingdanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_neirongView addSubview:_tabelView];
    
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(0, 50+76*_dingdanArray.count, 320, 15)];
    _zongjine = 0;
    for (NSDictionary *dic in _dingdanArray) {
        _zongjine = _zongjine + [dic[@"1"] floatValue];
    }
    label.text = [NSString stringWithFormat:@"总金额:￥%.2f",_zongjine];
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14*self.bili];
    [_neirongView addSubview:label];
    
    
    
    
    
    UIButton *tijiaoButton = [[UIButton alloc]initWithFrame:CGRectMake1(0, 70+76*_dingdanArray.count, 320, 40)];
    [tijiaoButton setTitle:@"提交" forState:UIControlStateNormal];
    [tijiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tijiaoButton.backgroundColor = [UIColor redColor];
    tijiaoButton.titleLabel.font = [UIFont systemFontOfSize:16*self.bili];
    [tijiaoButton addTarget:self action:@selector(tijiaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_neirongView addSubview:tijiaoButton];
    
    
    
}
#pragma mark - 提交按钮点击事件
-(void)tijiaoButtonClick:(UIButton *)button{
    
   
    NSLog(@"点击了提交按钮，提交的数据是:%@，",_dingdanArray);
    
    
    DingdanZhifuViewController *zhifu = [[DingdanZhifuViewController alloc]init];
    
    zhifu.dataArray = _dingdanArray;
    zhifu.zongjine = _zongjine;
    
    
    [self.navigationController pushViewController:zhifu animated:YES];
    
    //[self presentViewController:zhifu animated:YES completion:nil];
    
    
}





#pragma mark - 设置添加按钮点击事件
-(void)tianjiaZhukeButtonClick:(UIButton *)button{
    _tianjiaZhuhuView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHight-64)];
    _tianjiaZhuhuView.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:_tianjiaZhuhuView];
    
    
    //设置添加按钮
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [button1 setBackgroundColor: [UIColor colorWithRed:0/250.0 green:159/250.0 blue:252/250.0 alpha:1]];
        [button1 setTitle:@"       添加常用住客" forState:UIControlStateNormal];
    
    button1.titleLabel.font = [UIFont systemFontOfSize:14*self.bili];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(tianjiaXinxiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 1000;
    [_neirongView addSubview:button1];
    
    UIImageView *imi = [[UIImageView alloc]initWithFrame:CGRectMake1(12, 7, 21, 21)];
    imi.image = [UIImage imageNamed:@"添加图标.png"];
    [button1 addSubview:imi];
    button1.layer.cornerRadius = 6*self.bili;

    
    
    
    
    //设置tabelView
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake1(320,60 , 320, ScreenHight-155)];
    tabelView.backgroundColor = [UIColor whiteColor];
    [_neirongView addSubview:tabelView];
    tabelView.dataSource = self;
    tabelView.delegate = self;
    tabelView.tag = 10;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tabelView registerNib:[UINib nibWithNibName:@"DingdanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    
    
}
#pragma mark - 设置点击添加常用住客按钮点击
-(void)tianjiaXinxiButtonClick:(UIButton *)button{
    NSLog(@"点击了添加信息按钮");
    
    BianjiYeViewController *bianji = [[BianjiYeViewController alloc]init];
    
    bianji.buttonTag = button.tag;
    
    
    [self.navigationController pushViewController:bianji animated:YES];
    
    //[self presentViewController:bianji animated:YES completion:nil];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dingdanArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 76*self.bili;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell1";
    
    
    DingdanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[DingdanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.bili = self.bili;
   
    cell.chakanOrZhifu = YES;
    [cell jiazaiShuju:_dingdanArray[indexPath.row]];
    
    
    
    return cell;
    
}




-(void)setTheTabelView{
    
    //_tabelView = [[UITableView alloc]init];
    //_tabelView.frame =
    
    
    
}




-(void)fanhuiButtonClick{
    
    
    
    //把工具栏显示出来
    self.hidesBottomBarWhenPushed=NO;
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
   
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
