//
//  ExamStatus.h
//  GreWords
//
//  Created by 崔 昊 on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class History;

@interface ExamStatus : NSManagedObject

@property (nonatomic, retain) NSNumber * difficulty;
@property (nonatomic, retain) History *history;

@end
