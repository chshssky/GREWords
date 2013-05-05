//
//  SettingsViewController.h
//  GreWords
//
//  Created by 崔 昊 on 13-4-13.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTabViewDeckViewController.h"
@interface SettingsViewController : UIViewController
{
    SettingTabViewDeckViewController *tabs;
}
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIView *tabViews;

@end
