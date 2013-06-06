//
//  ExamResultCardController.m
//  GreWords
//
//  Created by xsource on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "ExamResultCardController.h"

@interface ExamResultCardController ()

@end

@implementation ExamResultCardController

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

- (void)viewDidUnload
{
    [self setScoreLabel:nil];
    [self setDifficultLabel:nil];
    [self setTimeLabel:nil];
    [self setTotalWordCountLabel:nil];
    [self setRememberCountLabel:nil];
    [self setForgetCountLabel:nil];
    [super viewDidUnload];
}
- (IBAction)homePressed:(id)sender
{
    
}

- (IBAction)reexamPressed:(id)sender
{
    
}
@end
