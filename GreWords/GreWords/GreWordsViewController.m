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

@interface GreWordsViewController ()<WordDetailViewControllerProtocol>

@property (nonatomic, strong) UIImageView *slideBarView;
@property (nonatomic, strong) UIImageView *slideBarStatusView;
@property (nonatomic, strong) UIImageView *slideBarStatusTextView;
@property (nonatomic, strong) AwesomeMenu *menu;

@property (weak, nonatomic) IBOutlet UIImageView *titleView;

@end

@implementation GreWordsViewController

- (void)initDashboard
{
    dashboard = [[DashboardViewController alloc] init];
    dashboard.nonFinishedNumber = 100;
    dashboard.sumNumber = 300;
    dashboard.delegate = self;
    [self.view addSubview:dashboard.view];
    
    
    self.slideBarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar.png"]];
    self.slideBarView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+190);
    self.slideBarView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.slideBarView.gestureRecognizers = self.view.gestureRecognizers;
    //slideBarView.alpha = 0.5;
    [self.view addSubview:self.slideBarView];

    
    //slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus1.png"]];
    self.slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus2.png"]];
    //slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus3.png"]];
    //slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus4.png"]];
    
    self.slideBarStatusView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+190);
    self.slideBarStatusView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.slideBarStatusView.gestureRecognizers = self.view.gestureRecognizers;
    //slideBarStatusView.alpha = 0.5;
    [self.view addSubview:self.slideBarStatusView];
    
    //slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text1.png"]];
    self.slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text2.png"]];
    //slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text3.png"]];
    //slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text4.png"]];
    self.slideBarStatusTextView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3 + 215);
    self.slideBarStatusTextView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.slideBarStatusTextView.gestureRecognizers = self.view.gestureRecognizers;
    //slideBarStatusView.alpha = 0.5;
    [self.view addSubview:self.slideBarStatusTextView];

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
    
    self.menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds menus:menus];
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"Main menu_xButton.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"Main menu_xButton_clicked.png"];
    
	// customize menu
    self.menu.image = storyMenuItemImage;
    self.menu.highlightedImage = storyMenuItemImagePressed;
    self.menu.contentImage = nil;
    self.menu.highlightedContentImage = nil;
    self.menu.rotateAngle = -0.1;
    self.menu.menuWholeAngle = M_PI / 2 + M_PI / 4;
    self.menu.timeOffset = 0.015f;
    self.menu.farRadius = 95.0f;
    self.menu.endRadius = 80.0f;
    self.menu.nearRadius = 70.0f;
    NSLog(@"size: %f, %f", self.view.bounds.size.height, self.view.bounds.size.width);
    
    self.menu.startPoint = CGPointMake(40.0, self.view.bounds.size.height - 40.0);
	
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
    
    //[self.view makeKeyAndVisible];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initDashboard];
    
    //    for (int i=0; i<3073; i++) {
    //        [vc displayWord:[[WordHelper instance] wordWithID:i] withOption:nil];
    //    }
    //[vc displayWord:[[WordHelper instance] wordWithID:3] withOption:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self initAwesomeMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - menu items

- (void)transaction
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
}

- (void)listController
{
    [self transaction];
    
    SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc.type = SmartListType_Slide;
    vc.array = @[[[WordHelper instance] wordWithID:1],[[WordHelper instance] wordWithID:2],[[WordHelper instance] wordWithID:3]];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

- (void)examController
{
    [self transaction];
    
    WordDetailViewController *vc = [[WordDetailViewController alloc] init];
    vc.wordID = 100;
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

- (void)historyController
{
    [self transaction];
    
    HistoryStatisticsViewController *vc = [[HistoryStatisticsViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

- (void)settingController
{
    [self transaction];
    
    SettingsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"setting"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

#pragma mark - AwesomeMenu Response Delegate

- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    if (idx == 0) {
        [self performSelector:@selector(settingController) withObject:nil afterDelay:0.1];
    } else if (idx == 1) {
        [self performSelector:@selector(examController) withObject:nil afterDelay:0.1];
    } else if (idx == 2) {
        [self performSelector:@selector(historyController) withObject:nil afterDelay:0.1];
    } else if (idx == 3) {
        [self performSelector:@selector(listController) withObject:nil afterDelay:0.1];
    }
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

#pragma mark - DashBoardDelegate
-(void)bigButtonPressed
{
    NSLog(@"Big Button Pressed");
    
    [UIView animateWithDuration:0.5f animations:^{
        self.titleView.transform = CGAffineTransformMakeTranslation(-150, -100);
        self.slideBarView.transform = CGAffineTransformMakeTranslation(-300, 0);
        self.slideBarStatusTextView.transform = CGAffineTransformMakeTranslation(-300, 0);
        self.slideBarStatusView.transform = CGAffineTransformMakeTranslation(-300, 0);
        dashboard.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.2f, 0.2f), CGAffineTransformMakeTranslation(-125, -250));
        self.menu.transform = CGAffineTransformMakeTranslation(-300, 0);
    } completion:^(BOOL finished) {
        WordDetailViewController *vc = [[WordDetailViewController alloc] init];
        vc.delegate = self;
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:vc animated:YES];
    }];
}

#pragma mark - WordDetailDelegate
- (void)AnimationBack
{
    [UIView animateWithDuration:0.5f animations:^{
        self.titleView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(-0.001f, -0.001f));
        self.slideBarView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(-0.001f, 0));
        self.slideBarStatusTextView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(-0.001f, 0));
        self.slideBarStatusView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(-0.001f, 0));
        dashboard.view.transform = CGAffineTransformInvert(CGAffineTransformConcat(CGAffineTransformMakeScale(1.0f, 1.0f), CGAffineTransformMakeTranslation(-0.001f, -0.001f)));
        self.menu.transform = CGAffineTransformMakeTranslation(-0.001f, 0);

    }];
}

- (void)viewDidUnload {
    [self setTitleView:nil];
    [super viewDidUnload];
}
@end
