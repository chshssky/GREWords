//
//  History.h
//  GreWords
//
//  Created by 崔 昊 on 13-6-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@class ExamStatus, NewWordStatus, ReviewStatus;

@interface History : IAThreadSafeManagedObject

@property (nonatomic, retain) NSNumber * dayOfSchedule;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * event;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * totalWordCount;
@property (nonatomic, retain) NSNumber * wrongWordCount;
@property (nonatomic, retain) NSNumber * stage;
@property (nonatomic, retain) ExamStatus *examStatus;
@property (nonatomic, retain) NewWordStatus *newWordStatus;
@property (nonatomic, retain) ReviewStatus *reviewStatus;

@end
