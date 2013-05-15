//
//  WordSmallLayoutViewController.h
//  GreWords
//
//  Created by xsource on 13-5-4.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordEntity.h"

@interface WordSmallLayoutViewController : UIViewController


- (void)displayWord:(WordEntity*)word;

@property (nonatomic) float sumHeight;
@end
