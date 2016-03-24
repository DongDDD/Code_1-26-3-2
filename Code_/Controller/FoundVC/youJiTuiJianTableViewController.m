//
//  youJiTuiJianTableViewController.m
//  Code_
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 东. All rights reserved.
//
#import "youJiTuiJianTableViewCell.h"
#import "youJiTuiJianTableViewController.h"

@interface youJiTuiJianTableViewController ()

@end

@implementation youJiTuiJianTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 10, 17);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(fanhuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    title.text = self.headTite;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    self.navigationItem.titleView = title;
    
    self.tableView.separatorColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    youJiTuiJianTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
    if (cell==nil) {
        cell=[[youJiTuiJianTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"four"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (ScreenWidth-20)*0.47+10;
}

#pragma mark--2.点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击cell");
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)fanhuAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
