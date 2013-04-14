//
//  Note.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-10.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@class Word;

@interface Note : IAThreadSafeManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) Word *note2word;

@end
