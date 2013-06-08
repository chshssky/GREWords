//
//  ExamResultCardController.h
//  GreWords
//
//  Created by xsource on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamResultCardController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWordCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rememberCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *forgetCountLabel;
- (IBAction)homePressed:(id)sender;
- (IBAction)reexamPressed:(id)sender;
@end