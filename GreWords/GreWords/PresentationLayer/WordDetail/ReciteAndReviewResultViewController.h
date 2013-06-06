//
//  ReciteAndReviewResultCardViewController.h
//  GreWords
//
//  Created by xsource on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseEvent;

@interface ReciteAndReviewResultViewController : UIViewController
- (void)addReciteAndReviewResultCardAt:(UIViewController *)buttomController withEvent:(BaseEvent*)evet;
- (void)removeReciteAndReviewResultCard;

@end
