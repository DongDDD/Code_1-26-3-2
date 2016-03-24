//
//  cityView.h
//  Code_
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 东. All rights reserved.
//

#import "MyViewController.h"
#import <UIKit/UIKit.h>

@interface cityView : MyViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSDictionary *dict;//传过来的城市dict;
@property(nonatomic,strong)NSDictionary *dict1;//传给其他界面的dict;
@property(nonatomic,strong)UILabel *label;//显示当前选择的地点
@property(nonatomic,strong)UITableView *tabelView1;
@property(nonatomic,strong)UITableView *tabelView2;
@property(nonatomic,strong)UITableView *tabelView3;
@property(nonatomic,strong)NSArray *dataArr1;
@property(nonatomic,strong)NSArray *dataArr2;
@property(nonatomic,strong)NSArray *dataArr3;

//@property(nonatomic,copy)NSString *lingpai;//令牌
//
//@property(nonatomic,assign)float bili;




//-(void)setTheFenji;//设置分级




@end
