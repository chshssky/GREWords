//
//  TaskStatus.m
//  GreWords
//
//  Created by 崔 昊 on 13-5-29.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "TaskStatus.h"

#import "HistoryManager.h"


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


- (void)beginNewWord
{
    self.taskType = TASK_TYPE_NEWWORD;
    
    self.nwEvent.indexOfWordToday = 799;
    self.nwEvent.maxWordID = 199;
    self.nwEvent.stage_now = 0;
    self.nwEvent.reviewEnable = YES;
    self.nwEvent.wrongWordCount = 0;
    
    self.nwEvent.dayOfSchedule = [[HistoryManager instance] getANewDay];
}

- (void)beginReview
{
    self.taskType = TASK_TYPE_REVIEW;
    self.rEvent.indexOfWordToday = 0;
    self.rEvent.wrongWordCount = 0;
    self.rEvent.stage_now = 0;
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


@end
