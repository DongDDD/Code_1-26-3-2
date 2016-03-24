//
//  QuanbuDingdanViewController.m
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//

#import "QuanbuDingdanViewController.h"
#import "DingdanXiangQingViewController.h"
#import "DingdanZhifuViewController.h"
#import "DingdanTableViewCell.h"
@interface QuanbuDingdanViewController ()<UITableViewDataSource,UITableViewDelegate,fanhuiXuanzeDeDingdanDelegate>
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *daiPingjiaDataArray;
@property(nonatomic,strong)NSMutableArray *daiZhifuDataArray;
@property(nonatomic,strong)NSMutableArray *lishiDataArray;
@property(nonatomic,strong)UIImageView *neirongImageView1;
@property(nonatomic,strong)UIImageView *xiamianImageView1;
@property(nonatomic,strong)UITableView *tabelView1;


@property (nonatomic,assign)NSInteger zhifuButtonTag;

@property(nonatomic,strong)UIImageView *xiahuaxian;
@end

@implementation QuanbuDingdanViewController

-(void)viewDidAppear:(BOOL)animated{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"我的订单";
//    //把工具栏隐藏起来
//    self.hidesBottomBarWhenPushed=YES;
//    self.tabBarController.tabBar.hidden=YES;
    
    [self getTheDataArray];
   
    _neirongImageView1 = [[UIImageView alloc]init];
    _neirongImageView1.frame = CGRectMake(0, 64+25*self.bili, 320*self.bili, 464*self.bili);
    
    _neirongImageView1.tag = 222222;
    _neirongImageView1.userInteractionEnabled = YES;
    [self.view addSubview:_neirongImageView1];
    
    
    [self changTheFrame];
    [self setTheTabelView];
    [self setTheButton];
    
    
    //选择显示的栏
    switch (_buttonTag) {
        case 1:
            [self quanbuDingdanButtonClick:_quanbuDingButton];
            break;
        case 2:
            [self tijiaoDingdanButtonClick:_tijiaoDingdanButton];
            break;
        case 3:
            [self dingdanZhifuButtonClick:_dingdanZhifuButton];
            break;

        case 4:
            [self lishiDingdanButtonClick:_lishiDingdanButton];
            break;
        default:
            break;
    }
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 下载数据
-(void)getTheDataArray{
    
    _daiPingjiaDataArray = [NSMutableArray array];
    _daiZhifuDataArray = [NSMutableArray array];
    _lishiDataArray = [NSMutableArray array];
    NSDictionary *dict = @{@"dingdan":@"1",@"pingjia":@"0",@"zongjine":@"1333"};
    NSDictionary *dict1 = @{@"dingdan":@"1",@"pingjia":@"1",@"zongjine":@"333"};
    NSDictionary *dict2 = @{@"dingdan":@"0",@"pingjia":@"1",@"zongjine":@"2333"};
    NSDictionary *dict3 = @{@"dingdan":@"0",@"pingjia":@"0",@"zongjine":@"8333"};
    NSArray *arr = @[dict,dict1,dict2,dict3,dict3,dict2,dict1,dict,dict,dict1,dict2,dict3];
    
    _dataArray = arr;
    for (NSDictionary *dict0 in arr) {
        if ([dict0[@"dingdan"]isEqualToString:@"0"]&&[dict0[@"pingjia"]isEqualToString:@"0"]) {
            [_daiZhifuDataArray addObject:dict0];
        }else if([dict0[@"dingdan"]isEqualToString:@"0"]&&[dict0[@"pingjia"]isEqualToString:@"1"]) {
            [_daiPingjiaDataArray addObject:dict0];
        }else if([dict0[@"dingdan"]isEqualToString:@"1"]){
            [_lishiDataArray addObject:dict0];
        }
    }
    NSLog(@"dataArr:%lu,lishiDataArr:%lu",(unsigned long)_dataArray.count,(unsigned long)_lishiDataArray.count);
    
}



-(void)setTheButton{
   
    UIImageView *im =[[UIImageView alloc]init];
    im.frame = CGRectMake(0, 64+25*self.bili, 320*self.bili, 1);
    //im.backgroundColor =[UIColor colorWithRed:121 green:121 blue:121 alpha:1];
    im.backgroundColor = [UIColor blackColor];
    [self.view addSubview:im];
    for (int i = 1; i < 4; i++) {
        UIImageView *imi = [[UIImageView alloc]init];
        imi.frame = CGRectMake(ScreenWidth/4*i, 64, 1, 25*self.bili);
        //imi.backgroundColor =[UIColor colorWithRed:176 green:176 blue:176 alpha:1];
        imi.backgroundColor = [UIColor grayColor];
        [self.view addSubview:imi];
    }
    
    NSLog(@"设置好了按钮");
    _xiahuaxian = [[UIImageView alloc]init];
    _xiahuaxian.backgroundColor = [UIColor redColor];
    [self.view addSubview:_xiahuaxian];
    
}
#pragma mark - 设置全部订单
- (IBAction)quanbuDingdanButtonClick:(id)sender {
   // _tabelView1.frame = CGRectMake1(0, 0, 320, 464);
    [_xiamianImageView1 removeFromSuperview];
    [self changeTheXiahuaxianAndTheFontforButton:1 with:@"全部订单"];
    [_tabelView1 reloadData];
}



#pragma mark - 设置提交订单
- (IBAction)tijiaoDingdanButtonClick:(id)sender {
    //[self setTheImageView11];
    [self changeTheXiahuaxianAndTheFontforButton:2 with:@"提交订单"];
    [_tabelView1 reloadData];
    //[self setTheTijiaoDingdanXianshi];
}

#pragma mark - 设置提交订单显示
-(void)setTheTijiaoDingdanXianshi{
    
    
    
    NSArray *arr = @[@"价       格 ：",@"入住日期 ：",@"入住人数 ："];
    for (int i = 0; i<3; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake1(30, 12+38*i, 200, 13);
        //拼接字符串
        NSString *str = [NSString stringWithFormat:@"%@%@",arr[i],@"1008677"];
        label.text = str;
        label.font = [UIFont systemFontOfSize:12*self.bili];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        [_xiamianImageView1 addSubview:label];
        UIImageView *imm = [[UIImageView alloc]init];
        imm.frame = CGRectMake1(8, 37+38*i, 304, 1);
        imm.backgroundColor = [UIColor grayColor];
        [_xiamianImageView1 addSubview:imm];
    }
    
    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake1(30, 192, 260, 30)];
    [bu setTitle:@"提交订单" forState:UIControlStateNormal];
    bu.titleLabel.font = [UIFont systemFontOfSize:14*self.bili];
    [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bu setBackgroundColor:[UIColor colorWithRed:246/255.0 green:123/255.0 blue:3/255.0 alpha:1]];
    [bu addTarget:self action:@selector(tijiaoDingdanButtonClick) forControlEvents: UIControlEventTouchUpInside];
    bu.layer.cornerRadius = 4*self.bili;
    [_xiamianImageView1 addSubview:bu];
    
}
#pragma mark - 设置提交订单按钮点击事件
-(void)tijiaoDingdanButtonClick{
    NSLog(@"提交了订单");
    
}




#pragma mark - 设置订单支付
- (IBAction)dingdanZhifuButtonClick:(id)sender {
    //[self setTheImageView11];
    [self changeTheXiahuaxianAndTheFontforButton:3 with:@"订单支付"];
    [_tabelView1 reloadData];
    //[self setTheZhifuDingdanXianshi];
}

//#pragma mark - 设置订单支付显示
//-(void)setTheZhifuDingdanXianshi{
//
//   
//    _zhifuButtonTag = 123456;
//    NSArray *arr1 = @[@"支付宝支付",@"银联支付",@"微信支付"];
//    NSArray *arr2 = @[@"推荐有支付宝账号的用户使用",@"支持储蓄信用卡，无需开通网银",@"推荐安装微信5.0以上版本的用户使用"];
//    for (int i = 0; i<3; i++) {
//        UILabel *label = [[UILabel alloc]init];
//        label.frame = CGRectMake1(62, 23+47*i, 180, 12);
//        label.text = arr1[i];
//        label.font = [UIFont systemFontOfSize:13*self.bili];
//        label.textColor = [UIColor blackColor];
//        label.textAlignment = NSTextAlignmentLeft;
//        [_xiamianImageView1 addSubview:label];
//        UILabel *label2 = [[UILabel alloc]init];
//        label2.frame = CGRectMake1(62, 29+47*i, 180, 10);
//        label.text = arr2[i];
//        label.font = [UIFont systemFontOfSize:9*self.bili];
//        label.textColor = [UIColor grayColor];
//        label.textAlignment = NSTextAlignmentLeft;
//        [_xiamianImageView1 addSubview:label];
//        
//        //设置左侧图片
//        UIImageView *imm1 = [[UIImageView alloc]init];
//        imm1.frame = CGRectMake1(12, 20+47*i, 42, 30);
//        imm1.backgroundColor = [UIColor yellowColor];
//        [_xiamianImageView1 addSubview:imm1];
//        
//        //设置下划线
//        UIImageView *imm = [[UIImageView alloc]init];
//        imm.frame = CGRectMake1(8, 46+47*i, 304, 1);
//        imm.backgroundColor = [UIColor grayColor];
//        [_xiamianImageView1 addSubview:imm];
//        
//        UIButton *bb = [[UIButton alloc]initWithFrame:CGRectMake1(280, 17+47*i, 12, 12)];
//        bb.tag = (i+1)*10;
//        
//        [bb setBackgroundImage:[UIImage imageNamed:@"关于.png"] forState:UIControlStateNormal];
//        [bb setBackgroundImage:[UIImage imageNamed:@"实名认证.png"] forState:UIControlStateSelected];
//        [bb addTarget:self action:@selector(xuanzeZhifuFangshiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_xiamianImageView1 addSubview:bb];
//        
//    }
//    
//    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake1(30, 184, 260, 30)];
//    [bu setTitle:@"确认支付" forState:UIControlStateNormal];
//    bu.titleLabel.font = [UIFont systemFontOfSize:14*self.bili];
//    bu.selected = NO;
//    [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [bu setBackgroundColor:[UIColor colorWithRed:246/255.0 green:123/255.0 blue:3/255.0 alpha:1]];
//    [bu addTarget:self action:@selector(querenZhifuButtonClick) forControlEvents: UIControlEventTouchDown];
//    bu.layer.cornerRadius = 4*self.bili;
//    [_xiamianImageView1 addSubview:bu];
//    
//}
//#pragma mark - 设置选择支付方式按钮点击事件
//-(void)xuanzeZhifuFangshiButtonClick:(UIButton *)button{
//    
//    if (_zhifuButtonTag == button.tag) {
//        button.selected = NO;
//        _zhifuButtonTag = 123456;
//    }else{
//        UIButton *bu = (UIButton *)[[[self.view viewWithTag:222222]viewWithTag:111111] viewWithTag:_zhifuButtonTag];
//        bu.selected = NO;
//        button.selected = YES;
//        _zhifuButtonTag = button.tag;
//    }
//    
//}
//
//
//#pragma mark - 设置确认支付按钮点击事件
//-(void)querenZhifuButtonClick{
//    
//    if (_zhifuButtonTag == 123456) {
//        UIAlertView *alertView = [[UIAlertView alloc] init];
//        alertView.message = @"请选择支付方式在确认付款";
//        [alertView addButtonWithTitle:@"取消"];
//        [alertView show];
//    }else{
//        NSLog(@"选择了第%ld种支付方式并确认了支付,支付的金额是%@",_zhifuButtonTag,@"10011");
//        
//        QuanbuDingdanViewController *quanbu = [[QuanbuDingdanViewController alloc]init];
//        
//        //把工具栏显示出来
//        self.hidesBottomBarWhenPushed=NO;
//        self.tabBarController.tabBar.hidden=NO;
//        
//        [self.navigationController pushViewController:quanbu animated:YES];
//
//    }

    
    
//}
#pragma mark - 加载一个imageView
-(void)setTheImageView11{
//    [_xiamianImageView1 removeFromSuperview];
//    _tabelView1.frame = CGRectMake1(0, 0, 320, 76);
//    //if (!_xiamianImageView1) {
//        _xiamianImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake1(0, 77, 320, 224)];
//        _xiamianImageView1.tag = 111111;
//        _xiamianImageView1.userInteractionEnabled = YES;
//        [_neirongImageView1 addSubview:_xiamianImageView1];
    //}
   
}


#pragma mark - 设置历史账单
- (IBAction)lishiDingdanButtonClick:(id)sender {
    _tabelView1.frame = CGRectMake1(0, 0, 320, 464);
    [_xiamianImageView1 removeFromSuperview];
   [self changeTheXiahuaxianAndTheFontforButton:4 with:@"历史订单"];
    [_tabelView1 reloadData];
}

#pragma mark - 点击按钮改变字体大小跟下划线
-(void)changeTheXiahuaxianAndTheFontforButton:(int)tag with:(NSString *)str{
    UIButton *BU = (UIButton *)[self.view viewWithTag:_buttonTag];
    BU.titleLabel.font = [UIFont systemFontOfSize:11*self.bili];
    _buttonTag = tag;
    BU = (UIButton *)[self.view viewWithTag:tag];
    BU.titleLabel.font = [UIFont systemFontOfSize:13*self.bili];
    _xiahuaxian.frame = CGRectMake(ScreenWidth/4*(tag-1), 64+25*self.bili, ScreenWidth/4, 1);
    //self.titleLabel.text = str;
    
}

#pragma mark - 设置tabelView
-(void)setTheTabelView{
    
    _tabelView1 = [[UITableView alloc]init];
    _tabelView1.frame = CGRectMake1(0, 0, 320, 464);
    _tabelView1.dataSource = self;
    _tabelView1.delegate = self;
    //设置cell没有下划线
    _tabelView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_neirongImageView1 addSubview:_tabelView1];
    
    [_tabelView1 registerNib:[UINib nibWithNibName:@"DingdanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    
    
}

#pragma mark - 设置tabelView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_buttonTag == 1) {
        return _dataArray.count;
    }else if(_buttonTag == 2){
        return _daiZhifuDataArray.count;
    }else if(_buttonTag == 3){
        return _daiPingjiaDataArray.count;
    }else{
        return _lishiDataArray.count;
    }
    
    
}
#pragma mark - 设置tabelView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76 *self.bili;
}

#pragma mark - 设置tabelView的显示
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell1";
   
    
    DingdanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[DingdanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.delegate = self;
    cell.xianshiLan = _buttonTag;
    cell.bili = self.bili;
    //cell.selectionStyle = NO;
    //赋值
    //设置tabelView能不能滑动
//    if (_buttonTag == 2) {
//        cell.selectionStyle = NO;
//        _tabelView1.userInteractionEnabled = NO;
//        cell.userInteractionEnabled = YES;
//    }else{
//        _tabelView1.userInteractionEnabled = YES;
//    }
    cell.chakanOrZhifu = NO;
    switch (_buttonTag) {
        case 1:
            [cell jiazaiShuju:_dataArray[indexPath.row]];
            break;
        case 2:
            [cell jiazaiShuju:_daiZhifuDataArray[indexPath.row]];
            break;
        case 3:
            [cell jiazaiShuju:_daiPingjiaDataArray[indexPath.row]];
            break;
        case 4:
            [cell jiazaiShuju:_lishiDataArray[indexPath.row]];
            break;
        default:
            break;
    }
       return cell;
    
}

#pragma mark - 处理某行的点击事件--跳到订单详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DingdanXiangQingViewController *xiangqing = [[DingdanXiangQingViewController alloc]init];
    
    [self.navigationController pushViewController:xiangqing animated:YES];
    //[self presentViewController:xiangqing animated:YES completion:nil];
    
}
    
-(void)fanhuiXuanzeDeDingdan:(NSDictionary *)dict withTag:(NSInteger)tag{
    
    
    switch (tag) {
        case 1:
            break;
        case 2:
            //[self tijiaoDingdanButtonClick:_tijiaoDingdanButton];
            break;
        case 3:
            NSLog(@"准备跳转页面1");
            [self yemianTiaozhuan];
            
            //[self dingdanZhifuButtonClick:_dingdanZhifuButton];
            break;
            
        default:
            break;
    }
    
}

-(void)yemianTiaozhuan{
    DingdanZhifuViewController *zhifu = [[DingdanZhifuViewController alloc]init];
    
    NSLog(@"_dataArray的个数:%lu",(unsigned long)_dataArray.count);
    NSArray *arr = @[_dataArray[0]];
    zhifu.dataArray = arr;
     NSLog(@"准备跳转页面2");
    [self.navigationController pushViewController:zhifu animated:YES];
    
    //[self presentViewController:zhifu animated:YES completion:nil];
}




-(void)changTheFrame{
    
    float a = ScreenWidth/4;
    float b = 25*self.bili;
    float c = 11*self.bili;
    _quanbuDingButton.frame = CGRectMake(0, 64, a ,b);
    _tijiaoDingdanButton.frame = CGRectMake(80*self.bili, 64, a, b);
    _dingdanZhifuButton.frame = CGRectMake(160*self.bili, 64, a, b);
    _lishiDingdanButton.frame = CGRectMake(240*self.bili, 64, a, b);
    _xiahuaxianImageView.frame = CGRectMake(0, 64+b, 320*self.bili, 1);
    
    
//    _quanbuDingButton.enabled = NO;
//    _tijiaoDingdanButton.enabled = NO;
//    _dingdanZhifuButton.enabled = NO;
//    _lishiDingdanButton.enabled = NO;
    
    NSLog(@"_quanbuDingButton.frame = %f  --  %f  ",79*self.bili, 25*self.bili);
    _quanbuDingButton.titleLabel.font = [UIFont systemFontOfSize:c];
    _tijiaoDingdanButton.titleLabel.font = [UIFont systemFontOfSize:c];
    _dingdanZhifuButton.titleLabel.font = [UIFont systemFontOfSize:c];
    _lishiDingdanButton.titleLabel.font = [UIFont systemFontOfSize:c];


    
    
    
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
