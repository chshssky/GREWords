//
//  ProgressBarViewController.h
//  GreWords
//
//  Created by xsource on 13-6-14.
//  Copyright (c) 2013年 TAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressBarViewController : UIViewController
- (void)setStage:(int)stage andDayOfSchedule:(int)day;
//- (void)changeStageTo:(int)stage andDayOfScheduleTo:(int)day;
@property (nonatomic) int stage;
@property (nonatomic) int day;
+ (ProgressBarViewController*)instance;
@end
