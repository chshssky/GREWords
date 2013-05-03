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

@interface DashboardViewController ()

@property(nonatomic) UIImageView *circle;
@property(nonatomic) UIImageView *FimageView;
@property(nonatomic) CGPoint centerPoint;
@property(nonatomic) int touchPointX;
@property(nonatomic) int touchPointY;

@property(nonatomic) bool whetherMin;
@property(nonatomic) bool whetherMax;


@property(nonatomic) float temp_percent;
@property(nonatomic) float percent;





@end

@implementation DashboardViewController

@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.centerPoint = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+35);
    
    circlePointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_buttom.png"]];
    circlePointView.center = self.centerPoint;
    circlePointView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    circlePointView.gestureRecognizers = self.FimageView.gestureRecognizers;
    //circlePointView.alpha = 0.5f;
    [self.view addSubview:circlePointView];
    
    
    
    //self.nonFinishedNumber = 270;
    //self.sumNumber = 300;
    _percent = (float)_nonFinishedNumber/_sumNumber*(0.999-0.001)+0.001;
    
    self.slices = [NSMutableArray arrayWithCapacity:10];
    
    NSNumber *unfinished = [NSNumber numberWithInt:_nonFinishedNumber];
    [_slices addObject:unfinished];
    NSNumber *finished = [NSNumber numberWithInt:(_sumNumber - _nonFinishedNumber)];
    [_slices addObject:finished];
    
    //    for(int i = 0; i < 5; i ++)
    //    {
    //        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
    //        [_slices addObject:one];
    //    }
    
    self.pieChartLeft = [[PieChart alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    [self.view addSubview:self.pieChartLeft];
    
    
    [self.pieChartLeft setDataSource:self];
    self.pieChartLeft.delegate = self;
    [self.pieChartLeft setAnimationSpeed:1];
    [self.pieChartLeft setShowPercentage:NO];
    [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:0]];
    [self.pieChartLeft setPieCenter:_centerPoint];
    [self.pieChartLeft setUserInteractionEnabled:NO];
    [self.pieChartLeft setPieRadius:117];
    //NSLog(@"%@",self.pieChartLeft);
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:223/255.0 green:150/255.0 blue:57/255.0 alpha:1],
                       [UIColor colorWithRed:223/255.0 green:150/255.0 blue:57/255.0 alpha:0],nil];
    

    
    //添加分针图片并消除锯齿
//    UIImage *f = [UIImage imageNamed:@"f.png"];
//    UIGraphicsBeginImageContextWithOptions(f.size, NO, f.scale);
//    [f drawInRect:CGRectMake(1, 1, f.size.width-2, f.size.height-2)];
//    UIImage *imageF = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    self.FimageView = [[UIImageView alloc] initWithImage:nil];
    
    self.FimageView.frame = CGRectMake(0, 0, 30, 170);
    self.FimageView.center = self.centerPoint;
    self.FimageView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    [self.view addSubview:self.FimageView];
    
    UILongPressGestureRecognizer *gestureRecognizerF = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleF:)];
    gestureRecognizerF.minimumPressDuration=1.2;
    [self.FimageView addGestureRecognizer:gestureRecognizerF];
    self.FimageView.userInteractionEnabled = YES;
    
    self.FimageView.transform = CGAffineTransformMakeRotation(_percent*2*M_PI);
    
    
    shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_out.png"]];
    shadowImageView.center = self.centerPoint;
    shadowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    shadowImageView.gestureRecognizers = self.FimageView.gestureRecognizers;
    //shadowImageView.alpha = 0.5;
    [self.view addSubview:shadowImageView];
    
    centerCircleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_center.png"]];
    centerCircleView.center = self.centerPoint;
    centerCircleView.layer.anchorPoint = CGPointMake(0.554, 0.5);
    centerCircleView.gestureRecognizers = self.FimageView.gestureRecognizers;
    centerCircleView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
    [self.view addSubview:centerCircleView];
    
    circlePointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_point.png"]];
    circlePointView.center = self.centerPoint;
    circlePointView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    circlePointView.gestureRecognizers = self.FimageView.gestureRecognizers;
    //circlePointView.alpha = 0.5f;
    [self.view addSubview:circlePointView];
    
    
    circleLightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_circle_beard.png"]];
    circleLightView.center = self.centerPoint;
    circleLightView.layer.anchorPoint = CGPointMake(0.5, 0.415);
    circleLightView.gestureRecognizers = self.FimageView.gestureRecognizers;
    circleLightView.alpha = 0;
    
    textView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_text_newWord.png"]];
    textView.center = CGPointMake(self.view.frame.size.width/2-15, self.view.frame.size.height/3-10);
    textView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    textView.gestureRecognizers = self.FimageView.gestureRecognizers;
    //shadowImageView.alpha = 0.5;
    [self.view addSubview:textView];
    
    startTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_text_startTask.png"]];
    startTextView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+80);
    startTextView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    startTextView.gestureRecognizers = self.FimageView.gestureRecognizers;
    startTextView.alpha = 0.6;
    [self.view addSubview:startTextView];
    
    wordNumberTest = [[FXLabel alloc] initWithFrame:CGRectMake(20, 10, 100, 65)];
    wordNumberTest.text =  [NSString stringWithFormat:@"%d",0];
    wordNumberTest.textColor = [UIColor colorWithRed:101/255.00 green:116/255.00 blue:68/255.00 alpha:1];
    wordNumberTest.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:55];
    wordNumberTest.backgroundColor = [UIColor clearColor];
    wordNumberTest.shadowColor = [UIColor grayColor];
    //wordNumberTest.shadowOffset = CGSizeMake(-1, -1);
    wordNumberTest.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    wordNumberTest.innerShadowOffset = CGSizeMake(0.0f, 0.8f);
    wordNumberTest.center = CGPointMake(self.view.frame.size.width/2+15, self.view.frame.size.height/3+40);
    wordNumberTest.textAlignment = UITextAlignmentRight;
    [self.view addSubview:wordNumberTest];

    
    shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar.png"]];
    shadowImageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+185);
    shadowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    shadowImageView.gestureRecognizers = self.FimageView.gestureRecognizers;
    //shadowImageView.alpha = 0.5;
    [self.view addSubview:shadowImageView];

    
    
    
//    shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus1.png"]];
//    shadowImageView.center = CGPointMake(self.view.frame.size.width/2-88, self.view.frame.size.height/3+170);
//    shadowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    shadowImageView.gestureRecognizers = self.FimageView.gestureRecognizers;
//    //shadowImageView.alpha = 0.5;
    [self.view addSubview:shadowImageView];
    
    shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus2.png"]];
    shadowImageView.center = CGPointMake(self.view.frame.size.width/2-59, self.view.frame.size.height/3+185);
    shadowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    shadowImageView.gestureRecognizers = self.FimageView.gestureRecognizers;
    //shadowImageView.alpha = 0.5;
    [self.view addSubview:shadowImageView];
    
//    shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus3.png"]];
//    shadowImageView.center = CGPointMake(self.view.frame.size.width/2-29, self.view.frame.size.height/3+170);
//    shadowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    shadowImageView.gestureRecognizers = self.FimageView.gestureRecognizers;
//    //shadowImageView.alpha = 0.5;
//    [self.view addSubview:shadowImageView];
//    
//    shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus4.png"]];
//    shadowImageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+170);
//    shadowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    shadowImageView.gestureRecognizers = self.FimageView.gestureRecognizers;
//    //shadowImageView.alpha = 0.5;
//    [self.view addSubview:shadowImageView];
    
    [self.view addSubview:circleLightView];
//    UIImage *k = [self maskImage:self.FimageView  withMask:[UIImage imageNamed:@"mask2.png"]];
//    self.FimageView = [[UIImageView alloc] initWithImage:k];
//    [self.view addSubview:self.FimageView];
    
}

- (void)handleF:(UILongPressGestureRecognizer *)recognizer
{
    self.pieChartLeft.delegate = nil;
    
    [self.pieChartLeft setAnimationSpeed:0.01];
    
    CGPoint movePoint = [recognizer locationInView:self.view];
    
    CGPoint startPoint = CGPointMake(_centerPoint.x,
                                     0);
    //    CGPoint endPoint = CGPointMake(_len_f*sin(_radio_f) + translation.x + _touchPointX,
    //                                   0-_len_f*cos(_radio_f) + translation.y + _touchPointY);
    CGPoint endPoint = CGPointMake(movePoint.x, movePoint.y);
    //NSLog(@"%f,%f",movePoint.x,movePoint.y);
    
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
    
    self.FimageView.transform = CGAffineTransformMakeRotation(_percent*2*M_PI);
    centerCircleView.transform = CGAffineTransformMakeRotation(_percent*2*M_PI+0.49*M_PI);
    
    
    
    if (_nonFinishedNumber <= (_percent-0.001)/(0.999-0.001) * _sumNumber) {
        //_nonFinishedNumber = 0;
        NSLog(@"%d",_nonFinishedNumber);
    }
    
    _nonFinishedNumber = (_percent-0.001)/(0.999-0.001) * _sumNumber;
    
    wordNumberTest.text =  [NSString stringWithFormat:@"%d",_nonFinishedNumber];
    
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
        //NSLog(@"Long Press began");
    }
    if ( recognizer.state == UIGestureRecognizerStateEnded ) {
        [UIView animateWithDuration:0.5 animations:^(){
            circleLightView.alpha = 0;
        }];
        //NSLog(@"Long Press ended");
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
    
    if (_percent > 50.0/100.0 && _percent <= 1) {
        _whetherMax = YES;
    }else{
        _whetherMax = NO;
    }
    
    if (_percent <= 50.0/100.0 && _percent >= 0) {
        _whetherMin = YES;
    }else{
        _whetherMin = NO;
    }
    
    _temp_percent = _percent;
}

//- (UIImage*) maskImage:(UIView *)image withMask:(UIImage *)maskImage {
//    
//    UIGraphicsBeginImageContext(image.bounds.size);
//    [image.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    
//    CGImageRef maskRef = maskImage.CGImage;
//    
//    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
//                                        CGImageGetHeight(maskRef),
//                                        CGImageGetBitsPerComponent(maskRef),
//                                        CGImageGetBitsPerPixel(maskRef),
//                                        CGImageGetBytesPerRow(maskRef),
//                                        CGImageGetDataProvider(maskRef), NULL, false);
//    
//    CGImageRef masked = CGImageCreateWithMask([viewImage CGImage], mask);
//    return [UIImage imageWithCGImage:masked];
//    
//}


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

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//}


#pragma mark - PieChart Data Source

- (void)pieChart:(PieChart*)pieChart isDoingAnimationAtPercent:(float)percent
{
    centerCircleView.transform = CGAffineTransformMakeRotation(((percent/(1-_percent)*_percent)*2*M_PI+0.49*M_PI));
    int wordNumber = round((1-percent)*_sumNumber);
    wordNumberTest.text = [NSString stringWithFormat:@"%d",wordNumber];
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

//- (UIColor *)pieChart:(PieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
//{
//    if(pieChart == self.pieChartRight) return nil;
//    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
//}

#pragma mark - PieChart Delegate
//- (void)pieChart:(PieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
//{
//    NSLog(@"did select slice at index %d",index);
//    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
