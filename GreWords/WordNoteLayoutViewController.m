//
//  WordNoteLayoutViewController.m
//  GreWords
//
//  Created by xsource on 13-5-17.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordNoteLayoutViewController.h"
#import "NSDate-Utilities.h"

@interface WordNoteLayoutViewController ()

@end

@implementation WordNoteLayoutViewController
@synthesize sumHeight = _sumHeight;

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
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayNote:(WordEntity *)word
{
    _sumHeight = 5.0f;
    
    UIImageView *rectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_meaning_rect.png"]];
    rectImage.frame = CGRectMake(12, _sumHeight, 296, 25);
    [self.view addSubview:rectImage];
    [self.view sendSubviewToBack:rectImage];
    
    _sumHeight = _sumHeight+2;
    CGRect labelRect = CGRectMake(10, _sumHeight, 105, 25);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:labelRect];
    titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
    titleLabel.textColor = [UIColor colorWithRed:209.0/255.0 green:134.0/255.0 blue:39/255.0 alpha:1];
    titleLabel.text = @"【记录时间】";
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel sizeToFit];
    [self.view addSubview:titleLabel];
    
    CGRect timeRect = CGRectMake(130, _sumHeight, 215, 25);
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:timeRect];
    timeLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17];
    
    NSDate *createAt = word.noteCreateAt;
    timeLabel.text = [NSString stringWithFormat:@"%d-%d-%d",createAt.year,createAt.month,createAt.day];
    //timeLabel.text = word.note.time;
    timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    timeLabel.numberOfLines = 0;
    timeLabel.backgroundColor = [UIColor clearColor];
    [timeLabel sizeToFit];
    [self.view addSubview:timeLabel];
    _sumHeight = timeLabel.frame.origin.y + timeLabel.frame.size.height + 8.0;
    
    
    CGRect contentRect = CGRectMake(30, _sumHeight, 258, 220);
    UITextView *noteTextView = [[UITextView alloc] initWithFrame:contentRect];
    [noteTextView setFont:[UIFont fontWithName:@"Noteworthy" size:18]];
    [noteTextView setBackgroundColor:[UIColor clearColor]];
    [noteTextView setEditable:NO];
    noteTextView.text = word.note;
    _sumHeight = noteTextView.frame.origin.y + noteTextView.frame.size.height + 8.0;
    
    [self.view addSubview:noteTextView];
    
    CGRect frame = self.view.frame;
    frame.size.height = self.sumHeight;
    self.view.frame = frame;
}

@end
