//
//  WelcomeViewController.m
//  GreWords
//
//  Created by Song on 13-5-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WelcomeViewController.h"

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goPressed:(id)sender
{
    NSLog(@"Go Pressed");
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
