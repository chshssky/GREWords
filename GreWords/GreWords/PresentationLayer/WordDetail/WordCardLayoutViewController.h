//
//  WordCardLayoutViewController.h
//  GreWords
//
//  Created by xsource on 13-5-17.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordEntity.h"

@interface WordCardLayoutViewController : UIViewController

- (void)displayCard:(NSDictionary *) wordDictionary;

@property (nonatomic) float sumHeight;


@end
