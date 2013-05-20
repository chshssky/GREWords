//
//  WordDetailViewControllerProtocol.h
//  GreWords
//
//  Created by 崔 昊 on 13-5-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WordDetailViewControllerProtocol <NSObject>

- (void)AnimationBack;
- (void)GoToNewWordWithWord:(int)wordIndex andThe:(int)maxWordNum;

@end
