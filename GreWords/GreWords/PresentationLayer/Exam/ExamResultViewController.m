//
//  ExamResultViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "ExamResultViewController.h"

@interface ExamResultViewController ()

@end

@implementation ExamResultViewController

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
    [self setMemoryRate:nil];
    [self setTotalCount:nil];
    [self setRightCount:nil];
    [self setWrongCount:nil];
    [self setAgainImage:nil];
    [self setHomeImage:nil];
    [super viewDidUnload];
}

- (IBAction)againPressed:(id)sender {
    
}
- (IBAction)homePressed:(id)sender {
    [self.delegate returnHome];
}


@end
