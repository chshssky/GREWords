//
//  wordEntity.m
//  GreWords
//
//  Created by Song on 13-4-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordEntity.h"

@implementation WordEntity

-(id)initWithID:(int)wordID data:(NSDictionary*)data
{
    if(self = [super init])
    {
        _wordID = wordID;
        _data = data;
        
        NSError *error;
        NSManagedObjectContext *context = [[MyDataStorage instance] managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSString *simplePredicateFormat = [NSString stringWithFormat:@"plistID == %d",_wordID];
        NSPredicate *simplePredicate = [NSPredicate predicateWithFormat:simplePredicateFormat];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Word" inManagedObjectContext:context]];
        [fetchRequest setPredicate:simplePredicate];
        NSArray *matching = [context executeFetchRequest:fetchRequest error:&error];
        if(!matching || matching.count == 0)
        {
            NSAssert(NO,@"fail to find counterpart in database for word:%d %@",_wordID,_data[@"word"]);
        }
        wordManagedObject = matching.lastObject;
        noteManagedObject = wordManagedObject.word2note;
    }
    return self;
}

-(NSString*)note
{
    return noteManagedObject.content;
}

-(void)setNote:(NSString *)note
{
    if(!noteManagedObject)
    {
        NSManagedObjectContext *context = [[MyDataStorage instance] managedObjectContext];
        noteManagedObject = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Note"
                             inManagedObjectContext:context];
    }
    noteManagedObject.content = note;
    [[MyDataStorage instance] saveContext];
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
    while(lastMistakes.count > 7)
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

-(void)didMadeAMistakeOnDate:(NSDate*)date
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
    int mistakeCount = 0;
    for(NSString *str in lastMistakes)
    {
        if([str isEqualToString:@"W"])
            mistakeCount++;
    }
    return mistakeCount / (float)lastMistakes.count;
}

-(NSArray*)currentMistkeStatus
{
    return [self mistakeStringToArray];
}

@end
