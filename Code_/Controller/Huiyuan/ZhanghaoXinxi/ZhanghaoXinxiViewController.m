//
//  ZhanghaoXinxiViewController.m
//  Code_
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 东. All rights reserved.
//

#import "ZhanghaoXinxiViewController.h"
#import "ZhanghaoXinxiTableViewCell.h"
#import "BianjiYeViewController.h"
@interface ZhanghaoXinxiViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *xiahuaxianImageView;

@property (nonatomic,strong)UIScrollView *neirongScorollView;

@property (nonatomic,strong)UITableView *tabelView1;




@end

@implementation ZhanghaoXinxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"常用信息";
    
    //把工具栏隐藏起来
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    self.titleLabel.text = @"请输入城市或目的地";
    
    [self setTheButton];
    [self setTheScorrlView];
    // Do any additional setup after loading the view from its nib.
}
//-(void)fanhuiButtonClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
-(void)setTheButton{
    //设置头部三个按钮
    NSArray *arr = @[@"常用住客",@"常用地址",@"发票抬头"];
    for (int i = 0; i<3; i++) {
        UIButton *bu = [[UIButton alloc]init];
        bu.frame = CGRectMake1(0+107*i, 0, 106, 25);
        
        [bu setTitle:arr[i] forState:UIControlStateNormal];
        bu.titleLabel.font = [UIFont systemFontOfSize:12*self.bili];
        [bu setBackgroundColor:[UIColor whiteColor]];
        bu.tag = (i+1)*100;
        [bu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        [_neirongView addSubview:bu];
        
        if (i<2) {
            UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake1(106+i*107, 0, 1, 25)];
            im.backgroundColor = [UIColor colorWithRed:90/250.0 green:90/250.0 blue:90/250.0 alpha:1];
            [_neirongView addSubview:im];
        }
        
        
        
    }
    //设置下划线
    UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake1(0, 25, 320, 1)];
    im1.backgroundColor = [UIColor colorWithRed:83/250.0 green:83/250.0 blue:83/250.0 alpha:1];
    [_neirongView addSubview:im1];
    
    _xiahuaxianImageView = [[UIImageView alloc]initWithFrame:CGRectMake1(0, 25, 106, 1)];
    _xiahuaxianImageView.backgroundColor = [UIColor colorWithRed:245/250.0 green:105/250.0 blue:0/250.0 alpha:1];
    _xiahuaxianImageView.backgroundColor = [UIColor orangeColor];
    [_neirongView addSubview:_xiahuaxianImageView];
    
    
}

-(void)buttonClick:(UIButton *)button{
    
    
    _xiahuaxianImageView.frame = CGRectMake1((button.tag/100-1)*107, 25, 106, 1);
    
    
    
    _neirongScorollView.contentOffset = CGPointMake((button.tag/100-1)*ScreenWidth, 0);
    
    NSLog(@"buttonTag:%lu",button.tag);
}
#pragma mark - 设置显示内容
-(void)setTheScorrlView{
    NSLog(@"------screeh:%f",ScreenHight-89);
    _neirongScorollView = [[UIScrollView alloc]initWithFrame:CGRectMake1(0, 26, 320, ScreenHight-89)];
    [_neirongView addSubview:_neirongScorollView];
    // 内容大小
    _neirongScorollView.contentSize = CGSizeMake(ScreenWidth*3, ScreenHight-89);    // 取消水平滚动条
    _neirongScorollView.showsHorizontalScrollIndicator = NO;
    // 取消垂直滚动条
    _neirongScorollView.showsVerticalScrollIndicator = NO;
    // 取消弹簧效果
    _neirongScorollView.bounces = NO;
    _neirongScorollView.delegate = self;
    // _neirongScorollView.backgroundColor = [UIColor colorWithRed:231/205.0 green:237/250.0 blue:238/250.0 alpha:1];
    // 设置偏移位置
    _neirongScorollView.contentOffset = CGPointMake(0, 0);
    
    // 分页使能
    _neirongScorollView.pagingEnabled = YES;
    _neirongScorollView.userInteractionEnabled = YES ;
    for (int i = 1; i<4; i++) {
        //设置tabelView
        UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake1(320*(i-1),60 , 320, ScreenHight-155)];
        tabelView.backgroundColor = [UIColor whiteColor];
        [_neirongScorollView addSubview:tabelView];
        tabelView.dataSource = self;
        tabelView.delegate = self;
        tabelView.tag = i*10;
        tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tabelView registerNib:[UINib nibWithNibName:@"ZhanghaoXinxiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
        
        //设置添加按钮
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake1(95+(i-1)*320, 13, 130, 35)];
        [button1 setBackgroundColor: [UIColor colorWithRed:0/250.0 green:159/250.0 blue:252/250.0 alpha:1]];
        
        
        if (i == 1) {
            [button1 setTitle:@"       添加常用住客" forState:UIControlStateNormal];
        }else if(i == 2){
            [button1 setTitle:@"       添加常用地址" forState:UIControlStateNormal];
        }else{
            [button1 setTitle:@"       添加发票抬头" forState:UIControlStateNormal];
        }
        button1.titleLabel.font = [UIFont systemFontOfSize:14*self.bili];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button1 addTarget:self action:@selector(tianjiaXinxiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag = i*1000;
        [_neirongScorollView addSubview:button1];
        
        UIImageView *imi = [[UIImageView alloc]initWithFrame:CGRectMake1(12, 7, 21, 21)];
        imi.image = [UIImage imageNamed:@"添加图标.png"];
        [button1 addSubview:imi];
        button1.layer.cornerRadius = 6*self.bili;
        
        
        
    }
    
    
    
    
}
-(void)tianjiaXinxiButtonClick:(UIButton *)button{
    NSLog(@"点击了添加信息按钮");
    
    BianjiYeViewController *bianji = [[BianjiYeViewController alloc]init];
    
    bianji.buttonTag = button.tag;
    
    [self.navigationController pushViewController:bianji animated:YES];
    
    
    
    //[self presentViewController:bianji animated:YES completion:nil];
    
}


// 结束图片拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // scrollView.contentOffset
    NSLog(@"现在%f",scrollView.contentOffset.x);
    
}
// 视图滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _xiahuaxianImageView.frame = CGRectMake1((scrollView.contentOffset.x/ScreenWidth)*107, 25, 106, 1);
    NSLog(@"视图滚动结束现在%f",scrollView.contentOffset.x/ScreenWidth);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag/10) {
        case 1:
            return 10;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 3;
            break;
        default:
            return 0;
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 30) {
        return 42*self.bili;
    }else{
        return 60*self.bili;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell1";
    
    
    ZhanghaoXinxiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[ZhanghaoXinxiTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.bili = self.bili;
    cell.buttonTag = tableView.tag;
    [cell setTheCell];
    
    
    
    return cell;
    
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
