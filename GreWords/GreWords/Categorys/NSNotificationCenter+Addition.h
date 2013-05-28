//
//  NSNotificationCenter+Addition.h
//  GreWords
//
//  Created by Song on 13-5-20.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WordEntity;

@interface NSNotificationCenter (Addition)
+ (void)postAddNoteForWordNotification:(WordEntity*)word;
+ (void)registerAddNoteForWordNotificationWithSelector:(SEL)aSelector target:(id)aTarget;

+ (void)postRemoveNoteForWordNotification:(WordEntity*)word;
+ (void)registerRemoveNoteForWordNotificationWithSelector:(SEL)aSelector target:(id)aTarget;

+ (void)postShowNoteForWordNotification:(WordEntity*)word;
+ (void)registerShowNoteForWordNotificationWithSelector:(SEL)aSelector target:(id)aTarget;

@end
