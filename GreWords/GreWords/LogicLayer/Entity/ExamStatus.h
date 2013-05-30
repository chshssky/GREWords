//
//  ExamStatus.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-30.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@class History;

@interface ExamStatus : IAThreadSafeManagedObject

@property (nonatomic, retain) NSNumber * difficulty;
@property (nonatomic, retain) History *history;

@end
