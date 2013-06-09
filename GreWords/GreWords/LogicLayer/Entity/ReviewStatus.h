//
//  ReviewStatus.h
//  GreWords
//
//  Created by 崔 昊 on 13-6-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class History;

@interface ReviewStatus : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) History *history;

@end
