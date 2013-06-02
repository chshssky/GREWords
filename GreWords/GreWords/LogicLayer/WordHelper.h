//
//  WordHelper.h
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordEntity.h"
@interface WordHelper : NSObject
{
    NSMutableArray *wordList;
    
    NSArray *homoArr;
}

+(WordHelper*) instance;
//-(WordEntity*)wordWithString:(NSString*)string;
-(WordEntity*)wordWithID:(int)wordID;
-(int)wordIDForWord:(WordEntity*)word;

//return array of wordID:int
-(NSArray*)wordsHasNote;
-(NSArray*)wordsAlphabeticOrder;
-(NSArray*)wordsHomoionym;
-(NSArray*)wordsRatioOfMistake;

-(NSArray*)recitedWordsWithRatioOfMistakeFrom:(float)lowerBound to:(float)upperBound;


-(int)wordCount;
@end
