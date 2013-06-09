//
//  NewWordStatus.h
//  GreWords
//
//  Created by 崔 昊 on 13-6-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@class History;

@interface NewWordStatus : IAThreadSafeManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * maxWordID;
@property (nonatomic, retain) NSNumber * reviewEnable;
@property (nonatomic, retain) History *history;

@end
