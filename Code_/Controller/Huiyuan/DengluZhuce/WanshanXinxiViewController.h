//
//  WanshanXinxiViewController.h
//  Code_
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 东. All rights reserved.
//

#import "MyViewController.h"

@interface WanshanXinxiViewController : MyViewController
@property (weak, nonatomic) IBOutlet UIView *neirongView;


@property (nonatomic,strong)NSDictionary *dict;//接收注册信息传来的值

@property (nonatomic,copy)NSString *Passwords;
@property (nonatomic,copy)NSString *LoginName;

@property (nonatomic,retain)UIButton *but;

@end
