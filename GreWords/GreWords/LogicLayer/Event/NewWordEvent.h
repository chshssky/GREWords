//
//  NewWordEvent.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "BaseEvent.h"

@interface NewWordEvent : BaseEvent

@property (nonatomic) int indexOfWordToday;
@property (nonatomic) int maxWordID;
@property (nonatomic) BOOL reviewEnable;

@end
