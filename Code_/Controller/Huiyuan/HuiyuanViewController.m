//
//  HuiyuanViewController.m
//  登陆
//
//  Created by admin on 15/12/18.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "HuiyuanViewController.h"
#import "DengluViewController.h"
#import "ZHUceViewController.h"
#import "AppDelegate.h"
@interface HuiyuanViewController ()

@end

@implementation HuiyuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor=[UIColor colorWithRed:233/255.0 green:237/255.0 blue:239/255.0 alpha:1];
 
    
    
    [self OneView];
}


- (void)OneView{
    
    UIView *OneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180*ScreenWidth/375)];
    OneView.backgroundColor=[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    [self.view addSubview:OneView];
    
    UIImageView *bottom=[[UIImageView alloc]initWithFrame:CGRectMake(100*ScreenWidth/375, 60*ScreenWidth/375,175*ScreenWidth/375, 53*ScreenWidth/375)];
    bottom.image=[UIImage imageNamed:@"xinLogo"];
    [OneView addSubview:bottom];
    
    UIButton *orderBut=[UIButton buttonWithType:UIButtonTypeCustom];
    orderBut.frame=CGRectMake(50*ScreenWidth/375, 130*ScreenWidth/375, 125*ScreenWidth/375, 40*ScreenWidth/375);
    [orderBut setTitle:@"登陆" forState:UIControlStateNormal];
    [orderBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    orderBut.backgroundColor = [UIColor  colorWithRed:252/255.0 green:160/255.0 blue:53/255.0 alpha:1];
    orderBut.titleLabel.font = [UIFont systemFontOfSize:16*ScreenWidth/375.0];
    [orderBut addTarget:self action:@selector(orderAction1) forControlEvents:UIControlEventTouchUpInside];
    orderBut.layer.borderWidth=1;
    orderBut.layer.borderColor=[[UIColor clearColor]CGColor];
    orderBut.layer.cornerRadius=8;
    [OneView addSubview:orderBut];
    
    UIButton *orderBut1=[UIButton buttonWithType:UIButtonTypeCustom];
    orderBut1.frame=CGRectMake(200*ScreenWidth/375, 130*ScreenWidth/375, 125*ScreenWidth/375, 40*ScreenWidth/375);
    [orderBut1 setTitle:@"注册" forState:UIControlStateNormal];
    [orderBut1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    orderBut1.backgroundColor = [UIColor  colorWithRed:19/255.0 green:86/255.0 blue:126/255.0 alpha:1];
    orderBut1.titleLabel.font = [UIFont systemFontOfSize:16*ScreenWidth/375.0];
    [orderBut1 addTarget:self action:@selector(orderAction2) forControlEvents:UIControlEventTouchUpInside];
    orderBut1.layer.borderWidth=1;
    orderBut1.layer.borderColor=[[UIColor clearColor]CGColor];
    orderBut1.layer.cornerRadius=8;
    [OneView addSubview:orderBut1];
    
    UIView *view01=[[UIView alloc]initWithFrame:CGRectMake(0, 190*ScreenWidth/375.0, ScreenWidth, 40*ScreenWidth/375.0)];
    view01.backgroundColor=[UIColor whiteColor];
    UIImageView *imagevie1=[[UIImageView alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, 7*ScreenWidth/375, 24*ScreenWidth/375, 26*ScreenWidth/375)];
    imagevie1.image=[UIImage imageNamed:@"分享优惠"];
    [view01 addSubview:imagevie1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40*ScreenWidth/375, 0, ScreenWidth-28*ScreenWidth/375, 40*ScreenWidth/375)];
    label1.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    label1.textColor=[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    label1.text=@"分享优惠";
    label1.textAlignment =NSTextAlignmentLeft ;
    [view01 addSubview:label1];
    [self.view  addSubview:view01];
    
    UIView *view02=[[UIView alloc]initWithFrame:CGRectMake(0, 240*ScreenWidth/375.0, ScreenWidth, 40*ScreenWidth/375.0)];
    view02.backgroundColor=[UIColor whiteColor];
    UIImageView *imagevie2=[[UIImageView alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, 6*ScreenWidth/375, 32*ScreenWidth/375, 28*ScreenWidth/375)];
    imagevie2.image=[UIImage imageNamed:@"收藏有奖"];
    [view02 addSubview:imagevie2];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(40*ScreenWidth/375, 0, ScreenWidth-28*ScreenWidth/375, 40*ScreenWidth/375)];
    label2.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    label2.textColor=[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    label2.text=@"收藏有奖";
    label2.textAlignment =NSTextAlignmentLeft ;
    [view02 addSubview:label2];
    [self.view  addSubview:view02];
    
    UIView *view03=[[UIView alloc]initWithFrame:CGRectMake(0, 290*ScreenWidth/375.0, ScreenWidth, 40*ScreenWidth/375.0)];
    view03.backgroundColor=[UIColor whiteColor];
    UIImageView *imagevie3=[[UIImageView alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, 6*ScreenWidth/375, 22*ScreenWidth/375, 28*ScreenWidth/375)];
    imagevie3.image=[UIImage imageNamed:@"会员社区"];
    [view03 addSubview:imagevie3];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(40*ScreenWidth/375, 0, ScreenWidth-28*ScreenWidth/375, 40*ScreenWidth/375)];
    label3.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    label3.textColor=[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    label3.text=@"会员社区";
    label3.textAlignment =NSTextAlignmentLeft ;
    [view03 addSubview:label3];
    [self.view  addSubview:view03];
    
    UIView *view04=[[UIView alloc]initWithFrame:CGRectMake(0, 340*ScreenWidth/375.0, ScreenWidth, 40*ScreenWidth/375.0)];
    view04.backgroundColor=[UIColor whiteColor];
    UIImageView *imagevie4=[[UIImageView alloc]initWithFrame:CGRectMake(5*ScreenWidth/375, 5*ScreenWidth/375, 30*ScreenWidth/375, 30*ScreenWidth/375)];
    imagevie4.image=[UIImage imageNamed:@"关于"];
    [view04 addSubview:imagevie4];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(40*ScreenWidth/375, 0, ScreenWidth-28*ScreenWidth/375, 40*ScreenWidth/375)];
    label4.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
    label4.textColor=[UIColor colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
    label4.text=@"关于";
    label4.textAlignment =NSTextAlignmentLeft ;
    [view04 addSubview:label4];
    [self.view  addSubview:view04];
    
}

//点击登陆
- (void)orderAction1{
    
//    LandViewController *landVC=[[LandViewController alloc]init];
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController pushViewController:landVC animated:YES];
    DengluViewController *denglu = [[DengluViewController alloc]init];
    if (self.RRR==1) {
        denglu.RRR=1;
        [self.navigationController pushViewController:denglu animated:YES];
    }else{
        [self.navigationController pushViewController:denglu animated:YES];
    }
    
}

//点击注册
- (void)orderAction2{
//    RegisterViewController *RegistVC=[[RegisterViewController alloc]init];
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController pushViewController:RegistVC animated:YES];
    ZHUceViewController *zhuce = [[ZHUceViewController alloc]init];

    [self.navigationController pushViewController:zhuce animated:YES];
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
