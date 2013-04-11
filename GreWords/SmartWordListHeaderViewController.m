//
//  SmartWordListHeaderViewController.m
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SmartWordListHeaderViewController.h"

@interface SmartWordListHeaderViewController ()

@end

@implementation SmartWordListHeaderViewController

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
    self.wordLabel.text = self.text;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWordLabel:nil];
    [super viewDidUnload];
}
@end
