//
//  wordEntity.h
//  GreWords
//
//  Created by Song on 13-4-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordEntity : NSObject

@property (nonatomic,retain,readonly) NSDictionary *data;
@property (nonatomic,retain) NSString *note;
@property (nonatomic,readonly) float ratioOfMistake;
@property (nonatomic,retain,readonly) NSArray *currentMistkeStatus;
@property (nonatomic,retain,readonly) NSDate *lastMistakeTime;
@property (nonatomic,readonly) int wordID;

-(void)didMadeAMistakeOnDate:(NSDate*)date;


-(id)initWithID:(int)wordID data:(NSDictionary*)data;


@end
