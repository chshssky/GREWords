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
    }
    return self;
}


@end
