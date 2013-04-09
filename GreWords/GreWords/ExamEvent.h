//
//  ExamEvent.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "BaseEvent.h"

@interface ExamEvent : BaseEvent

@property (nonatomic) int totalWordCount;
@property (nonatomic) int wrongWordCount;
@property (nonatomic) int difficulty;
@property (nonatomic) NSTimeInterval duration;


@end
