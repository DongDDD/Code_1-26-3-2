//
//  YueduViewController.m
//  Code_
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 东. All rights reserved.
//

#import "YueduViewController.h"

@interface YueduViewController ()

@end

@implementation YueduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    
    if (_buttonTag == 111) {
        self.titleLabel.text = @"服务44444条款";
    }else{
        self.titleLabel.text = @"隐私政策";
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
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
