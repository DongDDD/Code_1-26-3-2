//
//  foundThreeTableViewCell.m
//  Code_
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 东. All rights reserved.
//

#import "foundThreeTableViewCell.h"

@implementation foundThreeTableViewCell

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
        NSArray *array=[[NSArray alloc]initWithObjects:@"广州世外桃源",@"从化特色行",@"特色生态园",@"特色生态园",@"广州世外桃源",@"从化特色行", nil];
        
        NSArray *array1=[[NSArray alloc]initWithObjects:@"http://pic30.nipic.com/20130618/11860366_201437262000_2.jpg",@"http://img10.3lian.com/sc6/show02/38/65/386515.jpg",@"http://imgk.zol.com.cn/dcbbs/2342/a2341460.jpg",@"http://pic2.ooopic.com/11/79/98/31bOOOPICb1_1024.jpg",@"http://img.sc115.com/uploads/sc/jpgs/07/pic5093_sc115.com.jpg",@"http://pic15.nipic.com/20110731/8022110_162804602317_2.jpg",nil];
        
        for (int i = 0; i < 6; i++) {
            
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake((9*ScreenWidth/375)+(i%3)*((ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375)), (i/3)*((ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375)), (ScreenWidth-(36*ScreenWidth/375))/3, (ScreenWidth-(36*ScreenWidth/375))/3)];
            view.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
            [self.contentView addSubview:view];
            
            self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake((9*ScreenWidth/375)+(i%3)*((ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375)), (i/3)*((ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375)), (ScreenWidth-(36*ScreenWidth/375))/3, (ScreenWidth-(36*ScreenWidth/375))/3)];
            self.imageV.tag=i+1;
            [UIImageCutter cutImageAutoWithUIImageView:self.imageV urlString:array1[i]];
            [self.contentView addSubview:self.imageV];
            
            UIView *titeView=[[UIView alloc]initWithFrame:CGRectMake(6*ScreenWidth/375, (ScreenWidth-(36*ScreenWidth/375))/3-((24+10)*ScreenWidth/375), (ScreenWidth-(36*ScreenWidth/375))/3-(12*ScreenWidth/375), 24*ScreenWidth/375)];
            titeView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
            [self.imageV addSubview:titeView];
            
            self.titeLabel=[[UILabel alloc]initWithFrame:CGRectMake(2*ScreenWidth/375, 0,(ScreenWidth-(36*ScreenWidth/375))/3-((12+4)*ScreenWidth/375), 24*ScreenWidth/375)];
            self.titeLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
            self.titeLabel.textColor=[UIColor whiteColor];
            self.titeLabel.text=array[i];
            self.titeLabel.textAlignment =NSTextAlignmentCenter;
            [titeView addSubview:self.titeLabel];
            
            UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
            butt.tag=i+1;
            butt.frame=CGRectMake((9*ScreenWidth/375)+(i%3)*((ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375)), (i/3)*((ScreenWidth-(36*ScreenWidth/375))/3+(9*ScreenWidth/375)), (ScreenWidth-(36*ScreenWidth/375))/3, (ScreenWidth-(36*ScreenWidth/375))/3);
            butt.backgroundColor=[UIColor clearColor];
            [butt addTarget:self action:@selector(selectButtionWithTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:butt];
            
        }
    }
    return self;
}


- (void)selectButtionWithTag:(UIButton*)butt{
    NSLog(@"点击了%ld",butt.tag);
    //   NSLog(@"点击了图片%@",_photoArr[butt.tag]);
}
@end
