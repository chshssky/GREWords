//
//  GreWordsViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-3-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreWordsViewController.h"
#import "WordLayoutViewController.h"

@interface GreWordsViewController ()

@end

@implementation GreWordsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    WordLayoutViewController *vc = [[WordLayoutViewController alloc] init];
    WordEntity *word = [[WordEntity alloc] init];
    [vc displayWord:word withOption:nil];
    [self.view addSubview:vc.view];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
