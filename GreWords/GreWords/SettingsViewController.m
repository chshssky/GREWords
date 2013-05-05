//
//  SettingsViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-4-13.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingTabViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    
    
    
    SettingTabViewController *s1 = [[SettingTabViewController alloc] init];
    CGRect frame = s1.view.frame;
    frame.origin.y = -150;
    s1.view.frame = frame;
    s1.describeImage.image = [UIImage imageNamed:@"Settings_dataCover.png"];
    SettingTabViewController *s2 = [[SettingTabViewController alloc] init];
    frame.origin.y -= 35;
    s2.view.frame = frame;
    s2.describeImage.image = [UIImage imageNamed:@"Settings_viewCover.png"];
    SettingTabViewController *s3 = [[SettingTabViewController alloc] init];
    frame.origin.y -= 35;
    s3.view.frame = frame;
    s3.describeImage.image = [UIImage imageNamed:@"Settings_reviewCover.png"];
    SettingTabViewController *s4 = [[SettingTabViewController alloc] init];
    frame.origin.y -= 35;
    s4.view.frame = frame;
    s4.describeImage.image = [UIImage imageNamed:@"Settings_taskCover.png"];
    
    s1.originalFrame = s1.view.frame;
    s2.originalFrame = s2.view.frame;
    s3.originalFrame = s3.view.frame;
    s4.originalFrame = s4.view.frame;
    
    
    [self.tabViews addSubview:s1.view];
    [self.tabViews addSubview:s2.view];
    [self.tabViews addSubview:s3.view];
    [self.tabViews addSubview:s4.view];
    
    tabArr = @[s1,s2,s3,s4];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setExitButton:nil];
    [self setTabViews:nil];
    [super viewDidUnload];
}
- (IBAction)exitPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
