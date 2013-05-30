//
//  ReviewStatus.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-30.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@class History;

@interface ReviewStatus : IAThreadSafeManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * stage;
@property (nonatomic, retain) History *history;

@end
