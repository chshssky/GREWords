//
//  DashboardProtocal.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-21.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DashboardProtocal <NSObject>

- (void)resetIndexOfWordList:(int)remainWords;
- (void)bigButtonPressed;

@end
