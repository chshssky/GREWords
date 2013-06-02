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

- (void)beginNewWord
{
    self.taskType = TASK_TYPE_NEWWORD;
    
    self.indexOfWordIDToday = 0;
    self.maxWordID = 0;
    self.stage_now = 0;
    self.reviewEnable = NO;
    self.wrongWordCount = 0;
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
