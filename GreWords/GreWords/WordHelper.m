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



-(id)init
{
    if(self = [super init])
    {
        
        
        
    }
    return self;
}





-(WordEntity*)wordWithString:(NSString*)string
{
    return nil;
}

-(WordEntity*)wordWithID:(int)wordID
{
    return nil;
}

//return array of wordID:int
-(NSArray*)wordsHasNote
{
    return nil;   
}

-(NSArray*)wordsAlphabeticOrder
{
    return nil;
}

-(NSArray*)wordsHomoionym
{
    return nil;
}

-(NSArray*)wordsRatioOfMistake
{
    return nil;
}


@end
