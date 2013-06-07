//
//  HistoryStatisticsViewController.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-13.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryView.h"

@interface HistoryStatisticsViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet HistoryView *hitTestView;

@end
