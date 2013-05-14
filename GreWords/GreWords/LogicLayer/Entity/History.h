//
//  History.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-14.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@interface History : IAThreadSafeManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * event;
@property (nonatomic, retain) NSData * info;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * totalWordCount;
@property (nonatomic, retain) NSNumber * wrongWordCount;

@end
