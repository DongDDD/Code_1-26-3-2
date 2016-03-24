//
//  inforCommentsTableViewController.m
//  Code_
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AutoAdjustFrame.h"
#import "EightTableViewCell.h"
#import "inforCommentsTableViewController.h"

@interface inforCommentsTableViewController ()

@end

@implementation inforCommentsTableViewController

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
    title.text = @"租客评论";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    self.navigationItem.titleView = title;
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
    return 15;
}

#pragma mark - Cell 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Eight"];
    if (cell==nil) {
        cell=[[EightTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Eight"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=@"第一次入住，就得到了非常棒的入住体验，房间非常温馨，有一种回家的感觉。雅轩居这个名字和房东的气质非常贴近，她不但优雅美丽，气宇轩昂，而且服务热情周到，住到这里有一种管家式的贴心服务，简直比五星级还五星级，下次一定还来住！ ";
    NSString *str1=@"五星級管家不敢當，呵呵，在修行狀態的日子裡面做一個默默的麥田守望者吧！等待新的小夥伴回到雅軒居！和你們一起分享美食，美房和美趣！感謝你的認可和支持，我們都會越來越棒的！很有口福的小夥伴，每次我做美食你都有口福！感謝你送的漂亮的不銹鋼湯鍋喔！有時間再一起享用我做的台北小火鍋吧！今天才剛剛發現房東的回評也可以用手機了！真的是太方便了！";
    if ( [AutoAdjustFrame heightForString:str font:12*ScreenWidth/375 width:ScreenWidth]<50) {
        return 94*ScreenWidth/375+[AutoAdjustFrame heightForString:str1 font:12*ScreenWidth/375 width:340*ScreenWidth/375]+15*ScreenWidth/375;
    }else{
        return   [AutoAdjustFrame heightForString:str font:12*ScreenWidth/375 width:ScreenWidth]+81*ScreenWidth/375+[AutoAdjustFrame heightForString:str1 font:12*ScreenWidth/375 width:340*ScreenWidth/375]+15*ScreenWidth/375;
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
