//
//  ViewController.m
//  circle
//
//  Created by xsource on 13-4-11.
//  Copyright (c) 2013年 xsource. All rights reserved.
//

#import "DashboardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "PieChart.h"
#import "TaskStatus.h"

@interface DashboardViewController ()

@property(nonatomic) UIImageView *circle;
@property(nonatomic) CGPoint centerPoint;
@property(nonatomic) int touchPointX;
@property(nonatomic) int touchPointY;

@property(nonatomic) bool whetherMin;
@property(nonatomic) bool whetherMax;

@property(nonatomic) float temp_percent;
@property(nonatomic) float percent;
@property(nonatomic) BOOL centerCircleViewAnimationEnable;

@end

@implementation DashboardViewController

@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;

DashboardViewController* _dashboardViewControllerInstance = nil;

+ (DashboardViewController*)instance
{
    if(!_dashboardViewControllerInstance)
    {
        _dashboardViewControllerInstance = [[DashboardViewController alloc] init];
    }
    return _dashboardViewControllerInstance;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.centerPoint = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+20);
    
    circleShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_shadow.png"]];
    circleShadowView.center = self.centerPoint;
    circleShadowView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //circlePointView.alpha = 0.5f;
    [self.view addSubview:circleShadowView];
    
    circleButtomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_buttom.png"]];
    circleButtomView.center = self.centerPoint;
    circleButtomView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //circleButtomView.alpha = 0.5f;
    [self.view addSubview:circleButtomView];
    
    _percent = (float)_nonFinishedNumber/_sumNumber*(0.999-0.001)+0.001;
    
    
    self.slices = [NSMutableArray arrayWithCapacity:10];
    NSNumber *unfinished = [NSNumber numberWithInt:_nonFinishedNumber];
    [_slices addObject:unfinished];
    NSNumber *finished = [NSNumber numberWithInt:(_sumNumber - _nonFinishedNumber)];
    [_slices addObject:finished];
    
    self.pieChartLeft = [[PieChart alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    [self.view addSubview:self.pieChartLeft];
    
    
    [self.pieChartLeft setDataSource:self];
    self.pieChartLeft.delegate = self;
    [self.pieChartLeft setAnimationSpeed:1];
    [self.pieChartLeft setShowPercentage:NO];
    [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:0]];
    [self.pieChartLeft setPieCenter:_centerPoint];
    [self.pieChartLeft setUserInteractionEnabled:NO];
    [self.pieChartLeft setPieRadius:110];
    _centerCircleViewAnimationEnable = YES;
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:223/255.0 green:150/255.0 blue:57/255.0 alpha:0],
                       [UIColor colorWithRed:223/255.0 green:150/255.0 blue:57/255.0 alpha:1],nil];
    
    
    
    //添加分针图片并消除锯齿
    //    UIImage *f = [UIImage imageNamed:@"f.png"];
    //    UIGraphicsBeginImageContextWithOptions(f.size, NO, f.scale);
    //    [f drawInRect:CGRectMake(1, 1, f.size.width-2, f.size.height-2)];
    //    UIImage *imageF = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    
    
    FimageView = [[UIImageView alloc] initWithImage:nil];
    FimageView.frame = CGRectMake(0, 0, 30, 170);
    FimageView.center = self.centerPoint;
    FimageView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    [self.view addSubview:FimageView];
    
    
    UILongPressGestureRecognizer *gestureRecognizerF = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleF:)];
    gestureRecognizerF.minimumPressDuration=0;
    [FimageView addGestureRecognizer:gestureRecognizerF];
    FimageView.userInteractionEnabled = YES;
    
    FimageView.transform = CGAffineTransformMakeRotation(_percent*2*M_PI);
    
    
    
    centerCircleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_center.png"]];
    centerCircleView.center = self.centerPoint;
    centerCircleView.layer.anchorPoint = CGPointMake(0.551, 0.5);
    centerCircleView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
    [self.view addSubview:centerCircleView];
    
    circlePointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_point.png"]];
    circlePointView.center = self.centerPoint;
    circlePointView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //circlePointView.alpha = 0.5f;
    [self.view addSubview:circlePointView];
    
    
    circleLightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_beard.png"]];
    circleLightView.center = self.centerPoint;
    circleLightView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    circleLightView.alpha = 0;
    [self.view addSubview:circleLightView];
    
    _textView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_text_newWord.png"]];
    _textView.center = CGPointMake(self.centerPoint.x-15, self.centerPoint.y-45);
    _textView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.view addSubview:_textView];
    
    _wordNumberTest = [[FXLabel alloc] initWithFrame:CGRectMake(20, 10, 120, 70)];
    _wordNumberTest.text =  [NSString stringWithFormat:@"%d",0];
    _wordNumberTest.textColor = [UIColor colorWithRed:101/255.00 green:116/255.00 blue:68/255.00 alpha:1];
    _wordNumberTest.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:70];
    _wordNumberTest.backgroundColor = [UIColor clearColor];
    _wordNumberTest.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    _wordNumberTest.innerShadowOffset = CGSizeMake(0.0f, 0.8f);
    _wordNumberTest.center = CGPointMake(self.centerPoint.x+15, self.centerPoint.y+5);
    _wordNumberTest.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:_wordNumberTest];
    
    _bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bigButton setImage:[UIImage imageNamed:@"Main menu_text_startTask.png"] forState:UIControlStateNormal];
    [_bigButton setImage:[UIImage imageNamed:@"Main menu_text_startTask_clicked.png"] forState:UIControlStateHighlighted];
    [_bigButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _bigButton.center = self.centerPoint;
    _bigButton.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [_bigButton sizeToFit];
    _bigButton.center = CGPointMake(self.centerPoint.x, self.centerPoint.y);
    [self.view addSubview:_bigButton];
}

- (void)mainViewGen
{
    [self.pieChartLeft setDataSource:self];
    self.pieChartLeft.delegate = self;
    [self.pieChartLeft setAnimationSpeed:1];
    FimageView.alpha = 1;
    _textView.alpha = 1;
    _bigButton.alpha = 1;
}

- (void)wordDetailIndicatorGen
{
    [self.pieChartLeft setDataSource:self];
    self.pieChartLeft.delegate = self;
    [self.pieChartLeft setAnimationSpeed:0.08];
    FimageView.alpha = 0;
    _textView.alpha = 0;
    _bigButton.alpha = 0;
}

- (void)minusData
{
    _nonFinishedNumber-=1;
    _minNumber = _nonFinishedNumber;
    _percent = (float)_nonFinishedNumber/_sumNumber*(0.999-0.001)+0.001;
    
    [_slices replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:_nonFinishedNumber]];
    [_slices replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:(_sumNumber - _nonFinishedNumber)]];
    [_pieChartLeft reloadData];
}

- (void)reloadData
{
    [_slices replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:_nonFinishedNumber]];
    [_slices replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:(_sumNumber - _nonFinishedNumber)]];
    [_pieChartLeft reloadData];

}

- (void)plusData
{
    _nonFinishedNumber+=1;
    _minNumber = _nonFinishedNumber;
    _percent = (float)_nonFinishedNumber/_sumNumber*(0.999-0.001)+0.001;
    
    [_slices replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:_nonFinishedNumber]];
    [_slices replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:(_sumNumber - _nonFinishedNumber)]];
    [_pieChartLeft reloadData];
}

- (void)buttonPressed
{
    [self.delegate bigButtonPressed];
}

- (void)handleF:(UILongPressGestureRecognizer *)recognizer
{    
    self.pieChartLeft.delegate = nil;
    
    [self.pieChartLeft setAnimationSpeed:0.01];
    
    CGPoint movePoint = [recognizer locationInView:self.view];
    
    CGPoint startPoint = CGPointMake(_centerPoint.x, 0);
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
    
    [self calculateRotation:rads];
    
    FimageView.transform = CGAffineTransformMakeRotation(_percent*2*M_PI);
    centerCircleView.transform = CGAffineTransformMakeRotation(_percent*2*M_PI+M_PI/2);
    
    if (_percent < 0.5) {
        _nonFinishedNumber = ceil((_percent-0.001)/(0.999-0.001) * _sumNumber);
    }else{
        _nonFinishedNumber = (_percent-0.001)/(0.999-0.001) * _sumNumber;

    }
    //_nonFinishedNumber = (_percent-0.001)/(0.999-0.001) * _sumNumber;
    _wordNumberTest.text =  [NSString stringWithFormat:@"%d", _nonFinishedNumber];
    
    
    if (_nonFinishedNumber >= _sumNumber) {
        _nonFinishedNumber = _sumNumber;
    }
    [_slices replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:_nonFinishedNumber]];
    [_slices replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:(_sumNumber - _nonFinishedNumber)]];
    [self.pieChartLeft reloadData];
    
    if ( recognizer.state == UIGestureRecognizerStateBegan ) {
        [UIView animateWithDuration:0.5 animations:^(){
            circleLightView.alpha = 1;
        }];
    }
    if ( recognizer.state == UIGestureRecognizerStateEnded ) {
        [UIView animateWithDuration:0.5 animations:^(){
            circleLightView.alpha = 0;
            
            //
            
            [self.delegate resetIndexOfWordList:_nonFinishedNumber];
            
            
            
        }];
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

- (void)calculateRotation:(float) rads
{
    if (_whetherMax) {
        _percent = rads*180/M_PI/360;
        if (_temp_percent - _percent > 50.0/100.0) {
            _percent = 0.999;
            _whetherMax = NO;
        }
    }
    if (_whetherMin) {
        _percent = rads*180/M_PI/360;
        if (_percent - _temp_percent > 50.0/100.0) {
            _percent = 0.001;
            _whetherMin = NO;
        }
    }
    
    if (_percent > _percent && _percent <= 1) {
        _whetherMax = YES;
        _whetherMin = NO;
    }else{
        _whetherMax = NO;
        _whetherMin = YES;
    }
    
    if (_percent <= 0.3  && _percent >= 0) {
        _whetherMin = YES;
        _whetherMax = NO;
    }else{
        _whetherMin = NO;
        _whetherMax = YES;
    }

    if (_percent < (float)_minNumber/(float)_sumNumber) {
        _percent = (float)_minNumber/(float)_sumNumber;
    }
    
    _temp_percent = _percent;
}

- (void)viewDidUnload
{
    [self setPieChartLeft:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChartLeft reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - PieChart Data Source

- (void)pieChart:(PieChart*)pieChart isDoingAnimationAtPercent:(float)percent
{
    centerCircleView.transform = CGAffineTransformMakeRotation(M_PI/2+(1-percent)*M_PI*2);
    FimageView.transform = CGAffineTransformMakeRotation((1-percent)*M_PI*2);
    int wordNumber = round((1-percent)*_sumNumber);
    _wordNumberTest.text = [NSString stringWithFormat:@"%d",wordNumber];
}


- (NSUInteger)numberOfSlicesInPieChart:(PieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(PieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] floatValue];
}

- (UIColor *)pieChart:(PieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

- (void)changeTextViewToReview
{
    [TaskStatus instance].rComplete = NO;
    [TaskStatus instance].nwComplete = NO;
    self.view.userInteractionEnabled = YES;
    self.bigButton.userInteractionEnabled = YES;
    
    self.wordNumberTest.alpha = 1;    _textView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_text_reciteWord.png"]];
    _textView.center = CGPointMake(self.centerPoint.x-15, self.centerPoint.y-45);
    _textView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.view addSubview:_textView];
}

- (void)changeTextViewToNewWord
{
    [TaskStatus instance].rComplete = NO;
    [TaskStatus instance].nwComplete = NO;
    self.view.userInteractionEnabled = YES;
    self.bigButton.userInteractionEnabled = YES;
    
    self.wordNumberTest.alpha = 1;
    
    _textView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_text_newWord.png"]];
    _textView.center = CGPointMake(self.centerPoint.x-15, self.centerPoint.y-45);
    _textView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.view addSubview:_textView];
}

- (void)changeTextViewToHalfComplete
{
    [TaskStatus instance].nwComplete = YES;
    self.view.userInteractionEnabled = NO;
    self.wordNumberTest.alpha = 0;
    self.bigButton.userInteractionEnabled = NO;
    
    self.theNewTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_text_HalfFinished.png"]];
    self.theNewTextView.center = CGPointMake(self.centerPoint.x, self.centerPoint.y);
    [self.view insertSubview:self.theNewTextView atIndex:100];
    //    [self.view addSubview:self.theNewTextView];
}

- (void)changeTextViewToComplete
{
    [TaskStatus instance].rComplete = YES;
    
    self.wordNumberTest.alpha = 0;
    
    self.bigButton.userInteractionEnabled = NO;
    
    self.theNewTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_text_allFinished.png"]];
    self.theNewTextView.center = CGPointMake(self.centerPoint.x, self.centerPoint.y);
    [self.view addSubview:self.theNewTextView];
    
}


//- (UIColor *)pieChart:(PieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
//{
//    if(pieChart == self.pieChartRight) return nil;
//    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
//}

#pragma mark - PieChart Delegate
//- (void)pieChart:(PieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
//{
//    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
