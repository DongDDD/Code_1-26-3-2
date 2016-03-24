//
//  OrderlistSSTableViewController.h
//  Code_
//
//  Created by admin on 16/3/6.
//  Copyright © 2016年 东. All rights reserved.
//
#import "MyTableViewController.h"
#import <UIKit/UIKit.h>
#import "OrderlistModeSSS.h"


@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end

@interface OrderlistSSTableViewController : MyTableViewController

@property(nonatomic,copy)NSString *MembIdsStr;
@property(nonatomic,copy)NSString *OrderIdsStr;

//@property(nonatomic,retain) NSString *OrderNo;
//@property(nonatomic,retain) NSString *OrderState;
//@property(nonatomic,retain) NSString *OrderTotalPrice;
//@property(nonatomic,retain) NSString *ProdName;//房屋名称
@property(nonatomic,retain) OrderlistModeSSS *ordesss;
@property(nonatomic,retain) NSString *ordeStr;
@property(nonatomic,retain) NSString *ProdStr;

@end
