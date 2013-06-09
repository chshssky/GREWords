//
//  Note.h
//  GreWords
//
//  Created by 崔 昊 on 13-6-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IAThreadSafeCoreData/IAThreadSafeManagedObject.h>

@class Word;

@interface Note : IAThreadSafeManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) Word *note2word;

@end
