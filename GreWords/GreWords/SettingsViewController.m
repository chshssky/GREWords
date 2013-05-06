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

- (void)SettingTabViewdidChangeTo:(int)index
{
    NSLog(@"Setting Now Select:%d",index);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tabs = [self.storyboard instantiateViewControllerWithIdentifier:@"settingDeck"];
    tabs.delegate = self;
    
    [self.tabViews addSubview:tabs.view];

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
