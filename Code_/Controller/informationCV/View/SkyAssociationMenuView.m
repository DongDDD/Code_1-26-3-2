//
//  SkyAssociationMenuView.m
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "SkyAssociationMenuView.h"
#import "informationViewController.h"



NSString *const IDENTIFIER = @"CELL";

@interface SkyAssociationMenuView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSArray *tables;
    UIView *bgView;
}
@end

@implementation SkyAssociationMenuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化选择项
        for(int i=0; i!=3; ++i) {
            sels[i] = -1;
        }
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.userInteractionEnabled = YES;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0,ScreenWidth, 44*ScreenWidth/375);
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        //cancelBtn.backgroundColor = [UIColor redColor];
        
        // 初始化菜单
        tables = @[[[UITableView alloc] init], [[UITableView alloc] init], [[UITableView alloc] init] ];
        [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
            [table registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER ];
            table.dataSource = self;
            table.delegate = self;
            table.frame = CGRectMake(0, 0, 0, 0);
            table.backgroundColor = [UIColor clearColor];
            table.tableFooterView = [UIView new];
        }];
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.userInteractionEnabled = YES;
        
        [bgView addSubview:[tables objectAtIndex:0]];
        
        [self SetView];
        
        NSLog(@"sssssssssss%@",_dict);
        
    }
    return self;
}

- (void)SetView{
    self.viewV = [[UIView alloc]init];
    self.viewV.frame = CGRectMake(0, ScreenHight-174*ScreenWidth/375, ScreenWidth, 110*ScreenWidth/375);
    self.viewV.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewV];
    
    self.label = [[UILabel alloc]init];
    self.label.frame = CGRectMake(17.5*ScreenWidth/375, 8*ScreenWidth/375,ScreenWidth-35*ScreenWidth/375, 38*ScreenWidth/375);
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.text = self.dict[@"FullName"];
    self.label.layer.borderWidth = 1;
    self.label.layer.borderColor = [[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1]CGColor];
    [self.viewV addSubview:self.label];
    
    self.AreaView=[[UIView alloc]init];
    self.AreaView.frame=CGRectMake(0, 55*SCREEN_WIDTH/375, SCREEN_WIDTH, 50*SCREEN_WIDTH/375);
    self.AreaView.backgroundColor=[UIColor whiteColor];
    [self.viewV addSubview:self.AreaView];
    
//    UIView *saiView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//    saiView.backgroundColor=[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6];
//    [self.AreaView addSubview:saiView];
    
    self.quxiaoBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.quxiaoBut.frame=CGRectMake(17.5*ScreenWidth/375, 0,152.5*ScreenWidth/375, 38*ScreenWidth/375);
    self.quxiaoBut.backgroundColor=[UIColor whiteColor];
    self.quxiaoBut.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.quxiaoBut setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.quxiaoBut setTitle:@"取消" forState:UIControlStateNormal];
    self.quxiaoBut.layer.borderWidth=1;
    self.quxiaoBut.layer.borderColor=[[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.6]CGColor];
    [self.AreaView addSubview:self.quxiaoBut];
    
    self.OKBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.OKBut.frame=CGRectMake(205*ScreenWidth/375, 0,152.5*ScreenWidth/375, 38*ScreenWidth/375);
    self.OKBut.backgroundColor=[UIColor whiteColor];
    self.OKBut.titleLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    [self.OKBut setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.OKBut setTitle:@"确定" forState:UIControlStateNormal];
    self.OKBut.layer.borderWidth=1;
    self.OKBut.layer.borderColor=[[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1]CGColor];
    [self.AreaView addSubview:self.OKBut];
    
    
    
    
}

#pragma mark private
/**
 *  调整表视图的位置、大小
 */
- (void)adjustTableViews{
    int w = SCREEN_WIDTH;
    int __block showTableCount = 0;
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        CGRect rect = t.frame;
        rect.size.height = SCREEN_HEIGHT - bgView.frame.origin.y-200*ScreenWidth/375;
        t.frame = rect;
        if(t.superview)
            ++showTableCount;
    }];
    
    for(int i=0; i!=showTableCount; ++i){
        UITableView *t = [tables objectAtIndex:i];
        CGRect f = t.frame;
        f.size.width = w / showTableCount;
        f.origin.x = f.size.width * i;
        t.frame = f;
    }
}
/**
 *  取消选择按钮
 */
- (void)cancel{
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(assciationMenuViewCancel)]) {
        [self.delegate assciationMenuViewCancel];
    }
}

/**
 *  保存table选中项
 */
- (void)saveSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        sels[idx] = t.superview ? t.indexPathForSelectedRow.row : -1;
    }];
}

/**
 *  加载保存的选中项
 */
- (void)loadSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger i, BOOL *stop) {
        [t selectRowAtIndexPath:[NSIndexPath indexPathForRow:sels[i] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        if((sels[i] != -1 && !t.superview) || !i) {
            [bgView addSubview:t];
        }
    }];
}

#pragma mark public
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 {
    sels[0] = idx_1;
    sels[1] = idx_2;
    sels[2] = idx_3;
}


- (void)setView:(UIView *) view{
    CGFloat x = 0.f;
    CGFloat y = 44*ScreenWidth/375;
    CGFloat w = SCREEN_WIDTH;
    CGFloat h = SCREEN_HEIGHT-y-174*ScreenWidth/375;
    bgView.frame = CGRectMake(x, y, w, h);
    
    if(!bgView.superview) {
        [self addSubview:bgView];
    }
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.alpha = 1.0f;
    }
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
    
    //[bgView addSubview:self.viewV];
}

/**
 *  隐藏菜单
 */
- (void)dismiss{
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            [self removeFromSuperview];
        }];
    }
    
}

#pragma mark UITableViewDateSourceDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if(tableView == [tables objectAtIndex:0]){
        //一级
        
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:self.TownArray[indexPath.row]];
        
        NSLog(@"hhhhhhhhh%ld",indexPath.row);
        // NSLog(@"yyyyyyyyy%@",self.CityArray[indexPath.row]);
        
    }else if(tableView == [tables objectAtIndex:1]){
        //二级
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_2:self.CountryArray[indexPath.row]];
        
    }else if(tableView == [tables objectAtIndex:2]){
        
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_3:self.XiangcunArray[indexPath.row]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger __block count;
    [tables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == tableView) {
            count = [_delegate assciationMenuView:self countForClass:idx];
            *stop = YES;
            NSLog(@"-----------------%ld",count);
            
        }
    }];
    
    
    return count;
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1 = [tables objectAtIndex:1];
    UITableView *t2 = [tables objectAtIndex:2];
    BOOL isNexClass = true;
    if(tableView == t0){
        
        self.dict = self.TownArray[indexPath.row];
        self.label.text = self.FullNameArray1[indexPath.row];
        self.AreaWBS = self.AreaWBSArray1[indexPath.row];
        NSLog(@"1ppppp%@",self.AreaWBS);
        NSLog(@"ppppp点击的是%@",self.FullNameArray1[indexPath.row]);
        
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
        }
        if(isNexClass) {
            [t1 reloadData];
            if(!t1.superview) {
                [bgView addSubview:t1];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self adjustTableViews];
        }else{
            if(t1.superview) {
                [t1 removeFromSuperview];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self saveSels];
            [self dismiss];
        }
    }else if(tableView == t1) {
        self.dict = self.CountryArray[indexPath.row];
        self.label.text = self.FullNameArray2[indexPath.row];
        self.AreaWBS = self.AreaWBSArray2[indexPath.row];
         NSLog(@"2ppppp%@",self.AreaWBS);
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
        }
        if(isNexClass){
            [t2 reloadData];
            if(!t2.superview) {
                [bgView addSubview:t2];
            }
            [self adjustTableViews];
        }else{
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self saveSels];
            [self dismiss];
        }
    }else if(tableView == t2) {
        self.dict = self.XiangcunArray[indexPath.row];
        self.label.text = self.FullNameArray3[indexPath.row];
        self.AreaWBS = self.AreaWBSArray3[indexPath.row];
        NSLog(@"3ppppp%@",self.AreaWBS);
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:indexPath.row];
        }
        if(isNexClass) {
            [self saveSels];
            //[self dismiss];
        }
    }
}

@end
