//
//  WelcomeViewController.h
//  GreWords
//
//  Created by Song on 13-5-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
-(IBAction)goPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIView *v3;
@property (weak, nonatomic) IBOutlet UIView *v4;
@property (weak, nonatomic) IBOutlet UIView *v5;

@property (weak, nonatomic) IBOutlet UIImageView *v1i;
@property (weak, nonatomic) IBOutlet UIImageView *v2i;
@property (weak, nonatomic) IBOutlet UIImageView *v3i;
@property (weak, nonatomic) IBOutlet UIImageView *v4i;


@end
