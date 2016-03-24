//
//  TuiJianPage.m
//  Code_
//
//  Created by 潘伟东 on 16/3/3.
//  Copyright © 2016年 东. All rights reserved.
//

#import "TuiJianPage.h"

#import <CoreLocation/CoreLocation.h>
#import "HomeViewController.h"
#import "guanggaoXunhuan.h"
#import "JingxuanTableViewCell.h"
#import "XiangcunFenxiangTableViewCell.h"
#import <AFNetworking.h>
#import<CommonCrypto/CommonDigest.h>
#import "LingpaiYuWangluoQingqiu.h"


@interface TuiJianPage ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) NSMutableArray *GuangGaoArray;//广告解析的数据
@property(nonatomic,retain) NSMutableArray *tuijianArray;//精选推荐解析的数据
@property(nonatomic,retain) NSMutableArray *fenxiangArray;//家分享解析的数据

@property(nonatomic,strong)UITableView *jingxuanTableView;
@property(nonatomic,strong)UITableView *fenxiangTableView;


//当前屏幕的宽
@property(nonatomic,assign)int widht;
//当前屏幕的高
@property(nonatomic,assign)int hight;


@end

@implementation TuiJianPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheTableView ];
    
}

#pragma mark - 设置tabelView
-(void)setTheTableView{
    float b = self.bili;
    for (int a; a <2; a++) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10*b, 0, 300*b, 20*b)];//创建一个视图（v_headerView）
        [self.view addSubview:headerView];
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake1(5, 3, 2, 14)];//创建一个UIimageView
        [headerView addSubview:headerImageView];//添加到创建的视图中
        
        UILabel *headerLab = [[UILabel alloc] initWithFrame:CGRectMake1(10, 6, 70, 12)];//创建一个UILable用来显示标题
        headerLab.font = [UIFont systemFontOfSize:12*self.bili];//设置v_headerLab的字体样式和大小
        
        [headerView addSubview:headerLab];//将标题添加到创建的视图
        
        if (a == 0) {
            headerImageView.image = [UIImage imageNamed:@"jingxuanTuijian.png"];//设置图片
            headerLab.text = @"精选推荐";
            headerLab.textColor = [UIColor colorWithRed:242/250.0 green:36/250.0 blue:3/250.0 alpha:1];//设置v_headerLab的字体颜色
            
        }else{
            headerImageView.image = [UIImage imageNamed:@"jiaTuijian.png"];//设置图片
            headerLab.text = @"乡村.家推荐";
            headerLab.textColor = [UIColor colorWithRed:255/250.0 green:125/250.0 blue:63/250.0 alpha:1];//设置v_headerLab的字体颜色
        }
        
    }
    
    
    _jingxuanTableView = [[UITableView alloc]init];
    
    float a = self.bili;
    
    NSLog(@"---%f",a);
    _jingxuanTableView.frame = CGRectMake(10*a, 12, 300*a, 325*a);
    NSLog(@"---%f,---%f,---%f",ScreenWidth*self.bili,ScreenWidth,self.bili);
    
    _jingxuanTableView.dataSource = self;
    _jingxuanTableView.delegate = self;
    //取消弹簧效果
    _jingxuanTableView.bounces = NO;
    [self.view addSubview:_jingxuanTableView];
    
    
    
    _fenxiangTableView = [[UITableView alloc]init];
    
    _fenxiangTableView.frame = CGRectMake(10*a, 325*a, 300*a,370*a);
    NSLog(@"111111--%f",390*self.bili);
    _fenxiangTableView.dataSource = self;
    _fenxiangTableView.delegate =self;
    _fenxiangTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //取消弹簧效果
    _fenxiangTableView.bounces = NO;
    
    [self.view addSubview:_fenxiangTableView];
    
    [_jingxuanTableView registerNib:[UINib nibWithNibName:@"JingxuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_fenxiangTableView registerNib:[UINib nibWithNibName:@"XiangcunFenxiangTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
   

}


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

#pragma mark - 设置cell的层数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_jingxuanTableView]) {
        return _tuijianArray.count;
        //return 6;
    }
    else if ([tableView isEqual:_fenxiangTableView])
    {
        //return _fenxiangArray.count;
        return 8;
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
        
    }else{
        return  nil;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
