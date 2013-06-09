//
//  GuideSettingViewController.m
//  GreWords
//
//  Created by xsource on 13-6-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GuideSettingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GuideSettingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *progressGreen;
@property (weak, nonatomic) IBOutlet UIImageView *progressButton;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *titleText;
@property (nonatomic) UIImageView *popCard;
@property (nonatomic) CGPoint firstPoint;
@property (nonatomic) CGPoint secondPoint;
@property (nonatomic) CGPoint thridPoint;
@property (nonatomic) CGPoint fourthPoint;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) CGPoint choosePoint;
@end

@implementation GuideSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialFourPoint];
    [self setProgressButtonLocation:_firstPoint];
    [self setPopCardLocation:_firstPoint];
    [self setGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    _titleText.center = CGPointMake(self.view.center.x, self.view.center.y - 210);
}

- (void)viewDidUnload {
    [self setProgressButton:nil];
    [self setProgressGreen:nil];
    [self setBackground:nil];
    [self setTitleText:nil];
    [super viewDidUnload];
}

#pragma mark - progressBar
- (void)initialFourPoint
{
    if (iPhone5) {
        _firstPoint.x = 77.0f;
        _firstPoint.y = 210.0f;
        _secondPoint.x = 135.0f;
        _secondPoint.y = 210.0f;
        _thridPoint.x = 190.0f;
        _thridPoint.y = 210.0f;
        _fourthPoint.x = 245.0f;
        _fourthPoint.y = 210.0f;
    }else {
        _firstPoint.x = 77.0f;
        _firstPoint.y = 122.0f;
        _secondPoint.x = 135.0f;
        _secondPoint.y = 122.0f;
        _thridPoint.x = 190.0f;
        _thridPoint.y = 122.0f;
        _fourthPoint.x = 245.0f;
        _fourthPoint.y = 122.0f;
    }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if([[theAnimation valueForKey:@"id"] isEqual:@"GoToPointFinished"])
    {
        if (_progressButton.center.x == _firstPoint.x) {
            [self popAnimationFrom:_firstPoint];
            _choosePoint = _firstPoint;
        }else if (_progressButton.center.x == _secondPoint.x) {
            [self popAnimationFrom:_secondPoint];
            _choosePoint = _secondPoint;
        }else if (_progressButton.center.x == _thridPoint.x) {
            [self popAnimationFrom:_thridPoint];
            _choosePoint = _thridPoint;
        }else if (_progressButton.center.x == _fourthPoint.x) {
            [self popAnimationFrom:_fourthPoint];
            _choosePoint = _fourthPoint;
        }
    }
}

- (void)setProgressButtonLocation:(CGPoint)point
{
    _lastPoint = _fourthPoint;
    _progressButton.center = point;
    _progressGreen.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
    _choosePoint = point;
}

- (void)checkProgressButtonShouldMoveToWhichPoint
{
    if (_progressButton.center.x >= 77.0f && _progressButton.center.x <= 106.0f) {
        [self goToPoint:_firstPoint];
    }else if (_progressButton.center.x > 106.0f && _progressButton.center.x <= 163.0f) {
        [self goToPoint:_secondPoint];
    }else if (_progressButton.center.x > 163.0f && _progressButton.center.x <= 218.0f) {
        [self goToPoint:_thridPoint];
    }else if (_progressButton.center.x > 218.0f && _progressButton.center.x <= 245.0f) {
        [self goToPoint:_fourthPoint];
    }
}

- (void)goToPoint:(CGPoint)destinationPoint
{
    CAKeyframeAnimation *lineAnimation;
    CGMutablePathRef path;
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _progressButton.center.x, _progressButton.center.y);
    CGPathAddLineToPoint(path, NULL, destinationPoint.x, destinationPoint.y);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.15f;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_progressButton.layer addAnimation:lineAnimation forKey:nil];
    
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"GoToPointFinished" forKey:@"id"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _progressButton.center.x - 85.0f, _progressButton.center.y);
    CGPathAddLineToPoint(path, NULL, destinationPoint.x - 85.0f, destinationPoint.y);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.15f;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_progressGreen.layer addAnimation:lineAnimation forKey:nil];
    
    _progressButton.center = destinationPoint;
    _progressGreen.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
}

- (void)setGesture
{
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handle:)];
    [_progressButton addGestureRecognizer:gestureRecognizer];
    _progressButton.userInteractionEnabled = YES;
    gestureRecognizer.minimumPressDuration = 0;
}

- (void)handle:(UILongPressGestureRecognizer *)recognizer
{
    
    if (recognizer.state ==
        UIGestureRecognizerStateBegan) {
        [_progressButton setImage:[UIImage imageNamed:@"history progressBar_button_clicked.png"]];
    }
    
    if (recognizer.state ==
        UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [recognizer locationInView:self.view];
        if (movePoint.x >= _firstPoint.x && movePoint.x <= _lastPoint.x) {
            _progressButton.center = CGPointMake(movePoint.x, _progressButton.center.y);
            _progressGreen.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
        }else if (movePoint.x < _firstPoint.x) {
            _progressButton.center = _firstPoint;
            _progressGreen.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
        }else if (movePoint.x > _lastPoint.x) {
            _progressButton.center = _lastPoint;
            _progressGreen.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [_progressButton setImage:[UIImage imageNamed:@"history progressBar_button.png"]];
        [self checkProgressButtonShouldMoveToWhichPoint];
    }
}


- (void)popAnimationFrom:(CGPoint)startPoint
{
    [self setPopCardLocation:startPoint];
    
    CABasicAnimation* rotateAnimation;
    CABasicAnimation* rotateAnimation2;
    CABasicAnimation *scaleAnimation;
    
    //缩放动画
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.beginTime = CACurrentMediaTime();
    scaleAnimation.fillMode = kCAFillModeBackwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.duration = 0.2f;
    [_popCard.layer addAnimation:scaleAnimation forKey:nil];

    
    //旋转动画
    rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotateAnimation.fromValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(40)];
    rotateAnimation.toValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-6)];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    rotateAnimation.beginTime = CACurrentMediaTime();
    rotateAnimation.fillMode = kCAFillModeBackwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.duration = 0.3f;
    [_popCard.layer addAnimation:rotateAnimation forKey:nil];
    
    rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotateAnimation2.fromValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-6)];
    rotateAnimation2.toValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(0)];
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    rotateAnimation2.beginTime = CACurrentMediaTime() + 0.3f;
    rotateAnimation2.duration = 0.02f;
    [_popCard.layer addAnimation:rotateAnimation2 forKey:nil];
}

- (void)setPopCardLocation:(CGPoint)startPoint
{
    if (_popCard != nil) {
        [_popCard removeFromSuperview];
        _popCard = nil;
    }
    
    if (CGPointEqualToPoint(startPoint, _firstPoint)) {
        _popCard = [[UIImageView alloc] init];
        [_popCard setImage:[UIImage imageNamed:@"GuideSetting_firstStep.png"]];
        [_popCard sizeToFit];
        _popCard.layer.anchorPoint = CGPointMake(60.0/292.0, 0.0);
        _popCard.center = CGPointMake(startPoint.x,startPoint.y + 30.0);
        [self.view addSubview:_popCard];
    }else if (CGPointEqualToPoint(startPoint, _secondPoint)) {
        _popCard = [[UIImageView alloc] init];
        [_popCard setImage:[UIImage imageNamed:@"GuideSetting_secondStep.png"]];
        [_popCard sizeToFit];
        _popCard.layer.anchorPoint = CGPointMake(116.0/292.0, 0.0);
        _popCard.center = CGPointMake(startPoint.x,startPoint.y + 30.0);
        [self.view addSubview:_popCard];
    }else if (CGPointEqualToPoint(startPoint, _thridPoint)) {
        _popCard = [[UIImageView alloc] init];
        [_popCard setImage:[UIImage imageNamed:@"GuideSetting_thirdStep.png"]];
        [_popCard sizeToFit];
        _popCard.layer.anchorPoint = CGPointMake(172.0/292.0, 0.0);
        _popCard.center = CGPointMake(startPoint.x,startPoint.y + 30.0);
        [self.view addSubview:_popCard];
    }else if (CGPointEqualToPoint(startPoint, _fourthPoint)) {
        _popCard = [[UIImageView alloc] init];
        [_popCard setImage:[UIImage imageNamed:@"GuideSetting_fourthStep.png"]];
        [_popCard sizeToFit];
        _popCard.layer.anchorPoint = CGPointMake(228.0/292.0, 0.0);
        _popCard.center = CGPointMake(startPoint.x,startPoint.y + 30.0);
        [self.view addSubview:_popCard];
    }
}


@end
