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

//@property (nonatomic) BOOL nwComplete;
//@property (nonatomic) BOOL rComplete;

+ (TaskStatus *)instance;

- (void)beginNewWord;
- (void)beginReview;

- (void)beginExam;
- (void)endExam;

- (void)setReviewEnable;
- (void)setReviewEnable:(BOOL)enable;
- (BOOL)getReviewEnable;

- (BOOL)isNewWordComplete;
- (BOOL)isReviewComplete;

@end
