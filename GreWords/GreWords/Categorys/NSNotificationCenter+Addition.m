//
//  NSNotificationCenter+Addition.m
//  GreWords
//
//  Created by Song on 13-5-20.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "NSNotificationCenter+Addition.h"
#import "WordEntity.h"

#define kAddNoteForWordNotification @"kAddNoteForWordNotification"
#define kRemoveNoteForWordNotification @"kRemoveNoteForWordNotification"

@implementation NSNotificationCenter (Addition)
+ (void)postAddNoteForWordNotification:(WordEntity*)word
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddNoteForWordNotification object:word userInfo:nil];
}

+ (void)registerAddNoteForWordNotificationWithSelector:(SEL)aSelector target:(id)aTarget
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:aTarget selector:aSelector
                   name:kAddNoteForWordNotification
                 object:nil];
}

+ (void)postRemoveNoteForWordNotification:(WordEntity*)word
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveNoteForWordNotification object:word userInfo:nil];
}

+ (void)registerRemoveNoteForWordNotificationWithSelector:(SEL)aSelector target:(id)aTarget
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:aTarget selector:aSelector
                   name:kRemoveNoteForWordNotification
                 object:nil];
}

@end
