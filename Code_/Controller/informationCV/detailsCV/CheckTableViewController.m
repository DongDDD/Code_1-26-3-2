//
//  CheckTableViewController.m
//  Code_
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AutoAdjustFrame.h"
#import "CheckTableViewController.h"

@interface CheckTableViewController ()

@end

@implementation CheckTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 9+1*ScreenWidth/375, 16+1*ScreenWidth/375);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(fanhuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    title.text = @"入住须知";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    self.navigationItem.titleView = title;
    
    NSString *str=@"1.呵呵呵呵呵呵2.嘻嘻嘻嘻嘻3.hdgffdfffhhrrggr rg ere re rery ery ryrvrevgfghthjjjdfhgfjjfjt4.dfgdhdfhfhd1.呵呵呵呵呵呵2.嘻嘻嘻嘻嘻3.hdgffdfffhhrrggr rg ere re rery ery ryrvrevgfghthjjjdfhgfjjfjt4.dfgdhdfhfhd";
    self.contentL=[[UILabel alloc]init];
    self.contentL.text=[str stringByReplacingOccurrencesOfString:@"<br />" withString:@" "];
    self.contentL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
    self.contentL.frame=CGRectMake(15*ScreenWidth/375, 79+1*ScreenWidth/375, 345*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]);
    self.contentL.textColor=[UIColor grayColor];
    self.contentL.numberOfLines=0;
    //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
    self.contentL.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:self.contentL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
