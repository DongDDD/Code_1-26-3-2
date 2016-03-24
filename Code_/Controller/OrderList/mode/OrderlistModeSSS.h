//
//  OrderlistModeSSS.h
//  Code_
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderlistModeSSS : NSObject

@property(nonatomic,retain) NSString * OrderNo;//订单ID
@property(nonatomic,assign) int OrderState;//订单状态，1待支付、2 已支付、-1已取消
@property(nonatomic,assign) float OrderTotalPrice;//支付金额

//@property(nonatomic,retain) NSString *ProdName;//房屋名称

@property(nonatomic,retain) NSString *CreateTime;//下单时间

@end
