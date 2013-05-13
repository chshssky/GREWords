//
//  WholeSmartWordViewController.h
//  GreWords
//
//  Created by Song on 13-5-12.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartWordListViewController.h"
#import "MHTabBarController.h"

@interface WholeSmartWordViewController : UIViewController<SmartWordListScrollDelegate,MHTabBarControllerDelegate,UIScrollViewDelegate>
{
    CGFloat _tabbarYBeforeScroll;
    CGRect originalTableViewFrame;
    
    NSArray *smartlistArr;
    
    MHTabBarController *tabBarController;
    
    BOOL isDragging;
}

@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
