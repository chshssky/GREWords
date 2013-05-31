//
//  GreTableViewSearchIndexIndicatorViewController.m
//  GreWords
//
//  Created by Song on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreTableViewSearchIndexIndicatorViewController.h"

@interface GreTableViewSearchIndexIndicatorViewController ()

@end

@implementation GreTableViewSearchIndexIndicatorViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBackgroundVIew:nil];
    [self setIndicatorLabel:nil];
    [super viewDidUnload];
}
@end
