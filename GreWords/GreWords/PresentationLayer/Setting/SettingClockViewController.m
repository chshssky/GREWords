//
//  SettingClockViewController.m
//  GreWords
//
//  Created by Song on 13-6-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SettingClockViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate-Utilities.h"

@interface SettingClockViewController ()
@property(nonatomic) UIImageView *FimageView;
@property(nonatomic) UIImageView *SimageView;
@property(nonatomic) UIImageView *PimageView;
@property(nonatomic) UIImageView *CimageView;
@property(nonatomic) UIImageView *N1_imageView;
@property(nonatomic) UIImageView *N2_imageView;
@property(nonatomic) UIImageView *N3_imageView;
@property(nonatomic) UIImageView *N4_imageView;
@property(nonatomic) UIImageView *N5_imageView;
@property(nonatomic) UIImageView *N6_imageView;
@property(nonatomic) UIImageView *N7_imageView;
@property(nonatomic) UIImageView *N8_imageView;
@property(nonatomic) UIImageView *N9_imageView;
@property(nonatomic) UIImageView *N10_imageView;
@property(nonatomic) UIImageView *N11_imageView;
@property(nonatomic) UIImageView *N12_imageView;
@property(nonatomic) UIImageView *AM;
@property(nonatomic) UIImageView *PM;

@property(nonatomic) CGPoint centerPoint;
@property(nonatomic) float radio_f;
@property(nonatomic) float len_f;
@property(nonatomic) float radio_s;
@property(nonatomic) float len_s;
@property(nonatomic) int touchPointX;
@property(nonatomic) int touchPointY;
@property(nonatomic) int movePointX;
@property(nonatomic) int movePointY;
@property(nonatomic) bool whetherPlusHour;
@property(nonatomic) bool whetherMinusHour;


@property(nonatomic) int minute;
@property(nonatomic) int temp_minute;
@property(nonatomic) int hour;



@property(nonatomic) int time;
@property(nonatomic) int minTime;
@property(nonatomic) BOOL whetherSetTimeToMinTime;
@end

@implementation SettingClockViewController

- (void)setTime:(int)time
{
    if (time <= 1440 && time >= 0) {
        _time = time;
    }else{
        _time = 0;
    }
}

- (int)getTime
{
    return _time;
}

-(void)setAlertTime:(NSDate*)date
{
    [self setTime: date.hour*60 + date.minute];
}
-(void)setStartTime:(NSDate*)date
{
    self.minTime =  date.hour*60 + date.minute;
    
    if (_minTime > _time) {
        _whetherSetTimeToMinTime = YES;
    }
    
    if (_whetherSetTimeToMinTime == YES) {
        [self.delegate clock:self timeEndChange:date];
        int difference = _minTime - _time;
        int difference_hour = floor(difference/60);
        int difference_minute = fmod(difference, 60);
        
        float difference_radioOfMinute = (float)difference_minute/60.0*2*M_PI + difference_hour*M_PI*2;
        float difference_radioOfHour = (float)difference_hour/12.0*2*M_PI + (float)difference_minute/60.0*M_PI/6;
        
        _time = _minTime;
        _minute = fmod(_time, 60);
        _hour = floor(_time/60);
        _radio_f = (float)_minute/60.0*2*M_PI;
        _radio_s = (float)_hour/12.0*2*M_PI + (float)_minute/60.0*M_PI/6;
        _whetherPlusHour = NO;
        _whetherMinusHour = NO;
        _whetherSetTimeToMinTime = NO;
        
        
        [self minuteHandAnimationChangeBackFrom:_radio_f-difference_radioOfMinute to:_radio_f];
        [self hourHandAnimationChangeBackFrom:_radio_s-difference_radioOfHour to:_radio_s];
        self.FimageView.transform = CGAffineTransformMakeRotation(_radio_f);
        self.SimageView.transform = CGAffineTransformMakeRotation(_radio_s);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.time = 1020;
    //数据初始化
    //self.minTime = 425;
    _minute = fmod(_time, 60);
    _hour = floor(_time/60);
    
    _radio_f = (float)_minute/60.0*2*M_PI;
    _len_f = 150;
    _centerPoint = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);;
    _radio_s = (float)_hour/12.0*2*M_PI + (float)_minute/60.0*M_PI/6;
    _len_s = 90;
    _whetherPlusHour = NO;
    _whetherMinusHour = NO;
    _whetherSetTimeToMinTime = NO;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    //添加背景图片
    [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]];
    
    //添加时钟数字
    
    if (_whetherRecite == YES) {
        UIImage *N1 = [UIImage imageNamed:@"Settings_taskClock_1.png"];
        self.N1_imageView = [[UIImageView alloc] initWithImage:N1];
        self.N1_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+55, _centerPoint.y-95);
        self.N1_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N1_imageView];
        UIImage *N2 = [UIImage imageNamed:@"Settings_taskClock_2.png"];
        self.N2_imageView = [[UIImageView alloc] initWithImage:N2];
        self.N2_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+105, _centerPoint.y-65);
        self.N2_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N2_imageView];
        UIImage *N3 = [UIImage imageNamed:@"Settings_taskClock_3.png"];
        self.N3_imageView = [[UIImageView alloc] initWithImage:N3];
        self.N3_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+123, _centerPoint.y);
        self.N3_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N3_imageView];
        UIImage *N4 = [UIImage imageNamed:@"Settings_taskClock_4.png"];
        self.N4_imageView = [[UIImageView alloc] initWithImage:N4];
        self.N4_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+100, _centerPoint.y+62);
        self.N4_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N4_imageView];
        UIImage *N5 = [UIImage imageNamed:@"Settings_taskClock_5.png"];
        self.N5_imageView = [[UIImageView alloc] initWithImage:N5];
        self.N5_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+58, _centerPoint.y+105);
        self.N5_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N5_imageView];
        UIImage *N6 = [UIImage imageNamed:@"Settings_taskClock_6.png"];
        self.N6_imageView = [[UIImageView alloc] initWithImage:N6];
        self.N6_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x, _centerPoint.y+120);
        self.N6_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N6_imageView];
        UIImage *N7 = [UIImage imageNamed:@"Settings_taskClock_7.png"];
        self.N7_imageView = [[UIImageView alloc] initWithImage:N7];
        self.N7_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-60, _centerPoint.y+112);
        self.N7_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N7_imageView];
        UIImage *N8 = [UIImage imageNamed:@"Settings_taskClock_8.png"];
        self.N8_imageView = [[UIImageView alloc] initWithImage:N8];
        self.N8_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-100, _centerPoint.y+62);
        self.N8_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N8_imageView];
        UIImage *N9 = [UIImage imageNamed:@"Settings_taskClock_9.png"];
        self.N9_imageView = [[UIImageView alloc] initWithImage:N9];
        self.N9_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-130, _centerPoint.y);
        self.N9_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N9_imageView];
        UIImage *N10 = [UIImage imageNamed:@"Settings_taskClock_10.png"];
        self.N10_imageView = [[UIImageView alloc] initWithImage:N10];
        self.N10_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-115, _centerPoint.y-68);
        self.N10_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N10_imageView];
        UIImage *N11 = [UIImage imageNamed:@"Settings_taskClock_11.png"];
        self.N11_imageView = [[UIImageView alloc] initWithImage:N11];
        self.N11_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-55, _centerPoint.y-98);
        self.N11_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N11_imageView];
        UIImage *N12 = [UIImage imageNamed:@"Settings_taskClock_12.png"];
        self.N12_imageView = [[UIImageView alloc] initWithImage:N12];
        self.N12_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x, _centerPoint.y-117);
        self.N12_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N12_imageView];
        
        
        //添加钟盘图片并消除锯齿
        UIImage *clockCircle = [UIImage imageNamed:@"Settings_taskClock_circle.png"];
        self.CimageView = [[UIImageView alloc] initWithImage:clockCircle];
        self.CimageView.center = _centerPoint;
        self.CimageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        //self.CimageView.alpha = 0.5;
        [self.view addSubview:self.CimageView];
        
        
    }else {
        
        UIImage *N1 = [UIImage imageNamed:@"Settings_task2Clock_1.png"];
        self.N1_imageView = [[UIImageView alloc] initWithImage:N1];
        self.N1_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+55, _centerPoint.y-95);
        self.N1_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N1_imageView];
        UIImage *N2 = [UIImage imageNamed:@"Settings_task2Clock_2.png"];
        self.N2_imageView = [[UIImageView alloc] initWithImage:N2];
        self.N2_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+105, _centerPoint.y-65);
        self.N2_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N2_imageView];
        UIImage *N3 = [UIImage imageNamed:@"Settings_task2Clock_3.png"];
        self.N3_imageView = [[UIImageView alloc] initWithImage:N3];
        self.N3_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+123, _centerPoint.y);
        self.N3_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N3_imageView];
        UIImage *N4 = [UIImage imageNamed:@"Settings_task2Clock_4.png"];
        self.N4_imageView = [[UIImageView alloc] initWithImage:N4];
        self.N4_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+100, _centerPoint.y+62);
        self.N4_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N4_imageView];
        UIImage *N5 = [UIImage imageNamed:@"Settings_task2Clock_5.png"];
        self.N5_imageView = [[UIImageView alloc] initWithImage:N5];
        self.N5_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x+58, _centerPoint.y+105);
        self.N5_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N5_imageView];
        UIImage *N6 = [UIImage imageNamed:@"Settings_task2Clock_6.png"];
        self.N6_imageView = [[UIImageView alloc] initWithImage:N6];
        self.N6_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x, _centerPoint.y+120);
        self.N6_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N6_imageView];
        UIImage *N7 = [UIImage imageNamed:@"Settings_task2Clock_7.png"];
        self.N7_imageView = [[UIImageView alloc] initWithImage:N7];
        self.N7_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-60, _centerPoint.y+112);
        self.N7_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N7_imageView];
        UIImage *N8 = [UIImage imageNamed:@"Settings_task2Clock_8.png"];
        self.N8_imageView = [[UIImageView alloc] initWithImage:N8];
        self.N8_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-100, _centerPoint.y+62);
        self.N8_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N8_imageView];
        UIImage *N9 = [UIImage imageNamed:@"Settings_task2Clock_9.png"];
        self.N9_imageView = [[UIImageView alloc] initWithImage:N9];
        self.N9_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-130, _centerPoint.y);
        self.N9_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N9_imageView];
        UIImage *N10 = [UIImage imageNamed:@"Settings_task2Clock_10.png"];
        self.N10_imageView = [[UIImageView alloc] initWithImage:N10];
        self.N10_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-115, _centerPoint.y-68);
        self.N10_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N10_imageView];
        UIImage *N11 = [UIImage imageNamed:@"Settings_task2Clock_11.png"];
        self.N11_imageView = [[UIImageView alloc] initWithImage:N11];
        self.N11_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x-55, _centerPoint.y-98);
        self.N11_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N11_imageView];
        UIImage *N12 = [UIImage imageNamed:@"Settings_task2Clock_12.png"];
        self.N12_imageView = [[UIImageView alloc] initWithImage:N12];
        self.N12_imageView.center = _centerPoint;// CGPointMake(_centerPoint.x, _centerPoint.y-117);
        self.N12_imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.view addSubview:self.N12_imageView];
        
        
        //添加钟盘图片并消除锯齿
        UIImage *clockCircle = [UIImage imageNamed:@"Settings_task2Clock_circle.png"];
        self.CimageView = [[UIImageView alloc] initWithImage:clockCircle];
        self.CimageView.center = _centerPoint;
        self.CimageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        //self.CimageView.alpha = 0.5;
        [self.view addSubview:self.CimageView];
    }
    
    //添加AM和PM
    _AM = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Settings_taskClock_AM.png"]];
    _AM.center = CGPointMake(_centerPoint.x, _centerPoint.y+44.0);
    [self.view addSubview:_AM];
    _PM = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Settings_taskClock_PM.png"]];
    [self.view addSubview:_PM];
    _PM.center = CGPointMake(_centerPoint.x, _centerPoint.y+44.0);
    if (_time >= 720) {
        _AM.alpha=0;
        _PM.alpha=1;
    }else {
        _AM.alpha=1;
        _PM.alpha=0;
    }
    
    
    //添加时针图片并消除锯齿
    UIImage *imageS = [UIImage imageNamed:@"Settings_taskClock_hourHand.png"];
    self.SimageView = [[UIImageView alloc] initWithImage:imageS];
    self.SimageView.center = _centerPoint;
    self.SimageView.layer.anchorPoint = CGPointMake(0.5, 0.92);
    [self.view addSubview:self.SimageView];
    
    //添加分针图片并消除锯齿
    UIImage *imageF = [UIImage imageNamed:@"Settings_taskClock_minuteHand.png"];
    self.FimageView = [[UIImageView alloc] initWithImage:imageF];
    self.FimageView.center = _centerPoint;
    self.FimageView.layer.anchorPoint = CGPointMake(0.5, 0.78);
    [self.view addSubview:self.FimageView];
    
    
    //添加中心点图片并消除锯齿
    UIImage *clockPoint = [UIImage imageNamed:@"Settings_taskClock_pointer.png"];
    self.PimageView = [[UIImageView alloc] initWithImage:clockPoint];
    self.PimageView.center = _centerPoint;
    self.PimageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.view addSubview:self.PimageView];
    
    
    [self AMPMAnimation];
    [self circleAnimation];
    [self numberLineAnimation];
    [self minuteHandAnimation];
    [self hourHandAnimation];
    [self performSelector:@selector(setGesture) withObject:nil afterDelay:2.5f];
    
}
- (void)setGesture
{
    UILongPressGestureRecognizer *gestureRecognizerF = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleF:)];
    [self.FimageView addGestureRecognizer:gestureRecognizerF];
    self.FimageView.userInteractionEnabled = YES;
    gestureRecognizerF.minimumPressDuration=0;
    
    self.FimageView.transform = CGAffineTransformMakeRotation(_radio_f);
    self.SimageView.transform = CGAffineTransformMakeRotation(_radio_s);
}

- (void) minuteHandAnimationChangeBackFrom:(float)startRad to:(float)endRad
{
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.fromValue = [NSNumber numberWithFloat:startRad];
    circleAnimation.toValue = [NSNumber numberWithFloat:endRad];
    
    CAAnimationGroup *minuteHandeAnimation = [CAAnimationGroup animation];
    minuteHandeAnimation.animations = [NSArray arrayWithObjects:circleAnimation, nil];
    minuteHandeAnimation.duration = 2.5f;
    minuteHandeAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :1.0 :0.0 :1.0];
    [self.FimageView.layer addAnimation:minuteHandeAnimation forKey:@"shakeAnimation"];
}

- (void) hourHandAnimationChangeBackFrom:(float)startRad to:(float)endRad
{
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.fromValue = [NSNumber numberWithFloat:startRad];
    circleAnimation.toValue = [NSNumber numberWithFloat:endRad];
    
    CAAnimationGroup *minuteHandeAnimation = [CAAnimationGroup animation];
    minuteHandeAnimation.animations = [NSArray arrayWithObjects:circleAnimation, nil];
    minuteHandeAnimation.duration = 2.5f;
    minuteHandeAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :1.0 :0.0 :1.0];
    [self.SimageView.layer addAnimation:minuteHandeAnimation forKey:@"shakeAnimation"];
}

- (void) AMPMAnimation
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1.0)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnimation.duration = 0.6f;
    scaleAnimation.beginTime = CACurrentMediaTime();
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeBackwards;
    [self.AM.layer addAnimation:scaleAnimation forKey:nil];
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1.0)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnimation.duration = 0.6f;
    scaleAnimation.beginTime = CACurrentMediaTime();
    scaleAnimation.fillMode = kCAFillModeBackwards;
    scaleAnimation.removedOnCompletion = YES;
    [self.PM.layer addAnimation:scaleAnimation forKey:nil];
}

- (void) minuteHandAnimation
{
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.fromValue = [NSNumber numberWithFloat:_radio_f-4*M_PI];
    circleAnimation.toValue = [NSNumber numberWithFloat:_radio_f];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1];
    
    CAAnimationGroup *minuteHandeAnimation = [CAAnimationGroup animation];
    minuteHandeAnimation.animations = [NSArray arrayWithObjects:circleAnimation, opacityAnimation, nil];
    minuteHandeAnimation.duration = 2.5f;
    minuteHandeAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :1.0 :0.0 :1.0];
    [self.FimageView.layer addAnimation:minuteHandeAnimation forKey:@"shakeAnimation"];
    
    self.FimageView.transform = CGAffineTransformMakeRotation(_radio_f);
}

- (void) hourHandAnimation
{
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.fromValue = [NSNumber numberWithFloat:_radio_s-4*M_PI/12];
    circleAnimation.toValue = [NSNumber numberWithFloat:_radio_s];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1];
    
    CAAnimationGroup *minuteHandeAnimation = [CAAnimationGroup animation];
    minuteHandeAnimation.animations = [NSArray arrayWithObjects:circleAnimation, opacityAnimation, nil];
    minuteHandeAnimation.duration = 2.5f;
    minuteHandeAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :1.0 :0.0 :1.0];
    [self.SimageView.layer addAnimation:minuteHandeAnimation forKey:@"shakeAnimation"];
    
    self.SimageView.transform = CGAffineTransformMakeRotation(_radio_s);
}

- (void) circleAnimation
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.duration = 0.6f;
    [self.CimageView.layer addAnimation:scaleAnimation forKey:nil];
}

- (void) numberLineAnimation
{
    CAKeyframeAnimation *lineAnimation;
    CGMutablePathRef path;
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6), _centerPoint.y+100*sin(M_PI/6));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6), _centerPoint.y+80*sin(M_PI/6));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6), _centerPoint.y+85*sin(M_PI/6));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.3/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N4_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 2), _centerPoint.y+100*sin(M_PI/6 * 2));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 2), _centerPoint.y+80*sin(M_PI/6 * 2));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 2), _centerPoint.y+85*sin(M_PI/6 * 2));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.4/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N5_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 3), _centerPoint.y+100*sin(M_PI/6 * 3));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 3), _centerPoint.y+80*sin(M_PI/6 * 3));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 3), _centerPoint.y+85*sin(M_PI/6 * 3));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.5/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N6_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 4), _centerPoint.y+100*sin(M_PI/6 * 4));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 4), _centerPoint.y+80*sin(M_PI/6 * 4));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 4), _centerPoint.y+85*sin(M_PI/6 * 4));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.6/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N7_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 5), _centerPoint.y+100*sin(M_PI/6 * 5));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 5), _centerPoint.y+80*sin(M_PI/6 * 5));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 5), _centerPoint.y+85*sin(M_PI/6 * 5));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.7/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N8_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 6), _centerPoint.y+100*sin(M_PI/6 * 6));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 6), _centerPoint.y+80*sin(M_PI/6 * 6));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 6), _centerPoint.y+85*sin(M_PI/6 * 6));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.8/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N9_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 7), _centerPoint.y+100*sin(M_PI/6 * 7));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 7), _centerPoint.y+80*sin(M_PI/6 * 7));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 7), _centerPoint.y+85*sin(M_PI/6 * 7));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.9/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N10_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 8), _centerPoint.y+100*sin(M_PI/6 * 8));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 8), _centerPoint.y+80*sin(M_PI/6 * 8));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 8), _centerPoint.y+85*sin(M_PI/6 * 8));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 1.0/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N11_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 9), _centerPoint.y+100*sin(M_PI/6 * 9));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 9), _centerPoint.y+80*sin(M_PI/6 * 9));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 9), _centerPoint.y+85*sin(M_PI/6 * 9));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 1.1/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N12_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 10), _centerPoint.y+100*sin(M_PI/6 * 10));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 10), _centerPoint.y+80*sin(M_PI/6 * 10));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 10), _centerPoint.y+85*sin(M_PI/6 * 10));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N1_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 11), _centerPoint.y+100*sin(M_PI/6 * 11));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 11), _centerPoint.y+80*sin(M_PI/6 * 11));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 11), _centerPoint.y+85*sin(M_PI/6 * 11));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.1/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N2_imageView.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _centerPoint.x, _centerPoint.y);
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+100*cos(M_PI/6 * 12), _centerPoint.y+100*sin(M_PI/6 * 12));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+80*cos(M_PI/6 * 12), _centerPoint.y+80*sin(M_PI/6 * 12));
    CGPathAddLineToPoint(path, NULL, _centerPoint.x+85*cos(M_PI/6 * 12), _centerPoint.y+85*sin(M_PI/6 * 12));
    lineAnimation.path = path;
    CGPathRelease(path);
    
    lineAnimation.duration = 1.0f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime() + 0.2/2;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.N3_imageView.layer addAnimation:lineAnimation forKey:nil];
    
}

- (void) numberHitAnimationWithNumber:(int)i
{
    if (_whetherSetTimeToMinTime == YES) {
        return;
    }
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1.0)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnimation.duration = 0.2f;
    if ( i==1 || i==13 ) {
        [self.N1_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==2 || i==14 ) {
        [self.N2_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==3 || i==15  ) {
        [self.N3_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==4 || i==16  ) {
        [self.N4_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==5 || i==17  ) {
        [self.N5_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==6 || i==18  ) {
        [self.N6_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==7 || i==19  ) {
        [self.N7_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==8 || i==20  ) {
        [self.N8_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==9 || i==21  ) {
        [self.N9_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==10 || i==22  ) {
        [self.N10_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else if ( i==11 || i==23  ) {
        [self.N11_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }else {
        [self.N12_imageView.layer addAnimation:scaleAnimation forKey:nil];
    }
    
}

- (void)handleF:(UILongPressGestureRecognizer *)recognizer
{
    
    if (recognizer.state ==
        UIGestureRecognizerStateBegan) {
        //NSLog(@"UIGestureRecognizerStateBegan");
    }
    if (recognizer.state ==
        UIGestureRecognizerStateChanged) {
        //NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (_whetherSetTimeToMinTime == YES) {
            
            int difference = _minTime - _time;
            int difference_hour = floor(difference/60);
            int difference_minute = fmod(difference, 60);
            
            float difference_radioOfMinute = (float)difference_minute/60.0*2*M_PI + difference_hour*M_PI*2;
            float difference_radioOfHour = (float)difference_hour/12.0*2*M_PI + (float)difference_minute/60.0*M_PI/6;
            
            _time = _minTime;
            _minute = fmod(_time, 60);
            _hour = floor(_time/60);
            _radio_f = (float)_minute/60.0*2*M_PI;
            _radio_s = (float)_hour/12.0*2*M_PI + (float)_minute/60.0*M_PI/6;
            _whetherPlusHour = NO;
            _whetherMinusHour = NO;
            _whetherSetTimeToMinTime = NO;
            
            
            [self minuteHandAnimationChangeBackFrom:_radio_f-difference_radioOfMinute to:_radio_f];
            [self hourHandAnimationChangeBackFrom:_radio_s-difference_radioOfHour to:_radio_s];
            
        }
    }
    
    
    CGPoint movePoint = [recognizer locationInView:self.view];
    
    CGPoint startPoint = CGPointMake(_centerPoint.x,
                                     0);
    CGPoint endPoint = CGPointMake(movePoint.x, movePoint.y);
    
    CGFloat rads;
    if (endPoint.x>_centerPoint.x && endPoint.y<_centerPoint.y) {
        rads = [self angleBetweenLine1Start:startPoint line1End:_centerPoint line2Start:endPoint line2End:_centerPoint];
    }else if (endPoint.x>_centerPoint.x && endPoint.y==_centerPoint.y){
        rads = M_PI/2;
    }else if (endPoint.x>_centerPoint.x && endPoint.y>_centerPoint.y){
        rads = M_PI - [self angleBetweenLine1Start:startPoint line1End:_centerPoint line2Start:endPoint line2End:_centerPoint];
    }else if (endPoint.x==_centerPoint.x && endPoint.y>_centerPoint.y){
        rads = M_PI;
    }else if (endPoint.x<_centerPoint.x && endPoint.y>_centerPoint.y){
        rads = M_PI + [self angleBetweenLine1Start:startPoint line1End:_centerPoint line2Start:endPoint line2End:_centerPoint];
    }else if (endPoint.x<_centerPoint.x && endPoint.y==_centerPoint.y){
        rads = M_PI/2*3;
    }else if (endPoint.x<_centerPoint.x && endPoint.y<_centerPoint.y){
        rads = M_PI*2 - [self angleBetweenLine1Start:startPoint line1End:_centerPoint line2Start:endPoint line2End:_centerPoint];
    }else {
        rads = M_PI*2;
    }
    
    [self calculateTime:rads];
    //控制分针转动
    self.FimageView.transform = CGAffineTransformMakeRotation(fmod(_time, 60)*2*M_PI/60);
    //控制时针转动
    self.SimageView.transform = CGAffineTransformMakeRotation(fmod(_time, 60)*2*M_PI/60/12 + floor(_time/60)*2*M_PI/12);
    
    
    //记录分针位置
    _radio_f = fmod(_time, 60)*2*M_PI/60;
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    [components setHour: _hour];
    [components setMinute: _minute];
    [components setSecond: 0];
    
    NSDate *newDate = [gregorian dateFromComponents: components];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self.delegate clock:self timeEndChange:newDate];
    }
    else
    {
        if(!_whetherSetTimeToMinTime)
            [self.delegate clock:self timeChanged:newDate];
    }
}

- (void)calculateTime:(float) rads
{
    if (_whetherPlusHour) {
        _minute = rads*180/M_PI/360*60;
        if (_temp_minute - _minute > 30) {
            if (_hour == 11) {
                _AM.alpha=0;
                _PM.alpha=1;
            }else if (_hour == 23) {
                _AM.alpha=1;
                _PM.alpha=0;
            }
            _hour ++;
            [self numberHitAnimationWithNumber:_hour];
            _whetherPlusHour = NO;
        }
    }
    if (_whetherMinusHour) {
        _minute = rads*180/M_PI/360*60;
        if (_minute - _temp_minute > 30) {
            [self numberHitAnimationWithNumber:_hour];
            if (_hour == 12) {
                _AM.alpha=1;
                _PM.alpha=0;
            }else if (_hour == 0) {
                _AM.alpha=0;
                _PM.alpha=1;
            }
            _hour --;
            _whetherMinusHour = NO;
        }
    }
    
    if (_minute > 30 && _minute <= 60) {
        _whetherPlusHour = YES;
    }else{
        _whetherPlusHour = NO;
    }
    
    if (_minute <= 30 && _minute >= 0) {
        _whetherMinusHour = YES;
    }else{
        _whetherMinusHour = NO;
    }
    
    if (_hour >= 24) {
        _hour = 0;
    }
    
    if (_hour < 0) {
        _hour = 23;
    }
    
    _time = _hour*60 + _minute;
    _temp_minute = _minute;
    
    if (_time < _minTime) {
        _whetherSetTimeToMinTime = YES;
    }else{
        _whetherSetTimeToMinTime = NO;
    }
}

- (CGFloat) angleBetweenLine1Start:(CGPoint)line1Start line1End:(CGPoint)line1End line2Start:(CGPoint)line2Start line2End:(CGPoint)line2End
{
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = fabs(line2End.x - line2Start.x);
    CGFloat d = fabs(line2End.y - line2Start.y);
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    return rads;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    _touchPointX = (int)(touchPoint.x);
    _touchPointY = (int)(touchPoint.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
