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

@interface HistoryManager ()

@property (weak, nonatomic) NSManagedObjectContext *context;

@end

@implementation HistoryManager
@synthesize context = _context;

HistoryManager* _historyManagerInstance = nil;

+ (HistoryManager*)instance
{
    if(!_historyManagerInstance)
    {
        _historyManagerInstance = [[HistoryManager alloc] init];
    }
    return _historyManagerInstance;
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        MyDataStorage *myDateStorage;
        _context = [myDateStorage managedObjectContext];
    }
    return _context;
}

- (void)addEvent:(BaseEvent *)aEvent
{
    History *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:self.context];
    [history setStartTime:aEvent.startTime];
    [history setEvent:aEvent.eventType];
    [history setTotalWordCount:[NSNumber numberWithInt:aEvent.totalWordCount]];
    [history setWrongWordCount:[NSNumber numberWithInt:aEvent.wrongWordCount]];
    [history setDuration:[NSNumber numberWithDouble:aEvent.duration]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if ([aEvent isKindOfClass:[NewWordEvent class]]) {
        NewWordEvent *newWordEvent = (NewWordEvent *)aEvent;
        // convert enum to NSNumber
        [dict setObject:[NSNumber numberWithInt:[newWordEvent stage_now]] forKey:@"stage"];
        [dict setObject:[NSNumber numberWithInt:[newWordEvent unit]] forKey:@"unit"];
        [dict setObject:[NSNumber numberWithInt:[newWordEvent round]] forKey:@"round"];
        [dict setObject:[NSNumber numberWithInt:[newWordEvent orderInUnit]] forKey:@"orderInUnit"];
    } else if ([aEvent isKindOfClass:[ReviewEvent class]]) {
        ReviewEvent *reviewEvent = (ReviewEvent *)aEvent;
        [dict setObject:[NSNumber numberWithInt:[reviewEvent stage_now]] forKey:@"stage"];
        [dict setObject:[NSNumber numberWithInt:[reviewEvent unit]] forKey:@"unit"];
        [dict setObject:[NSNumber numberWithInt:[reviewEvent orderInUnit]] forKey:@"orderInUnit"];
    } else if ([aEvent isKindOfClass:[ExamEvent class]]) {
        ExamEvent *examEvent = (ExamEvent *)aEvent;
        [dict setObject:[NSNumber numberWithInt:[examEvent difficulty]] forKey:@"difficulty"];
    } else {
        NSLog(@"BaseEvent is not a specific class");
    }
    
    [history setInfo:[NSString stringWithFormat:@"%@", dict]];
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
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
