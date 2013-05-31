//
//  GreTableViewSearchIndexViewController.h
//  GreWords
//
//  Created by Song on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreTableViewSearchIndexIndicatorViewController.h"

@protocol GreTableViewSearchIndexDelegate <NSObject>

- (NSArray*)sectionTitles;
- (void)didSelectedIndex:(int)index;

- (void)startTouch;
- (void)endTouch;

@end

@interface GreTableViewSearchIndexViewController : UIViewController
{
    GreTableViewSearchIndexIndicatorViewController *indicator;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) IBOutlet UILabel *sampleLabel;

@property (retain,nonatomic) id<GreTableViewSearchIndexDelegate> delegate;

- (BOOL)isTouching;

- (void)setCurrentIndex:(int)index;

@end
