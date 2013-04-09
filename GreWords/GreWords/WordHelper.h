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
    NSMutableDictionary *wordIndexes;
}
+(WordHelper*) instance;
-(WordEntity*)wordWithString:(NSString*)string;
-(WordEntity*)wordWithID:(int)wordID;

//return array of wordID:int
-(NSArray*)wordsHasNote;
-(NSArray*)wordsAlphabeticOrder;
-(NSArray*)wordsHomoionym;
-(NSArray*)wordsRatioOfMistake;

@end
