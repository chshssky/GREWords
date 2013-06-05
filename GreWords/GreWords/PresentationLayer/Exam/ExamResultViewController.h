//
//  ExamResultViewController.h
//  GreWords
//
//  Created by 崔 昊 on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExamResultProtocol <NSObject>

- (void)returnHome;

@end

@interface ExamResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *memoryRate;
@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *rightCount;
@property (weak, nonatomic) IBOutlet UILabel *wrongCount;

@property (weak, nonatomic) IBOutlet UIImageView *againImage;
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;

@property (nonatomic, strong) id<ExamResultProtocol> delegate;

@end
