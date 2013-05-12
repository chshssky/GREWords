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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"begin dragging:%@",scrollView);
//    if(_scroller == scrollView)
//    {
//        _contentOffsetBeforeScroll = _scroller.contentOffset.y;
//        _tabbarYBeforeScroll = self.topTabbarView.frame.origin.y;
//    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    originalTableViewFrame = self.pageScrollView.frame;
    
    SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc.type = SmartListType_Slide;
    vc.array = [[WordHelper instance] wordsAlphabeticOrder];
    
    [self.pageScrollView addSubview:vc.view];
    
    SmartWordListViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc2.type = SmartListType_Slide;
    vc2.array = @[[[WordHelper instance] wordWithID:101],[[WordHelper instance] wordWithID:102],[[WordHelper instance] wordWithID:103]];
    CGRect frame = vc2.view.frame;
    frame.origin.x += frame.size.width;
    vc2.view.frame = frame;
    [self.pageScrollView addSubview:vc2.view];

    
    SmartWordListViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    vc3.type = SmartListType_Slide;
    vc3.array = @[[[WordHelper instance] wordWithID:201],[[WordHelper instance] wordWithID:202],[[WordHelper instance] wordWithID:203]];
    frame = vc3.view.frame;
    frame.origin.x += frame.size.width * 2;
    vc3.view.frame = frame;
    [self.pageScrollView addSubview:vc3.view];
    self.pageScrollView.contentSize = CGSizeMake(frame.size.width * 3, self.pageScrollView.frame.size.height);

    
    smartlistArr = @[vc,vc2,vc3];
    
    vc.scrollDelegate = self;
    vc2.scrollDelegate = self;
    vc3.scrollDelegate = self;
    
	// Do any additional setup after loading the view.
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
        frame.origin.y =0;
    if(frame.origin.y < -frame.size.height)
        frame.origin.y = -frame.size.height;
    
    self.topView.frame = frame;
    
    frame = self.pageScrollView.frame;
    frame.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height;
    frame.size.height = originalTableViewFrame.origin.y + originalTableViewFrame.size.height - frame.origin.y;
    self.pageScrollView.frame = frame;
}

@end
