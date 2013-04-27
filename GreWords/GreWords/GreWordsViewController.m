//
//  GreWordsViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-3-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreWordsViewController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "SmartWordListViewController.h"
#import "AwesomeMenu.h"
#import "HistoryStatisticsViewController.h"
#import "SettingsViewController.h"
#import "ExamViewController.h"
#import "WordDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GreWordsViewController ()

@end

@implementation GreWordsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    dashboard = [[DashboardViewController alloc] init];
    dashboard.nonFinishedNumber = 100;
    dashboard.sumNumber = 300;
    
    [self.view addSubview:dashboard.view];
    
//    for (int i=0; i<3073; i++) {
//        [vc displayWord:[[WordHelper instance] wordWithID:i] withOption:nil];
//    }
    //[vc displayWord:[[WordHelper instance] wordWithID:3] withOption:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self initAwesomeMenu];
}

- (void)initAwesomeMenu
{
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xSettingButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xSettingButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xTestButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xTestButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xHistoryButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xHistoryButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xListButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xListButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
    NSLog(@"count: %d", menus.count);
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds menus:menus];
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"Main menu_xButton.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"Main menu_xButton_clicked.png"];
    
	// customize menu
    menu.image = storyMenuItemImage;
    menu.highlightedImage = storyMenuItemImagePressed;
    menu.contentImage = nil;
    menu.highlightedContentImage = nil;
    menu.rotateAngle = -0.1;
    menu.menuWholeAngle = M_PI / 2 + M_PI / 4;
    menu.timeOffset = 0.015f;
    menu.farRadius = 95.0f;
    menu.endRadius = 80.0f;
    menu.nearRadius = 70.0f;
    NSLog(@"size: %f, %f", self.view.bounds.size.height, self.view.bounds.size.width);
    
    menu.startPoint = CGPointMake(40.0, self.view.bounds.size.height - 40.0);
	
    menu.delegate = self;
    [self.view addSubview:menu];
    
    //[self.view makeKeyAndVisible];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listController
{
    UIImageView *blackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568h.png"]];
    blackView.alpha = 0;
    [self.view addSubview:blackView];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)];
    scaleAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:scaleAnim, nil];
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup.duration = 0.5;
    [self.view.layer addAnimation:animGroup forKey:nil];
    
    CABasicAnimation *opacityAnim_black = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim_black.fromValue = [NSNumber numberWithFloat:0];
    opacityAnim_black.toValue = [NSNumber numberWithFloat:0.7];
    opacityAnim_black.removedOnCompletion = YES;
    CAAnimationGroup *animGroup_black = [CAAnimationGroup animation];
    animGroup_black.animations = [NSArray arrayWithObjects:opacityAnim_black, nil];
    animGroup_black.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup_black.duration = 0.5;
    [blackView.layer addAnimation:animGroup_black forKey:nil];
    
    SmartWordListViewController *vc = [[SmartWordListViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

- (void)examController
{
    UIImageView *blackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568h.png"]];
    blackView.alpha = 0;
    [self.view addSubview:blackView];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)];
    scaleAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:scaleAnim, nil];
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup.duration = 0.5;
    [self.view.layer addAnimation:animGroup forKey:nil];
    
    CABasicAnimation *opacityAnim_black = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim_black.fromValue = [NSNumber numberWithFloat:0];
    opacityAnim_black.toValue = [NSNumber numberWithFloat:0.7];
    opacityAnim_black.removedOnCompletion = YES;
    CAAnimationGroup *animGroup_black = [CAAnimationGroup animation];
    animGroup_black.animations = [NSArray arrayWithObjects:opacityAnim_black, nil];
    animGroup_black.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup_black.duration = 0.5;
    [blackView.layer addAnimation:animGroup_black forKey:nil];
    
    ExamViewController *vc = [[ExamViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

- (void)historyController
{
    UIImageView *blackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568h.png"]];
    blackView.alpha = 0;
    [self.view addSubview:blackView];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)];
    scaleAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:scaleAnim, nil];
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup.duration = 0.5;
    [self.view.layer addAnimation:animGroup forKey:nil];
    
    CABasicAnimation *opacityAnim_black = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim_black.fromValue = [NSNumber numberWithFloat:0];
    opacityAnim_black.toValue = [NSNumber numberWithFloat:0.7];
    opacityAnim_black.removedOnCompletion = YES;
    CAAnimationGroup *animGroup_black = [CAAnimationGroup animation];
    animGroup_black.animations = [NSArray arrayWithObjects:opacityAnim_black, nil];
    animGroup_black.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup_black.duration = 0.5;
    [blackView.layer addAnimation:animGroup_black forKey:nil];
    
    WordLayoutViewController *vc = [[WordLayoutViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

- (void)settingController
{
    UIImageView *blackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568h.png"]];
    blackView.alpha = 0;
    [self.view addSubview:blackView];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)];
    scaleAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:scaleAnim, nil];
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup.duration = 0.5;
    [self.view.layer addAnimation:animGroup forKey:nil];
    
    CABasicAnimation *opacityAnim_black = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim_black.fromValue = [NSNumber numberWithFloat:0];
    opacityAnim_black.toValue = [NSNumber numberWithFloat:0.7];
    opacityAnim_black.removedOnCompletion = YES;
    CAAnimationGroup *animGroup_black = [CAAnimationGroup animation];
    animGroup_black.animations = [NSArray arrayWithObjects:opacityAnim_black, nil];
    animGroup_black.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup_black.duration = 0.5;
    [blackView.layer addAnimation:animGroup_black forKey:nil];
    
    WordDetailViewController *vc = [[WordDetailViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

#pragma mark - AwesomeMenu Response Delegate

- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    if (idx == 0) {
        SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
        vc.type = SmartListType_Slide;
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:vc animated:YES];
    } else if (idx == 1) {
        [self performSelector:@selector(examController) withObject:nil afterDelay:0.3];
    } else if (idx == 2) {
        [self performSelector:@selector(historyController) withObject:nil afterDelay:0.3];
    } else if (idx == 3) {
        [self performSelector:@selector(listController) withObject:nil afterDelay:0.3];
    }
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

@end
