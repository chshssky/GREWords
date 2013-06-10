//
//  SelectorController.m
//  GreWords
//
//  Created by xsource on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SelectorController.h"
#import "NSNotificationCenter+Addition.h"

@interface SelectorController ()
@property (weak, nonatomic) IBOutlet UIButton *tenMinButton;
@property (weak, nonatomic) IBOutlet UIButton *thirtyMinButton;
@property (weak, nonatomic) IBOutlet UIButton *sixtyMinButton;
@property (weak, nonatomic) IBOutlet UIButton *easyButton;
@property (weak, nonatomic) IBOutlet UIButton *mediumButton;
@property (weak, nonatomic) IBOutlet UIButton *hardButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic) NSString *time;
@property (nonatomic) NSString *level;

@end

@implementation SelectorController

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
    self.time = @"10min";
    self.level = @"easy";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)easyButtonClicked:(id)sender {
    [_easyButton setImage:[UIImage imageNamed:@"test easy_choose.png"] forState:UIControlStateNormal];
    [_mediumButton setImage:[UIImage imageNamed:@"test medium.png"] forState:UIControlStateNormal];
    [_hardButton setImage:[UIImage imageNamed:@"test hard.png"] forState:UIControlStateNormal];
    
    _level = @"easy";
}

- (IBAction)mediumButtonClicked:(id)sender {
    [_easyButton setImage:[UIImage imageNamed:@"test easy.png"] forState:UIControlStateNormal];
    [_mediumButton setImage:[UIImage imageNamed:@"test medium_choose.png"] forState:UIControlStateNormal];
    [_hardButton setImage:[UIImage imageNamed:@"test hard.png"] forState:UIControlStateNormal];
    
    _level = @"medium";
}

- (IBAction)hardButtonClicked:(id)sender {
    [_easyButton setImage:[UIImage imageNamed:@"test easy.png"] forState:UIControlStateNormal];
    [_mediumButton setImage:[UIImage imageNamed:@"test medium.png"] forState:UIControlStateNormal];
    [_hardButton setImage:[UIImage imageNamed:@"test hard_choose.png"] forState:UIControlStateNormal];
    
    _level = @"hard";
}

- (IBAction)tenMinButtonClicked:(id)sender {
    [_tenMinButton setImage:[UIImage imageNamed:@"test 10min_choose.png"] forState:UIControlStateNormal];
    [_thirtyMinButton setImage:[UIImage imageNamed:@"test 30min.png"] forState:UIControlStateNormal];
    [_sixtyMinButton setImage:[UIImage imageNamed:@"test 60min.png"] forState:UIControlStateNormal];
    
    _time = @"10min";
}

- (IBAction)thirtyMinButtonClicked:(id)sender {
    [_tenMinButton setImage:[UIImage imageNamed:@"test 10min.png"] forState:UIControlStateNormal];
    [_thirtyMinButton setImage:[UIImage imageNamed:@"test 30min_choose.png"] forState:UIControlStateNormal];
    [_sixtyMinButton setImage:[UIImage imageNamed:@"test 60min.png"] forState:UIControlStateNormal];
    
    _time = @"30min";
}

- (IBAction)sixtyButtonClicked:(id)sender {
    [_tenMinButton setImage:[UIImage imageNamed:@"test 10min.png"] forState:UIControlStateNormal];
    [_thirtyMinButton setImage:[UIImage imageNamed:@"test 30min.png"] forState:UIControlStateNormal];
    [_sixtyMinButton setImage:[UIImage imageNamed:@"test 60min_choose.png"] forState:UIControlStateNormal];
    
    _time = @"60min";
}

- (IBAction)startButtonClicked:(id)sender {
    NSDictionary *examInfo = @{@"time":_time, @"level":_level};
    [NSNotificationCenter postStartExamNotification:examInfo];
}

- (void)ChangeTestOfBeginTestLabelWith:(NSString *)text
{
    self.beginTestLabel.text = text;
}

- (void)viewDidUnload {
    [self setTenMinButton:nil];
    [self setThirtyMinButton:nil];
    [self setSixtyMinButton:nil];
    [self setEasyButton:nil];
    [self setMediumButton:nil];
    [self setHardButton:nil];
    [self setStartButton:nil];
    [self setBeginTestLabel:nil];
    [super viewDidUnload];
}
@end
