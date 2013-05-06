//
//  SettingTabViewDeckViewController.h
//  GreWords
//
//  Created by Song on 13-5-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTabViewController.h"
#import "SettingTabViewDelegate.h"
@interface SettingTabViewDeckViewController : UIViewController
{
    NSArray *tabArr;
    int touchIndex;
}
@property (strong, nonatomic) IBOutlet UIView *tabViews;
@property (retain, nonatomic)  id<SettingTabViewDelegate> delegate;

@end
