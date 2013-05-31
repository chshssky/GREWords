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
@property (nonatomic) UIViewController* vc;

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
    _vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mainScreen"];
    _vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:_vc animated:YES];
    
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
