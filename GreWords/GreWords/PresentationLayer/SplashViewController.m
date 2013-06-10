//
//  SplashViewController.m
//  GreWords
//
//  Created by Song on 13-5-28.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SplashViewController.h"
#import "ConfigurationHelper.h"
#import "WelcomeViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

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
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    if(!iPhone5)
    {
        self.splashImageView.image = [UIImage imageNamed:@"Default.png"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    UIViewController *vc;
    if([[ConfigurationHelper instance] isFirstTimeRun])
    {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"welcomeVC"];
    }
    else
    {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mainScreen"];
    }
    [self presentModalViewController:vc animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSplashImageView:nil];
    [super viewDidUnload];
}
@end
