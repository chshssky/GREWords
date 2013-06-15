//
//  SettingClockViewController.h
//  GreWords
//
//  Created by Song on 13-6-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingClockViewController;

@protocol SettingClockProtocal <NSObject>

-(void)clock:(SettingClockViewController*)clock timeChanged:(NSDate*)time;
-(void)clock:(SettingClockViewController*)clock timeEndChange:(NSDate*)time;

@end

@interface SettingClockViewController : UIViewController
@property (retain,nonatomic) id<SettingClockProtocal> delegate;
@property(nonatomic) bool whetherRecite;

-(void)setAlertTime:(NSDate*)date;
-(void)setStartTime:(NSDate*)date;
@end
