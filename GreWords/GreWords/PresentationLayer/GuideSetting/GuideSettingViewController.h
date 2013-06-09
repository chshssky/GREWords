//
//  GuideSettingViewController.h
//  GreWords
//
//  Created by xsource on 13-6-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideSettingViewController : UIViewController

@property (weak, nonatomic) id pview;

@property (weak, nonatomic) IBOutlet UIButton *goButton;

-(int)stage;

- (IBAction)goPressed:(id)sender;

@end
