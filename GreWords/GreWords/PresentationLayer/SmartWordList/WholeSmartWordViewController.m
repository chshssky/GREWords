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
#import "GreWordsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSNotificationCenter+Addition.h"
#import "NoteViewController.h"
#import "ConfigurationHelper.h"
#import "GuideImageFactory.h"
#import <Flurry.h>

@interface WholeSmartWordViewController ()
{
    UIImageView *guideImageView;
}
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
    
    [Flurry logEvent:@"viewSmartList" timed:YES];
    
    isDragging = NO;
    isSearching = NO;
    
    originalTableViewFrame = self.pageScrollView.frame;
    
    SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc.type = SmartListType_Mistake;
    vc.array = [[WordHelper instance] wordsRatioOfMistake];
    CGRect frame = vc.view.frame;
    frame.origin.y = 0;
    vc.view.frame = frame;
    [self.pageScrollView addSubview:vc.view];
    
    SmartWordListViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc2.type = SmartListType_Full;
    vc2.array = [[WordHelper instance] wordsAlphabeticOrder];
    frame = vc2.view.frame;
    frame.origin.x += frame.size.width;
    frame.origin.y = 0;
    vc2.view.frame = frame;
    [self.pageScrollView addSubview:vc2.view];

    
    SmartWordListViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc3.type = SmartListType_Homo;
    vc3.array = [[WordHelper instance] wordsHomoionym];
    frame = vc3.view.frame;
    frame.origin.x += frame.size.width * 2;
    frame.origin.y = 0;
    vc3.view.frame = frame;
    [self.pageScrollView addSubview:vc3.view];
    
    SmartWordListViewController *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc4.type = SmartListType_Note;
    vc4.array = [[WordHelper instance] wordsHasNote];
    frame = vc4.view.frame;
    frame.origin.x += frame.size.width * 3;
    frame.origin.y = 0;
    vc4.view.frame = frame;
    [self.pageScrollView addSubview:vc4.view];
    self.pageScrollView.contentSize = CGSizeMake(frame.size.width * 4, self.pageScrollView.frame.size.height);

    {
        UIImageView *middleLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"words list_pageLine.png"]];
        frame = middleLine.frame;
        frame.origin.x = self.pageScrollView.frame.size.width - 3;
        middleLine.frame = frame;
        
        [self.pageScrollView addSubview:middleLine];
    }
    {
        UIImageView *middleLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"words list_pageLine.png"]];
        frame = middleLine.frame;
        frame.origin.x = self.pageScrollView.frame.size.width * 2 - 3;
        middleLine.frame = frame;
        
        [self.pageScrollView addSubview:middleLine];
    }
    {
        UIImageView *middleLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"words list_pageLine.png"]];
        frame = middleLine.frame;
        frame.origin.x = self.pageScrollView.frame.size.width * 3 - 3;
        middleLine.frame = frame;
        
        [self.pageScrollView addSubview:middleLine];
    }

    
    smartlistArr = @[vc,vc2,vc3,vc4];
    
    vc.scrollDelegate = self;
    vc2.scrollDelegate = self;
    vc3.scrollDelegate = self;
    vc4.scrollDelegate = self;
    
    tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"mhtab"];
    tabBarController.view.frame = CGRectMake(0, 48, 320, 44);
    
	tabBarController.delegate = self;
	tabBarController.viewControllerTitles = @[@"重难词汇",@"三千单词",@"词义归类",@"便笺小记"];
    
    [self.topView addSubview:tabBarController.view];
    
    self.pageScrollView.clipsToBounds = YES;
	
    
    [NSNotificationCenter registerShowNoteForWordNotificationWithSelector:@selector(showNote:) target:self];
    
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_List])
    {
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_List];
        [self.view addSubview:guideImageView];
    }

    
    [self setTapToTop:0];
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
    [Flurry endTimedEvent:@"viewSmartList" withParameters:nil];
    
    GreWordsViewController *superController =  (GreWordsViewController *)[self presentingViewController];
    
    UIImageView *blackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [blackView setBackgroundColor:[UIColor blackColor]];
    blackView.alpha = 0;
    [superController.view addSubview:blackView];
    
    
    superController.whetherAllowViewFrameChanged = YES;
    CABasicAnimation *opacityAnim_black = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim_black.fromValue = [NSNumber numberWithFloat:0.7];
    opacityAnim_black.toValue = [NSNumber numberWithFloat:0];
    opacityAnim_black.removedOnCompletion = YES;
    CAAnimationGroup *animGroup_black = [CAAnimationGroup animation];
    animGroup_black.animations = [NSArray arrayWithObjects:opacityAnim_black, nil];
    animGroup_black.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup_black.duration = 0.5;
    [blackView.layer addAnimation:animGroup_black forKey:nil];
    
    [self dismissModalViewControllerAnimated:YES];
}


- (void)setTapToTop:(int)index
{
    NSLog(@"Tap To Top:%d",index);
    [self.pageScrollView setScrollsToTop:NO];
    for(int i = 0; i < smartlistArr.count; i++)
    {
        SmartWordListViewController *vc = smartlistArr[i];
        [vc.tableView setScrollsToTop:(i == index)];
    }
}

#pragma mark - Smart Word List View Scroll Delegate

-(void)smartWordListWillStartSearch:(SmartWordListViewController*)list
{
    isSearching = YES;
    [UIView animateWithDuration:0.2 animations:^()
    {
        CGRect frame = self.topView.frame;
        frame.origin.y = - frame.size.height;
        self.topView.frame = frame;
        
        frame = self.pageScrollView.frame;
        frame.origin.y = 0;
        frame.size.height = originalTableViewFrame.size.height +self.topView.frame.size.height;
        self.pageScrollView.frame = frame;
        
        frame = list.view.frame;
        frame.size.height = originalTableViewFrame.size.height + self.topView.frame.size.height;
        list.view.frame = frame;
        
    }];
}

-(void)smartWordListDidEndSearch:(SmartWordListViewController*)list
{
    isSearching = NO;
    [UIView animateWithDuration:0.2 animations:^()
     {
         CGRect frame = self.topView.frame;
         frame.origin.y = 0;
         self.topView.frame = frame;
         
         frame = self.pageScrollView.frame;
         frame.origin.y = self.topView.frame.size.height;
         frame.size.height = originalTableViewFrame.size.height;
         self.pageScrollView.frame = frame;
         
     }];
}

-(void)smartWordListWillBeginDragging:(SmartWordListViewController*)list
{
    if(isSearching)
        return;
    //NSLog(@"will begin draggin");
    _tabbarYBeforeScroll = self.topView.frame.origin.y;
}

-(void)smartWordList:(SmartWordListViewController*)list didTranslationYSinceLast:(CGFloat)traslation
{
    if(isSearching)
        return;
    //NSLog(@"didTranslationYSinceLast");
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
    frame.size.height = originalTableViewFrame.size.height +self.topView.frame.size.height;
    self.pageScrollView.frame = frame;
}


-(void)smartWordListSearchIndexStartTouch:(SmartWordListViewController *)list
{
    [self.pageScrollView.panGestureRecognizer setEnabled:NO];
}

-(void)smartWordListSearchIndexEndTouch:(SmartWordListViewController *)list
{
    [self.pageScrollView.panGestureRecognizer setEnabled:YES];
}

#pragma mark - MHTabbarController delegate
- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectIndex:(NSUInteger)index
{
    if(isDragging){
        return;
    }
    
    [self.pageScrollView scrollRectToVisible:CGRectMake(self.pageScrollView.frame.size.width * index, 0, self.pageScrollView.frame.size.width, self.pageScrollView.frame.size.height) animated:YES];
    
    [self setTapToTop:index];
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
    [self setTapToTop:page];
}


#pragma mark - NSNotification Responder

- (void)showNote:(NSNotification *)notification
{
    WordEntity* word = (WordEntity*) notification.object;
    
    NoteViewController *noteVC = [[NoteViewController alloc] init];

    int wordID =  [[WordHelper instance] wordIDForWord:word];
    [noteVC addNoteAt:self withWordID:wordID];
    [noteVC.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:noteVC.view];
}


@end
