//
//  TaskStatus.m
//  GreWords
//
//  Created by 崔 昊 on 13-5-29.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "TaskStatus.h"

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

- (void)beginExam
{
    self.indexOfExam = 0;
    self.difficulty = 0;
    self.duration = 0;
    self.wrongWordCount = 0;
    self.totalWordCount = 0;
}

- (void)endExam
{
    self.indexOfExam = 0;
    self.difficulty = 0;
    self.duration = 0;
    self.wrongWordCount = 0;
    self.totalWordCount = 0;
}


- (void)beginNewWord
{
    self.taskType = TASK_TYPE_NEWWORD;
    
    self.indexOfWordIDToday = 796;
    self.maxWordID = 199;
    self.stage_now = 0;
    self.reviewEnable = YES;
    self.wrongWordCount = 100;
}

- (void)beginReview
{
    self.taskType = TASK_TYPE_REVIEW;
    self.indexOfWordIDToday = 0;
    self.wrongWordCount = 0;
    self.stage_now = 0;
}


- (void)setReviewEnable
{
    self.reviewEnable = YES;
}

- (BOOL)getReviewEnable
{
    return self.reviewEnable;
}


@end
