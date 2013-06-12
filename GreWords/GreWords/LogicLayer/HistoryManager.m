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
#import "TaskStatus.h"
#import "WordTaskGenerator.h"

#import "NSDate-Utilities.h"


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
    [history setTotalWordCount:[NSNumber numberWithInt:aEvent.totalWordCount]];
    [history setWrongWordCount:[NSNumber numberWithInt:aEvent.wrongWordCount]];
    [history setDuration:[NSNumber numberWithDouble:aEvent.duration]];
    [history setDayOfSchedule:[NSNumber numberWithInt:aEvent.dayOfSchedule]];
    [history setStage:[NSNumber numberWithInt:aEvent.stage_now]];
    
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if ([aEvent isKindOfClass:[NewWordEvent class]]) {
        [history setEvent:EVENT_TYPE_NEWWORD];
        NewWordEvent *newWordEvent = (NewWordEvent *)aEvent;
        
        NewWordStatus *newWordStatus = [NSEntityDescription insertNewObjectForEntityForName:@"NewWordStatus" inManagedObjectContext:self.context];
        newWordStatus.index = [NSNumber numberWithInt:newWordEvent.indexOfWordToday];
        newWordStatus.maxWordID = [NSNumber numberWithInt:newWordEvent.maxWordID];
        newWordStatus.reviewEnable = [NSNumber numberWithBool:newWordEvent.reviewEnable];
        
        [history setNewWordStatus:newWordStatus];
        NSLog(@"%@:%@:%@", newWordStatus.index, newWordStatus.maxWordID, newWordStatus.reviewEnable);
        
        // convert enum to NSNumber
        
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent stage_now]] forKey:NEWWORDEVENT_STAGE_NOW];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent maxWordID]] forKey:NEWWORDEVENT_MAX_ID];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent indexOfWordToday]] forKey:NEWWORDEVENT_INDEX];
//        [dict setObject:[NSNumber numberWithBool:[newWordEvent reviewEnable]] forKey:NEWWORDEVENT_REVIEW_ENABLE];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent unit]] forKey:NEWWORDEVENT_UNIT];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent round]] forKey:NEWWORDEVENT_ROUNG];
//        [dict setObject:[NSNumber numberWithInt:[newWordEvent orderInUnit]] forKey:NEWWORDEVENT_ORDER_IN_UNIT];
    } else if ([aEvent isKindOfClass:[ReviewEvent class]]) {
        [history setEvent:EVENT_TYPE_REVIEW];
        ReviewEvent *reviewEvent = (ReviewEvent *)aEvent;
        
        ReviewStatus *reviewStatus = [NSEntityDescription insertNewObjectForEntityForName:@"ReviewStatus" inManagedObjectContext:self.context];
        reviewStatus.index = [NSNumber numberWithInt:reviewEvent.indexOfWordToday];
        
        [history setReviewStatus:reviewStatus];
//        [dict setObject:[NSNumber numberWithInt:[reviewEvent stage_now]] forKey:REVIEWEVENT_STAGE_NOW];
//        [dict setObject:[NSNumber numberWithInt:[reviewEvent unit]] forKey:REVIEWEVENT_UNIT];
//        [dict setObject:[NSNumber numberWithInt:[reviewEvent orderInUnit]] forKey:REVIEWEVENT_ORDER_IN_UNIT];
    } else if ([aEvent isKindOfClass:[ExamEvent class]]) {
        [history setEvent:EVENT_TYPE_EXAM];
        ExamEvent *examEvent = (ExamEvent *)aEvent;
        
        ExamStatus *examStatus = [NSEntityDescription insertNewObjectForEntityForName:@"ExamStatus" inManagedObjectContext:self.context];
        
        examStatus.difficulty = [NSNumber numberWithFloat:examEvent.difficulty];
        
        [history setExamStatus:examStatus];
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
    request.predicate = [NSPredicate predicateWithFormat:@"endTime = nil"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];
    
    NSLog(@"Fetch Event Results number: %d", [matches count]);
    History *history = [matches lastObject];
    
    NSLog(@"History Start Time: %@ Wrong: %@", history.startTime, history.wrongWordCount);
    
    history.wrongWordCount = [NSNumber numberWithInt:aEvent.wrongWordCount];
    history.totalWordCount = [NSNumber numberWithInt:aEvent.totalWordCount];

    
    if ([aEvent isKindOfClass:[NewWordEvent class]]) {
        NewWordEvent *newWordEvent = (NewWordEvent *)aEvent;
        NewWordStatus *newWordStatus = history.newWordStatus;//[history performSelector:@selector(examStatus)];//history.newWordStatus;
        
        NSLog(@"NewWordStatus before: index:%@, maxID:%@, reviewEnable:%@", newWordStatus.index, newWordStatus.maxWordID, newWordStatus.reviewEnable);
        newWordStatus.index = [NSNumber numberWithInt:newWordEvent.indexOfWordToday];
        newWordStatus.maxWordID = [NSNumber numberWithInt:newWordEvent.maxWordID];
        newWordStatus.reviewEnable = [NSNumber numberWithBool:newWordEvent.reviewEnable];
            
    } else if ([aEvent isKindOfClass:[ReviewEvent class]]) {
        
        ReviewEvent *reviewEvent = (ReviewEvent *)aEvent;
        ReviewStatus *reviewStatus = history.reviewStatus;        

        reviewStatus.index = [NSNumber numberWithInt:reviewEvent.indexOfWordToday];
        
    } else if ([aEvent isKindOfClass:[ExamEvent class]]) {
        ExamEvent *examEvent = (ExamEvent *)aEvent;
        
        ExamStatus *examStatus = history.examStatus;
        
        examStatus.difficulty = [NSNumber numberWithFloat:examEvent.difficulty];
        
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
    request.predicate = [NSPredicate predicateWithFormat:@"endTime = nil"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];
    
    NSLog(@"Fetch Event Results number: %d", [matches count]);
    
    //History *history = [matches lastObject];
        
    for (History *history in matches) {
        if (history.endTime != nil) {
            break;
        }
        if ([history.event isEqualToString:EVENT_TYPE_EXAM] && [aEvent isKindOfClass:[ExamEvent class]]) {
            history.endTime = aEvent.endTime;
            NSLog(@"History End: %@ : %@", EVENT_TYPE_EXAM, history.endTime);
        }
        if ([history.event isEqualToString:EVENT_TYPE_NEWWORD] && [aEvent isKindOfClass:[NewWordEvent class]]) {
            history.endTime = aEvent.endTime;
            NSLog(@"History End: %@ : %@", EVENT_TYPE_NEWWORD, history.endTime);
        }
        if ([history.event isEqualToString:EVENT_TYPE_REVIEW] && [aEvent isKindOfClass:[ReviewEvent class]]) {
            history.endTime = aEvent.endTime;
            NSLog(@"History End: %@ : %@", EVENT_TYPE_REVIEW, history.endTime);
        }
    }
    
    if (![self.context save:&err]) {
        NSLog(@"End Event Error");
    }

}

- (void)deleteEvent:(BaseEvent *)aEvent
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    request.predicate = [NSPredicate predicateWithFormat:@"endTime = nil"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];
    
    NSLog(@"Fetch Event Results number: %d", [matches count]);
    
    //History *history = [matches lastObject];
    
    for (History *history in matches) {
        if (history.endTime != nil) {
            break;
        }
        if ([history.event isEqualToString:EVENT_TYPE_EXAM] && [aEvent isKindOfClass:[ExamEvent class]]) {
            [self.context deleteObject:history];
            NSLog(@"delete Exam");
        }
        if ([history.event isEqualToString:EVENT_TYPE_NEWWORD] && [aEvent isKindOfClass:[NewWordEvent class]]) {
            [self.context deleteObject:history];
            NSLog(@"delete NewWord");

        }
        if ([history.event isEqualToString:EVENT_TYPE_REVIEW] && [aEvent isKindOfClass:[ReviewEvent class]]) {
            [self.context deleteObject:history];
            NSLog(@"delete Review");

        }
    }
}

- (BOOL)readStatusIfNew
{
    TaskStatus *taskStatus = [TaskStatus instance];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    request.predicate = [NSPredicate predicateWithFormat:@"endTime = nil"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];

    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];

#warning !!!!!!!!!!!!!  15天以后。。。
    if ([matches count] == 0) {
        
        [taskStatus beginNewWord];
        
        return YES;
    } else {
        History *history = [matches lastObject];
        if ([history.event isEqualToString:EVENT_TYPE_NEWWORD]) {
            NewWordStatus *nwStatus = history.newWordStatus;
            
            taskStatus.taskType = TASK_TYPE_NEWWORD;
            taskStatus.nwEvent.indexOfWordToday = [nwStatus.index integerValue];
            taskStatus.nwEvent.maxWordID = [nwStatus.maxWordID integerValue];
            taskStatus.nwEvent.stage_now = [history.stage integerValue];
            taskStatus.nwEvent.reviewEnable = [nwStatus.reviewEnable boolValue];
            taskStatus.nwEvent.wrongWordCount = [history.wrongWordCount integerValue];
            taskStatus.nwEvent.startTime = history.startTime;
            taskStatus.nwEvent.totalWordCount = [history.totalWordCount intValue];
            taskStatus.nwEvent.dayOfSchedule = [history.dayOfSchedule intValue];
            taskStatus.nwEvent.newWordCount = [[WordTaskGenerator instance] theNumberOfNewWordToday_twolist:taskStatus.nwEvent.dayOfSchedule];
            
            NSLog(@"History Manager : Total Word Count: %d", taskStatus.nwEvent.totalWordCount);

        } else if ([history.event isEqualToString:EVENT_TYPE_REVIEW]) {
            ReviewStatus *rStatus = history.reviewStatus;
            
            taskStatus.taskType = TASK_TYPE_REVIEW;
            taskStatus.rEvent.indexOfWordToday = [rStatus.index integerValue];
            taskStatus.rEvent.stage_now = [history.stage integerValue];
            taskStatus.rEvent.startTime = history.startTime;
            taskStatus.rEvent.totalWordCount = [history.totalWordCount intValue];
            taskStatus.rEvent.wrongWordCount = [history.wrongWordCount intValue];
            taskStatus.rEvent.dayOfSchedule = [history.dayOfSchedule intValue];
            NSLog(@"History Manager : Total Word Count: %d", taskStatus.nwEvent.totalWordCount);
        } else if ([history.event isEqualToString:EVENT_TYPE_EXAM]) {
            //ExamStatus *eStatus = history.examStatus;
            //eStatus.difficulty;
        }
        return NO;
    }
}

//Statistic Methods

- (BOOL)isNewWordPaused
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    request.predicate = [NSPredicate predicateWithFormat:@"event = %@ && endTime = nil", EVENT_TYPE_NEWWORD];
    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];
    
    if ([matches count] == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isReviewPaused
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    request.predicate = [NSPredicate predicateWithFormat:@"event = %@ && endTime = nil", EVENT_TYPE_REVIEW];
 
    NSError *err = nil;
    NSArray *matches = [self.context executeFetchRequest:request error:&err];
    
    if ([matches count] == 0) {
        return NO;
    } else {
        return YES;
    }
}


- (int)currentStage
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'newWordEvent'"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    History *his = [fetchMatches lastObject];
    if ([fetchMatches count] <= 0) {
        return 0;
    }
    
    NSLog(@"Today is %d", [his.stage intValue]);
    return [his.stage intValue];
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
    
    float progress = 0;
    
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

- (int)getANewDay
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'ReviewEvent'"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    
    int today = 0;
    if ([fetchMatches count] > 0) {
        History *his = [fetchMatches lastObject];
        today = [his.dayOfSchedule intValue] + 1;
    }
    NSLog(@"Today is %d", today);
    return today;
}

- (NSArray *)newWordEventsInStage:(int)stage
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'NewWordEvent' && stage == %d", stage];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    
    NSLog(@"Count: %d", [fetchMatches count]);
    for (History *his in fetchMatches) {
        if (his.endTime == nil) {
            break;
        }
        NewWordStatus *nwStatus = his.newWordStatus;
        
        NewWordEvent *nwEvent = [[NewWordEvent alloc] init];
//        @property (nonatomic) NSString *eventType;
//        @property (nonatomic) NSDate *startTime;
//        @property (nonatomic) NSDate *endTime;
//        @property (nonatomic) NSTimeInterval duration;
//        @property (nonatomic) int totalWordCount;
//        @property (nonatomic) int wrongWordCount;
//        @property (nonatomic) int dayOfSchedule;
//        @property (nonatomic) enum Stage stage_now;
//        @property (nonatomic) int indexOfWordToday;
//        @property (nonatomic) int maxWordID;
//        @property (nonatomic) BOOL reviewEnable;
        nwEvent.eventType = his.event;
        nwEvent.startTime = his.startTime;
        nwEvent.endTime = his.endTime;
        nwEvent.duration = [his.endTime timeIntervalSinceDate:his.startTime];
        nwEvent.totalWordCount = [his.totalWordCount intValue];
        nwEvent.wrongWordCount = [his.wrongWordCount intValue];
        nwEvent.dayOfSchedule = [his.dayOfSchedule intValue];
        nwEvent.stage_now = [his.stage intValue];
        
        nwEvent.indexOfWordToday = [nwStatus.index intValue];
        nwEvent.maxWordID = [nwStatus.maxWordID intValue];
        nwEvent.reviewEnable = [nwStatus.reviewEnable boolValue];
        
        [resultArr addObject:nwEvent];
    }
    
    NSLog(@"result count: %d", [resultArr count]);
    
    return resultArr;
                               
}

- (NSArray *)reviewEventsInStage:(int)stage
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'ReviewEvent' && stage == %d", stage];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    
    NSLog(@"Count: %d", [fetchMatches count]);
    for (History *his in fetchMatches) {
        if (his.endTime == nil) {
            break;
        }
        ReviewStatus *rStatus = his.reviewStatus;
        
        ReviewEvent *rEvent = [[ReviewEvent alloc] init];
        //        @property (nonatomic) NSString *eventType;
        //        @property (nonatomic) NSDate *startTime;
        //        @property (nonatomic) NSDate *endTime;
        //        @property (nonatomic) NSTimeInterval duration;
        //        @property (nonatomic) int totalWordCount;
        //        @property (nonatomic) int wrongWordCount;
        //        @property (nonatomic) int dayOfSchedule;
        //        @property (nonatomic) enum Stage stage_now;
        //        @property (nonatomic) int indexOfWordToday;
        //        @property (nonatomic) int maxWordID;
        //        @property (nonatomic) BOOL reviewEnable;
        rEvent.eventType = his.event;
        rEvent.startTime = his.startTime;
        rEvent.endTime = his.endTime;
        rEvent.duration = [his.endTime timeIntervalSinceDate:his.startTime];
        rEvent.totalWordCount = [his.totalWordCount intValue];
        rEvent.wrongWordCount = [his.wrongWordCount intValue];
        rEvent.dayOfSchedule = [his.dayOfSchedule intValue];
        
        rEvent.stage_now = [his.stage intValue];
        rEvent.indexOfWordToday = [rStatus.index intValue];

        
        [resultArr addObject:rEvent];
    }
    
    NSLog(@"result count: %d", [resultArr count]);
    
    return resultArr;
}

- (NSArray *)examEventsInStage:(int)stage
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'ExamEvent' && stage == %d", stage];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    
    NSLog(@"Count: %d", [fetchMatches count]);
    for (History *his in fetchMatches) {
        if (his.endTime == nil) {
            break;
        }
        ExamStatus *eStatus = his.examStatus;
        
        ExamEvent *eEvent = [[ExamEvent alloc] init];
        //        @property (nonatomic) NSString *eventType;
        //        @property (nonatomic) NSDate *startTime;
        //        @property (nonatomic) NSDate *endTime;
        //        @property (nonatomic) NSTimeInterval duration;
        //        @property (nonatomic) int totalWordCount;
        //        @property (nonatomic) int wrongWordCount;
        //        @property (nonatomic) int dayOfSchedule;
        //        @property (nonatomic) enum Stage stage_now;
        //        @property (nonatomic) int indexOfWordToday;
        //        @property (nonatomic) int maxWordID;
        //        @property (nonatomic) BOOL reviewEnable;
        eEvent.eventType = his.event;
        eEvent.startTime = his.startTime;
        eEvent.endTime = his.endTime;
        eEvent.duration = [his.endTime timeIntervalSinceDate:his.startTime];
        eEvent.totalWordCount = [his.totalWordCount intValue];
        eEvent.wrongWordCount = [his.wrongWordCount intValue];
        eEvent.dayOfSchedule = [his.dayOfSchedule intValue];
        
        eEvent.stage_now = [his.stage intValue];
        eEvent.difficulty = [eStatus.difficulty intValue];
        
        [resultArr addObject:eEvent];
    }
    
    NSLog(@"result count: %d", [resultArr count]);
    
    return resultArr;
}

- (BOOL)isNewWordComplete
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'ReviewEvent' || event == 'NewWordEvent'"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    
    History *his = [fetchMatches lastObject];
    
    if ([his.event isEqualToString:EVENT_TYPE_NEWWORD] && his.endTime != nil) {
        return YES;
    } else {
        return NO;
    }
    
}

- (BOOL)isReviewComplete
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'ReviewEvent' || event == 'NewWordEvent'"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    
    History *his = [fetchMatches lastObject];
    
    if ([his.event isEqualToString:EVENT_TYPE_REVIEW] && his.endTime != nil) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isNewWordCompleteToday
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"event == 'ReviewEvent' || event == 'NewWordEvent'"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *fetchMatches = [self.context executeFetchRequest:request error:&fetchError];
    
    History *his = [fetchMatches lastObject];
    
    if ([his.event isEqualToString:EVENT_TYPE_NEWWORD] && his.endTime != nil) {
        if (his.startTime.day == [NSDate new].day) {
            return NO;
        }
        return YES;
    } else {
        return NO;
    }
}

@end
