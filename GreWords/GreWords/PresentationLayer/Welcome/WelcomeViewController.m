//
//  WelcomeViewController.m
//  GreWords
//
//  Created by Song on 13-5-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WelcomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GuideSettingViewController.h"
#import "ConfigurationHelper.h"

@interface WelcomeViewController ()
{
    GuideSettingViewController *lastPage;
}
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
    [self.scrollView setContentSize:CGSizeMake(320 * 5, self.scrollView.frame.size.height)];
    if(!iPhone5)
    {
        _v1i.image = [UIImage imageNamed:@"Welcome1_960.png"];
        _v2i.image = [UIImage imageNamed:@"Welcome2_960.png"];
        _v3i.image = [UIImage imageNamed:@"Welcome3_960.png"];
        _v4i.image = [UIImage imageNamed:@"Welcome4_bg_960.png"];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    lastPage = [[GuideSettingViewController alloc] init];
    lastPage.pview = self;
    lastPage.view.frame = self.v1.frame;
    [self.v5 addSubview:lastPage.view];
    [self.scrollView sendSubviewToBack:self.v5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goPressed:(id)sender
{
    int stage = [lastPage stage];
    NSLog(@"initing for stage:%d",stage);
    [[ConfigurationHelper instance] initData];
    [[ConfigurationHelper instance] initConfigsForStage:stage];
    
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
    [self setV5:nil];
    [super viewDidUnload];
}
@end
