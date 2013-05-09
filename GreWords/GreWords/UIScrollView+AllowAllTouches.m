//
//  UIScrollView+AllowAllTouches.m
//  GreWords
//
//  Created by Song on 13-5-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "UIScrollView+AllowAllTouches.h"

@implementation UIScrollView (AllowAllTouches)

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
