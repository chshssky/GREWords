//
//  SettingTabViewController.h
//  GreWords
//
//  Created by Song on 13-5-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTabViewDelegate.h"

typedef enum {
    SettingTabViewStateUp,
    SettingTabViewStateDown
}SettingTabViewState;

@interface SettingTabViewController : UIViewController<UIScrollViewDelegate>
{
    //CGRect originalFrame;
    CGPoint lastTranslate;
    SettingTabViewState state;
}

@property (weak, nonatomic) IBOutlet UIImageView *describeImage;
@property (nonatomic) CGRect originalFrame;
@property (nonatomic) float yOffset;
@property (nonatomic,strong) id<SettingTabViewDelegate> delegate;

@end
