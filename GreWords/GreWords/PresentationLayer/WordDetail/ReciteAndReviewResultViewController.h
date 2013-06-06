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
- (void)addReciteAndReviewResultCardAt:(UIViewController *)buttomController;
- (void)removeReciteAndReviewResultCard;

@property (retain,nonatomic) BaseEvent *event;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

- (IBAction)homePressed:(id)sender;

@end
