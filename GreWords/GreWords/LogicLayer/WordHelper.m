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

-(void)loadFlipcard
{
    NSString *infoSouceFile = [[NSBundle mainBundle] pathForResource:@"flipcard" ofType:@"plist"];
    NSData* data = [NSData dataWithContentsOfFile:infoSouceFile];
    NSError *error;
    NSPropertyListFormat format;
    homoArr = [NSPropertyListSerialization propertyListWithData:data options:0 format:&format error:&error];
}

//-(void)genFlipcard
//{
//    //homoArr;
//    NSString *infoSouceFile = [[NSBundle mainBundle] pathForResource:@"flipcard" ofType:@"plist"];
//    NSData* data = [NSData dataWithContentsOfFile:infoSouceFile];
//    NSError *error;
//    NSPropertyListFormat format;
//    NSDictionary *dict = [NSPropertyListSerialization propertyListWithData:data options:0 format:&format error:&error];
//    NSMutableArray *arr = [@[] mutableCopy];
//    {
//        NSEnumerator *myEnumerator = [dict keyEnumerator];
//        NSString *key;
//        while((key = [myEnumerator nextObject]))
//        {
//            id item = dict[key];
//            
//            if([key hasSuffix:@"-"] || [key hasSuffix:@"i"] ||
//               [key hasSuffix:@"b"] || [key hasSuffix:@"d"] ||
//               [key hasSuffix:@"p"] || [key hasSuffix:@"g"] || [key hasSuffix:@"m"]
//               )
//            {
//                continue;
//            }
//            
//            NSString *className = [NSString stringWithFormat:@"%@",[item class]];
//            if([className isEqualToString:@"__NSCFString"])
//            {
//                NSMutableDictionary *d = [@{} mutableCopy];
//                d[@"key"] = key;
//                d[@"arr"] = @[@{@"key":key,@"content":item}];
//                [arr addObject:d];
//            }
//            else
//            {
//            }
//            //__NSCFString
//        }
//
//    }
//    {
//        NSEnumerator *myEnumerator = [dict keyEnumerator];
//        NSString *key;
//        while((key = [myEnumerator nextObject]))
//        {
//            id item = dict[key];
//            
//            if([key isEqualToString:@"形近词"])
//            {
//                continue;
//            }
//            
//            NSString *className = [NSString stringWithFormat:@"%@",[item class]];
//            if([className isEqualToString:@"__NSCFString"])
//            {
//               
//            }
//            else
//            {
//                NSMutableDictionary *d = [@{} mutableCopy];
//                d[@"key"] = key;
//                NSMutableArray *a = [@[] mutableCopy];
//                NSEnumerator *tempEnumerator = [item keyEnumerator];
//                NSString *littleKey;
//                while((littleKey = [tempEnumerator nextObject]))
//                {
//                    NSMutableDictionary *dd = [@{} mutableCopy];
//                    dd[@"key"] = littleKey;
//                    dd[@"contnet"] = item[littleKey];
//                    [a addObject:dd];
//                }
//                d[@"arr"] = a;
//                [arr addObject:d];
//            }
//            //__NSCFString
//        }
//        
//    }
//    {
//        NSEnumerator *myEnumerator = [dict keyEnumerator];
//        NSString *key;
//        while((key = [myEnumerator nextObject]))
//        {
//            id item = dict[key];
//            
//            if([key hasSuffix:@"-"] || [key hasSuffix:@"i"] ||
//               [key hasSuffix:@"b"] || [key hasSuffix:@"d"] ||
//               [key hasSuffix:@"p"] || [key hasSuffix:@"g"] || [key hasSuffix:@"m"]
//               )
//            {
//                NSString *className = [NSString stringWithFormat:@"%@",[item class]];
//                if([className isEqualToString:@"__NSCFString"])
//                {
//                    NSMutableDictionary *d = [@{} mutableCopy];
//                    d[@"key"] = key;
//                    d[@"arr"] = @[@{@"key":key,@"content":item}];
//                    [arr addObject:d];
//                }
//                else
//                {
//                }
//            }
//        }
//        
//    }
//    {
//        NSEnumerator *myEnumerator = [dict keyEnumerator];
//        NSString *key;
//        while((key = [myEnumerator nextObject]))
//        {
//            id item = dict[key];
//            
//            if([key isEqualToString:@"形近词"])
//            {
//                NSString *className = [NSString stringWithFormat:@"%@",[item class]];
//                if([className isEqualToString:@"__NSCFString"])
//                {
//                    
//                }
//                else
//                {
//                    NSMutableDictionary *d = [@{} mutableCopy];
//                    d[@"key"] = key;
//                    NSMutableArray *a = [@[] mutableCopy];
//                    NSEnumerator *tempEnumerator = [item keyEnumerator];
//                    NSString *littleKey;
//                    while((littleKey = [tempEnumerator nextObject]))
//                    {
//                        NSMutableDictionary *dd = [@{} mutableCopy];
//                        dd[@"key"] = littleKey;
//                        dd[@"contnet"] = item[littleKey];
//                        [a addObject:dd];
//                    }
//                    d[@"arr"] = a;
//                    [arr addObject:d];
//                }
//
//            }
//            
//                        //__NSCFString
//        }
//        
//    }
//
//    
//    homoArr = arr;
//    
//    NSData* newdata = [NSPropertyListSerialization dataWithPropertyList:arr format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];
//    NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    
//    NSString *storePath = [applicationDocumentsDir stringByAppendingPathComponent:@"xml.plist"];
//    
//    [newdata writeToFile:storePath atomically:YES];
//}

-(void)loadWords
{
    wordList = [@[] mutableCopy];
    
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
        [wordList addObject:theWord];
    }
}


-(id)init
{
    if(self = [super init])
    {
        [self loadWords];
        [self loadFlipcard];
    }
    return self;
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
    NSArray *arr = [wordList filteredArrayUsingPredicate:predicate];
    return [arr sortedArrayUsingComparator: ^(id obj1, id obj2) {
        return [((WordEntity*)obj2).noteCreateAt compare: ((WordEntity*)obj1).noteCreateAt];
    }];
}

-(NSArray*)wordsAlphabeticOrder
{
    return [wordList sortedArrayUsingComparator: ^(id obj1, id obj2) {
        return [((WordEntity*)obj1).data[@"word"] compare: ((WordEntity*)obj2).data[@"word"]];
    }];
}

-(NSArray*)wordsHomoionym
{
    return homoArr;
}

-(NSArray*)wordsRatioOfMistake
{
    NSArray *temp = [wordList sortedArrayUsingComparator: ^(id obj1, id obj2) {
        return [[NSNumber numberWithFloat:((WordEntity*)obj2).ratioOfMistake] compare: [NSNumber numberWithFloat:((WordEntity*)obj1).ratioOfMistake]];
    }];
    temp = [temp filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.ratioOfMistake > 0.0"]];
    return temp;
}


-(int)wordCount
{
    return wordList.count;
}

-(int)wordIDForWord:(WordEntity*)word
{
    return [wordList indexOfObject:word];
}

@end
