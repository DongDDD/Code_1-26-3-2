//
//  FoundViewController.m
//  Code_
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 东. All rights reserved.
//
#import "youJiTuiJianTableViewController.h"
#import "recordTableViewController.h"
#import "travelTableViewController.h"
#import "ticketsTableViewController.h"
#import "dynamicTableViewController.h"
#import "AutoAdjustFrame.h"
#import "foundFiveTableViewCell.h"
#import "foundFourTableViewCell.h"
#import "foundThreeTableViewCell.h"
#import "foundtowTableViewCell.h"
#import "founfOneTableViewCell.h"
#import "FoundViewController.h"

@interface FoundViewController ()

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor=[UIColor colorWithRed:231/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, ScreenWidth-50, 44)];
    title.text = @"发现";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    self.navigationItem.titleView = title;
    
}

#pragma mark -HeaderInSection
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else if (section==1){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 40*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.2;
        [view addSubview:foot];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 5*ScreenWidth/375, ScreenWidth-(25*ScreenWidth/375), 35*ScreenWidth/375)];
        label.text=@"门票";
        label.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        label.textColor=[UIColor blackColor];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375)];
        label1.text=@"查看全部";
        label1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-(15*ScreenWidth/375), 25*ScreenWidth/375/2+(5*ScreenWidth/375), 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt2) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt2) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 33.5*ScreenWidth/375, ScreenWidth-(14*ScreenWidth/375), 1.5*ScreenWidth/375)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.2;
        [view addSubview:headS];
        
        return view;
    }else if (section==2){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 40*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.2;
        [view addSubview:foot];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 5*ScreenWidth/375, ScreenWidth-(25*ScreenWidth/375), 35*ScreenWidth/375)];
        label.text=@"当季出行";
        label.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        label.textColor=[UIColor blackColor];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375)];
        label1.text=@"查看全部";
        label1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-(15*ScreenWidth/375), 25*ScreenWidth/375/2+(5*ScreenWidth/375), 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt3) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt3) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 33.5*ScreenWidth/375, ScreenWidth-(14*ScreenWidth/375), 1.5*ScreenWidth/375)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.2;
        [view addSubview:headS];
        
        return view;
    }else if (section==3){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 40*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.2;
        [view addSubview:foot];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 5*ScreenWidth/375, ScreenWidth-(25*ScreenWidth/375), 35*ScreenWidth/375)];
        label.text=@"游记推荐";
        label.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        label.textColor=[UIColor blackColor];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375)];
        label1.text=@"查看全部";
        label1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-(15*ScreenWidth/375), 25*ScreenWidth/375/2+(5*ScreenWidth/375), 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt4) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt4) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 33.5*ScreenWidth/375, ScreenWidth-(14*ScreenWidth/375), 1.5*ScreenWidth/375)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.2;
        [view addSubview:headS];
        
        return view;
    }else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 40*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        foot.backgroundColor=[UIColor grayColor];
        foot.alpha=0.2;
        [view addSubview:foot];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 5*ScreenWidth/375, ScreenWidth-(25*ScreenWidth/375), 35*ScreenWidth/375)];
        label.text=@"看别人去哪里玩";
        label.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        label.textColor=[UIColor blackColor];
        [view addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375)];
        label1.text=@"查看全部";
        label1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        label1.textAlignment =NSTextAlignmentRight;
        label1.textColor=[UIColor grayColor];
        [view addSubview:label1];
        
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(ScreenWidth-(15*ScreenWidth/375), 25*ScreenWidth/375/2+(5*ScreenWidth/375), 6*ScreenWidth/375, 10*ScreenWidth/375);
        [butt setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(partButt5) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:butt];
        
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(ScreenWidth-((25+70+2)*ScreenWidth/375), 5*ScreenWidth/375, 70*ScreenWidth/375, 35*ScreenWidth/375);
        but1.backgroundColor=[UIColor clearColor];
        [but1 addTarget:self action:@selector(partButt5) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but1];
        
        UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 33.5*ScreenWidth/375, ScreenWidth-(14*ScreenWidth/375), 1.5*ScreenWidth/375)];
        headS.backgroundColor=[UIColor grayColor];
        headS.alpha=0.2;
        [view addSubview:headS];
        
        
        
        return view;
    }
}
#pragma mark -HeaderHeight
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 40*ScreenWidth/375;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section==1) {
        return 2;
    }else if (section==4){
        return 2;
    }
    else{
        return 1;
    }
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        founfOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zer"];
        if (cell==nil) {
            cell=[[founfOneTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"zer"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else if (indexPath.section==1){
        foundtowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
        if (cell==nil) {
            cell=[[foundtowTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"one"];
        }
        self.tableView.separatorColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.7];
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else if (indexPath.section==2){
        foundThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tow"];
        if (cell==nil) {
            cell=[[foundThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tow"];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else if (indexPath.section==3){
        foundFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
        if (cell==nil) {
            cell=[[foundFourTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"three"];
        }
        #warning Incomplete implementation, return the number of rows
        cell.btnClick = ^(){
            NSLog(@"222===%ld",indexPath.row);
          #warning Incomplete implementation, return the number of rows
        };
         cell.delegate = self;
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else {
        
        foundFiveTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
        if (cell==nil) {
            cell=[[foundFiveTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"four"];
        }
        self.tableView.separatorColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        
        return cell;
   }
}

//实现代理
#warning Incomplete implementation, return the number of rows
-(void)myTabVClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
     youJiTuiJianTableViewController*recordTC=[[youJiTuiJianTableViewController alloc]init];
    recordTC.headTite=@"dvfb";

    [self.navigationController pushViewController:recordTC animated:YES];
    
    NSLog(@"333===%ld",index.row);
    
}

#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return ScreenHight/4.6+(ScreenWidth/13)*2+(5+25+5)*ScreenWidth/375;
    }else if (indexPath.section==1){
        if (((10+15+8+15+8+20+5)*ScreenWidth/375)>(ScreenWidth/3.5)*0.7+(20*ScreenWidth/375)) {
            return (10+15+8+15+8+20+5)*ScreenWidth/375;
        }else{
            return (ScreenWidth/3.5)*0.7+(20*ScreenWidth/375);
        }
    }else if (indexPath.section==2){
        int i =5;
            return (i/3)*((ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375))+(ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375);
        
    }else if (indexPath.section==3){
        int i =5;
            return (i/2)*((ScreenWidth-(27*ScreenWidth/375))/2*0.6+(9*ScreenWidth/375))+(ScreenWidth-(27*ScreenWidth/375))/2*0.6+(10*ScreenWidth/375);
    }else {

            int i=2;
            NSString *str=@"you游客评论等zdfkjhgkdejghdfkjhtrh 俄和他个人空间好个特人集体和个人冠军的办法就是大锅饭 i 俄国特热贴 u 让用户更加开ppcgnbgfdtrhy fgthfg hjfgdhjfgjgjgfpp放";
            return (i/3)*((ScreenWidth-(56*ScreenWidth/375))/3+(9*ScreenWidth/375))+(90*ScreenWidth/375)+[AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth-(40*ScreenWidth/375)]+(ScreenWidth-(56*ScreenWidth/375))/3.5+(10*ScreenWidth/375)+15*ScreenWidth/375+20*ScreenWidth/375;
       
    }
}

#pragma mark--2.点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击详情");
    
    if (indexPath.section==0) {
        NSLog(@"第o个cell");
    }else if (indexPath.section==1){
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        NSLog(@"第一个cell");
    }else if (indexPath.section==2){
        NSLog(@"第2个cell");
    }else if (indexPath.section==3){
        NSLog(@"第3个cell");
    }else{
        NSLog(@"第4个cell,动态的说说图");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -HeaderButtonAction

-(void)partButt2{
    NSLog(@"门票");
    ticketsTableViewController *dynamicTC=[[ticketsTableViewController alloc]init];
    
    
    [self.navigationController pushViewController:dynamicTC animated:YES];
}
-(void)partButt3{
    NSLog(@"当季出行");
    travelTableViewController *travelTC=[[travelTableViewController alloc]init];
    
    
    [self.navigationController pushViewController:travelTC animated:YES];
}
-(void)partButt4{
    NSLog(@"游记推荐");
    recordTableViewController *recordTC=[[recordTableViewController alloc]init];
    
    
    [self.navigationController pushViewController:recordTC animated:YES];
}
-(void)partButt5{
    NSLog(@"别人去哪玩");
    dynamicTableViewController *dynamicTC=[[dynamicTableViewController alloc]init];

    
    [self.navigationController pushViewController:dynamicTC animated:YES];
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
