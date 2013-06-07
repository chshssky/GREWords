//
//  ExamViewController.h
//  GreWords
//
//  Created by 崔 昊 on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *WordParaphraseView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@property (strong, nonatomic) NSDictionary *examInfo;
@property (nonatomic, strong) NSArray * examArr;


@end
