//
//  SettingTabViewDeckViewController.h
//  GreWords
//
//  Created by Song on 13-5-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTabViewController.h"

@interface SettingTabViewDeckViewController : UIViewController<SettingTabViewDelegate>
{
    NSArray *tabArr;
    int touchIndex;
}
@property (weak, nonatomic) IBOutlet UIView *tabViews;

@end
