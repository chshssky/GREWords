//
//  HistoryStatisticsViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-4-13.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "HistoryStatisticsViewController.h"
#import "GreWordsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LineChartViewController.h"
#import "TestPageViewController.h"
#import "BaseEvent.h"

@interface HistoryStatisticsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *greenCover;
@property (weak, nonatomic) IBOutlet UIButton *progressButton;
@property (weak, nonatomic) IBOutlet UIImageView *progressText;

@property (nonatomic) CGPoint firstPoint;
@property (nonatomic) CGPoint secondPoint;
@property (nonatomic) CGPoint thridPoint;
@property (nonatomic) CGPoint fourthPoint;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) CGPoint choosePoint;

@end

@implementation HistoryStatisticsViewController

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
    [self initialLastPointWithPoint:_thridPoint];
    [self setGesture];
    
    
    ExamEvent *test1 = [[ExamEvent alloc] init];
    test1.startTime = [NSDate new];
    test1.duration = 600;
    test1.difficulty = 1;
    test1.totalWordCount = 100;
    test1.wrongWordCount = 20;
    
    
    ExamEvent *test2 = [[ExamEvent alloc] init];
    test2.startTime = [NSDate new];
    test2.duration = 6000;
    test2.difficulty = 2;
    test2.totalWordCount = 20;
    test2.wrongWordCount = 2;
    
    
    
    //添加卡片，设置卡片数量
    TestPageViewController *testPageViewController = [[TestPageViewController alloc] init];
    testPageViewController.view.center = CGPointMake(self.view.center.x, self.view.center.y+57);
    testPageViewController.data = @[test1,test2];
    [self addChildViewController:testPageViewController];
    [self.view addSubview:testPageViewController.view];
    
    
//    LineChartViewController *vc = [[LineChartViewController alloc] init];
//    vc.type = HistoryChartReview;
//    
//    BaseEvent *r1 = [[BaseEvent alloc] init];
//    r1.duration = 20 * 60;
//    r1.startTime = [NSDate new];
//    
//    BaseEvent *r2 = [[BaseEvent alloc] init];
//    r2.duration = 120 * 60;
//    r2.startTime = [NSDate new];
//    vc.data = @[r1,r2];
//    
//    BaseEvent *r3 = [[BaseEvent alloc] init];
//    r3.duration = 60 * 60;
//    r3.startTime = [NSDate new];
//    vc.data = @[r1,r2,r3];
//    [self addChildViewController:vc];
//    [self.view addSubview:vc.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setExitButton:nil];
    [self setGreenCover:nil];
    [self setProgressButton:nil];
    [self setProgressText:nil];
    [super viewDidUnload];
}

#pragma mark - exitButton
- (IBAction)exitPressed:(id)sender {
    GreWordsViewController *superController =  (GreWordsViewController *)[self presentingViewController];
    
    UIImageView *blackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [blackView setBackgroundColor:[UIColor blackColor]];
    blackView.alpha = 0;
    [superController.view addSubview:blackView];
    
    
    superController.whetherAllowViewFrameChanged = YES;
    CABasicAnimation *opacityAnim_black = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim_black.fromValue = [NSNumber numberWithFloat:0.7];
    opacityAnim_black.toValue = [NSNumber numberWithFloat:0];
    opacityAnim_black.removedOnCompletion = YES;
    CAAnimationGroup *animGroup_black = [CAAnimationGroup animation];
    animGroup_black.animations = [NSArray arrayWithObjects:opacityAnim_black, nil];
    animGroup_black.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup_black.duration = 0.5;
    [blackView.layer addAnimation:animGroup_black forKey:nil];
    
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - progressBar
- (void)initialFourPoint
{
    _firstPoint.x = 77.0f;
    _firstPoint.y = 77.0f;
    _secondPoint.x = 135.0f;
    _secondPoint.y = 77.0f;
    _thridPoint.x = 190.0f;
    _thridPoint.y = 77.0f;
    _fourthPoint.x = 245.0f;
    _fourthPoint.y = 77.0f;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if([[theAnimation valueForKey:@"id"] isEqual:@"GoToPointFinished"])
    {
        if (_progressButton.center.x == _firstPoint.x) {
            [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text1.png"]];
            _choosePoint = _firstPoint;
        }else if (_progressButton.center.x == _secondPoint.x) {
            [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text2.png"]];
            _choosePoint = _secondPoint;
        }else if (_progressButton.center.x == _thridPoint.x) {
            [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text3.png"]];
            _choosePoint = _thridPoint;
        }else if (_progressButton.center.x == _fourthPoint.x) {
            [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text4.png"]];
            _choosePoint = _fourthPoint;
        }
    }
}

- (void)initialLastPointWithPoint:(CGPoint)lastPoint
{
    _lastPoint = lastPoint;
    _progressButton.center = lastPoint;
    _greenCover.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
    _choosePoint = lastPoint;
    
    if (lastPoint.x == _firstPoint.x) {
        [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text1.png"]];
    }else if (lastPoint.x == _secondPoint.x) {
        [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text2.png"]];
    }else if (lastPoint.x == _thridPoint.x) {
        [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text3.png"]];
    }else if (lastPoint.x == _fourthPoint.x) {
        [_progressText setImage:[UIImage imageNamed:@"history_slideBar_text4.png"]];
    }
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
    [_greenCover.layer addAnimation:lineAnimation forKey:nil];
    
    _progressButton.center = destinationPoint;
    _greenCover.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
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
        [_progressButton setImage:[UIImage imageNamed:@"history progressBar_button_clicked.png"] forState:UIControlStateNormal];
    }
    
    if (recognizer.state ==
        UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [recognizer locationInView:self.view];
        if (movePoint.x >= _firstPoint.x && movePoint.x <= _lastPoint.x) {
            _progressButton.center = CGPointMake(movePoint.x, _progressButton.center.y);
            _greenCover.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
        }else if (movePoint.x < _firstPoint.x) {
            _progressButton.center = _firstPoint;
            _greenCover.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
        }else if (movePoint.x > _lastPoint.x) {
            _progressButton.center = _lastPoint;
            _greenCover.center = CGPointMake(_progressButton.center.x - 85.0f, _progressButton.center.y);
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [_progressButton setImage:[UIImage imageNamed:@"history progressBar_button.png"] forState:UIControlStateNormal];
        [self checkProgressButtonShouldMoveToWhichPoint];
    }
}


- (IBAction)progressButtonClicked:(id)sender {
    NSLog(@"progressButtonClicked");
}


@end
