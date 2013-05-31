//
//  UIColor+RGB.h
//  GreWords
//
//  Created by Song on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)

+ (UIColor*)colorWithR:(int)r G:(int)g B:(int)b;
+ (UIColor*)colorWithR:(int)r G:(int)g B:(int)b A:(float)a;

@end
