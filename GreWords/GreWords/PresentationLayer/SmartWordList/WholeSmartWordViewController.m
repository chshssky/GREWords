//
//  WholeSmartWordViewController.m
//  GreWords
//
//  Created by Song on 13-5-12.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WholeSmartWordViewController.h"
#import "SmartWordListViewController.h"
#import "WordHelper.h"


@interface WholeSmartWordViewController ()

@end

@implementation WholeSmartWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isDragging = NO;
    
    originalTableViewFrame = self.pageScrollView.frame;
    
    SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc.type = SmartListType_Full;
    vc.array = [[WordHelper instance] wordsAlphabeticOrder];
    CGRect frame = vc.view.frame;
    frame.origin.y = 0;
    vc.view.frame = frame;
    [self.pageScrollView addSubview:vc.view];
    
    SmartWordListViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc2.type = SmartListType_Slide;
    vc2.array = @[[[WordHelper instance] wordWithID:101],[[WordHelper instance] wordWithID:102],[[WordHelper instance] wordWithID:103]];
    frame = vc2.view.frame;
    frame.origin.x += frame.size.width;
    frame.origin.y = 0;
    vc2.view.frame = frame;
    [self.pageScrollView addSubview:vc2.view];

    
    SmartWordListViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc3.type = SmartListType_Full;
    vc3.array = @[[[WordHelper instance] wordWithID:201],[[WordHelper instance] wordWithID:202],[[WordHelper instance] wordWithID:203]];
    frame = vc3.view.frame;
    frame.origin.x += frame.size.width * 2;
    frame.origin.y = 0;
    vc3.view.frame = frame;
    [self.pageScrollView addSubview:vc3.view];
    self.pageScrollView.contentSize = CGSizeMake(frame.size.width * 3, self.pageScrollView.frame.size.height);

    
    smartlistArr = @[vc,vc2,vc3];
    
    vc.scrollDelegate = self;
    vc2.scrollDelegate = self;
    vc3.scrollDelegate = self;
    
    
    tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"mhtab"];
    tabBarController.view.frame = CGRectMake(0, 48, 320, 44);
    
	tabBarController.delegate = self;
	tabBarController.viewControllerTitles = @[@"重难词汇",@"三千单词",@"词义归类"];
    
    [self.topView addSubview:tabBarController.view];
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPageScrollView:nil];
    [self setTopView:nil];
    [super viewDidUnload];
}

- (IBAction)exitPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Smart Word List View Scroll Delegate
-(void)smartWordListWillBeginDragging:(SmartWordListViewController*)list
{
    NSLog(@"will begin draggin");
    _tabbarYBeforeScroll = self.topView.frame.origin.y;
}

-(void)smartWordList:(SmartWordListViewController*)list didTranslationYSinceLast:(CGFloat)traslation
{
    NSLog(@"didTranslationYSinceLast");
    CGFloat contentOffsetY = traslation;
    CGRect frame = self.topView.frame;
    
    frame.origin.y = _tabbarYBeforeScroll - contentOffsetY;
    if(frame.origin.y > 0)
        frame.origin.y = 0;
    if(frame.origin.y < -frame.size.height)
        frame.origin.y = -frame.size.height;
    
    self.topView.frame = frame;
    
    frame = self.pageScrollView.frame;
    frame.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height;
    frame.size.height = originalTableViewFrame.origin.y + originalTableViewFrame.size.height - frame.origin.y;
    self.pageScrollView.frame = frame;
}

#pragma mark - MHTabbarController delegate
- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectIndex:(NSUInteger)index
{
    NSLog(@"smart list tab select %d",index);
    if(isDragging)
        return;

    [self.pageScrollView scrollRectToVisible:CGRectMake(self.pageScrollView.frame.size.width * index, 0, self.pageScrollView.frame.size.width, self.pageScrollView.frame.size.height) animated:YES];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    isDragging = YES;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isDragging = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!isDragging)
        return;
    
    int x = self.pageScrollView.contentOffset.x;
    
    x += self.pageScrollView.frame.size.width / 2.0;
    
    int page = x / (self.pageScrollView.frame.size.width);
    
    [tabBarController setSelectedIndex:page animated:YES];
}

@end
