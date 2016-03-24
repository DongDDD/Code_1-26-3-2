//
//  dynamicTableViewController.m
//  Code_
//
//  Created by admin on 15/12/23.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AutoAdjustFrame.h"
#import "foundFiveTableViewCell.h"
#import "dynamicTableViewController.h"

@interface dynamicTableViewController ()

@end

@implementation dynamicTableViewController

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
    title.text = @"看别人哪里玩";
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
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    foundFiveTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
    if (cell==nil) {
        cell=[[foundFiveTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"four"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    return cell;
}

#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int i=2;
    NSString *str=@"you游客评论等zdfkjhgkdejghdfkjhtrh 俄和他个人空间好个特人集体和个人冠军的办法就是大锅饭 i 俄国特热贴 u 让用户更加开ppcgnbgfdtrhy fgthfg hjfgdhjfgjgjgfpp放";
    return (i/3)*((ScreenWidth-(56*ScreenWidth/375))/3+(9*ScreenWidth/375))+(90*ScreenWidth/375)+[AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth-(40*ScreenWidth/375)]+(ScreenWidth-(56*ScreenWidth/375))/3.5+(10*ScreenWidth/375)+15*ScreenWidth/375+20*ScreenWidth/375;
    
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
