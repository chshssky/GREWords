//
//  HistoryStatisticsViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-4-13.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "HistoryStatisticsViewController.h"

@interface HistoryStatisticsViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setExitButton:nil];
    [super viewDidUnload];
}
- (IBAction)exitPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
