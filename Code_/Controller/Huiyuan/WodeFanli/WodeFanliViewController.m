//
//  WodeFanliViewController.m
//  Code_
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 东. All rights reserved.
//

#import "WodeFanliViewController.h"

@interface WodeFanliViewController ()
@property (nonatomic,strong)UITableView *tabelView;

@property(nonatomic,assign)BOOL xianshiOrXiaoshi;

@end

@implementation WodeFanliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"我的返利";
    
    _xianshiOrXiaoshi = NO;
    // Do any additional setup after loading the view from its nib.
}

-(void)setTabelView{
    _tabelView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 235, 320, 333)];
    
    _tabelView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabelView];
    
    
}


- (IBAction)xianshiDingdanButtonClick:(id)sender {
    
    _xianshiOrXiaoshi = !_xianshiOrXiaoshi;
    
    if (_xianshiOrXiaoshi) {
        [self setTabelView];
    }else{
        [_tabelView removeFromSuperview];
    }
    
    
    
    
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
