//
//  OrderlistSSTableViewCell.m
//  Code_
//
//  Created by admin on 16/3/6.
//  Copyright © 2016年 东. All rights reserved.
//

#import "OrderlistSSTableViewCell.h"

@implementation OrderlistSSTableViewCell

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
        
        self.ProdNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 18*ScreenWidth/375, 360*ScreenWidth/375, 14*ScreenWidth/375)];
        self.ProdNameLabel.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
        self.ProdNameLabel.textColor=[UIColor blackColor];
        self.ProdNameLabel.textAlignment =NSTextAlignmentLeft;
        self.ProdNameLabel.text=@"房屋名称:";
        [self .contentView addSubview:self.ProdNameLabel];
        
        self.OrderIdLabel =[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 50*ScreenWidth/375, 360*ScreenWidth/375, 14*ScreenWidth/375)];
        self.OrderIdLabel.font=[UIFont systemFontOfSize:16*ScreenWidth/375];
        self.OrderIdLabel.textColor=[UIColor blackColor];
        self.OrderIdLabel.textAlignment =NSTextAlignmentLeft;

        [self .contentView addSubview:self.OrderIdLabel];
        
        self.OrderTotalPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 80*ScreenWidth/375, 360*ScreenWidth/375, 14*ScreenWidth/375)];
        self.OrderTotalPriceLabel.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        self.OrderTotalPriceLabel.textColor=[UIColor blackColor];
        self.OrderTotalPriceLabel.textAlignment =NSTextAlignmentLeft;
        
        [self .contentView addSubview:self.OrderTotalPriceLabel];
        
        
        self.OrderStateLabel =[[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375, 110*ScreenWidth/375, 360*ScreenWidth/375, 14*ScreenWidth/375)];
        self.OrderStateLabel.font=[UIFont systemFontOfSize:15*ScreenWidth/375];
        self.OrderStateLabel.textColor=[UIColor grayColor];
        self.OrderStateLabel.textAlignment =NSTextAlignmentLeft;
        
        [self .contentView addSubview:self.OrderStateLabel];
        
        
    }
    return self;
}


- (void)setOrdessss:(OrderlistModeSSS *)ordessss
{
    if (_ordessss !=ordessss) {
        
    }
    self.OrderIdLabel.text=[NSString stringWithFormat:@"订单ID编号: %@ ",ordessss.OrderNo];
    self.OrderTotalPriceLabel.text=[NSString stringWithFormat:@"支付金额:%.2f 元",ordessss.OrderTotalPrice];
    
    NSLog(@"%d------------99",ordessss.OrderState);
    if (ordessss.OrderState==1) {
        self.OrderStateLabel.text=[NSString stringWithFormat:@"订单状态: 待支付"];
        
    }else if (ordessss.OrderState==2)
    {
        self.OrderStateLabel.text=[NSString stringWithFormat:@"订单状态: 已支付"];
       
    }else if (ordessss.OrderState==-1)
    {
        self.OrderStateLabel.text=[NSString stringWithFormat:@"订单状态: 已取消"];
        
    }else{
        self.OrderStateLabel.text=[NSString stringWithFormat:@"订单状态: 异常"];
        
    }
    
}

@end
