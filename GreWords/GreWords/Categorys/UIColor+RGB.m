//
//  UIColor+RGB.m
//  GreWords
//
//  Created by Song on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+ (UIColor*)colorWithR:(int)r G:(int)g B:(int)b
{
     return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (UIColor*)colorWithR:(int)r G:(int)g B:(int)b A:(float)a
{
     return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

@end
