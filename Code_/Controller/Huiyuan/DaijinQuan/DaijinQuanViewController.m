//
//  DaijinQuanViewController.m
//  Code_
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 东. All rights reserved.
//

#import "DaijinQuanViewController.h"
#import "DaijinquanTableViewCell.h"
@interface DaijinQuanViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)NSArray *dataArray;




@end

@implementation DaijinQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"代金券";
    
    
    
    [self setTheView];
    
     // Do any additional setup after loading the view from its nib.
}

-(void)setTheView{
   //设置使用说明按钮
    UIButton *bu = [[UIButton alloc]init];
    bu.frame = CGRectMake(0 , 64, ScreenWidth, 16*self.bili);
    [bu setBackgroundColor:[UIColor whiteColor]];
    [bu setTitle:@"使用说明" forState:UIControlStateNormal];
    bu.titleLabel.font = [UIFont systemFontOfSize:12*self.bili];
    [bu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:bu];
    
    
    
    
    float a =64+16*self.bili;
    
    
    _tabelView = [[UITableView alloc]init];
    _tabelView.frame = CGRectMake1(0, a, ScreenWidth, (568-a)*self.bili);
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    //设置没有下划线
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tabelView];
    
    [_tabelView registerNib:[UINib nibWithNibName:@"DaijinquanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];

    
    
    
    
}

#pragma mark - 设置tabelView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return _dataArray.count;
    return 10;
}
#pragma mark - 设置tabelView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 *self.bili;
}

#pragma mark - 设置tabelView的显示
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell1";
    
    
    DaijinquanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[DaijinquanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
        cell.bili = self.bili;
       return cell;
    
}

#pragma mark - 处理某行的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了代金券");
    
}







-(void)fanhuiButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
