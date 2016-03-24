//
//  UpFaceView.h
//  Code_
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 lansi All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"

@interface UpFaceView : UIView

@property (nonatomic,retain)UIView *blackView;
@property(nonatomic,retain)UIView * whiteView;
@property(nonatomic,retain)UIButton *LocalFaceBut;
@property(nonatomic,retain)UIButton *TakeFaceBut;
@property(nonatomic,retain)UIButton *CancelBut;

- (void)showAsDrawDownView:(UIView*) view;
@end
