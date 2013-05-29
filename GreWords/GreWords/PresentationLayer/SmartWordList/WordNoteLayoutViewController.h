//
//  WordNoteLayoutViewController.h
//  GreWords
//
//  Created by xsource on 13-5-17.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordEntity.h"

@interface WordNoteLayoutViewController : UIViewController

- (void)displayNote:(WordEntity*)word;

@property (nonatomic) float sumHeight;


@end
