//
//  WordTaskGenerator.h
//  GreWords
//
//  Created by xsource on 13-4-10.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordTaskGenerator : NSObject

+ (WordTaskGenerator *)instance;
- (NSArray *)newWordTask_twoList:(int)day;
- (int)theNumberOfNewWordToday_twolist:(int)day;
- (NSArray *)reviewTask_twoList:(int)day;
- (NSArray *)reviewTask_fourthCircle:(int)day;


- (NSArray *)testTaskWithOptions:(NSDictionary *)dict whetherWithAllWords:(BOOL)allWords;
- (void)clearTask;

//- (NSArray *)newWordTask_threeList:(int)day;
//- (NSArray *)reviewTask_threeList:(int)day;
//- (void)setWhetherNoOrder:(bool)flag;

@property(nonatomic) bool whetherViewNoOrder;

@end
