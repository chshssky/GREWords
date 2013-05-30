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
#import "Entity/ExamStatus.h"
#import "Entity/NewWordStatus.h"
#import "Entity/ReviewStatus.h"


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
    return [[MyDataStorage instance] managedObjectContext];
}

- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

- (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
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
    
    if ([aEvent isKindOfClass:[NewWordEvent class]] && [aEvent.eventType isEqualToString:EVENT_TYPE_NEWWORD]) {
        NewWordEvent *newWordEvent = (NewWordEvent *)aEvent;
        
        NewWordStatus *newWordStatus = [NSEntityDescription insertNewObjectForEntityForName:@"NewWordStatus" inManagedObjectContext:self.context];
        newWordStatus.index = [NSNumber numberWithInt:newWordEvent.indexOfWordToday];
        newWordStatus.maxWordID = [NSNumber numberWithInt:newWordEvent.maxWordID];
        newWordStatus.stage = [NSNumber numberWithInt:newWordEvent.stage_now];
        newWordStatus.reviewEnable = [NSNumber numberWithBool:newWordEvent.reviewEnable];
        
        // convert enum to NSNumber
        
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent stage_now]] forKey:NEWWORDEVENT_STAGE_NOW];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent maxWordID]] forKey:NEWWORDEVENT_MAX_ID];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent indexOfWordToday]] forKey:NEWWORDEVENT_INDEX];
//        [dict setObject:[NSNumber numberWithBool:[newWordEvent reviewEnable]] forKey:NEWWORDEVENT_REVIEW_ENABLE];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent unit]] forKey:NEWWORDEVENT_UNIT];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent round]] forKey:NEWWORDEVENT_ROUNG];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent orderInUnit]] forKey:NEWWORDEVENT_ORDER_IN_UNIT];
    } else if ([aEvent isKindOfClass:[ReviewEvent class]] && [aEvent.eventType isEqualToString:EVENT_TYPE_REVIEW]) {
        ReviewEvent *reviewEvent = (ReviewEvent *)aEvent;
        
        ReviewStatus *reviewStatus = [NSEntityDescription insertNewObjectForEntityForName:@"ReviewStatus" inManagedObjectContext:self.context];
        reviewStatus.index = [NSNumber numberWithInt:reviewEvent.indexOfWordToday];
        reviewStatus.stage = [NSNumber numberWithInt:reviewEvent.stage_now];

//        [dict setObject:[NSNumber numberWithInt:[reviewEvent stage_now]] forKey:REVIEWEVENT_STAGE_NOW];
//        [dict setObject:[NSNumber numberWithInt:[reviewEvent unit]] forKey:REVIEWEVENT_UNIT];
//        [dict setObject:[NSNumber numberWithInt:[reviewEvent orderInUnit]] forKey:REVIEWEVENT_ORDER_IN_UNIT];
    } else if ([aEvent isKindOfClass:[ExamEvent class]] && [aEvent.eventType isEqualToString:EVENT_TYPE_EXAM]) {
        ExamEvent *examEvent = (ExamEvent *)aEvent;
        
        ExamStatus *examStatus = [NSEntityDescription insertNewObjectForEntityForName:@"ExamStatus" inManagedObjectContext:self.context];
        
        examStatus.difficulty = [NSNumber numberWithFloat:examEvent.difficulty];
        
//        [dict setObject:[NSNumber numberWithInt:[examEvent difficulty]] forKey:EXAMEVENT_DIFFICULTY];
    } else {
        NSLog(@"Something Wrong : BaseEvent is not a specific class");
    }
    
//    NSString *jsonString = [[NSString alloc] initWithData:[self toJSONData:dict]
//                                                 encoding:NSUTF8StringEncoding];
//    [history setInfo:jsonString];
    
        
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Save Event error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)updateEvent:(BaseEvent *)aEvent
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    request.predicate = [NSPredicate predicateWithFormat:@"event = %@ && endTime = %@", aEvent.eventType, @""];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];
    
    NSLog(@"Fetch Event Results number: %d", [matches count]);
    History *history = [matches lastObject];
    
    NSLog(@"History Start Time: %@", history.startTime);
    
    if ([aEvent isKindOfClass:[NewWordEvent class]] && [aEvent.eventType isEqualToString:EVENT_TYPE_NEWWORD]) {
        NewWordEvent *newWordEvent = (NewWordEvent *)aEvent;
        
        NewWordStatus *newWordStatus ;//= //[NSFetchRequest fetchRequestWithEntityName:@"NewWordStatus"];
        newWordStatus.index = [NSNumber numberWithInt:newWordEvent.indexOfWordToday];
        newWordStatus.maxWordID = [NSNumber numberWithInt:newWordEvent.maxWordID];
        newWordStatus.stage = [NSNumber numberWithInt:newWordEvent.stage_now];
        newWordStatus.reviewEnable = [NSNumber numberWithBool:newWordEvent.reviewEnable];
        
    } else if ([aEvent isKindOfClass:[ReviewEvent class]] && [aEvent.eventType isEqualToString:EVENT_TYPE_REVIEW]) {
        ReviewEvent *reviewEvent = (ReviewEvent *)aEvent;
        
        ReviewStatus *reviewStatus = [NSEntityDescription insertNewObjectForEntityForName:@"ReviewStatus" inManagedObjectContext:self.context];
        reviewStatus.index = [NSNumber numberWithInt:reviewEvent.indexOfWordToday];
        reviewStatus.stage = [NSNumber numberWithInt:reviewEvent.stage_now];
        

    } else if ([aEvent isKindOfClass:[ExamEvent class]] && [aEvent.eventType isEqualToString:EVENT_TYPE_EXAM]) {
        ExamEvent *examEvent = (ExamEvent *)aEvent;
        
        ExamStatus *examStatus = [NSEntityDescription insertNewObjectForEntityForName:@"ExamStatus" inManagedObjectContext:self.context];
        
        examStatus.difficulty = [NSNumber numberWithFloat:examEvent.difficulty];
        
        //        [dict setObject:[NSNumber numberWithInt:[examEvent difficulty]] forKey:EXAMEVENT_DIFFICULTY];
    } else {
        NSLog(@"Something Wrong : BaseEvent is not a specific class");
    }

    
//    NSDictionary *info = [self toArrayOrNSDictionary:[history.info dataUsingEncoding:NSASCIIStringEncoding]];
//    
//    NSLog(@"HistoryManager: max:%@ Index:%@, enable:%@", [info objectForKey:NEWWORDEVENT_MAX_ID], [info objectForKey:NEWWORDEVENT_INDEX], [info objectForKey:NEWWORDEVENT_REVIEW_ENABLE]);
    
    if (![self.context save:&err]) {
        NSLog(@"End Event Error");
    }
}

- (void)endEvent:(BaseEvent *)aEvent
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    request.predicate = [NSPredicate predicateWithFormat:@"event = %@ && endTime = %@", aEvent.eventType, @""];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];
    
    History *history = [matches lastObject];
    [history setEndTime:aEvent.endTime];
    
    if (![self.context save:&err]) {
        NSLog(@"End Event error");
    }
}

//Statistic Methods

- (int)currentStage
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == newWord"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    [request setFetchLimit:1];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    History *history = [fetchMatches lastObject];
    
    NSDictionary *info = [self toArrayOrNSDictionary:[history.info dataUsingEncoding:NSASCIIStringEncoding]];
    
    return [[info objectForKey:NEWWORDEVENT_STAGE_NOW] integerValue];
}

- (float)currentStageProgress
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'newWordEvent'"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    [request setFetchLimit:1];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    History *history = [fetchMatches lastObject];
    
    NSDictionary *info = [self toArrayOrNSDictionary:[history.info dataUsingEncoding:NSASCIIStringEncoding]];
    
    float progress = 0;
    //!!!!!!!!!!!!!!!!
    //[[info objectForKey:@"unit"] floatValue] / ;
    
    return progress;
}

- (BOOL)isFinishedForDate:(NSDate *)date
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    //!!!!!!!!!!!!!!!
    request.predicate = [NSPredicate predicateWithFormat:@"(event == newWord || event = review) &&  date <= %@ && date >= %@", date, date];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    [request setFetchLimit:2];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    if ([fetchMatches count] <= 0) {
        return NO;
    } else {
        return YES;
    }
}

- (NSArray *)errorRatioInExams
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'examEvent'"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    [request setFetchLimit:1];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (History *hist in fetchMatches) {
        [results addObject:[NSNumber numberWithFloat:[hist.wrongWordCount floatValue]/[hist.totalWordCount floatValue]]];
    }
    return results;
}

- (NSArray *)dateAndDurationInStage:(int)stage
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"(event == 'newWordEvent' || event = 'reviewEvent') && stage = %d", stage];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:NO]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (History *hist in fetchMatches) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:hist.duration forKey:DATE_AND_DURATION_IN_STAGE_DURATION];
        //Date:
        [dict setObject:hist.startTime  forKey:DATE_AND_DURATION_IN_STAGE_DATE];
        [results addObject:dict];
    }
    return results;
}

@end
