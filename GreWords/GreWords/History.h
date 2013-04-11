//
//  History.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-10.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface History : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * event;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * totalWordCount;
@property (nonatomic, retain) NSNumber * wrongWordCount;
@property (nonatomic, retain) NSNumber * duration;

@end
