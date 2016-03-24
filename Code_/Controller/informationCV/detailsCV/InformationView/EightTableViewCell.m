//
//  EightTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/17.
//  Copyright © 2015年 东. All rights reserved.
//
#import "AutoAdjustFrame.h"
#import "EightTableViewCell.h"

@implementation EightTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.headImageV=[[UIImageView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, 10*ScreenWidth/375, 50*ScreenWidth/375, 50*ScreenWidth/375)];
        [UIImageCutter cutImageAutoWithUIImageView:self.headImageV urlString:@"http://s1.sinaimg.cn/middle/8f8157e54b24e2e0f47b0&amp;690"];
        self.headImageV.layer.borderWidth=0;
        self.headImageV.layer.cornerRadius=25*ScreenWidth/375;
        self.headImageV.layer.masksToBounds = YES;
        self.headImageV.layer.borderColor=[[UIColor clearColor]CGColor];
        [self.contentView addSubview:self.headImageV];
        
        self.nameL=[[UILabel alloc]initWithFrame:CGRectMake(65*ScreenWidth/375, 18*ScreenWidth/375, 310*ScreenWidth/375, 11*ScreenWidth/375)];
        self.nameL.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        self.nameL.textColor=[UIColor grayColor];
        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.nameL.text=@"黄牛东       2015年11月11日入住";
        self.nameL.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameL];
        
        NSString *str=@"第一次入住，就得到了非常棒的入住体验，房间非常温馨，有一种回家的感觉。雅轩居这个名字和房东的气质非常贴近，她不但优雅美丽，气宇轩昂，而且服务热情周到，住到这里有一种管家式的贴心服务，简直比五星级还五星级，下次一定还来住！";
        self.contentL=[[UILabel alloc]init];
        self.contentL.text=[str stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        self.contentL.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
        self.contentL.frame=CGRectMake(65*ScreenWidth/375, 35*ScreenWidth/375, 305*ScreenWidth/375,  [AutoAdjustFrame heightForString:str font:12*ScreenWidth/375 width:305*ScreenWidth/375]);
        self.contentL.textColor=[UIColor grayColor];
        self.contentL.numberOfLines=0;
        //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
        self.contentL.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.contentL];
        
        NSString *str1=@"五星級管家不敢當，呵呵，在修行狀態的日子裡面做一個默默的麥田守望者吧！等待新的小夥伴回到雅軒居！和你們一起分享美食，美房和美趣！感謝你的認可和支持，我們都會越來越棒的！很有口福的小夥伴，每次我做美食你都有口福！感謝你送的漂亮的不銹鋼湯鍋喔！有時間再一起享用我做的台北小火鍋吧！今天才剛剛發現房東的回評也可以用手機了！真的是太方便了！";
      if (str1!=nil) {
        if ( [AutoAdjustFrame heightForString:str font:12*ScreenWidth/375 width:ScreenWidth]<50) {
            
            UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, 68*ScreenWidth/375, 361*ScreenWidth/375, 2*ScreenWidth/375)];
            headS.backgroundColor=[UIColor grayColor];
            headS.alpha=0.3;
            [self.contentView addSubview:headS];
            
            self.nameL1=[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 78*ScreenWidth/375, 310*ScreenWidth/375, 11*ScreenWidth/375)];
            self.nameL1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
            self.nameL1.textColor=[UIColor blackColor];
            //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
            self.nameL1.text=@"房东回复 : ";
            self.nameL1.textAlignment =NSTextAlignmentLeft;
            [self.contentView addSubview:self.nameL1];
            
            self.contentL1=[[UILabel alloc]init];
            self.contentL1.text=[str1 stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
            self.contentL1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
            self.contentL1.frame=CGRectMake(30*ScreenWidth/375, 95*ScreenWidth/375, 340*ScreenWidth/375,  [AutoAdjustFrame heightForString:str1 font:12*ScreenWidth/375 width:340*ScreenWidth/375]);
            self.contentL1.textColor=[UIColor grayColor];
            self.contentL1.numberOfLines=0;
            //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
            self.contentL1.textAlignment =NSTextAlignmentLeft;
            [self.contentView addSubview:self.contentL1];
       

          
          
          
            }else
            {
                UIView *headS=[[UIView alloc]initWithFrame:CGRectMake(7*ScreenWidth/375, [AutoAdjustFrame heightForString:str font:12*ScreenWidth/375 width:ScreenWidth]+55*ScreenWidth/375, 361*ScreenWidth/375, 1*ScreenWidth/375)];
                headS.backgroundColor=[UIColor grayColor];
                headS.alpha=0.3;
                [self.contentView addSubview:headS];
                
                self.nameL1=[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, [AutoAdjustFrame heightForString:str font:12*ScreenWidth/375 width:ScreenWidth]+65*ScreenWidth/375, 310*ScreenWidth/375, 11*ScreenWidth/375)];
                self.nameL1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
                self.nameL1.textColor=[UIColor blackColor];
                //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
                self.nameL1.text=@"房东回复 : ";
                self.nameL1.textAlignment =NSTextAlignmentLeft;
                [self.contentView addSubview:self.nameL1];
                
                self.contentL1=[[UILabel alloc]init];
                self.contentL1.text=[str1 stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
                self.contentL1.font=[UIFont systemFontOfSize:12*ScreenWidth/375];
                self.contentL1.frame=CGRectMake(30*ScreenWidth/375, [AutoAdjustFrame heightForString:str font:12*ScreenWidth/375 width:ScreenWidth]+81*ScreenWidth/375, 340*ScreenWidth/375,  [AutoAdjustFrame heightForString:str1 font:12*ScreenWidth/375 width:340*ScreenWidth/375]);
                self.contentL1.textColor=[UIColor grayColor];
                self.contentL1.numberOfLines=0;
                //        self.bookingCount.text=[NSString stringWithFormat:@"已订%@次, "];
                self.contentL1.textAlignment =NSTextAlignmentLeft;
                [self.contentView addSubview:self.contentL1];
            }
            
        }
        
        
        
        
    }
    return self;
}

@end
