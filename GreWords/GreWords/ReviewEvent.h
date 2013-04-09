//
//  ReviewEvent.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "BaseEvent.h"

@interface ReviewEvent : BaseEvent

@property (nonatomic) enum Stage stage_now;
@property (nonatomic) int unit;
@property (nonatomic) int orderInUnit;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) int totalWordCount;
@property (nonatomic) int wrongWordCount;

@end
