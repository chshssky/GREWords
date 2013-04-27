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

#pragma mark - AwesomeMenu Response Delegate

- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    if (idx == 0) {
        SmartWordListViewController *vc = [[SmartWordListViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:vc animated:YES];
    } else if (idx == 1) {
        ExamViewController *vc = [[ExamViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:vc animated:YES];
        //[self.view addSubview:vc.view];
    } else if (idx == 2) {
        WordLayoutViewController *vc = [[WordLayoutViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:vc animated:YES];
    } else if (idx == 3) {
        WordDetailViewController *vc = [[WordDetailViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:vc animated:YES];    }
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

@end
