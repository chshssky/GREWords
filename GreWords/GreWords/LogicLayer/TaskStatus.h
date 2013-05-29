//
//  TaskStatus.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-29.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskStatus : NSObject

@property (nonatomic) int indexOfWordIDToday;
@property (nonatomic) int stage_now;
@property (nonatomic) int day;
@property (nonatomic) int maxWordID;
@property (nonatomic) int wrongWordCount;
@property (nonatomic) BOOL reviewEnable;

+ (TaskStatus *)instance;

- (void)beginNewWord;

- (void)setReviewEnable;
- (BOOL)getReviewEnable;

@end
