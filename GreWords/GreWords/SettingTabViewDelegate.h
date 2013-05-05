//
//  SettingTabViewDelegate.h
//  GreWords
//
//  Created by Song on 13-5-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

//#import "SettingTabViewController.h"
#import <Foundation/Foundation.h>

@class SettingTabViewController;

@protocol SettingTabViewDelegate

- (void)SettingTabViewdidChangeState:(SettingTabViewController*) tabView;
@end
