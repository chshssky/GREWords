//
//  ReciteAndReviewResultCardViewController.h
//  GreWords
//
//  Created by xsource on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReciteAndReviewResultCardController.h"
@class BaseEvent;

@interface ReciteAndReviewResultViewController : UIViewController

@property (nonatomic, strong) id<CardProtocal> delegate;

- (void)addReciteAndReviewResultCardAt:(UIViewController *)buttomController withEvent:(BaseEvent*)evet;
- (void)removeReciteAndReviewResultCard;


@end
