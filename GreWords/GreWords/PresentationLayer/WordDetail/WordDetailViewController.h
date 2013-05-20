//
//  WordDetailViewController.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-25.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordDetailViewControllerProtocol.h"

@interface WordDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *WordParaphraseView;
@property (weak, nonatomic) IBOutlet UILabel *wordPronounceLabel;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (strong, nonatomic) id<WordDetailViewControllerProtocol> delegate;

@property (nonatomic) int indexOfWordIDToday;
@property (nonatomic) int maxWordID;

@end
