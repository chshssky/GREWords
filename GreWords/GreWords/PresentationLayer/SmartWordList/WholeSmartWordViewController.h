//
//  WholeSmartWordViewController.h
//  GreWords
//
//  Created by Song on 13-5-12.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WholeSmartWordViewController : UIViewController
{
    CGFloat _contentOffsetBeforeScroll;
    CGFloat _tabbarYBeforeScroll;
    CGRect originalTableViewFrame,originalTabBarFrame;
}

@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;

@end
