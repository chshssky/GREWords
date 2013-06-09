//
//  ReciteAndReviewResultCardController.m
//  GreWords
//
//  Created by xsource on 13-6-6.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "ReciteAndReviewResultCardController.h"

@interface ReciteAndReviewResultCardController ()

@end

@implementation ReciteAndReviewResultCardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configContent
{
    if([self.event isMemberOfClass: [NewWordEvent class]])
    {
        self.backgroundView.image = [UIImage imageNamed:@"learning_reciteResult.png"];
    }
    else
    {
        self.backgroundView.image = [UIImage imageNamed:@"learning_reviewResult.png"];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d个",self.event.totalWordCount];
    self.timeLabel.text = [NSString stringWithFormat:@"%d分钟",(int)(self.event.duration / 60.0)];
    self.percentLabel.text = [NSString stringWithFormat:@"%.02f",(float)100 - (self.event.wrongWordCount * 100.0 / self.event.totalWordCount)];
}

- (IBAction)homePressed:(id)sender
{
    NSLog(@"Home pressed");
    [self.delegate returnHome];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configContent];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
