//
//  DingdanZhifuViewController.m
//  Code_
//
//  Created by admin on 15/12/25.
//  Copyright © 2015年 东. All rights reserved.
//

#import "DingdanZhifuViewController.h"
#import "QuanbuDingdanViewController.h"
#import "DingdanXiangQingViewController.h"
#import "HomeViewController.h"
#import "DingdanTableViewCell.h"
#import "MemberViewController.h"
@interface DingdanZhifuViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,assign)NSInteger zhifuButtonTag;//记录选择的支付方式

@property (nonatomic,strong)UITableView *tabelView;//显示商品
@property (nonatomic,strong)UIScrollView *neirongScrollView;
@property (nonatomic,strong)UIImageView *zhifuImageView;
@property (nonatomic,assign)int liucheng;//记录支付走到哪一步？

@end

@implementation DingdanZhifuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"订单支付";
    
    //把工具栏隐藏掉
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    
    NSLog(@"要支付的数据是:%@",_dataArray);
    
    
    _liucheng = 0;
   
    [self setTheView];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 设置显示内容
-(void)setTheView{
    
    float a = 76*_dataArray.count;
    _neirongScrollView = [[UIScrollView alloc]init];
    _neirongScrollView.frame = CGRectMake(0, 64, ScreenWidth,ScreenHight-64);
    _neirongScrollView.tag = 1;
    // 内容大小
    _neirongScrollView.contentSize = CGSizeMake(320, (a+260)*self.bili);
    // 取消水平滚动条
    _neirongScrollView.showsHorizontalScrollIndicator = NO;
    // 取消垂直滚动条
    _neirongScrollView.showsVerticalScrollIndicator = NO;
    // 取消弹簧效果
    _neirongScrollView.bounces = NO;
    _neirongScrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_neirongScrollView];
    
    _tabelView = [[UITableView alloc]init];
    _tabelView.frame = CGRectMake1(0, 0, 320, a);
    _tabelView.backgroundColor = [UIColor brownColor];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    //设置没有下划线
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_neirongScrollView addSubview:_tabelView];
    
    [_tabelView registerNib:[UINib nibWithNibName:@"DingdanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];

    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake1(0, 190+a,200 , 30)];
    
//    for (NSDictionary *dict in _dataArray) {
//        _zongjine = _zongjine + [dict[@"zongjine"] floatValue];
//    }
    
    NSString *str11 = [NSString stringWithFormat:@"    需要支付的总金额是:￥%.2f",_zongjine];
    la.text = str11;
    la.font = [UIFont systemFontOfSize:13*self.bili];
    la.textAlignment = NSTextAlignmentLeft;
    la.backgroundColor = [UIColor colorWithRed:0/250.0 green:159/250.0 blue:252/250.0 alpha:1];
    la.textColor = [UIColor whiteColor];
    la.backgroundColor = [UIColor grayColor];
    NSLog(@"la:%@",la.text);
    [_neirongScrollView addSubview:la];
    
    UIButton *bu1 = [[UIButton alloc]initWithFrame:CGRectMake1(200, 190+a, 120, 30)];
    [bu1 setTitle:@"确认支付" forState:UIControlStateNormal];
    bu1.titleLabel.font = [UIFont systemFontOfSize:14*self.bili];
    bu1.selected = NO;
    [bu1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bu1 setBackgroundColor:[UIColor colorWithRed:246/255.0 green:123/255.0 blue:3/255.0 alpha:1]];
    [bu1 setBackgroundColor:[UIColor redColor]];
    
    [bu1 addTarget:self action:@selector(querenZhifuButtonClick) forControlEvents: UIControlEventTouchDown];
    //bu1.layer.cornerRadius = 4*self.bili;
    [_neirongScrollView addSubview:bu1];

    
    
    
    
    
    
    
    
    
}
#pragma mark - 记载支付
-(void)setTheZhifuImageView{
    
    _zhifuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHight-64)];
    _zhifuImageView.backgroundColor = [UIColor whiteColor];
    _zhifuImageView.tag = 111111;
    _zhifuImageView.userInteractionEnabled = YES;
    [self.view addSubview:_zhifuImageView];
    
    _zhifuButtonTag = 123456;
    NSArray *arr1 = @[@"支付宝支付",@"银联支付",@"微信支付"];
    NSArray *arr2 = @[@"推荐有支付宝账号的用户使用",@"支持储蓄信用卡，无需开通网银",@"推荐安装微信5.0以上版本的用户使用"];
    for (int i = 0; i<3; i++) {
        
        UIButton *xuanzeButton = [[UIButton alloc]init];
        xuanzeButton.frame =CGRectMake1(0, 80+47*i, 320, 47);
        xuanzeButton.tag = i+1;
        xuanzeButton.selected = NO;
        [xuanzeButton addTarget:self action:@selector(xuanzeZhifuFangshiButtonClick:) forControlEvents:UIControlEventTouchDown];
        
        [_zhifuImageView addSubview:xuanzeButton];
        
        
        
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake1(62, 13, 180, 12);
        label.text = arr1[i];
        label.font = [UIFont systemFontOfSize:13*self.bili];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        [xuanzeButton addSubview:label];
        UILabel *label2 = [[UILabel alloc]init];
        label2.frame = CGRectMake1(62, 29, 180, 10);
        label2.text = arr2[i];
        label2.font = [UIFont systemFontOfSize:9*self.bili];
        label2.textColor = [UIColor grayColor];
        label2.textAlignment = NSTextAlignmentLeft;
        [xuanzeButton addSubview:label2];
        
        //设置左侧图片
        UIImageView *imm1 = [[UIImageView alloc]init];
        imm1.frame = CGRectMake1(12, 8, 42, 30);
        imm1.backgroundColor = [UIColor yellowColor];
        [xuanzeButton addSubview:imm1];
        
        //设置下划线
        UIImageView *imm = [[UIImageView alloc]init];
        imm.frame = CGRectMake1(8, 46, 304, 1);
        imm.backgroundColor = [UIColor grayColor];
        [xuanzeButton addSubview:imm];
        
        UIButton *bb = [[UIButton alloc]initWithFrame:CGRectMake1(280, 97+47*i, 12, 12)];
        bb.tag = (i+1)*10;
        bb.selected = NO;
        [bb setBackgroundImage:[UIImage imageNamed:@"关于.png"] forState:UIControlStateNormal];
        [bb setBackgroundImage:[UIImage imageNamed:@"实名认证.png"] forState:UIControlStateSelected];
//        [bb addTarget:self action:@selector(xuanzeZhifuFangshiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_zhifuImageView addSubview:bb];
        
    }
    
    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake1(30, 264, 260, 30)];
    [bu setTitle:@"支   付" forState:UIControlStateNormal];
    bu.titleLabel.font = [UIFont systemFontOfSize:14*self.bili];
    bu.selected = NO;
    [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bu setBackgroundColor:[UIColor colorWithRed:246/255.0 green:123/255.0 blue:3/255.0 alpha:1]];
    [bu addTarget:self action:@selector(querenZhifuButtonClick) forControlEvents: UIControlEventTouchDown];
    bu.layer.cornerRadius = 4*self.bili;
    [_zhifuImageView addSubview:bu];


}






#pragma mark - 设置选择支付方式按钮点击事件
-(void)xuanzeZhifuFangshiButtonClick:(UIButton *)button{
    NSLog(@"点击了选择按钮");
    if (_zhifuButtonTag == 123456) {
        NSLog(@"还没选择方法 --->");
        button.selected = YES;
         UIButton *bu1 = (UIButton *)[[self.view viewWithTag:111111] viewWithTag:button.tag*10];
       
        bu1.selected = YES;
        _zhifuButtonTag = button.tag;
    }else{
        if (_zhifuButtonTag == button.tag) {
             UIButton *bu1 = (UIButton *)[[self.view viewWithTag:111111] viewWithTag:button.tag*10];
            bu1.selected = NO;
            
            button.selected = NO;
            _zhifuButtonTag = 123456;
        }else{
             UIButton *bu1 = (UIButton *)[[self.view viewWithTag:111111] viewWithTag:button.tag*10];
            bu1.selected = YES;
            button.selected = YES;
            UIButton *bu = (UIButton *)[[self.view viewWithTag:111111] viewWithTag:_zhifuButtonTag*10];
            bu.selected = !bu.isSelected;
            
            _zhifuButtonTag = button.tag;
        }
 
    }
    
}


#pragma mark - 设置确认支付按钮点击事件进入支付流程2
-(void)querenZhifuButtonClick{
    
    
    if (_liucheng == 0) {
        _liucheng = 1;
        [self setTheZhifuImageView];
    }else{
        if (_zhifuButtonTag == 123456) {
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = @"请选择支付方式在确认付款";
            [alertView addButtonWithTitle:@"取消"];
            [alertView show];
        }else{
            NSString *str = [NSString stringWithFormat:@"%f",_zongjine];
            NSLog(@"选择了第%ld种支付方式并确认了支付,支付的金额是%@",_zhifuButtonTag,str);
            
            //把工具栏显示出来
            self.hidesBottomBarWhenPushed=NO;
            self.tabBarController.tabBar.hidden=NO;

            QuanbuDingdanViewController *quanbu = [[QuanbuDingdanViewController alloc]init];
            quanbu.buttonTag = 3;
            [self.navigationController pushViewController:quanbu animated:YES];
            
        }
    }
 
}




#pragma mark - 设置tabelView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
#pragma mark - 设置tabelView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76 *self.bili;
}

#pragma mark - 设置tabelView的显示
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell1";
    
    
    DingdanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[DingdanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    //cell.delegate = self;
    //cell.xianshiLan = _buttonTag;
    cell.bili = self.bili;
    //cell.selectionStyle = NO;
    //赋值
    //设置tabelView能不能滑动
    //    if (_buttonTag == 2) {
    //        cell.selectionStyle = NO;
    //        _tabelView1.userInteractionEnabled = NO;
    //        cell.userInteractionEnabled = YES;
    //    }else{
    //        _tabelView1.userInteractionEnabled = YES;
    //    }
    
    cell.chakanOrZhifu = YES;
    [cell jiazaiShuju:_dataArray[indexPath.row]];
    
    
    return cell;
    
}

#pragma mark - 处理某行的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DingdanXiangQingViewController *xiangqing = [[DingdanXiangQingViewController alloc]init];
    
   
    
    
    
    
    [self.navigationController pushViewController:xiangqing animated:YES];
    
    //[self presentViewController:xiangqing animated:YES completion:nil];
    
}

-(void)fanhuiButtonClick{

    if (_liucheng == 1) {
        [_zhifuImageView removeFromSuperview];
        _liucheng = 0;
    }else{
        NSLog(@"");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"狠心放弃付款" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
//        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃付款" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了放弃付款按钮");
            
            [self fanhuiButtonClick];
//            //把工具栏显示出来
//            self.hidesBottomBarWhenPushed=NO;
//            self.tabBarController.tabBar.hidden=NO;
//            
//            // 返回上一个界面
//            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续付款" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        

        [self presentViewController:alertController animated:YES completion:nil];
        
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
