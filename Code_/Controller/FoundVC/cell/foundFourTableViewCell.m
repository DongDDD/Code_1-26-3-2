//
//  foundFourTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//
#import "youJiTuiJianTableViewController.h"
#import "foundFourTableViewCell.h"

@implementation foundFourTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.array=[[NSArray alloc]initWithObjects:@"亲子活动",@"结伴出行",@"骑行组织",@"徒步旅行",@"乡间体验",@"情侣出行", nil];
        
        NSArray *array1=[[NSArray alloc]initWithObjects:@"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",@"http://pic28.nipic.com/20130402/9252150_190139450381_2.jpg",@"http://imgk.zol.com.cn/dcbbs/2342/a2341460.jpg",@"http://img2.3lian.com/img2007/10/28/123.jpg",@"http://pic.nipic.com/2007-11-09/200711912230489_2.jpg",@"http://imgsrc.baidu.com/forum/pic/item/3ac79f3df8dcd1004e9102b8728b4710b9122f1e.jpg",nil];
        
        
        for (int i = 0; i < 6; i++) {
            
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake((9*ScreenWidth/375)+(i%2)*((ScreenWidth-(27*ScreenWidth/375))/2+(9*ScreenWidth/375)), (i/2)*((ScreenWidth-(27*ScreenWidth/375))/2*0.6+(9*ScreenWidth/375)), (ScreenWidth-(27*ScreenWidth/375))/2, (ScreenWidth-(27*ScreenWidth/375))/2*0.6)];
            view.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
            [self.contentView addSubview:view];
            
            self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake((9*ScreenWidth/375)+(i%2)*((ScreenWidth-(27*ScreenWidth/375))/2+(9*ScreenWidth/375)), (i/2)*((ScreenWidth-(27*ScreenWidth/375))/2*0.6+(9*ScreenWidth/375)), (ScreenWidth-(27*ScreenWidth/375))/2, (ScreenWidth-(27*ScreenWidth/375))/2*0.6)];
            self.imageV.tag=i;
            [UIImageCutter cutImageAutoWithUIImageView:self.imageV urlString:array1[i]];
            [self.contentView addSubview:self.imageV];
            
            UIView *titeView=[[UIView alloc]initWithFrame:CGRectMake(20*ScreenWidth/375, (ScreenWidth-(27*ScreenWidth/375))/2*0.6-((10+25)*ScreenWidth/375), (ScreenWidth-(27*ScreenWidth/375))/2-(40*ScreenWidth/375), 25*ScreenWidth/375)];
            titeView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
            [self.imageV addSubview:titeView];
            
            self.titeLabel=[[UILabel alloc]initWithFrame:CGRectMake(2*ScreenWidth/375, 0,(ScreenWidth-(27*ScreenWidth/375))/2-(44*ScreenWidth/375), 25*ScreenWidth/375)];
            self.titeLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
            self.titeLabel.textColor=[UIColor whiteColor];
            self.titeLabel.text=self.array[i];
            self.titeLabel.textAlignment =NSTextAlignmentCenter;
            [titeView addSubview:self.titeLabel];
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=i;
            btn.frame=CGRectMake((9*ScreenWidth/375)+(i%2)*((ScreenWidth-(27*ScreenWidth/375))/2+(9*ScreenWidth/375)), (i/2)*((ScreenWidth-(27*ScreenWidth/375))/2*0.6+(9*ScreenWidth/375)), (ScreenWidth-(27*ScreenWidth/375))/2, (ScreenWidth-(27*ScreenWidth/375))/2*0.6);
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(selectButtionWithTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            
            
        }
        
    }
    return self;
}

- (void)selectButtionWithTag:(UIButton*)butt{
    //    NSLog(@"%d",sender.tag);
    //实现代码块
    if (self.btnClick) {
        NSString *str=self.array[butt.tag];
        self.btnClick();
    }
    #warning Incomplete implementation, return the number of rows
     NSLog(@"－%ld,%@",(long)butt.tag,self.array[butt.tag]);
    [self.delegate myTabVClick:self];
    
}

//- (void)awakeFromNib
//{
//    // Initialization code
//}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//    
//    // Configure the view for the selected state
//}

@end
