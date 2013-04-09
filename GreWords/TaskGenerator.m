//
//  TaskGenerator.m
//  GreWords
//
//  Created by xsource on 13-4-10.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "TaskGenerator.h"

@implementation TaskGenerator

TaskGenerator* _taskGeneratorInstance = nil;

+ (TaskGenerator*)instance
{
    if(!_taskGeneratorInstance)
    {
        _taskGeneratorInstance = [[TaskGenerator alloc] init];
    }
    return _taskGeneratorInstance;
}

- (NSArray *)newWordTask
{
    NSArray *task = [[NSArray alloc] init];
    
    return task;
}

- (NSArray *)reviewTask
{
    NSArray *task = [[NSArray alloc] init];
    
    return task;
}

- (NSArray *)testTaskWithOptions:(NSDictionary *)dict
{
    NSArray *task = [[NSArray alloc] init];
    
    return task;
}


@end
