//
//  NewWordDetailViewController.h
//  GreWords
//
//  Created by xsource on 13-5-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWordDetailViewControllerProtocol.h"
#import "IIViewDeckController.h"
//#import "UIScrollView+AllowAllTouches.h"

@interface NewWordDetailViewController : UIViewController <UIScrollViewDelegate,IIViewDeckControllerDelegate>

@property int day;

@property (strong, nonatomic) id<NewWordDetailViewControllerProtocol> delegate;

@end
