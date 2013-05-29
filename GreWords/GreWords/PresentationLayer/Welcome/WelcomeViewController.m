//
//  WelcomeViewController.m
//  GreWords
//
//  Created by Song on 13-5-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WelcomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    [self.scrollView setContentSize:CGSizeMake(320*4, self.scrollView.frame.size.height)];
    if(!iPhone5)
    {
        _v1i.image = [UIImage imageNamed:@"Welcome1_960.png"];
        _v2i.image = [UIImage imageNamed:@"Welcome2_960.png"];
        _v3i.image = [UIImage imageNamed:@"Welcome3_960.png"];
        _v4i.image = [UIImage imageNamed:@"Welcome4_bg_960.png"];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goPressed:(id)sender
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 1)];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.duration = 0.2;
    scaleAnimation.delegate = self;
    [scaleAnimation setValue:@"removeGuide" forKey:@"id"];
    [self.view.layer addAnimation:scaleAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeGuide"])
    {
        UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mainScreen"];
        [self presentModalViewController:vc animated:NO];
    }
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setV1:nil];
    [self setV2:nil];
    [self setV3:nil];
    [self setV4:nil];
    [self setV1i:nil];
    [self setV2i:nil];
    [self setV3i:nil];
    [self setV4i:nil];
    [super viewDidUnload];
}
@end
