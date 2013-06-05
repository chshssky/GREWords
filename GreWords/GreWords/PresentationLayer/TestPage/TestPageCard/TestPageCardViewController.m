//
//  TestPageCardViewController.m
//  GreWords
//
//  Created by xsource on 13-6-4.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "TestPageCardViewController.h"
#import "NSDate-Utilities.h"

@interface TestPageCardViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation TestPageCardViewController

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
    
    NSDate *date = self.event.startTime;
    
    self.dateLabel.text = [NSString stringWithFormat:@"%d年%d月%d日 %02d:%02d",[date year],[date month],[date day],[date hour],[date minute]];
    self.sumNumberLabel.text = [NSString stringWithFormat:@"%d",self.event.totalWordCount];
    self.wrongNumberLabel.text = [NSString stringWithFormat:@"%d",self.event.wrongWordCount];
    self.rightNumberLabel.text = [NSString stringWithFormat:@"%d",self.event.totalWordCount - self.event.wrongWordCount];
    
    switch (self.event.difficulty) {
        case 0:
            self.levelLabel.text = @"易";
            break;
        case 1:
            self.levelLabel.text = @"中";
            break;
        case 2:
            self.levelLabel.text = @"难";
            break;
        default:
            break;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d分钟",(int)(self.event.duration / 60.0)];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!iPhone5) {
        [_backgroundImageView setImage:[UIImage imageNamed:@"history exam_upCardBottom_mini.png"]];
        [_backgroundImageView sizeToFit];
        _dateLabel.center = CGPointMake(_dateLabel.center.x, _dateLabel.center.y - 8);
        _sumNumberLabel.center = CGPointMake(_sumNumberLabel.center.x, _sumNumberLabel.center.y - 20);
        _rightNumberLabel.center = CGPointMake(_rightNumberLabel.center.x, _rightNumberLabel.center.y - 20);
        _wrongNumberLabel.center = CGPointMake(_wrongNumberLabel.center.x, _wrongNumberLabel.center.y - 20);
        _scoreNumberLabel.center = CGPointMake(_scoreNumberLabel.center.x, _scoreNumberLabel.center.y - 20);
        _levelLabel.center = CGPointMake(_levelLabel.center.x, _levelLabel.center.y - 20);
        _timeLabel.center = CGPointMake(_timeLabel.center.x, _timeLabel.center.y - 20);
    }
    
    
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.textColor = [UIColor colorWithRed:135/255.0 green:168/255.0 blue:57.0/255.0 alpha:1];
    _dateLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
    
    _sumNumberLabel.textAlignment = NSTextAlignmentCenter;
    _sumNumberLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:150.0/255.0 blue:57.0/255.0 alpha:1];
    _sumNumberLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
    
    _rightNumberLabel.textAlignment = NSTextAlignmentCenter;
    _rightNumberLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:150.0/255.0 blue:57.0/255.0 alpha:1];
    _rightNumberLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
    
    _wrongNumberLabel.textAlignment = NSTextAlignmentCenter;
    _wrongNumberLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:150.0/255.0 blue:57.0/255.0 alpha:1];
    _wrongNumberLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
    
    _scoreNumberLabel.text = [NSString stringWithFormat:@"%.1f",[_rightNumberLabel.text floatValue] * 100/[_sumNumberLabel.text floatValue]];
    _scoreNumberLabel.textAlignment = NSTextAlignmentCenter;
    _scoreNumberLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:150.0/255.0 blue:57.0/255.0 alpha:1];
    _scoreNumberLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:55];
    
    _levelLabel.textAlignment = NSTextAlignmentCenter;
    _levelLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:150.0/255.0 blue:57.0/255.0 alpha:1];
    _levelLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:13];
    
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:150.0/255.0 blue:57.0/255.0 alpha:1];
    _timeLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:13];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setSumNumberLabel:nil];
    [self setRightNumberLabel:nil];
    [self setWrongNumberLabel:nil];
    [self setScoreNumberLabel:nil];
    [self setLevelLabel:nil];
    [self setDateLabel:nil];
    [self setBackgroundImageView:nil];
    [super viewDidUnload];
}
@end
