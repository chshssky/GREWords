//
//  GreWordsViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-3-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreWordsViewController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "SmartWordListViewController.h"

@interface GreWordsViewController ()

@end

@implementation GreWordsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SmartWordListViewController *vc = [[SmartWordListViewController alloc] init];
//    for (int i=0; i<3073; i++) {
//        [vc displayWord:[[WordHelper instance] wordWithID:i] withOption:nil];
//    }
    //[vc displayWord:[[WordHelper instance] wordWithID:3] withOption:nil];
    [self.view addSubview:vc.view];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
