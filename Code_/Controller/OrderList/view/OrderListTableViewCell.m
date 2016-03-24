//
//  OrderListTableViewCell.m
//  Code_
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 东. All rights reserved.
//

#import "OrderListTableViewCell.h"

@implementation OrderListTableViewCell

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
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 15*ScreenWidth/375, ScreenWidth, 100*ScreenWidth/375)];
        view.backgroundColor=[UIColor whiteColor];
        [self .contentView addSubview:view];
        
        self.NameLabel =[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 18*ScreenWidth/375, 360*ScreenWidth/375, 14*ScreenWidth/375)];
        self.NameLabel.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
        self.NameLabel.textColor=[UIColor blackColor];
        self.NameLabel.textAlignment =NSTextAlignmentLeft;
        [view addSubview:self.NameLabel];
        
        
        self.TotalPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 50*ScreenWidth/375, 360*ScreenWidth/375, 14*ScreenWidth/375)];
        self.TotalPriceLabel.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        self.TotalPriceLabel.textColor=[UIColor blackColor];
        self.TotalPriceLabel.textAlignment =NSTextAlignmentLeft;
        [view addSubview:self.TotalPriceLabel];
        
        
        self.OrderStateLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 80*ScreenWidth/375, 350*ScreenWidth/375, 14*ScreenWidth/375)];
        self.OrderStateLabel.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        self.OrderStateLabel.textColor=[UIColor grayColor];
        self.OrderStateLabel.textAlignment =NSTextAlignmentRight;
        [view addSubview:self.OrderStateLabel];
        
        
    }
    return self;
}

- (void)setOrderlistM:(OrderlistMode *)OrderlistM
{
    if (_OrderlistM !=OrderlistM) {
        
    }
    self.NameLabel.text=OrderlistM.ProdName;
    self.TotalPriceLabel.text=[NSString stringWithFormat:@"订单金额: %d 元",OrderlistM.OrderTotalPrice];
    if (OrderlistM.OrderState==1) {
        self.OrderStateLabel.text=@"待支付";
    }else if (OrderlistM.OrderState==2)
    {
        self.OrderStateLabel.text=@"已支付";
    }else if (OrderlistM.OrderState==-1)
    {
        self.OrderStateLabel.text=@"已取消";
    }else{
        self.OrderStateLabel.text=@"异常";
    }
    
}

@end
