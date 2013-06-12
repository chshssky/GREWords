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
- (void)endEvent:(BaseEvent *)aEvent;
- (void)deleteEvent:(BaseEvent *)aEvent;

//Statistic Methods
- (BOOL)readStatusIfNew;

//- (BOOL)isNewWordPaused;
//- (BOOL)isReviewPaused;
- (int)currentStage;
//- (float)currentStageProgress;
//- (BOOL)isFinishedForDate:(NSDate *)date;

- (NSArray *)newWordEventsInStage:(int)stage;
- (NSArray *)reviewEventsInStage:(int)stage;
- (NSArray *)examEventsInStage:(int)stage;


//- (NSArray *)errorRatioInExams;
//- (NSArray *)dateAndDurationInStage:(int)stage;

- (int)getANewDay;

- (BOOL)isNewWordComplete;
- (BOOL)isReviewComplete;

@end
