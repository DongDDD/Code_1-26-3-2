//
//  DingdanXiangQingViewController.m
//  Code_
//
//  Created by admin on 15/12/23.
//  Copyright © 2015年 东. All rights reserved.
//

#import "DingdanXiangQingViewController.h"

@interface DingdanXiangQingViewController ()

@property(nonatomic,strong)NSDictionary *dataDict;


@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)float zongjine;


@property(nonatomic,strong)UIButton *genzongButton;
@property(nonatomic,strong)UIImageView *genzongImageView;

@end

@implementation DingdanXiangQingViewController

-(void)viewDidAppear:(BOOL)animated{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self zidingyiDaohanglan];
    self.titleLabel.text = @"订单详情";
    _zongjine = 0;
    // 取消弹簧效果
    _zhenggeJiemianScrollView.bounces = NO;
    
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;

    
    
    
    //NSArray *NSArray1 = @[@"从化温泉富力泉天下独栋豪华度假别墅",@"广州市从化区富力温泉天下",@"总面积:120平方",@"可住8人"];
    
    
    [self changeTheFrame];
    [self setTheImageView1];
    [self setTheDingdanGenzong];
    [self setTheDingdanMingxi];
    
    [self setThePeitaoSheshi];
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 设置_imageView1显示
-(void)setTheImageView1{
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake1(8, 8, 76, 60)];
    im.backgroundColor = [UIColor yellowColor];
    [_imageView1 addSubview:im];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake1(94, 8, 200, 10)];
    label1.text = @"从化温泉富力泉天下独栋豪华度假别墅";
    label1.font = [UIFont systemFontOfSize:10*self.bili];
    label1.textAlignment = NSTextAlignmentLeft;
    [_imageView1 addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake1(94, 42, 200, 10)];
    label2.text = @"总面积:120平方";
    label2.font = [UIFont systemFontOfSize:10*self.bili];
    label2.textColor = [UIColor grayColor];
    label2.textAlignment = NSTextAlignmentLeft;
    [_imageView1 addSubview:label2];
    
    UILabel *label3= [[UILabel alloc]initWithFrame:CGRectMake1(94, 57, 200, 10)];
    label3.text = @"可住8人";
    label3.font = [UIFont systemFontOfSize:10*self.bili];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.textColor = [UIColor colorWithRed:255/150.0 green:136/250.0 blue:56/250.0 alpha:1];
    [_imageView1 addSubview:label3];
    //设置地图按钮
    
    UIImageView *ii = [[UIImageView alloc]initWithFrame:CGRectMake1(93, 25, 9, 12)];
    ii.image = [UIImage imageNamed:@"地点图标.png"];
    [_imageView1 addSubview:ii];
    
    UIButton *bu = [[UIButton alloc]init];
    bu.frame = CGRectMake1(105, 25, 200, 10);
    [bu setTitle:@"广州市从化区富力温泉天下" forState:UIControlStateNormal];
    //[bu setImage:[UIImage imageNamed:@"地点图标.png"] forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    bu.titleLabel.font = [UIFont systemFontOfSize:10*self.bili];
    //bu.titleLabel.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;//设置文字位置，现设为居左，默认的是居中
    bu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [bu addTarget:self action:@selector(dituAnniuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView1 addSubview:bu];
    //设置星星
    UIImageView *xingxingImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake1(224, 53, 83, 15)];
    xingxingImageView1.backgroundColor = [UIColor grayColor];
    [_imageView1 addSubview:xingxingImageView1];
    UIImageView *xingxingImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake1(224, 53, 83*4/5, 15)];
    xingxingImageView2.backgroundColor = [UIColor orangeColor];
    [_imageView1 addSubview:xingxingImageView2];
    
}
#pragma mark - 设置地图按钮点击事件
-(void)dituAnniuButtonClick:(UIButton *)button{
    NSLog(@"点击了地图按钮");
}




#pragma mark - 设置配套设施
-(void)setThePeitaoSheshi{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 81, 25)];
    label.text = @"配套设施";
    label.textColor = [UIColor colorWithRed:0/250.0 green:159/250.0 blue:252/250.0 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10*self.bili];
    [_imageView4 addSubview:label];
    
    UIImageView *IM = [[UIImageView alloc]initWithFrame:CGRectMake1(8, 24, 304, 1)];
    IM.backgroundColor = [UIColor grayColor];
    [_imageView4 addSubview:IM];
    
    for (int i = 0; i<7; i++) {
        UIImageView *im = [[UIImageView alloc]init];
        im.frame = CGRectMake1(24+42*i, 36, 20, 20);
        im.backgroundColor = [UIColor yellowColor];
        [_imageView4 addSubview:im];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake1(21+42*i, 61, 26, 15)];
        label1.text = @"独立卫生间";
        label1.numberOfLines = 0;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:10*self.bili];
        [_imageView4 addSubview:label1];
        
        
    }
    
    UIButton *bu = [[UIButton alloc]init];
    bu.frame = CGRectMake1(251, 0, 38, 25);
    bu.titleLabel.font = [UIFont systemFontOfSize:8*self.bili];
    [bu setTitle:@"查看更多" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(chankanGengduoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView4 addSubview:bu];
    
    UIImageView *youImageView = [[UIImageView alloc]initWithFrame:CGRectMake1(295, 7, 7, 10)];
    youImageView.backgroundColor = [UIColor blueColor];
    [_imageView4 addSubview:youImageView];
    
    
}

-(void)chankanGengduoButtonClick:(UIButton *)button{
    NSLog(@"点击了查看更多的按钮");
}
#pragma mark - 设置订单跟踪显示
-(void)setTheDingdanGenzong{
    //获取数据
    NSArray *labelArr = @[@"当前订单以消费完成",@"您已退房 2015.12.28",@"您已入住 2015.12.26",@"已等待入住 2015.12.22",@"订单审核通过 2015.12.20",@"订单已进入系统时间 2015.12.12"];
    NSArray *genzongArr = @[@"0",@"0",@"1",@"1",@"1",@"1"];
    
    float a = 12 * self.bili;
    float b = 10 * self.bili;
    //设置头部栏
    UIImageView *ii = [[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 35)];
    ii.backgroundColor =[UIColor whiteColor];
    [_imageView2 addSubview:ii];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake1(12, 10, 60, 15)];
    label1.text = @"订单跟踪";
    label1.font = [UIFont systemFontOfSize:14*self.bili];
    [_imageView2 addSubview:label1];
    
    //设置跟踪详情
    _genzongButton = [[UIButton alloc]init];
    _genzongButton.frame = CGRectMake1(150, 90, 20, 20);
    [_genzongButton addTarget:self action:@selector(xianshiGengduo:) forControlEvents:UIControlEventTouchDown];
    _genzongButton.selected = NO;
    [_genzongButton setBackgroundImage:[UIImage imageNamed:@"放下.png"] forState:UIControlStateNormal];
    [_genzongButton setBackgroundImage:[UIImage imageNamed:@"收起.png"] forState:UIControlStateSelected];
    
    
    
    [_imageView2 addSubview:_genzongButton];
    UIImageView *im = [[UIImageView alloc]init];
    im.frame = CGRectMake1(25, 50, 20, 20);
    
    [_imageView2 addSubview:im];
    
    UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake1(50, 43, 250, 34)];
    im1.backgroundColor = [UIColor whiteColor];
    im1.layer.cornerRadius =  4*self.bili;
    [_imageView2 addSubview:im1];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake1(10, 0, 230, 34);
    label.font = [UIFont systemFontOfSize:12*self.bili];
    
    
    label.text = labelArr[0];
    [im1 addSubview:label];
    if ([genzongArr[0]isEqualToString:@"1"]) {
        label.textColor = [UIColor colorWithRed:0/250.0 green:159/250.0 blue:252/250.0 alpha:1];
        im.image = [UIImage imageNamed:@"蓝点.png"];
    }else{
        label.tintColor = [UIColor grayColor];
        im.image = [UIImage imageNamed:@"灰点.png"];
    }
    
}
//点击查看更多
-(void)xianshiGengduo:(UIButton *)button{
    NSLog(@"点击了显示更多的按钮");
    NSArray *labelArr = @[@"当前订单以消费完成",@"您已退房 2015.12.28",@"您已入住 2015.12.26",@"已等待入住 2015.12.22",@"订单审核通过 2015.12.20",@"订单已进入系统时间 2015.12.12"];
    NSArray *genzongArr = @[@"0",@"0",@"1",@"1",@"1",@"1"];
    
    
    
    if (_genzongButton.isSelected) {
        _genzongButton.selected = NO;
    }else{
        _genzongButton.selected = YES;
    }
    
    [self changeTheFrame];
    if (_genzongButton.isSelected) {
        
        _genzongButton.frame = CGRectMake1(150, 341, 20, 20);
        
        _genzongImageView = [[UIImageView alloc]init];
        _genzongImageView.frame = CGRectMake1(0, 0, 320, 335);
        _genzongImageView.userInteractionEnabled = YES;
        [_imageView2 addSubview:_genzongImageView];
        for (int i = 0; i<6; i++) {
            UIImageView *imi = [[UIImageView alloc]init];
            imi.frame = CGRectMake1(25, 50+i*50, 20, 20);
            [_genzongImageView addSubview:imi];
            
            UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake1(50, 43+i*50, 250, 34)];
            im1.backgroundColor = [UIColor whiteColor];
            im1.layer.cornerRadius = 4*self.bili;
            [_genzongImageView addSubview:im1];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(60, 43+i*50, 240, 34)];
            label.font = [UIFont systemFontOfSize:12*self.bili];
            label.text = labelArr[i];
            [_genzongImageView addSubview:label];
            //设置颜色
            if ([genzongArr[i]isEqualToString:@"1"]) {
                label.textColor = [UIColor colorWithRed:0/250.0 green:159/250.0 blue:252/250.0 alpha:1];
                imi.image = [UIImage imageNamed:@"蓝点.png"];
            }else{
                label.textColor = [UIColor grayColor];
                imi.image = [UIImage imageNamed:@"灰点.png"];
            }
            [_genzongImageView addSubview:label];
            
            //加载进度条
            if (i<5) {
                UIImageView *im2 = [[UIImageView alloc]init];
                im2.frame = CGRectMake1(34, (70+50*i), 2, 30);
                im2.backgroundColor =[UIColor blueColor];
                
                [_genzongImageView addSubview:im2];
                //设置颜色
                if ([genzongArr[i]isEqualToString:@"1"]) {
                    im2.backgroundColor = [UIColor colorWithRed:0/250.0 green:159/250.0 blue:252/250.0 alpha:1];
                }else{
                    im2.backgroundColor = [UIColor grayColor];
                }
            }
            
            
        }
        
    }else{
        
        _genzongButton.frame = CGRectMake1(150, 90, 20, 20);
        [_genzongImageView removeFromSuperview];
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}





#pragma mark - 设置订单明细显示
-(void)setTheDingdanMingxi{
    
    _arr = @[@"1",@"2",@"3",@"4"];
    _a = 30*_arr.count;
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(12, 10, 57, 15)];
    label.text = @"订单明细";
    label.font = [UIFont systemFontOfSize:14*self.bili];
    [_imageView3 addSubview:label];
    
    UIImageView *IM = [[UIImageView alloc]initWithFrame:CGRectMake1(8, 34, 304, 1)];
    IM.backgroundColor = [UIColor grayColor];
    [_imageView3 addSubview:IM];
    
    for (int i = 0; i<_arr.count; i++) {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake1(25, 46+30*i, 60, 12)];
        label1.text = @"房间";
        label1.font = [UIFont systemFontOfSize:13*self.bili];
        label1.textAlignment = NSTextAlignmentLeft;
        [_imageView3 addSubview:label1];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake1(150, 46+30*i, 60, 12)];
        label2.text = @"X2";
        label2.font = [UIFont systemFontOfSize:13*self.bili];
        label2.textAlignment = NSTextAlignmentLeft;
        [_imageView3 addSubview:label2];
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake1(260, 46+30*i, 60, 12)];
        label3.text = @"￥298";
        label3.font = [UIFont systemFontOfSize:13*self.bili];
        label3.textAlignment = NSTextAlignmentLeft;
        [_imageView3 addSubview:label3];
        
        
        UIImageView *im = [[UIImageView alloc]init];
        im.frame = CGRectMake1(8, 66+30*i, 304, 1);
        im.backgroundColor = [UIColor grayColor];
        [_imageView3 addSubview:im];
        
        _zongjine = _zongjine + [label3.text floatValue];
        
        NSLog(@"%f",_zongjine);
    }
    UILabel *jiage = [[UILabel alloc]init];
    jiage.text = @"总价:";
    jiage.font = [UIFont systemFontOfSize:13*self.bili];
    jiage.textAlignment = NSTextAlignmentRight;
    jiage.frame = CGRectMake1(220, 35+30*_arr.count, 38, 35);
    [_imageView3 addSubview:jiage];
    
    UILabel *shuzi = [[UILabel alloc]initWithFrame:CGRectMake1(260,35+30*_arr.count, 40, 35)];
    shuzi.font = [UIFont systemFontOfSize:13*self.bili];
    shuzi.text = [NSString stringWithFormat:@"￥%.2f",_zongjine];
    shuzi.textColor = [UIColor orangeColor];
    shuzi.textAlignment = NSTextAlignmentLeft;
    [_imageView3 addSubview:shuzi];
    
}

//-(void)fanhuiButtonClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
////    self
//}









-(void)changeTheFrame{
    
    
    
    
    
    float a = 12*self.bili;
    float b = 10 *self.bili;
    float c = 68+30*4;
    _zhenggeJiemianScrollView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHight-60);
    _imageView1.frame = CGRectMake1(0, 0, 320, 76);
    //打开交互
    _imageView1.userInteractionEnabled = YES;
    _imageView2.userInteractionEnabled = YES;
    if (_genzongButton.isSelected) {
        _imageView2.frame = CGRectMake1(0, 81, 320, 374);
        _imageView3.frame = CGRectMake1(0, 460, 320, c);
        _imageView4.frame = CGRectMake1(0, 465+c, 320, 90);
        
        // 内容大小
        _zhenggeJiemianScrollView.contentSize = CGSizeMake(ScreenWidth, (555+c)*self.bili);
        
        
    }else{
        _imageView2.frame = CGRectMake1(0, 81, 320, 124);
        _imageView3.frame = CGRectMake1(0, 210, 320, c);
        _imageView4.frame = CGRectMake1(0, 215+c, 320, 90);
        // 内容大小
        _zhenggeJiemianScrollView.contentSize = CGSizeMake(ScreenWidth, (305+c)*self.bili);
    }
    
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
