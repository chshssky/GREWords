//
//  SettingClockViewController.h
//  GreWords
//
//  Created by Song on 13-6-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingClockProtocal <NSObject>

-(void)clockTimeChanged:(NSDate*)time;
-(void)clockTimeEndChange:(NSDate*)time;

@end

@interface SettingClockViewController : UIViewController
@property (retain,nonatomic) id<SettingClockProtocal> delegate;

-(void)setAlertTime:(NSDate*)date;

@end
