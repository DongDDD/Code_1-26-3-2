//
//  GerenZiliaoViewController.m
//  Code_
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 东. All rights reserved.
//
#import "GerenZiliaoViewController.h"
#import "ChangePasswordController.h"
#import "ShimingRenzhengViewController.h"
#import "HuiyuanViewController.h"
#import "MemberViewController.h"
#import "ZiliaoTableViewCell.h"
#import <YTKKeyValueStore.h> 
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"


@interface GerenZiliaoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIView *BlackView;
@property (nonatomic,strong)UIView *WirtView;
@property (nonatomic,strong)UIButton *CameraBut;
@property (nonatomic,strong)UIButton *LocalBut;
@property (nonatomic,strong)UIButton *CancelBut;


//@property (nonatomic,assign)float bili;
@end

@implementation GerenZiliaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"会员资料";
    
    [self zidingyiDaohanglan];
    //self.titleLabel.text = @"个人资料";
    
    
    
    [self setTheTabelView1];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"user.db"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:tableName];
    NSString *key = @"user";
    // 查询令牌的获取时间与数值
    NSMutableDictionary *UrlDict = [store getObjectById:key fromTable:tableName];
    [self GateData:UrlDict];
    
}


-(void)buttonClick{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setTheTabelView1{
    
    
    _dataArray = [NSMutableArray array];
    
    NSDictionary *dict0 = @{@"1":@"头像",@"2":@"",@"3":@""};
    NSDictionary *dict1 = @{@"1":@"昵称",@"2":@"",@"3":@"箭头.png"};
    NSDictionary *dict2 = @{@"1":@"会员等级",@"2":@"",@"3":@"箭头.png"};
    NSDictionary *dict3 = @{@"1":@"",@"2":@"",@"3":@""};
    NSDictionary *dict4 = @{@"1":@"姓名",@"2":@"实名验证",@"3":@"箭头.png"};
    NSDictionary *dict5 = @{@"1":@"性别",@"2":@"",@"3":@"箭头.png"};
    NSDictionary *dict6 = @{@"1":@"手机号码",@"2":@"绑定手机",@"3":@"箭头.png"};
    NSDictionary *dict7 = @{@"1":@"会员卡",@"2":@"",@"3":@"箭头.png"};
    NSDictionary *dict8 = @{@"1":@"修改密码",@"2":@"",@"3":@"箭头.png"};
    
    
    NSArray *arr = @[dict0,dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8];
    [_dataArray addObjectsFromArray:arr];
    
    
    _tabelVAiew1 = [[UITableView alloc]init];
    
    _tabelVAiew1.frame = CGRectMake(10*self.bili, 70, 300*self.bili, 305*self.bili);
    
    _tabelVAiew1.dataSource = self;
    _tabelVAiew1.delegate = self;
    
    _tabelVAiew1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabelVAiew1.scrollEnabled = NO; //是设置能滚动。等于NO设置不可滚动。
    
    [_tabelVAiew1 registerNib:[UINib nibWithNibName:@"ZiliaoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [self.view addSubview:_tabelVAiew1];
    
    
    self.BlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
    self.BlackView.backgroundColor = [UIColor blackColor];
    self.BlackView.alpha = 0;
    [self.view addSubview:self.BlackView];
    
    self.WirtView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4), ScreenHight/3, ScreenWidth/2, ScreenHight/4)];
    self.WirtView.backgroundColor = [UIColor yellowColor];
    self.WirtView.alpha = 0;
    [self.view addSubview:self.WirtView];
    
    self.CameraBut = [[UIButton alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, self.WirtView.frame.size.height/4, self.WirtView.frame.size.width/2-10*ScreenWidth/375, 50*ScreenWidth/375)];
    [self.CameraBut addTarget:self action:@selector(CameraButAction) forControlEvents: UIControlEventTouchUpInside];
    [self.CameraBut setTitle:@"照相机" forState:UIControlStateNormal];
    self.CameraBut.backgroundColor = [UIColor redColor];
    [self.WirtView addSubview:self.CameraBut];
    
    self.LocalBut = [[UIButton alloc]initWithFrame:CGRectMake(self.WirtView.frame.size.width/2+5*ScreenWidth/375, self.WirtView.frame.size.height/4, self.WirtView.frame.size.width/2-10*ScreenWidth/375, 50*ScreenWidth/375)];
    [self.LocalBut addTarget:self action:@selector(LocalButAction) forControlEvents: UIControlEventTouchUpInside];
    [self.LocalBut setTitle:@"本地" forState:UIControlStateNormal];
    self.LocalBut.backgroundColor = [UIColor grayColor];
    [self.WirtView addSubview:self.LocalBut];
    
    self.CancelBut = [[UIButton alloc]initWithFrame:CGRectMake(self.WirtView.frame.size.width/4, self.WirtView.frame.size.height/2+25*ScreenWidth/375, self.WirtView.frame.size.width/2, 50*ScreenWidth/375)];
    [self.CancelBut addTarget:self action:@selector(CancelButAction) forControlEvents: UIControlEventTouchUpInside];
    [self.CancelBut setTitle:@"取消" forState:UIControlStateNormal];
    self.CancelBut.backgroundColor = [UIColor orangeColor];
    [self.WirtView addSubview:self.CancelBut];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 具体设置哪一行高度
    if(indexPath.row == 0) {
        
        return 54.0*self.bili;
    }else if(indexPath.row == 3){
        return 6.0*self.bili;
    }else{
        return 35.0*self.bili;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell1";
    
    ZiliaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[ZiliaoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    
    cell.bili = self.bili;
    
    [cell setTheCell:_dataArray[indexPath.row]];
    
    return cell;
    
    
    
    
}
#pragma mark -  设置点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 8 ) {
        
        ChangePasswordController *change = [[ChangePasswordController alloc]init];
        [self presentViewController:change animated:YES completion:nil];
        
    }else if(indexPath.row == 4 ){
        ShimingRenzhengViewController *shiming = [[ShimingRenzhengViewController alloc]init];
        [self presentViewController:shiming animated:YES completion:nil];
    }else if (indexPath.row == 0) {
        
        //判断是否支持相机
        UIActionSheet *sheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
            
        }else {
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
            
        }
        
        sheet.tag = 255;
        
        [sheet showInView:self.view];
        
        

//            [UIView animateWithDuration:0.5 animations:^{
//                self.BlackView.alpha = 0.2;
//                self.WirtView.alpha = 1;
//                
//            } completion:^(BOOL finished) {
//            }];

        NSLog(@"您点击了");
        
    }else{
         UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = [NSString stringWithFormat:@"您点击了%ld行",(long)indexPath.row];
        [alertView addButtonWithTitle:@"取消"];
        [alertView show];

    }
  
}

#pragma mark - 点击事件
- (void)LocalButAction{
    self.BlackView.alpha = 0;
    self.WirtView.alpha = 0;
}
- (void)CancelButAction{
    self.BlackView.alpha = 0;
    self.WirtView.alpha = 0;
}

- (void)CameraButAction{
    self.BlackView.alpha = 0;
    self.WirtView.alpha = 0;
}


-(void)fanhuiButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)GateData:(NSDictionary *)dict1{
    
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
    }else  {
        NSString *url = @"http://120.25.69.40:1005/API/RoomerData.ashx";
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"UpFace" forKey:@"action"];//接口方式
        [dict setObject:dict1[@"MembId"] forKey:@"MembId"];//会员ID
        [dict setValue:self.lingpai forKey:@"AccessToken"];//调用接口的令牌
        
        NSLog(@"请求的参数是:%@",dict);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  NSLog(@"获取列表的数据转成字典是---dic:%@",dic);
                  NSArray *ResultArr = dic[@"Result"];
                  NSLog(@"Result=%@",ResultArr);
                  
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  
                  if (nu =='1') {
                      NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                  }else{
                      NSLog(@"888888发送请求结果无异常");
                      
                     
                      
                  }
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"000%@",error);
                  
                  //请求失败的时候调用调用这个block
                  NSLog(@"请求失败");
                  [MBProgressHUD hideHUD];
              }];
        
    }

}



-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        //[imagePickerController release];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    //[self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    //isFullScreen = NO;
    //[self.imageView setImage:savedImage];
    
    //elf.imageView.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
