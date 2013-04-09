//
//  HistoryManager.m
//  GreWords
//
//  Created by 崔 昊 on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "HistoryManager.h"
#import "MyDataStorage.h"
#import "History.h"
#import "NewWordEvent.h"
#import "ReviewEvent.h"
#import "ExamEvent.h"

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
    MyDataStorage *myDateStorage;
    NSManagedObjectContext *context = [myDateStorage managedObjectContext];
    if ([aEvent isKindOfClass:[NewWordEvent class]]) {
        History *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
        [history setStartTime:[NSDate date]];
        [history setEvent:@"NewWordEvent"];
        
        [(NewWordEvent *)aEvent duration];
        
    } else if ([aEvent isKindOfClass:[ReviewEvent class]]) {
        
    } else if ([aEvent isKindOfClass:[ExamEvent class]]) {
        
    } else {
        NSLog(@"BaseEvent is not a specific class");
    }
    
}

- (void)updateEvent:(BaseEvent *)aEvent
{
    
}

//Statistic Methods

- (int)currentStage
{
    MyDataStorage *myDataStorage;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    [request setFetchLimit:1];
    NSError *fetchError = nil;
    NSArray *fetchMatches = [[myDataStorage managedObjectContext] executeFetchRequest:request error:&fetchError];
    History *history = [fetchMatches lastObject];
    
    //waiting For json
    
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
