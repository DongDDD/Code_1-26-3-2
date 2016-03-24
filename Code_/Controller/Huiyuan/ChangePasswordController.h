//
//  ChangePasswordController.h
//  Code_
//
//  Created by admin on 16/3/4.
//  Copyright © 2016年 lansi All rights reserved.
//

#import "MyViewController.h"

//@protocol ChangePassWordDeledate <NSObject>
//
//- (void)setNumber:(NSString *)str;
//- (void)setPassWord:(NSString *)str;
//
//@end


@interface ChangePasswordController : MyViewController

//@property(nonatomic,copy) id<ChangePassWordDeledate> delegate;



@property (nonatomic,retain) UIImageView *OldView;
@property (nonatomic,retain) UIImageView *NewView;
@property (nonatomic,retain) UIImageView *ConfirmView;

@property (nonatomic,retain) UITextField *OldPasswordField;
@property (nonatomic,retain) UITextField *NewPasswordField;
@property (nonatomic,retain) UITextField *ConfirmPasswordField;

@property (nonatomic,retain) UIImageView *LineView1;
@property (nonatomic,retain) UIImageView *LineView2;
@property (nonatomic,retain) UIImageView *LineView3;

//@property (nonatomic,retain) UITextField *CodeUITextField;
//@property (nonatomic,retain) UIButton *CodeBut;
@property (nonatomic,retain) UIButton *LoginBut;




@end
