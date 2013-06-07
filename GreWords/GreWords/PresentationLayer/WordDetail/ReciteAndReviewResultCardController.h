//
//  ReciteAndReviewResultCardController.h
//  GreWords
//
//  Created by xsource on 13-6-6.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEvent.h"
#import "NewWordEvent.h"
#import "ReviewEvent.h"

@protocol CardProtocal <NSObject>

- (void)returnHome;

@end

@interface ReciteAndReviewResultCardController : UIViewController

@property (retain,nonatomic) BaseEvent *event;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (strong, nonatomic) id<CardProtocal> delegate;

- (IBAction)homePressed:(id)sender;

@end
