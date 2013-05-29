//
//  NewWordDetailViewController.h
//  GreWords
//
//  Created by xsource on 13-5-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWordDetailViewControllerProtocol.h"
#import "IIViewDeckController.h"
#import "UIScrollView+AllowAllTouches.h"
#import "NoteViewController.h"

@interface NewWordDetailViewController : UIViewController <UIScrollViewDelegate,IIViewDeckControllerDelegate,UIGestureRecognizerDelegate, NoteViewControllerProtocol>

@property (strong, nonatomic) id<NewWordDetailViewControllerProtocol> delegate;

@property (nonatomic) int beginWordID;
@property (nonatomic) int changePage;

- (void)removeDownImageAnimation_withDownCover;
- (void)removeDownImageAnimation_withNoDownCover;

@end
