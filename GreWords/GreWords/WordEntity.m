//
//  wordEntity.m
//  GreWords
//
//  Created by Song on 13-4-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordEntity.h"

@implementation WordEntity

-(NSDictionary*)data
{
    NSArray *arr;
    {
        NSString *infoSouceFile = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
        NSData* data = [NSData dataWithContentsOfFile:infoSouceFile];
        NSError *error;
        NSPropertyListFormat format;
        arr = [NSPropertyListSerialization propertyListWithData:data options:0 format:&format error:&error];
    }
    return arr[0];
}


@end
