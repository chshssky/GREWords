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

@optional

- (BOOL)useCustomView;
- (UIView*)selectedCellViewAtIndex:(NSUInteger)index;
- (UIView*)unselectedCellViewAtIndex:(NSUInteger)index;
- (int)numberOfTiles;

@end

@interface GreTableViewSearchIndexViewController : UIViewController<UIGestureRecognizerDelegate>
{
    GreTableViewSearchIndexIndicatorViewController *indicator;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *backroundViewPressed;
@property (strong, nonatomic) IBOutlet UILabel *sampleLabel;

@property (nonatomic) BOOL usePicture;

@property (retain,nonatomic) id<GreTableViewSearchIndexDelegate> delegate;

- (BOOL)isTouching;

- (void)setCurrentIndex:(int)index;

@end
