//
//  GouwucheTableViewCell.h
//  Code_
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 东. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置返回选择商品的协议
@protocol xuanzeShangpinDelegate <NSObject>
/*
 返回修改后选择的商品信息，第几个，是否选中要不要提交
 */
-(void)fanhuiXuanzeDeShangpin:(NSDictionary *)dict withTag:(NSInteger)tag withButtonSelected:(BOOL)selected;
-(void)xiugaiShuliang:(NSDictionary *)dict withTag:(NSInteger)tag  withButtonSelected:(BOOL)selected;
@end


@interface GouwucheTableViewCell : UITableViewCell

//协议
@property(nonatomic,weak)id <xuanzeShangpinDelegate>delegate;


@property (nonatomic,assign)BOOL quanxuanButtonSelected;//是否全选
@property (nonatomic,assign)float bili;//当前比例
@property (nonatomic,assign)float danjia;//商品单价
@property (nonatomic,assign)float shuliang;//选择的数量
@property (nonatomic,assign)NSInteger indexPathRow;//数组的下标
@property (nonatomic,strong)NSDictionary *dict;//cell要显示的数据
@property (nonatomic,assign)BOOL xuanze;//是否选择商品


@property (weak, nonatomic) IBOutlet UIButton *duoxuanButton;//点击选择商品的按钮
@property (weak, nonatomic) IBOutlet UILabel *jiaqianLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *jiajianSegmented;



-(void)setTheCell:(NSDictionary *)dict;

@end
