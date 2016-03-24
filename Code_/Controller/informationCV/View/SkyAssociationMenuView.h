//
//  SkyAssociationMenuView.h
//  iOSTest
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) // 获取屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) // 获取屏幕高度

@class SkyAssociationMenuView;

@protocol SkyAssociationMenuViewDelegate <NSObject>
/**
 *  获取第class级菜单的数据数量
 *
 *  @param asView 联想菜单
 *  @param idx    第几级
 *
 *  @return 第class级菜单的数据数量
 */
- (NSInteger)assciationMenuView:(SkyAssociationMenuView*)asView countForClass:(NSInteger)idx;

/**
 *  获取第一级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSString *)idx_1;

/**
 *  获取第二级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_2:(NSString *)idx_2;

/**
 *  获取第三级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_3:(NSString *)idx_3;
@optional
/**
 *  取消选择
 */
- (void)assciationMenuViewCancel;

/**
 *  选择第一级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(SkyAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1;
/**
 *  选择第二级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(SkyAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2;
/**
 *  选择第三级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 是否dismiss
 */
- (BOOL)assciationMenuView:(SkyAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
@end

/**
 *  三级联动菜单
 */
@interface SkyAssociationMenuView : UIView{
@private
    NSInteger sels[3];
}
extern __strong NSString *const IDENTIFIER;
@property (weak,nonatomic) id<SkyAssociationMenuViewDelegate> delegate;
/**
 *  设置选中项，-1为未选中
 *
 *  @param idx_1  第一级选中项
 *  @param idx_2  第二级选中项
 *  @param idx_3  第三级选中项
 */
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
/**
 *  菜单显示在View的下面
 *
 *  @param view 显示在该view下
 */
- (void)showAsDrawDownView:(UIView*) view;
- (void)setView:(UIView *) view;
/**
 *  隐藏菜单
 */
- (void)dismiss;

@property (nonatomic,retain) UIView *viewV;
@property (nonatomic,retain) UIView *AreaView;
@property (nonatomic,retain) UIView *SelectedView;
@property (nonatomic,retain) UILabel *SelectedLable;
@property (nonatomic,retain) UIButton *quxiaoBut;
@property (nonatomic,retain) UIButton *OKBut;

@property (nonatomic,retain) NSMutableArray *CityArray;
@property (nonatomic,retain) NSMutableArray *TownArray;
@property (nonatomic,retain) NSMutableArray *CountryArray;
@property (nonatomic,retain) NSMutableArray *XiangcunArray;

@property (nonatomic,retain) NSMutableArray *FullNameArray1;
@property (nonatomic,retain) NSMutableArray *FullNameArray2;
@property (nonatomic,retain) NSMutableArray *FullNameArray3;
@property (nonatomic,retain) NSMutableArray *AreaWBSArray1;
@property (nonatomic,retain) NSMutableArray *AreaWBSArray2;
@property (nonatomic,retain) NSMutableArray *AreaWBSArray3;

@property (nonatomic,retain) NSString *AreaWBS;
//@property (nonatomic,retain) NSMutableArray *AreaWBSArrTwo;
//@property (nonatomic,retain) NSMutableArray *AreaWBSArrThree;

@property(nonatomic,strong)UILabel *label;//显示当前选择的地点
@property(nonatomic,strong)NSDictionary *dict;//传过来的城市dict;


@end
