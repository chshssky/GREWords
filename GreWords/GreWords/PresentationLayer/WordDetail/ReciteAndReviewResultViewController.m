//
//  ReciteAndReviewResultCardViewController.m
//  GreWords
//
//  Created by xsource on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "ReciteAndReviewResultViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+ColorImage.h"
#import "UIImage+StackBlur.h"
#import "ReciteAndReviewResultViewController.h"
#import "ReviewEvent.h"
#import "NewWordEvent.h"

@interface ReciteAndReviewResultViewController () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *blackImageView;
@property (strong, nonatomic) UIImageView *blurImageView;

@property (strong, nonatomic) UISwipeGestureRecognizer* cardRecognizer;
@property (strong, nonatomic) ReciteAndReviewResultViewController *cardController;
@property (nonatomic) float screenHeight;
@property (nonatomic) float screenWidth;
@end

@implementation ReciteAndReviewResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)configContent
{
    if([self.event isMemberOfClass: [NewWordEvent class]])
    {
        self.backgroundView.image = [UIImage imageNamed:@"learning_reciteResult.png"];
    }
    else
    {
        self.backgroundView.image = [UIImage imageNamed:@"learning_reviewResult.png"];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d个",self.event.totalWordCount];
    self.timeLabel.text = [NSString stringWithFormat:@"%d分钟",(int)(self.event.duration / 60.0)];
    self.percentLabel.text = [NSString stringWithFormat:@"%.02f",(float)100- (self.event.wrongWordCount * 100.0 / self.event.totalWordCount)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (iPhone5) {
        self.screenHeight = 568.0f;
        self.screenWidth = 320.0f;
    }else {
        self.screenHeight = 480.0f;
        self.screenWidth = 320.0f;
    }
    [self configContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addReciteAndReviewResultCardAt:(UIViewController *)buttomController
{
    [self addBlurBackground:buttomController];
    [self addBlackToBackground];
    [self addReciteAndReviewResultCardAnimation];
}

- (void)removeReciteAndReviewResultCard
{
    [self removeReciteAndReviewResultCardAnimation];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeReciteAndReviewResultCardAnimation"])
    {
        [self removeBlackToBackground];
        [self removeBlurBackground];
        [self removeReciteAndReviewResultCardController];
        [self.view removeFromSuperview];
    }
}

- (void)addBlurBackground:(UIViewController *)buttomController
{
    if (_blurImageView == nil) {
        UIImage *blurImage = [self getImageFromView:buttomController.view];
        blurImage = [blurImage stackBlur:3];
        
        _blurImageView = [[UIImageView alloc] initWithImage:blurImage];
        [_blurImageView setFrame:CGRectMake(0, 0, buttomController.view.frame.size.width, buttomController.view.frame.size.height)];
        
        [self.view addSubview:_blurImageView];
    }
}

- (void)addBlackToBackground
{
    if (_blackImageView ==nil) {
        UIImage *blackImage = [UIImage imageWithColor:[UIColor blackColor]];
        _blackImageView = [[UIImageView alloc] initWithImage:blackImage];
        [_blackImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _blackImageView.alpha = 0.3;
        [self.view addSubview:_blackImageView];
    }
}

//获取当前屏幕图片
- (UIImage *)getImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)removeBlurBackground
{
    [_blurImageView removeFromSuperview];
    _blurImageView = nil;
}

- (void)removeBlackToBackground
{
    [_blackImageView removeFromSuperview];
    _blackImageView = nil;
}

- (void)removeReciteAndReviewResultCardController
{
    if (_cardController != nil) {
        [_cardController.view removeFromSuperview];
        _cardController = nil;
    }
}


- (void)addReciteAndReviewResultCardAnimation
{
    if (_cardController == nil) {
        _cardController = [[ReciteAndReviewResultViewController alloc] init];
    }
    
    _cardController.view.center = CGPointMake(_screenWidth/2, _screenHeight/2-_cardController.view.frame.size.height);
    [self.view addSubview:_cardController.view];
    
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _screenWidth/2, _screenHeight/2-_cardController.view.frame.size.height-50.0f);
    CGPathAddLineToPoint(path, NULL, _screenWidth/2, _screenHeight/2);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_cardController.view.layer addAnimation:lineAnimation forKey:nil];
    
    CAKeyframeAnimation *lineAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, _screenWidth/2, _screenHeight/2);
    CGPathAddLineToPoint(path2, NULL, _screenWidth/2, _screenHeight/2 - 20.0f);
    lineAnimation2.path = path2;
    CGPathRelease(path2);
    lineAnimation2.duration = 0.2f;
    lineAnimation2.delegate = self;
    lineAnimation2.fillMode = kCAFillModeForwards;
    lineAnimation2.removedOnCompletion = NO;
    lineAnimation2.beginTime = CACurrentMediaTime()+0.3f;
    lineAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_cardController.view.layer addAnimation:lineAnimation2 forKey:nil];
    
    /////////////////////////////////
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(0) , 0, 0, 1.0)];
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(-3) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.15f;
    rotateAnimation.beginTime = CACurrentMediaTime();
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_cardController.view.layer addAnimation:rotateAnimation forKey:nil];
    
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(-3) , 0, 0, 1.0)];
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(1) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.17f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.15f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_cardController.view.layer addAnimation:rotateAnimation2 forKey:nil];
    
    CABasicAnimation *rotateAnimation3 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation3.delegate = self;
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(1) , 0, 0, 1.0)];
    rotateAnimation3.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(0) , 0, 0, 1.0)];
    rotateAnimation3.duration = 0.18f;
    rotateAnimation3.beginTime = CACurrentMediaTime()+0.32f;
    rotateAnimation3.fillMode = kCAFillModeForwards;
    rotateAnimation3.removedOnCompletion = NO;
    rotateAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_cardController.view.layer addAnimation:rotateAnimation3 forKey:nil];
    
    _cardController.view.center = CGPointMake(_screenWidth/2, _screenHeight/2 - 20.0f);
}

- (void)removeReciteAndReviewResultCardAnimation
{
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _screenWidth/2, _screenHeight/2-20.0f);
    CGPathAddLineToPoint(path, NULL, _screenWidth/2, _screenHeight/2);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_cardController.view.layer addAnimation:lineAnimation forKey:nil];
    
    CAKeyframeAnimation *lineAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, _screenWidth/2, _screenHeight/2);
    CGPathAddLineToPoint(path2, NULL, _screenWidth/2, _screenHeight/2 - _cardController.view.frame.size.height-50.0f);
    lineAnimation2.path = path2;
    CGPathRelease(path2);
    lineAnimation2.duration = 0.2f;
    lineAnimation2.delegate = self;
    lineAnimation2.fillMode = kCAFillModeForwards;
    lineAnimation2.removedOnCompletion = NO;
    lineAnimation2.beginTime = CACurrentMediaTime()+0.2f;
    [lineAnimation2 setValue:@"removeTestSelectorAnimation" forKey:@"id"];
    lineAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_cardController.view.layer addAnimation:lineAnimation2 forKey:nil];
    
    /////////////////////////////////
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(0) , 0, 0, 1.0)];
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(1) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.18f;
    rotateAnimation.beginTime = CACurrentMediaTime();
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_cardController.view.layer addAnimation:rotateAnimation forKey:nil];
    
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(1) , 0, 0, 1.0)];
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(-5) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.17f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.18f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_cardController.view.layer addAnimation:rotateAnimation2 forKey:nil];
}


- (void)viewDidUnload {
    [self setBackgroundView:nil];
    [self setPercentLabel:nil];
    [self setCountLabel:nil];
    [self setTimeLabel:nil];
    [super viewDidUnload];
}
- (IBAction)homePressed:(id)sender {
}
@end
