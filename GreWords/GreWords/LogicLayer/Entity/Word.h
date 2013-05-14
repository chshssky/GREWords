//
//  Word.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-14.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@class Note;

@interface Word : IAThreadSafeManagedObject

@property (nonatomic, retain) NSString * lastChecks;
@property (nonatomic, retain) NSDate * lastMistakeTime;
@property (nonatomic, retain) NSNumber * plistID;
@property (nonatomic, retain) Note *word2note;

@end
