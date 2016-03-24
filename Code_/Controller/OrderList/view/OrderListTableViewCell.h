//
//  OrderListTableViewCell.h
//  Code_
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 东. All rights reserved.
//
#import "MyTableViewCell.h"
#import <UIKit/UIKit.h>
#import "OrderlistMode.h"
@interface OrderListTableViewCell : MyTableViewCell


@property(nonatomic,retain)OrderlistMode *OrderlistM;
@property(nonatomic,retain)UILabel *OrderStateLabel;
@property(nonatomic,retain)UILabel *TotalPriceLabel;
@property(nonatomic,retain)UILabel *NameLabel;


@end
