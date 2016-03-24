//
//  OrderlistMode.h
//  Code_
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderlistMode : NSObject

@property(nonatomic,retain) NSString *OrderId;//订单ID
@property(nonatomic,assign) int OrderState;//订单状态，1待支付、2 已支付、-1已取消
@property(nonatomic,assign) int OrderTotalPrice;//支付金额

@property(nonatomic,retain) NSString *ProdName;//房屋名称


@end
