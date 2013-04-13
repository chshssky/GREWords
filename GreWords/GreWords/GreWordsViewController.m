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

@interface GreWordsViewController ()

@end

@implementation GreWordsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initAwesomeMenu];
    
//    for (int i=0; i<3073; i++) {
//        [vc displayWord:[[WordHelper instance] wordWithID:i] withOption:nil];
//    }
    //[vc displayWord:[[WordHelper instance] wordWithID:3] withOption:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)initAwesomeMenu
{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    /*AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem6 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem7 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem8 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem9 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];*/
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
    NSLog(@"count: %d", menus.count);
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds menus:menus];
    
	// customize menu
    
    menu.rotateAngle = 0.0;
    menu.menuWholeAngle = M_PI / 2 + M_PI / 6;
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

        [self.view addSubview:vc.view];
    }
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

@end
