//
//  JLDoubleSlider.m
//  JLDoubleSliderDemo
//
//  Created by linger on 16/1/13.
//  Copyright © 2016年 linger. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "JLDoubleSlider.h"
#import "UIView+Dimension.h"
static const CGFloat sliderOffY = 25.0f;
@interface JLDoubleSlider ()

@property (nonatomic,assign)CGFloat CurrentMinNum;

@property (nonatomic,assign)CGFloat CurrentMaxNum;

@end

@implementation JLDoubleSlider

{
    
    UIView *_minSliderLine;
    UIView *_maxSliderLine;
    UIView *_mainSliderLine;
    
    
    CGFloat _constOffY;
    
    CGFloat _tatol;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        if (frame.size.height < 80.0f*ScreenWidth/375) {
            self.height = 80.0f*ScreenWidth/375;
        }
        [self createMainView];
    }
    return self;
}

- (void)createMainView
{
    _minLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width/2.0f, 40*ScreenWidth/375)];
    _maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2.0f, 0 ,self.width/2.0f , 40*ScreenWidth/375)];
    _minLabel.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
     _maxLabel.textColor=[UIColor colorWithRed:240.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1];
     _maxLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    _minLabel.font=[UIFont systemFontOfSize:14*ScreenWidth/375];
    _minLabel.textAlignment = NSTextAlignmentRight;
    _maxLabel.textAlignment = NSTextAlignmentLeft;
    _minLabel.adjustsFontSizeToFitWidth = YES;
    _maxLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_minLabel];
    [self addSubview:_maxLabel];
    
    self.minNum = 0.0;
    self.maxNum = 0.0;
    self.unit = @"";
    
    _mainSliderLine = [[UIView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375,sliderOffY*ScreenWidth/375 + 20*ScreenWidth/375 - 2/2, self.width-20*ScreenWidth/375, 2*ScreenWidth/375)];
    _mainSliderLine.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_mainSliderLine];
    
    _minSliderLine = [[UIView alloc]initWithFrame:CGRectMake(10*ScreenWidth/375, _mainSliderLine.top, 0, _mainSliderLine.height)];
    _minSliderLine.backgroundColor = [UIColor yellowColor];
    [self addSubview:_minSliderLine];
    
    _maxSliderLine = [[UIView alloc]initWithFrame:CGRectMake(self.width-10*ScreenWidth/375, _mainSliderLine.top, 0, _mainSliderLine.height)];
    _maxSliderLine.backgroundColor = [UIColor yellowColor];
    [self addSubview:_maxSliderLine];
    
    UIButton *minSliderButton = [[UIButton alloc]initWithFrame:CGRectMake(0,sliderOffY*ScreenWidth/375 + 10*ScreenWidth/375, 20*ScreenWidth/375, 20*ScreenWidth/375)];
    minSliderButton.backgroundColor = [UIColor whiteColor];
    [minSliderButton setBackgroundImage:[UIImage imageNamed:@"seek_thumb_pressed"] forState:UIControlStateNormal];
    minSliderButton.showsTouchWhenHighlighted = YES;
    minSliderButton.layer.cornerRadius = minSliderButton.width/2.0f;
    minSliderButton.layer.masksToBounds = YES;
    minSliderButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    minSliderButton.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *minSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMinSliderButton:)];
    [minSliderButton addGestureRecognizer:minSliderButtonPanGestureRecognizer];
    [self addSubview:minSliderButton];
    _minSlider = minSliderButton;
    
    
    UIButton *maxSliderButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width-20*ScreenWidth/375, sliderOffY*ScreenWidth/375 + 10*ScreenWidth/375, 20*ScreenWidth/375, 20*ScreenWidth/375)];
    maxSliderButton.backgroundColor = [UIColor whiteColor];
    [maxSliderButton setBackgroundImage:[UIImage imageNamed:@"seek_thumb_pressed"] forState:UIControlStateNormal];
    maxSliderButton.showsTouchWhenHighlighted = YES;
    maxSliderButton.layer.cornerRadius = minSliderButton.width/2.0f;
    maxSliderButton.layer.masksToBounds = YES;
    maxSliderButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    maxSliderButton.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *maxSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMaxSliderButton:)];
    [maxSliderButton addGestureRecognizer:maxSliderButtonPanGestureRecognizer];
    [self addSubview:maxSliderButton];
    _maxSlider = maxSliderButton;
    _constOffY = _minSlider.centerY;
    
    
}

- (void)panMinSliderButton:(UIPanGestureRecognizer *)pgr
{
    CGPoint point = [pgr translationInView:self];
    static CGPoint center;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        center = pgr.view.center;
    }
    pgr.view.center = CGPointMake(center.x + point.x, center.y + point.y);
    pgr.view.centerY = _constOffY;
    
    
    if (pgr.view.right > _maxSlider.left) {
        pgr.view.right = _maxSlider.left;
    }else{
        if (pgr.view.centerX < 10) {
            pgr.view.centerX = 10;
        }
        if (pgr.view.centerX > self.width-10) {
            pgr.view.centerX = self.width-10;
        }
    }
    _minSliderLine.frame = CGRectMake(_minSliderLine.left, _minSliderLine.top,  pgr.view.centerX-_minSliderLine.left, _minSliderLine.height);
    [self valueMinChange:pgr.view.right];
}

- (void)panMaxSliderButton:(UIPanGestureRecognizer *)pgr
{
    CGPoint point = [pgr translationInView:self];
    static CGPoint center;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        center = pgr.view.center;
    }
    pgr.view.center = CGPointMake(center.x + point.x, center.y + point.y);
    pgr.view.centerY = _constOffY;
    
    if (pgr.view.left < _minSlider.right) {
        pgr.view.left = _minSlider.right;
    }else{
        if (pgr.view.centerX < 10) {
            pgr.view.centerX = 10;
        }
        if (pgr.view.centerX > self.width-10) {
            pgr.view.centerX = self.width-10;
        }
    }
    _maxSliderLine.frame = CGRectMake(pgr.view.centerX, _maxSliderLine.top, self.width-pgr.view.centerX-10, _maxSliderLine.height);
    [self valueMaxChange:pgr.view.left];
}

- (void)valueMinChange:(CGFloat)num
{
        _currentMinValue = _minNum + (_tatol * (num-20.0));
    if (_currentMaxValue==500&_currentMinValue==0) {
        _minLabel.text = @"不";
        _maxLabel.text = @"限";
    }else if (_currentMaxValue ==500&_currentMinValue !=0){
        _minLabel.text = [NSString stringWithFormat:@"%@%.f",_unit,_currentMinValue];
        _maxLabel.text = @"以上";
    }else if (_currentMaxValue !=500&_currentMinValue ==0){
        _minLabel.text = [NSString stringWithFormat:@"%@%.f",_unit,_currentMaxValue];
        _maxLabel.text = @"以下";
    }
    else{
        _minLabel.text = [NSString stringWithFormat:@"%@%.f",_unit,_currentMinValue];
        _maxLabel.text = [NSString stringWithFormat:@"－%@%.f",_unit,_currentMaxValue];
    }

}

- (void)valueMaxChange:(CGFloat)num
{
        _currentMaxValue = _minNum +(_tatol * (num-20.0));
    if (_currentMaxValue==500&_currentMinValue==0) {
        _minLabel.text = @"不";
        _maxLabel.text = @"限";
    }else if (_currentMaxValue !=500&_currentMinValue ==0){
        _minLabel.text = [NSString stringWithFormat:@"%@%.f",_unit,_currentMaxValue];
        _maxLabel.text = @"以下";
    }else if (_currentMaxValue ==500&_currentMinValue !=0){
        _minLabel.text = [NSString stringWithFormat:@"%@%.f",_unit,_currentMinValue];
        _maxLabel.text = @"以上";
    }
    else{
        _maxLabel.text = [NSString stringWithFormat:@"－%@%.f",_unit,_currentMaxValue];
        _minLabel.text = [NSString stringWithFormat:@"%@%.f",_unit,_currentMinValue];
    }
    
    
}


-(void)setMinNum:(CGFloat)minNum
{
    _minNum = minNum;
    _tatol = (_maxNum - _minNum)/(self.width - 40.0f);
    if (_tatol < 0) {
        _tatol = -_tatol;
    }
    _currentMinValue = minNum;
    if (_currentMinValue==0&_currentMaxValue==500) {
        _minLabel.text = @"不";
        _maxLabel.text = @"限";
    }else{
        _minLabel.text = [NSString stringWithFormat:@"%.f%@",minNum,_unit];
        
    }
    
}

-(void)setMaxNum:(CGFloat)maxNum
{
    _maxNum = maxNum;
    _tatol = (_maxNum - _minNum)/(self.width - 40.0f);
    if (_tatol < 0) {
        _tatol = -_tatol;
    }
    _currentMaxValue = maxNum;
    if (_currentMinValue==0&_currentMaxValue==500) {
        _minLabel.text = @"不";
        _maxLabel.text = @"限";
    }else{
        _maxLabel.text = [NSString stringWithFormat:@"－%.f%@",maxNum,_unit];
        
    }
}



-(void)setMinTintColor:(UIColor *)minTintColor
{
    _minTintColor = minTintColor;
    _minSliderLine.backgroundColor = minTintColor;
}

-(void)setMaxTintColor:(UIColor *)maxTintColor
{
    _maxTintColor = maxTintColor;
    _maxSliderLine.backgroundColor = maxTintColor;
}

-(void)setMainTintColor:(UIColor *)mainTintColor
{
    _mainTintColor = mainTintColor;
    _mainSliderLine.backgroundColor = mainTintColor;
}

-(void)setUnit:(NSString *)unit
{
    _unit = unit;
}



@end
