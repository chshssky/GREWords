//
//  WordHelper.m
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordHelper.h"

@implementation WordHelper

WordHelper* _wordHelperInstance = nil;

+(WordHelper*) instance
{
    if(!_wordHelperInstance)
    {
        _wordHelperInstance = [[WordHelper alloc] init];
    }
    return _wordHelperInstance;
}


-(void)loadWords
{
    wordList = [@[] mutableCopy];
    wordIndexes = [@{} mutableCopy];
    
    NSArray *arr;
    NSString *infoSouceFile = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSData* data = [NSData dataWithContentsOfFile:infoSouceFile];
    NSError *error;
    NSPropertyListFormat format;
    arr = [NSPropertyListSerialization propertyListWithData:data options:0 format:&format error:&error];
    NSAssert(error == nil, @"Error loading word plist:%@",[error description]);
    
    NSManagedObjectContext *context = [[MyDataStorage instance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Word" inManagedObjectContext:context]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"plistID" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSArray *matching = [context executeFetchRequest:fetchRequest error:&error];
    
    for(NSDictionary *dict in arr)
    {
        NSString *text = dict[@"word"];
        Word* word = matching[wordList.count];
        NSAssert(wordList.count == [word.plistID integerValue],@"fail to count database counterpart");
        WordEntity *theWord = [[WordEntity alloc] initWithID:wordList.count data:dict word:word];
        wordIndexes[text] = [NSNumber numberWithInt:wordList.count];
        [wordList addObject:theWord];
    }
}


-(id)init
{
    if(self = [super init])
    {
        [self loadWords];
    }
    return self;
}


-(WordEntity*)wordWithString:(NSString*)string
{
    int index = [wordIndexes[string] integerValue];
    return wordList[index];
}

-(WordEntity*)wordWithID:(int)wordID
{
    return wordList[wordID];
}

//return array of wordID:int
-(NSArray*)wordsHasNote
{
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"SELF.note != nil"];
    return [wordList filteredArrayUsingPredicate:predicate];
}

-(NSArray*)wordsAlphabeticOrder
{
    return [wordList sortedArrayUsingComparator: ^(id obj1, id obj2) {
        return [((WordEntity*)obj1).data[@"word"] compare: ((WordEntity*)obj2).data[@"word"]];
    }];
}

-(NSArray*)wordsHomoionym
{
    return nil;
}

-(NSArray*)wordsRatioOfMistake
{
    return [wordList sortedArrayUsingComparator: ^(id obj1, id obj2) {
        return [[NSNumber numberWithFloat:((WordEntity*)obj1).ratioOfMistake] compare: [NSNumber numberWithFloat:((WordEntity*)obj2).ratioOfMistake]];
    }];
}


-(int)wordCount
{
    return wordList.count;
}

@end
