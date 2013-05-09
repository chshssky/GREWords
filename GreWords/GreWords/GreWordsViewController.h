//
//  GreWordsViewController.h
//  GreWords
//
//  Created by 崔 昊 on 13-3-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardViewController.h"
#import "AwesomeMenu.h"
#import "IIViewDeckController.h"

@interface GreWordsViewController : UIViewController<DashboardProtocal,AwesomeMenuDelegate>
{
    DashboardViewController *dashboard;
}
@end
