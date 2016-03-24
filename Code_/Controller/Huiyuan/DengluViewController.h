//
//  DengluViewController.h
//  登陆
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#import "ChangePasswordController.h"

@interface DengluViewController : MyViewController
@property (weak, nonatomic) IBOutlet UIImageView *zhanghaoImageView;

@property (weak, nonatomic) IBOutlet UIImageView *zhanghaoxXiahuaxianImageView;


@property (weak, nonatomic) IBOutlet UIImageView *mimaImageView;
//@property (weak, nonatomic) IBOutlet UIImageView *mimaXiahuaxianImageView;

@property (weak, nonatomic) IBOutlet UIImageView *zhuceImageView;

@property (weak, nonatomic) IBOutlet UIImageView *wangjiMimaInageView;

@property (weak, nonatomic) IBOutlet UITextField *zhanghaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *mimaTextField;

@property (nonatomic,assign) NSInteger RRR;

@property (weak, nonatomic) IBOutlet UIButton *dengluButton;

@property (weak, nonatomic) IBOutlet UIButton *zhuceButton;

@property (weak, nonatomic) IBOutlet UIButton *wangjiMimaButton;







@end
