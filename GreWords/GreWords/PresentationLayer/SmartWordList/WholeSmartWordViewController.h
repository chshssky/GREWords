//
//  WholeSmartWordViewController.h
//  GreWords
//
//  Created by Song on 13-5-12.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartWordListViewController.h"

@interface WholeSmartWordViewController : UIViewController<SmartWordListScrollDelegate>
{
    CGFloat _tabbarYBeforeScroll;
    CGRect originalTableViewFrame;
    
    NSArray *smartlistArr;
}

@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
