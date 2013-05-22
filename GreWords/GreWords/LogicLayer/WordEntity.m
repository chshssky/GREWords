//
//  wordEntity.m
//  GreWords
//
//  Created by Song on 13-4-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordEntity.h"
#import "NSNotificationCenter+Addition.h"

#define MAX_HISTORY_MISTAKE_SIZE 7

@implementation WordEntity

-(id)initWithID:(int)wordID data:(NSDictionary*)data word:(Word*)wordManagedObj;
{
    if(self = [super init])
    {
        _wordID = wordID;
        _data = data;
        
        wordManagedObject = wordManagedObj;
        noteManagedObject = wordManagedObject.word2note;
    }
    return self;
}

-(NSString*)note
{
    return noteManagedObject.content;
}

-(void)clearNote
{
    if(noteManagedObject)
    {
        NSManagedObjectContext *context = [[MyDataStorage instance] managedObjectContext];
        [context deleteObject:noteManagedObject];
        wordManagedObject.word2note = nil;
        noteManagedObject = nil;
        [[MyDataStorage instance] saveContext];
        [NSNotificationCenter postRemoveNoteForWordNotification:self];
    }
}

-(void)setNote:(NSString *)note
{
    if([note isEqualToString:self.note])
        return;
    if([note isEqualToString:@""] || note == nil)
    {
        [self clearNote];
        return;
    }
    if(!noteManagedObject)
    {
        NSManagedObjectContext *context = [[MyDataStorage instance] managedObjectContext];
        noteManagedObject = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Note"
                             inManagedObjectContext:context];
        wordManagedObject.word2note = noteManagedObject;
        noteManagedObject.content = note;
        [NSNotificationCenter postAddNoteForWordNotification:self];
    }
    noteManagedObject.content = note;
    noteManagedObject.createAt = [NSDate new];
    [[MyDataStorage instance] saveContext];
}

-(NSDate*)noteCreateAt
{
    return noteManagedObject.createAt;
}

-(NSDate*)lastMistakeTime
{
    return wordManagedObject.lastMistakeTime;
}

-(NSMutableArray*)mistakeStringToArray
{
    NSMutableArray *lastMistakes = [[wordManagedObject.lastChecks componentsSeparatedByString:@","]  mutableCopy];
    if([[lastMistakes lastObject] isEqualToString:@""])
    {
        [lastMistakes removeLastObject];
    }
    return lastMistakes;
}

-(NSString*)truncMistakeString:(NSMutableArray*)lastMistakes
{
    while(lastMistakes.count > MAX_HISTORY_MISTAKE_SIZE)
    {
        [lastMistakes removeObjectAtIndex:0];
    }
    NSString *result = @"";
    for(NSString *str in lastMistakes)
    {
        result = [result stringByAppendingFormat:@"%@,",str];
    }
    return result;
}

-(void)didMakeAMistakeOnDate:(NSDate*)date
{
    NSMutableArray *lastMistakes = [self mistakeStringToArray];
    [lastMistakes addObject:@"W"];
    NSString* result = [self truncMistakeString:lastMistakes];
    wordManagedObject.lastChecks = result;
    wordManagedObject.lastMistakeTime = date;
    [[MyDataStorage instance] saveContext];
}

-(void)didRightOnDate:(NSDate*)date
{
    NSMutableArray *lastMistakes = [self mistakeStringToArray];
    [lastMistakes addObject:@"R"];
    NSString* result = [self truncMistakeString:lastMistakes];
    wordManagedObject.lastChecks = result;
    wordManagedObject.lastMistakeTime = date;
    [[MyDataStorage instance] saveContext];
}

-(float)ratioOfMistake
{
    NSMutableArray *lastMistakes = [self mistakeStringToArray];
    if(lastMistakes == nil || lastMistakes.count == 0)
        return 0;
    int mistakeCount = 0;
    for(NSString *str in lastMistakes)
    {
        if([str isEqualToString:@"W"])
            mistakeCount++;
    }
    return mistakeCount / (float)MAX_HISTORY_MISTAKE_SIZE;
}

-(NSArray*)currentMistkeStatus
{
    return [self mistakeStringToArray];
}

@end
