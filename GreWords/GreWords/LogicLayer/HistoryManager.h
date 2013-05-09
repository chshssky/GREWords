//
//  HistoryManager.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEvent.h"

@interface HistoryManager : NSObject



+ (HistoryManager *)instance;

- (void)addEvent:(BaseEvent *)aEvent;
- (void)updateEvent:(BaseEvent *)aEvent;

//Statistic Methods

- (int)currentStage;
- (float)currentStageProgress;
- (BOOL)isFinishedForDate:(NSDate *)date;

- (NSArray *)errorRatioInExams;
- (NSArray *)dateAndDurationInStage:(int)stage;

@end
