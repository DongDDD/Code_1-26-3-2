//
//  inforDescribeTableViewController.m
//  Code_
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 东. All rights reserved.
//
#import "ThreeTableViewCell.h"
#import "AutoAdjustFrame.h"
#import "inforDescribeTableViewController.h"

@interface inforDescribeTableViewController ()

@end

@implementation inforDescribeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
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
    title.text = @"房屋描述";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    self.navigationItem.titleView = title;
    
    self.tableView.separatorColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    
    
//    self.headImageV=[[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 10*ScreenWidth/375, 50*ScreenWidth/375, 50*ScreenWidth/375)];
//    [UIImageCutter cutImageAutoWithUIImageView:self.headImageV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
//    self.headImageV.layer.borderWidth=0;
//    self.headImageV.layer.cornerRadius=25*ScreenWidth/375;
//    self.headImageV.layer.masksToBounds = YES;
//    self.headImageV.layer.borderColor=[[UIColor redColor]CGColor];
//    [self.view addSubview:self.headImageV];
//    
//    UIView *dian=[[UIView alloc]initWithFrame:CGRectMake(65*ScreenWidth/375, 18*ScreenWidth/375, 6*ScreenWidth/375, 6*ScreenWidth/375)];
//    dian.backgroundColor=[UIColor blackColor];
//    dian.layer.borderWidth=0;
//    dian.layer.cornerRadius=3*ScreenWidth/375;
//    dian.layer.borderColor=[[UIColor whiteColor]CGColor];
//    [self.view addSubview:dian];
//    
//    self.nameL=[[UILabel alloc]initWithFrame:CGRectMake(72*ScreenWidth/375, 17*ScreenWidth/375, 303*ScreenWidth/375, 11*ScreenWidth/375)];
//    self.nameL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
//    self.nameL.textColor=[UIColor blackColor];
//    //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
//    self.nameL.text=@"一楼 :";
//    self.nameL.textAlignment =NSTextAlignmentLeft;
//    [self.view addSubview:self.nameL];
//    
//    NSString *str=@"1.呵呵呵呵呵呵\n2.嘻嘻嘻嘻嘻\n3.hdgffdfffhh\n4.dfgdhdfhfhd";
//    self.contentL=[[UILabel alloc]init];
//    self.contentL.text=[str stringByReplacingOccurrencesOfString:@"<br />" withString:@" "];
//    self.contentL.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
//    self.contentL.frame=CGRectMake(65*ScreenWidth/375, 35*ScreenWidth/375, 305*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+5);
//    
//    self.contentL.textColor=[UIColor grayColor];
//    self.contentL.numberOfLines=0;
//    //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
//    self.contentL.textAlignment =NSTextAlignmentLeft;
//    [self.view addSubview:self.contentL];
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
    return 1;
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThreeTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
    if (cell==nil) {
        cell=[[ThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"four"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=self.houseDe;
    NSLog(@"cell高度---房屋描述:%@",self.houseDe);
    if ( [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]<50) {
        return 100*ScreenWidth/375;
    }else{
        return   [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth]+60*ScreenWidth/375;
    }

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
