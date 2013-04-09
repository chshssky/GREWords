//
//  HistoryManager.m
//  GreWords
//
//  Created by 崔 昊 on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "HistoryManager.h"
#import "MyDataStorage.h"

@implementation HistoryManager

HistoryManager* _historyManagerInstance = nil;

+ (HistoryManager*)instance
{
    if(!_historyManagerInstance)
    {
        _historyManagerInstance = [[HistoryManager alloc] init];
    }
    return _historyManagerInstance;
}

- (void)addEvent:(BaseEvent *)aEvent
{
    
    
}

- (void)updateEvent:(BaseEvent *)aEvent
{
    
}

//Statistic Methods

- (int)currentStage
{
    MyDataStorage *myDataStorage;
    [myDataStorage managedObjectContext];
    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
//    
//    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"foodID" ascending:NO]];
//    [request setFetchLimit:1];
//    NSError *foodError = nil;
//    NSArray *foodMatches = [context executeFetchRequest:foodRequest error:&foodError];
//    return [food.foodID integerValue];

    
    return 0;
}

- (float)currentStageProgress
{
    
}

- (BOOL)isFinishedForDate:(NSDate *)date
{
    
}

- (NSArray *)errorRatioInExams
{
    
}

- (NSArray *)dateAndDurationInStage:(int)stage
{
    
}

@end
