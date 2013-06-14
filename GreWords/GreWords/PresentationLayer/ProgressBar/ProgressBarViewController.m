//
//  ProgressBarViewController.m
//  GreWords
//
//  Created by xsource on 13-6-14.
//  Copyright (c) 2013年 TAC. All rights reserved.
//

#import "ProgressBarViewController.h"

@interface ProgressBarViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *statusText;

@end

@implementation ProgressBarViewController

ProgressBarViewController* _progressBarViewController = nil;


+ (ProgressBarViewController*)instance
{
    if(!_progressBarViewController)
    {
        _progressBarViewController = [[ProgressBarViewController alloc] init];
    }
    return _progressBarViewController;
}

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

- (void)viewWillAppear:(BOOL)animated
{
    [self setStage:_stage andDayOfSchedule:_day];
}

- (void)setStage:(int)stage andDayOfSchedule:(int)day
{
    if (stage == 1) {
        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus1.png"]];
        if (day <= 99) {
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第一阶段",@"第",day,@"天"]];
        }else{
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%@%@",@"第一阶段",@"第",@"99+",@"天"]];
        }
        _statusText.center = CGPointMake(84, 35);
        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
    }else if (stage == 2) {
        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus2.png"]];
        if (day <= 99) {
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第二阶段",@"第",day,@"天"]];
        }else{
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%@%@",@"第二阶段",@"第",@"99+",@"天"]];
        }
        _statusText.center = CGPointMake(140, 35);
        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
    }else if (stage == 3) {
        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus3.png"]];
        if (day <= 99) {
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第三阶段",@"第",day,@"天"]];
        }else{
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%@%@",@"第三阶段",@"第",@"99+",@"天"]];
        }
        _statusText.center = CGPointMake(198, 35);
        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
    }else if (stage == 4) {
        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus4.png"]];
        if (day <= 99) {
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第四阶段",@"第",day,@"天"]];
        }else{
            _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%@%@",@"第四阶段",@"第",@"99+",@"天"]];
        }
        _statusText.center = CGPointMake(250, 35);
        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
    }
}

//- (void)changeStageTo:(int)stage andDayOfScheduleTo:(int)day
//{
//    if (stage == 1) {
//        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus1.png"]];
//        _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第一阶段",@"第",day,@"天"]];
//        _statusText.center = CGPointMake(84, 35);
//        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
//    }else if (stage == 2) {
//        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus2.png"]];
//        _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第二阶段",@"第",day,@"天"]];
//        _statusText.center = CGPointMake(140, 35);
//        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
//    }else if (stage == 3) {
//        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus3.png"]];
//        _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第三阶段",@"第",day,@"天"]];
//        _statusText.center = CGPointMake(198, 35);
//        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
//    }else if (stage == 4) {
//        [_statusImage setImage:[UIImage imageNamed:@"Main menu_slideStatus4.png"]];
//        _statusText.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@,%@%d%@",@"第四阶段",@"第",day,@"天"]];
//        _statusText.center = CGPointMake(250, 35);
//        [_statusText setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:18]];
//    }
//}

- (void)viewDidUnload {
    [self setStatusImage:nil];
    [self setStatusText:nil];
    [super viewDidUnload];
}
@end
