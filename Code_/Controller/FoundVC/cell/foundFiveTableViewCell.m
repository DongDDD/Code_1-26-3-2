//
//  foundFiveTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.

#import "AutoAdjustFrame.h"
#import "foundFiveTableViewCell.h"

@implementation foundFiveTableViewCell

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
        
        
            int i=2;
            NSString *str=@"you游客评论等zdfkjhgkdejghdfkjhtrh 俄和他个人空间好个特人集体和个人冠军的办法就是大锅饭 i 俄国特热贴 u 让用户更加开热风个人个热狗热狗火热和任何人和人很热和任何人恍恍惚惚好热好热好热好热热乎乎如何如何放";
            
            UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(9*ScreenWidth/375, 12*ScreenWidth/375, ScreenWidth-(18*ScreenWidth/375), (i/3)*((ScreenWidth-(56*ScreenWidth/375))/3+(9*ScreenWidth/375))+(90*ScreenWidth/375)+[AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:ScreenWidth-(40*ScreenWidth/375)]+(ScreenWidth-(56*ScreenWidth/375))/3.5+(10*ScreenWidth/375)+10*ScreenWidth/375)];
            foot.backgroundColor=[UIColor whiteColor];
            [self.contentView addSubview:foot];
            
            self.HeadImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 5*ScreenWidth/375, 60*ScreenWidth/375, 60*ScreenWidth/375)];
            [UIImageCutter cutImageAutoWithUIImageView:self.HeadImageView urlString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2531583001,1422407153&fm=116&gp=0.jpg"];
            self.HeadImageView.layer.borderWidth=0;
            self.HeadImageView.layer.cornerRadius=30*ScreenWidth/375;
            self.HeadImageView.layer.masksToBounds = YES;
            self.HeadImageView.layer.borderColor=[[UIColor redColor]CGColor];
            [foot addSubview:self.HeadImageView];
            
            self.sexV=[[UIImageView alloc]initWithFrame:CGRectMake(80*ScreenWidth/375, 5*ScreenWidth/375, 20*ScreenWidth/375, 20*ScreenWidth/375)];
            //        [UIImageCutter cutImageAutoWithUIImageView:self.sexV urlString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2531583001,1422407153&fm=116&gp=0.jpg"];
            self.sexV.image=[UIImage imageNamed:@"男"];//判断是男是女选取图标，或从网络获取
            self.sexV.layer.borderWidth=0;
            self.sexV.layer.cornerRadius=10;
            self.sexV.layer.masksToBounds = YES;
            self.sexV.layer.borderColor=[[UIColor redColor]CGColor];
            [foot addSubview:self.sexV];
            
            self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(105*ScreenWidth/375, 5*ScreenWidth/375,160*ScreenWidth/375, 20*ScreenWidth/375)];
            self.nameLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
            self.nameLabel.textColor=[UIColor blackColor];
            self.nameLabel.text=@"一个人的旅行";
            self.nameLabel.textAlignment =NSTextAlignmentLeft;
            [foot addSubview:self.nameLabel];
            
            self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(80*ScreenWidth/375, 27*ScreenWidth/375,160*ScreenWidth/375, 20*ScreenWidth/375)];
            self.timeLabel.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
            self.timeLabel.textColor=[UIColor grayColor];
            self.timeLabel.text=@"30分钟前";
            self.timeLabel.textAlignment =NSTextAlignmentLeft;
            [foot addSubview:self.timeLabel];
            
            UIView *oranV=[[UIView alloc]initWithFrame:CGRectMake(77.5*ScreenWidth/375, 47*ScreenWidth/375,70*ScreenWidth/375, 20*ScreenWidth/375)];
            oranV.backgroundColor=[UIColor colorWithRed:255/255.0 green:238/255.0 blue:218/255.0 alpha:0.6];
            oranV.layer.borderWidth=0;
            oranV.layer.cornerRadius=10*ScreenWidth/375;
            oranV.layer.masksToBounds = YES;
            oranV.layer.borderColor=[[UIColor redColor]CGColor];
            [foot addSubview:oranV];
            
            //ScreenWidth-20-(ScreenWidth/13)*2-20
            self.yeartimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(80*ScreenWidth/375, 47*ScreenWidth/375,65*ScreenWidth/375, 20*ScreenWidth/375)];
            self.yeartimeLabel.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
            self.yeartimeLabel.textColor=[UIColor orangeColor];
            self.yeartimeLabel.text=@"12月20号";
            self.yeartimeLabel.textAlignment =NSTextAlignmentCenter;
            [foot addSubview:self.yeartimeLabel];
            
            UIView *goranV=[[UIView alloc]initWithFrame:CGRectMake(155*ScreenWidth/375, 47*ScreenWidth/375,80*ScreenWidth/375, 20*ScreenWidth/375)];
            goranV.backgroundColor=[UIColor colorWithRed:211/255.0 green:249/255.0 blue:221/255.0 alpha:0.7];
            goranV.layer.borderWidth=0;
            goranV.layer.cornerRadius=10*ScreenWidth/375;
            goranV.layer.masksToBounds = YES;
            goranV.layer.borderColor=[[UIColor redColor]CGColor];
            [foot addSubview:goranV];
            
            self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(155*ScreenWidth/375, 47*ScreenWidth/375,80*ScreenWidth/375, 20*ScreenWidth/375)];
            self.addressLabel.font=[UIFont systemFontOfSize:13*ScreenWidth/375];
            self.addressLabel.textColor=[UIColor colorWithRed:64/255.0 green:154/255.0 blue:92/255.0 alpha:1];
            self.addressLabel.text=@"广州从化";
            self.addressLabel.textAlignment =NSTextAlignmentCenter;
            [foot addSubview:self.addressLabel];
            
            self.zanButton=[UIButton buttonWithType:UIButtonTypeCustom];
            self.zanButton.frame=CGRectMake(265*ScreenWidth/375, 5*ScreenWidth/375, 20*ScreenWidth/375, 18*ScreenWidth/375);
            [self.zanButton setBackgroundImage:[UIImage imageNamed:@"点赞说"] forState:UIControlStateNormal];
            [self.zanButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.zanButton addTarget:self action:@selector(zanAction) forControlEvents:UIControlEventTouchUpInside];
            [foot addSubview:self.zanButton];
            
            self.zanLabel=[[UILabel alloc]initWithFrame:CGRectMake(285*ScreenWidth/375, 5*ScreenWidth/375,25*ScreenWidth/375, 20*ScreenWidth/375)];
            self.zanLabel.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
            self.zanLabel.textColor=[UIColor grayColor];
            self.zanLabel.text=@"10";
            self.zanLabel.textAlignment =NSTextAlignmentCenter;
            [foot addSubview:self.zanLabel];
            
            self.pingButton=[UIButton buttonWithType:UIButtonTypeCustom];
            self.pingButton.frame=CGRectMake(310*ScreenWidth/375, 5*ScreenWidth/375, 20*ScreenWidth/375, 18*ScreenWidth/375);
            [self.pingButton setBackgroundImage:[UIImage imageNamed:@"评论说"] forState:UIControlStateNormal];
            [self.pingButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.pingButton addTarget:self action:@selector(pingAction) forControlEvents:UIControlEventTouchUpInside];
            [foot addSubview:self.pingButton];
            
            self.pingLabel=[[UILabel alloc]initWithFrame:CGRectMake(330*ScreenWidth/375, 5*ScreenWidth/375,25*ScreenWidth/375, 20*ScreenWidth/375)];
            self.pingLabel.font=[UIFont systemFontOfSize:11*ScreenWidth/375];
            self.pingLabel.textColor=[UIColor grayColor];
            self.pingLabel.text=@"10";
            self.pingLabel.textAlignment =NSTextAlignmentCenter;
            [foot addSubview:self.pingLabel];
            
        
                UIView *foots=[[UIView alloc]initWithFrame:CGRectMake(0, 72*ScreenWidth/375, 350*ScreenWidth/375, 2)];
                foots.backgroundColor=[UIColor grayColor];
                foots.alpha=0.2;
                [foot addSubview:foots];
                

                self.sayLabel=[[UILabel alloc]init];
                self.sayLabel.text=[str stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
                self.sayLabel.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
                self.sayLabel.frame=CGRectMake(10*ScreenWidth/375, 80*ScreenWidth/375, 335*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:335*ScreenWidth/375]+5*ScreenWidth/375);
                self.sayLabel.textColor=[UIColor grayColor];
                self.sayLabel.numberOfLines=0;
                self.sayLabel.textAlignment =NSTextAlignmentLeft;
                [foot addSubview:self.sayLabel];
                
                for (int i = 0; i < 3; i++) {
                    
                    UIView *view=[[UIView alloc]initWithFrame:CGRectMake((9*ScreenWidth/375)+(i%3)*((ScreenWidth-(56*ScreenWidth/375))/3+(9*ScreenWidth/375)), (i/3)*((ScreenWidth-(56*ScreenWidth/375))/3+(9*ScreenWidth/375))+(90*ScreenWidth/375)+[AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:335*ScreenWidth/375]+5*ScreenWidth/375, (ScreenWidth-(56*ScreenWidth/375))/3, (ScreenWidth-(56*ScreenWidth/375))/3.5)];
                    view.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                    [foot addSubview:view];
                    
                    self.sayImageView=[[UIImageView alloc]initWithFrame:CGRectMake((9*ScreenWidth/375)+(i%3)*((ScreenWidth-(56*ScreenWidth/375))/3+(9*ScreenWidth/375)), (i/3)*((ScreenWidth-(56*ScreenWidth/375))/3+(9*ScreenWidth/375))+(90*ScreenWidth/375)+[AutoAdjustFrame heightForString:str font:13*ScreenWidth/375 width:335*ScreenWidth/375]+
                                                                                   5*ScreenWidth/375, (ScreenWidth-(56*ScreenWidth/375))/3, (ScreenWidth-(56*ScreenWidth/375))/3.5)];
                    self.sayImageView.tag=i+1;
                    [UIImageCutter cutImageAutoWithUIImageView:self.sayImageView urlString:@"http://pic31.nipic.com/20130728/8821914_172637249163_2.jpg"];
                    [foot addSubview:self.sayImageView];
                }
                
        
    }
    return self;
}


-(void)zanAction{
    NSLog(@"dian zan ");
}

-(void)pingAction{
    NSLog(@"dian ping lun ");
}
@end
