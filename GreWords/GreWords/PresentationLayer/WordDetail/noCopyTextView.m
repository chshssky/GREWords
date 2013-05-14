//
//  noCopyTextView.m
//  GreWords
//
//  Created by xsource on 13-5-14.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "noCopyTextView.h"

@implementation noCopyTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:))
    {
        return NO;
    }
    else if (action == @selector(copy:))
    {
        return NO;
    }
    else if (action == @selector(paste:))
    {
        return NO;
    }
    else if (action == @selector(select:))
    {
        return NO;
    }
    else if (action == @selector(selectAll:))
    {
        return NO;
    }
    else if (action == @selector(_define:))
    {
        return NO;
    }
    else
    {
        return [super canPerformAction:action withSender:sender];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
