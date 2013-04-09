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
- (NSArray *)newWordTask;
- (NSArray *)reviewTask;
- (NSArray *)testTaskWithOptions:(NSDictionary *)dict;
@end
