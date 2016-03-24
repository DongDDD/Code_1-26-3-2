//
//  DingdanTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//

#import "DingdanTableViewCell.h"
#import "DingdanZhifuViewController.h"
#import "QuanbuDingdanViewController.h"
@implementation DingdanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)jiazaiShuju:(NSDictionary *)dict{
    
    
    [self changTheFrame];

    NSLog(@"显示栏是%ld",_xianshiLan);
    
    [self setTheQuPingjiaButtonXianShiLabel:dict];
    
    
    
    if (_chakanOrZhifu) {
        [_pingjiaButton removeFromSuperview];
    }
    
    if (dict.count!=0) {
        _jutiJiageLabel.text = dict[@"1"];
    
    }
    
    
}



#pragma mark - 设置评价按钮显示的字体

-(void)setTheQuPingjiaButtonXianShiLabel:(NSDictionary *)dict{
    
    if ([dict[@"dingdan"]isEqualToString:@"0"]) {
        if ([dict[@"pingjia"]isEqualToString:@"0"]) {
            [_pingjiaButton setTitle:@"去支付" forState:UIControlStateNormal];
        }else{
            [_pingjiaButton setTitle:@"去评价" forState:UIControlStateNormal];
        }
        //_pingjiaButton.titleLabel.text = @"去支付";
        
    }else{
        //if ([dict[@"pingjia"] isEqualToString:@"1"]) {
            [_pingjiaButton setTitle:@"查看评价" forState:UIControlStateNormal];
        //}
    }

    
    
}

#pragma mark - 设置提交订单显示栏
-(void)setTheJiaGeDengLabel:(NSDictionary *)dict{
    float a = 8*_bili;
    float b = 200*_bili;
    float c = 13*_bili;
    float d = 304*_bili;
    float e = 30 *_bili;
    
    NSArray *arr = @[@"价       格 ：",@"入住日期 ：",@"入住人数 ："];
    for (int i = 0; i<3; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(e, (88+38*i)*_bili, b, c);
        //拼接字符串
        NSString *str = [NSString stringWithFormat:@"%@%@",arr[i],dict[@""]];
        label.text = str;
        label.font = [UIFont systemFontOfSize:12*_bili];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        UIImageView *imm = [[UIImageView alloc]init];
        imm.frame = CGRectMake(a, (113+38*i)*_bili, d, 1);
        imm.backgroundColor = [UIColor grayColor];
        [self addSubview:imm];
    }
    
    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake(e, 268*_bili, 260*_bili, 30*_bili)];
    [bu setTitle:@"提交订单" forState:UIControlStateNormal];
    bu.titleLabel.font = [UIFont systemFontOfSize:14*_bili];
    [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bu setBackgroundColor:[UIColor colorWithRed:246/255.0 green:123/255.0 blue:3/255.0 alpha:1]];
    [bu addTarget:self action:@selector(tijiaoDingdanButtonClick) forControlEvents: UIControlEventTouchUpInside];
    bu.layer.cornerRadius = 4*_bili;
    [self addSubview:bu];
   
}
#pragma mark - 设置提交订单按钮点击事件
-(void)tijiaoDingdanButtonClick{
    NSLog(@"提交了订单");
    
}

//
//#pragma mark - 设置支付显示栏
//-(void)setTheZhifuXuanze:(NSDictionary *)dict{
//    float a = 62*_bili;
//    float b = 8*_bili;
//    float c = 180*_bili;
//    float d = 12*_bili;
//    float e = 30 *_bili;
//    
//    //self.userInteractionEnabled = YES;
//    _zhifuButtonTag = 123456;
//    NSArray *arr1 = @[@"支付宝支付",@"银联支付",@"微信支付"];
//    NSArray *arr2 = @[@"推荐有支付宝账号的用户使用",@"支持储蓄信用卡，无需开通网银",@"推荐安装微信5.0以上版本的用户使用"];
//    for (int i = 0; i<3; i++) {
//        UILabel *label = [[UILabel alloc]init];
//        label.frame = CGRectMake(a, (89+47*i)*_bili, c, d);
//        label.text = arr1[i];
//        label.font = [UIFont systemFontOfSize:13*_bili];
//        label.textColor = [UIColor blackColor];
//        label.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:label];
//        UILabel *label2 = [[UILabel alloc]init];
//        label2.frame = CGRectMake(a, (105+47*i)*_bili, c, 10*_bili);
//        label.text = arr2[i];
//        label.font = [UIFont systemFontOfSize:9*_bili];
//        label.textColor = [UIColor grayColor];
//        label.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:label];
//        
//        //设置左侧图片
//        UIImageView *imm1 = [[UIImageView alloc]init];
//        imm1.frame = CGRectMake(d, (86+47*i)*_bili, 42*_bili, e);
//        imm1.backgroundColor = [UIColor yellowColor];
//        [self addSubview:imm1];
//        
//        
//        UIImageView *imm = [[UIImageView alloc]init];
//        imm.frame = CGRectMake(b, (122+47*i)*_bili, 304*_bili, 1);
//        imm.backgroundColor = [UIColor grayColor];
//        [self addSubview:imm];
//        
//        UIButton *bb = [[UIButton alloc]initWithFrame:CGRectMake(280*_bili, (93 +47*i)*_bili, d, d)];
//        bb.tag = (i+1)*10;
//        
//        [bb setBackgroundImage:[UIImage imageNamed:@"关于.png"] forState:UIControlStateNormal];
//        [bb setBackgroundImage:[UIImage imageNamed:@"实名认证.png"] forState:UIControlStateSelected];
//        [bb addTarget:self action:@selector(xuanzeZhifuFangshiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:bb];
//        
//    }
//    
//    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake(e, 268*_bili, 260*_bili, 30*_bili)];
//    [bu setTitle:@"确认支付" forState:UIControlStateNormal];
//    bu.titleLabel.font = [UIFont systemFontOfSize:14*_bili];
//    bu.selected = NO;
//    [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [bu setBackgroundColor:[UIColor colorWithRed:246/255.0 green:123/255.0 blue:3/255.0 alpha:1]];
//    [bu addTarget:self action:@selector(querenZhifuButtonClick) forControlEvents: UIControlEventTouchDown];
//    bu.layer.cornerRadius = 4*_bili;
//    [self addSubview:bu];
//
//}
//#pragma mark - 设置选择支付方式按钮点击事件
//-(void)xuanzeZhifuFangshiButtonClick:(UIButton *)button{
//    
//    if (_zhifuButtonTag == button.tag) {
//        button.selected = NO;
//        _zhifuButtonTag = 123456;
//    }else{
//        UIButton *bu = (UIButton *)[self viewWithTag:_zhifuButtonTag];
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
//        NSLog(@"选择了第%ld种支付方式并确认了支付,支付的金额是%@",_zhifuButtonTag,_jutiJiageLabel.text);
//        
//        QuanbuDingdanViewController *quanbu = [[QuanbuDingdanViewController alloc]init];
//        
//    }
//    
//    
//    
//}



#pragma mark - 设置评价按钮点击事件
- (IBAction)pingjiaButtonClick:(id)sender {
     if ([_pingjiaButton.titleLabel.text isEqualToString:@"去提交"]) {
        [self.delegate fanhuiXuanzeDeDingdan:nil withTag:2];
     }else if([_pingjiaButton.titleLabel.text isEqualToString:@"去支付"]){
         [self.delegate fanhuiXuanzeDeDingdan:nil withTag:3];
     }else if([_pingjiaButton.titleLabel.text isEqualToString:@"去评价"]){
         
     }else{
         
     }
    
    
    //[self.delegate fanhuiXuanzeDeDingdan:nil withTag:nil];
    
    NSLog(@"点击了评价按钮");
    
    
    
}








-(void)changTheFrame{
    float a = 11*_bili;
    float b = 8*_bili;
    float c = 92*_bili;
    _tupianImageView.frame = CGRectMake(b, b, 76*_bili, 60*_bili);
    _mingchengLabel.frame = CGRectMake(c, b, 205*_bili, 16*_bili);
    _dizhiButton.frame =  CGRectMake(c, 28*_bili, 205*_bili, 13*_bili);
    _jiageLabel.frame =  CGRectMake(c, 44*_bili, 50*_bili, 16*_bili);
    _jutiJiageLabel.frame =  CGRectMake(142*_bili, 44*_bili, 80*_bili, 16*_bili);
    _pingjiaButton.frame =  CGRectMake(240*_bili, 42*_bili, 72*_bili, 26*_bili);
    _xiahuaxianImageView.frame = CGRectMake(b, 75*self.bili, 304*self.bili, 1);
    _jiageLabel.font = [UIFont systemFontOfSize:a];
    _mingchengLabel.font = [UIFont systemFontOfSize:a];
    _jutiJiageLabel.font = [UIFont systemFontOfSize:a];
    _dizhiButton.titleLabel.font = [UIFont systemFontOfSize:a];
    _pingjiaButton.titleLabel.font = [UIFont systemFontOfSize:14*_bili];
    _pingjiaButton.layer.cornerRadius = 4*_bili;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
