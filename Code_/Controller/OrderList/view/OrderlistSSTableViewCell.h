//
//  OrderlistSSTableViewCell.h
//  Code_
//
//  Created by admin on 16/3/6.
//  Copyright © 2016年 东. All rights reserved.
//
#import "MyTableViewCell.h"
#import <UIKit/UIKit.h>
#import "OrderlistModeSSS.h"
@interface OrderlistSSTableViewCell : MyTableViewCell
@property(nonatomic,retain)OrderlistModeSSS *ordessss;

@property(nonatomic,retain)UILabel *OrderIdLabel;
@property(nonatomic,retain)UILabel *OrderStateLabel;
@property(nonatomic,retain)UILabel *OrderTotalPriceLabel;
@property(nonatomic,retain)UILabel *ProdNameLabel;
@end
