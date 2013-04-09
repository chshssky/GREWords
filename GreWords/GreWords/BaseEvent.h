//
//  BaseEvent.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEvent : NSObject

@property (nonatomic) NSString *info;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *endTime;

@end
