//
//  TaskStatus.m
//  GreWords
//
//  Created by 崔 昊 on 13-5-29.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "TaskStatus.h"

#import "HistoryManager.h"

#import "WordTaskGenerator.h"

#import "ConfigurationHelper.h"

@implementation TaskStatus

TaskStatus* _taskStatusInstance = nil;

+ (TaskStatus *)instance
{
    if(!_taskStatusInstance)
    {
        _taskStatusInstance = [[TaskStatus alloc] init];
    }
    return _taskStatusInstance;
}

- (NewWordEvent *)nwEvent
{
    if (_nwEvent == nil) {
        _nwEvent = [[NewWordEvent alloc] init];
    }
    return _nwEvent;
}

- (ReviewEvent *)rEvent
{
    if (_rEvent == nil) {
        _rEvent = [[ReviewEvent alloc] init];
    }
    return _rEvent;
}

-(ExamEvent *)eEvent
{
    if (_eEvent == nil) {
        _eEvent = [[ExamEvent alloc] init];
    }
    return _eEvent;
}

- (void)beginExam
{
    self.eEvent.index = 0;
    self.eEvent.difficulty = 0;
    self.eEvent.duration = 0;
    self.eEvent.wrongWordCount = 0;
    self.eEvent.totalWordCount = 0;
}

- (void)endExam
{
    self.eEvent.index = 0;
    self.eEvent.difficulty = 0;
    self.eEvent.duration = 0;
    self.eEvent.wrongWordCount = 0;
    self.eEvent.totalWordCount = 0;
}
//
//- (int)getANewDay
//{
//    int day = [[HistoryManager instance] getANewDay];
//    if (day >= 31) {
//        day = 0;
//        self.nwEvent.stage_now ++;
//        self.rEvent.stage_now ++;
//    }
//    return day;
//}

- (void)beginNewWord
{
    self.taskType = TASK_TYPE_NEWWORD;
    
    self.nwEvent.indexOfWordToday = 0;
    self.nwEvent.maxWordID = 0;
    self.nwEvent.reviewEnable = NO;
    self.nwEvent.wrongWordCount = 0;
    self.nwEvent.stage_now = [[HistoryManager instance] currentStage];

    int day = [[HistoryManager instance] getANewDay];
    if (day > 28) {
        day = 0;
        self.nwEvent.stage_now ++;
        [[ConfigurationHelper instance] initConfigsForStage:self.nwEvent.stage_now];
    }
    self.nwEvent.dayOfSchedule = day;
    
    self.nwEvent.totalWordCount = 0;
    
    
    self.nwEvent.newWordCount = [[WordTaskGenerator instance] theNumberOfNewWordToday_twolist:[TaskStatus instance].nwEvent.dayOfSchedule];
    
    self.nwEvent.eventType = EVENT_TYPE_NEWWORD;
    self.nwEvent.startTime = [NSDate new];
}

- (void)beginReview
{
    self.taskType = TASK_TYPE_REVIEW;
    
    self.rEvent.indexOfWordToday = 0;
    self.rEvent.wrongWordCount = 0;
    self.rEvent.stage_now = [[HistoryManager instance] currentStage];
    

    int day = [[HistoryManager instance] getANewDay];
    
    
    if (self.rEvent.stage_now != 3 && day > 28) {
        day = 0;
        self.rEvent.stage_now ++;
        [[ConfigurationHelper instance] initConfigsForStage:self.rEvent.stage_now];
    }
    self.rEvent.dayOfSchedule = day;
    
    self.rEvent.eventType = EVENT_TYPE_REVIEW;
    self.rEvent.startTime = [NSDate new];
    if (self.rEvent.stage_now == 3) {
        self.rEvent.newWordCount = 500;
    } else {
        self.rEvent.newWordCount = [[[WordTaskGenerator instance] reviewTask_twoList:[TaskStatus instance].rEvent.dayOfSchedule] count];
    }
    self.rEvent.totalWordCount = 0;
}


- (void)setReviewEnable:(BOOL)enable
{
    self.nwEvent.reviewEnable = enable;
}

- (void)setReviewEnable
{
    self.nwEvent.reviewEnable = YES;
}

- (BOOL)getReviewEnable
{
    return self.nwEvent.reviewEnable;
}

- (BOOL)isNewWordComplete
{
    return [[HistoryManager instance] isNewWordComplete];
}

- (BOOL)isReviewComplete
{
    return [[HistoryManager instance] isReviewComplete];
}


@end
