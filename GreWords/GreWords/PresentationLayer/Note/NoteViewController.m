//
//  NoteViewController.m
//  GreWords
//
//  Created by xsource on 13-5-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "NoteViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "WordSpeaker.h"
#import "WordTaskGenerator.h"
#import "SmartWordListViewController.h"
#import "UIImage+ColorImage.h"
#import "UIImage+StackBlur.h"
#import "noCopyTextView.h"
#import "DashboardViewController.h"
#import "WordDetailViewController.h"
#import "WordCardLayoutViewController.h"
#import "WordNoteLayoutViewController.h"
#import "WordDetailViewController.h"
#import "ConfigurationHelper.h"


@interface NoteViewController () <UITextViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *noteUp;
@property (strong, nonatomic) UIImageView *noteDown;
@property (strong, nonatomic) UIImageView *blackImageView;
@property (strong, nonatomic) UIImageView *blurImageView;
@property (strong, nonatomic) UITextView *noteTextView;
@property (strong, nonatomic) UISwipeGestureRecognizer* noteRecognizer;
@property (nonatomic) int tempWordID;
@end

@implementation NoteViewController

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
    
    
    _noteRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    _noteRecognizer.delegate = self;
    _noteRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:_noteRecognizer];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_Note])
    {
        [GuideImageFactory instance].oneTimeDelegate = self;
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_Note];
        [self.view addSubview:guideImageView];
        _noteRecognizer.enabled = NO;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if([[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]] isEqualToString:@"UIPanGestureRecognizer"]) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer*)recognizer {
    
    if (_noteTextView != nil) {
        [_noteTextView resignFirstResponder];
    }
    [self removeNote];
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

- (void)removeDownNoteImageAnimation
{
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"removeDownNoteImageAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _noteDown.center.x, _noteDown.center.y);
    CGPathAddLineToPoint(path, NULL, _noteDown.center.x, -250);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteDown.layer addAnimation:lineAnimation forKey:nil];
}

- (void)removeUpNoteImageAnimation
{
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"removeUpNoteImageAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _noteUp.center.x, _noteUp.center.y);
    CGPathAddLineToPoint(path, NULL, _noteUp.center.x, -250);
    
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteUp.layer addAnimation:lineAnimation forKey:nil];
    
}

- (void)removeNoteTextViewAnimation:(int)wordID
{
    [[WordHelper instance] wordWithID:wordID].note = _noteTextView.text;
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"removeNoteTextViewAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _noteTextView.center.x, _noteTextView.center.y);
    CGPathAddLineToPoint(path, NULL, _noteTextView.center.x, -250);
    
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteTextView.layer addAnimation:lineAnimation forKey:nil];
    
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    

    if([[theAnimation valueForKey:@"id"] isEqual:@"removeUpNoteImageAnimation"])
    {
        [_noteDown removeFromSuperview];
        _noteDown = nil;
    }
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeUpNoteImageAnimation"])
    {
        [_noteUp removeFromSuperview];
        _noteUp = nil;
        
         [self.view removeFromSuperview];
    }
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeNoteTextViewAnimation"])
    {
        [_noteTextView removeFromSuperview];
        _noteTextView = nil;
        
        [self removeBlurBackground];
        [self.view removeFromSuperview];
    }
}

- (void)addUpNoteImageAnimation
{
    if (_noteUp == nil) {
        _noteUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_noteUp.png"]];
        [_noteUp setCenter:CGPointMake(55, -200)];
        _noteUp.layer.anchorPoint = CGPointMake(0.08, 0.08);
        [self.view addSubview:_noteUp];
    }
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 55, -200);
    CGPathAddLineToPoint(path, NULL, 55, self.view.frame.size.height/4);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteUp.layer addAnimation:lineAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(5) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.15f;
    rotateAnimation.beginTime = CACurrentMediaTime()+0.1f;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteUp.layer addAnimation:rotateAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(0) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.2f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.35f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_noteUp.layer addAnimation:rotateAnimation2 forKey:nil];
    
    _noteUp.center = CGPointMake(55, self.view.frame.size.height/4);
}

- (void)addDownNoteImageAnimation
{
    if (_noteDown == nil) {
        _noteDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_noteDown.png"]];
        [_noteDown setCenter:CGPointMake(25, -200)];
        _noteDown.layer.anchorPoint = CGPointMake(0.08, 0.08);
        [self.view addSubview:_noteDown];
    }
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 25, -200);
    CGPathAddLineToPoint(path, NULL, 25, self.view.frame.size.height/4-25);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteDown.layer addAnimation:lineAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(5) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.15f;
    rotateAnimation.beginTime = CACurrentMediaTime()+0.1f;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteDown.layer addAnimation:rotateAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(2.5) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.2f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.35f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_noteDown.layer addAnimation:rotateAnimation2 forKey:nil];
    
    _noteDown.center = CGPointMake(25, self.view.frame.size.height/4-25);
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

- (void)addNoteTextViewAnimation:(int)wordID
{
    if (_noteTextView == nil) {
        _noteTextView = [[noCopyTextView alloc] initWithFrame:CGRectMake(57, -170, 258, 220)];
        _noteTextView.delegate = self;
        _noteTextView.layer.anchorPoint = CGPointMake(0.08, 0);
        _noteTextView.editable = YES;
        //载入note
        
        _noteTextView.text = [[WordHelper instance] wordWithID:wordID].note;
        
        [_noteTextView setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:22]];
        [_noteTextView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_noteTextView];
    }
    
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 57, -170);
    CGPathAddLineToPoint(path, NULL, 57, self.view.frame.size.height/4-5);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteTextView.layer addAnimation:lineAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(5) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.15f;
    rotateAnimation.beginTime = CACurrentMediaTime()+0.1f;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteTextView.layer addAnimation:rotateAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(0) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.2f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.35f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_noteTextView.layer addAnimation:rotateAnimation2 forKey:nil];
    
    _noteTextView.center = CGPointMake(57, self.view.frame.size.height/4-5);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    CAKeyframeAnimation *lineAnimation;
    CGMutablePathRef path;
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 57, self.view.frame.size.height/4-5);
    CGPathAddLineToPoint(path, NULL, 57, self.view.frame.size.height/4-85);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [_noteTextView.layer addAnimation:lineAnimation forKey:nil];
    
    _noteTextView.center = CGPointMake(57, self.view.frame.size.height/4-85);
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 55, self.view.frame.size.height/4);
    CGPathAddLineToPoint(path, NULL, 55, self.view.frame.size.height/4-80);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [_noteUp.layer addAnimation:lineAnimation forKey:nil];
    
    _noteUp.center = CGPointMake(55, self.view.frame.size.height/4-80);
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 25, self.view.frame.size.height/4-25);
    CGPathAddLineToPoint(path, NULL, 25, self.view.frame.size.height/4-105);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [_noteDown.layer addAnimation:lineAnimation forKey:nil];
    
    _noteDown.center = CGPointMake(25, self.view.frame.size.height/4-105);
    
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (textView.contentSize.height + 10 >=200)
        {
            return NO;
        }
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.contentSize.height >= 200)
    {
        //删除最后一行的第一个字符，以便减少一行。
        int tempLocation = textView.selectedRange.location;
        NSString *noteText1= textView.text;
        NSString *noteText2= textView.text;
        noteText1 = [textView.text substringToIndex:textView.selectedRange.location-1];
        noteText2 = [textView.text substringFromIndex:textView.selectedRange.location];
        NSString *noteText = [noteText1 stringByAppendingString:noteText2];
        textView.text = noteText;
        
        NSRange range;
        range.location = tempLocation-1;
        range.length = 0;
        textView.selectedRange = range;
        
    }
}

//获取当前屏幕图片
-(UIImage *)getImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)addNoteAt:(UIViewController *)buttomController withWordID:(int)wordID
{
    [self addBlurBackground:buttomController];
    [self addBlackToBackground];
    [self addDownNoteImageAnimation];
    [self addUpNoteImageAnimation];
    [self addNoteTextViewAnimation:(int)wordID];
    self.tempWordID = wordID;
    [self.delegate whenNoteAppeared];
}

-(void)removeNote
{
    [self removeBlackToBackground];
    [self removeDownNoteImageAnimation];
    [self removeUpNoteImageAnimation];
    [self removeNoteTextViewAnimation:self.tempWordID];
    [self.delegate whenNoteDismissed];
}


#pragma mark - guide image delegate
-(void)guideEnded
{
    _noteRecognizer.enabled = YES;
}

@end
