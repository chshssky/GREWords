//
//  NewWordDetailViewController.h
//  GreWords
//
//  Created by xsource on 13-5-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWordDetailViewControllerProtocol.h"

@interface NewWordDetailViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *WordParaphraseView;

@property (weak, nonatomic) IBOutlet UIScrollView *pageControlView;
@property (nonatomic, retain) NSMutableArray *viewControlArray;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (strong, nonatomic) id<NewWordDetailViewControllerProtocol> delegate;

@property (nonatomic) int wordID;
@end
