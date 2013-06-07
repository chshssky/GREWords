//
//  TaskStatus.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-29.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ExamEvent.h"
#import "ReviewEvent.h"
#import "NewWordEvent.h"

enum TaskType {
    TASK_TYPE_NEWWORD = 0,
    TASK_TYPE_REVIEW = 1,
    TASK_TYPE_EXAM = 2,
};

@interface TaskStatus : NSObject

@property (nonatomic) enum TaskType taskType;

@property (nonatomic, strong) NewWordEvent *nwEvent;
@property (nonatomic, strong) ReviewEvent *rEvent;
@property (nonatomic, strong) ExamEvent *eEvent;

@property (nonatomic) int indexOfWordIDToday;
@property (nonatomic) int stage_now;
@property (nonatomic) int day;
@property (nonatomic) int maxWordID;
@property (nonatomic) int wrongWordCount;
@property (nonatomic) BOOL reviewEnable;

@property (nonatomic) int indexOfExam;
@property (nonatomic) int difficulty;
@property (nonatomic) int duration;
@property (nonatomic) int totalWordCount;

+ (TaskStatus *)instance;

- (void)beginNewWord;
- (void)beginReview;

- (void)beginExam;
- (void)endExam;

- (void)setReviewEnable;
- (BOOL)getReviewEnable;

@end
