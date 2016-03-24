//
//  GouwucheViewController.m
//  Code_
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 东. All rights reserved.
//

#import "GouwucheViewController.h"
#import "GouwucheTableViewCell.h"
#import "DingdanZhifuViewController.h"
#import "TijiaoDingdanViewController.h"
#import "MBProgressHUD+MJ.h"
@interface GouwucheViewController ()<UITableViewDataSource,UITableViewDelegate,xuanzeShangpinDelegate>
@property(nonatomic,strong)UITableView *tabelView;

@property(nonatomic,strong)UIButton *bianjiButton;
@property(nonatomic,strong)NSMutableArray *dataArr;//存储在购物车选好要提交的数据
@property(nonatomic,strong)NSMutableArray *xianshiDataArr;//存储要显示的数据

@end

@implementation GouwucheViewController


-(void)viewWillAppear:(BOOL)animated{
    
    //把工具栏隐藏掉
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"购物车";
    
    [self getData];
    [self setTheTabelView];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 下载数据
-(void)getData{
    _quanxuanButton.selected = NO;
    _dataArr = [NSMutableArray array];
    _xianshiDataArr = [NSMutableArray array];
    
    _zongJineLabel.text =@"总金额:￥0.00";
    NSArray *arr = @[@{@"1":@"100",@"geshu":@"2",@"danjia":@"50",@"shangpinming":@"1"},
                     @{@"1":@"80",@"geshu":@"4",@"danjia":@"20",@"shangpingming":@"2"},
                     @{@"1":@"60",@"geshu":@"2",@"danjia":@"30",@"shangpingming":@"3"},
                     @{@"1":@"90",@"geshu":@"9",@"danjia":@"10",@"shangpingming":@"4"},
                     @{@"1":@"120",@"geshu":@"1",@"danjia":@"120",@"shangpingming":@"5"},
                     @{@"1":@"130",@"geshu":@"1",@"danjia":@"130",@"shangpingming":@"6"}];
    //设置显示数组
    [_xianshiDataArr addObjectsFromArray:arr];
    NSLog(@"要显示的数据是%@",_xianshiDataArr);
    //设置提交数组
    for (int i = 0; i<_xianshiDataArr.count; i++) {
        [_dataArr addObject:@{@"1":@"0",@"geshu":@"0",@"danjia":@"0",@"shangpingming":@"6"}];
    }
    NSLog(@"");
  [self setThezongjinE];
}


#pragma mark - 设置tabelView
-(void)setTheTabelView{
    NSLog(@"设置需要支付的金额");
    [self setThezongjinE];
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake1(0, 0, 560, ScreenHight-64)];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    //设置cell没有下划线
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_neirongView addSubview:_tabelView];
    
    [_tabelView registerNib:[UINib nibWithNibName:@"GouwucheTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
}
#pragma mark - 设置tabelView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _xianshiDataArr.count;
    
}
#pragma mark - 设置tabelView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76 *self.bili;
}

#pragma mark - 设置tabelView的显示
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell1";
    
    
    GouwucheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[GouwucheTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.delegate = self;
    
    cell.quanxuanButtonSelected = _quanxuanButton.isSelected;
    
    if (_quanxuanButton.selected == YES) {
        cell.xuanze = YES;
    }else{
        if ([_dataArr[indexPath.row][@"1"]isEqualToString:@"0"]) {
            cell.xuanze = NO;
        }else{
            cell.xuanze = YES;
        }
    }
    
    
    
    
    cell.bili = self.bili;
    cell.indexPathRow = indexPath.row;
    
    [cell setTheCell:_xianshiDataArr[indexPath.row]];
       return cell;
    
}

#pragma mark - 处理某行的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了第%ld行",(long)indexPath.row);
    //    DingdanXiangQingViewController *xiangqing = [[DingdanXiangQingViewController alloc]init];
    //
    //    [self.navigationController pushViewController:xiangqing animated:YES];
    
}

#pragma mark - 设置代理方法
//选择了商品调用的方法
-(void)fanhuiXuanzeDeShangpin:(NSDictionary *)dict withTag:(NSInteger)tag withButtonSelected:(BOOL)selected{
    NSLog(@"因为点击了选择商品的按钮，调用方法");
    //选择商品后
    if (selected ==YES) {
        [_dataArr replaceObjectAtIndex:tag withObject:dict];
        [_xianshiDataArr replaceObjectAtIndex:tag withObject:dict];
        NSLog(@"添加后的提交订单是:%@",_dataArr);
    }else{
        [_dataArr replaceObjectAtIndex:tag withObject:@{@"1":@"0",@"geshu":@"0",@"danjia":@"0",@"shangpingming":@"6"}];
    }
   [self setThezongjinE];
   [_tabelView reloadData];
}
//修改了数量调用的方法
-(void)xiugaiShuliang:(NSDictionary *)dict withTag:(NSInteger)tag  withButtonSelected:(BOOL)selected{
    //修改数量后
    
    [_dataArr replaceObjectAtIndex:tag withObject:dict];
    
    
    if (selected == YES) {
       
        [_xianshiDataArr replaceObjectAtIndex:tag withObject:dict];
         NSLog(@"已经选择准备提交的商品改变数量价格后是:%@",_dataArr);
    }
    NSLog(@"修改数量后显示的方法");
    [self setThezongjinE];
    [_tabelView reloadData];

    
    
    
}
#pragma mark - 设置全选按钮
- (IBAction)quanxuanButtonClick:(id)sender {

    _quanxuanButton.selected = !_quanxuanButton.isSelected;
    
    [self setThezongjinE];
    [_tabelView reloadData];
    
    
}

#pragma mark - 设置需要支付的总金额的数字
-(void)setThezongjinE{
    float zongjine = 0;
    if (_quanxuanButton.selected) {
        NSLog(@"全选的状态");
        for (NSDictionary *dict in _xianshiDataArr) {
            zongjine = zongjine + [dict[@"1"] floatValue];
            NSLog(@"%f",zongjine);
        }
    }else{
        NSLog(@"没有全选的状态");
        for (NSDictionary *dict in _dataArr) {
            zongjine = zongjine + [dict[@"1"] floatValue];
            NSLog(@"%f",zongjine);
        }
    }
    _zongJineLabel.text = [NSString stringWithFormat:@"总金额:￥%.2f",zongjine];

    

    
    
}

#pragma mark - 设置提交按钮
- (IBAction)jiesuanButtonClick:(id)sender {
    
    
    //选好商品跳到提交页面提交
    TijiaoDingdanViewController *tijiao = [[TijiaoDingdanViewController alloc]init];
    if (_quanxuanButton.selected == YES) {
        if (_xianshiDataArr.count == 0) {
            [MBProgressHUD showError:@"没有选择商品"];
        }else{
            tijiao.dingdanArray = _xianshiDataArr;
            NSLog(@"需要提交的商品数据是:%@",_xianshiDataArr);
            
            [self.navigationController pushViewController:tijiao animated:YES];
            
            //[self presentViewController:tijiao animated:YES completion:nil];
        }
    }else{
        NSMutableArray *arr = [NSMutableArray array];//要提交的数据
        for (NSDictionary *dic in _dataArr) {
            if (![dic[@"1"]isEqualToString:@"0"]) {
                [arr addObject:dic];
            }
        }
        if (arr.count == 0) {
            [MBProgressHUD showError:@"请选择商品再提交"];
        }else{
            tijiao.dingdanArray = arr;
            NSLog(@"需要提交的商品数据是:%@",arr);
            [self.navigationController pushViewController:tijiao animated:YES];
            //[self presentViewController:tijiao animated:YES completion:nil];
        }
    }
    
    
    
    
    
    
    
    
    
}



-(void)fanhuiButtonClick{
    
    

    //把工具栏显示出来
    self.hidesBottomBarWhenPushed=NO;
    self.tabBarController.tabBar.hidden=NO;

    [self.navigationController popViewControllerAnimated:YES];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
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
