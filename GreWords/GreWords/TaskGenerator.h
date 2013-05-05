//
//  TaskGenerator.h
//  GreWords
//
//  Created by xsource on 13-4-10.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskGenerator : NSObject
+ (TaskGenerator *)instance;
- (NSArray *)newWordTask_twoList:(int)day;
- (NSArray *)newWordTask_threeList:(int)day;
- (NSArray *)reviewTask_threeList:(int)day;
- (NSArray *)reviewTask_twoList:(int)day;
- (NSArray *)testTaskWithOptions:(NSDictionary *)dict;
- (void)setWhetherNoOrder:(bool)flag;


@property(nonatomic) bool whetherViewNoOrder;

@end
