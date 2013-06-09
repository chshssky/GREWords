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
    self.totalWordCountLabel.text = [NSString stringWithFormat:@"%d",self.event.totalWordCount];
    self.forgetCountLabel.text = [NSString stringWithFormat:@"%d",self.event.wrongWordCount];
    self.rememberCountLabel.text = [NSString stringWithFormat:@"%d",self.event.totalWordCount - self.event.wrongWordCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"%.01f%%",((float)self.event.totalWordCount - self.event.wrongWordCount) * 100 / self.event.totalWordCount];
    if(self.event.totalWordCount == 0)
    {
        self.scoreLabel.text = @"0";
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%d分钟",(int)(self.event.duration / 60.0)];
    if(self.event.difficulty == 0)
    {
        self.timeLabel.text = @"简单";
    }
    else if(self.event.difficulty == 1)
    {
        self.timeLabel.text = @"中等";
    }
    else if(self.event.difficulty == 2)
    {
        self.timeLabel.text = @"困难";
    }
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
    [self.delegate backHome];
}

- (IBAction)reexamPressed:(id)sender
{
    [self.delegate reExam];
}
@end
