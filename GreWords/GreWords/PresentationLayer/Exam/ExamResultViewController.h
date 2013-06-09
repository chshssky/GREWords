//
//  ExamResultViewController.h
//  GreWords
//
//  Created by xsource on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamEvent.h"

@protocol ExamResultProtocal <NSObject>

-(void)reExam;
-(void)backLHome;

@end

@interface ExamResultViewController : UIViewController
- (void)addExamResultCardAt:(UIViewController *)buttomController withResult:(ExamEvent*)result delegate:(id<ExamResultProtocal>)delegate;
- (void)removeExamResultCard;
@end
