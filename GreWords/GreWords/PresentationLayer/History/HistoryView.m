//
//  HistoryView.m
//  GreWords
//
//  Created by xsource on 13-6-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "HistoryView.h"

@implementation HistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (iPhone5) {
        if (point.y <= 468.0 && point.y >= 181.0) {
            UIView* hitView = [self viewWithTag:1];
            if (hitView) {
                return hitView;
            }
        }
    }else {
        if (point.y <= 410.0 && point.y >= 165.0) {
            UIView* hitView = [self viewWithTag:1];
            if (hitView) {
                return hitView;
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
