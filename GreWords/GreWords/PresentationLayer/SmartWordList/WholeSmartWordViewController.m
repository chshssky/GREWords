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
    
    {
        SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
        vc.type = SmartListType_Slide;
        vc.array = [[WordHelper instance] wordsAlphabeticOrder];
        
        [self.pageScrollView addSubview:vc.view];
    }
    {
        SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
        vc.type = SmartListType_Slide;
        vc.array = @[[[WordHelper instance] wordWithID:101],[[WordHelper instance] wordWithID:102],[[WordHelper instance] wordWithID:103]];
        CGRect frame = vc.view.frame;
        frame.origin.x += frame.size.width;
        vc.view.frame = frame;
        [self.pageScrollView addSubview:vc.view];
    }
    {
        SmartWordListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
        vc.type = SmartListType_Slide;
        vc.array = @[[[WordHelper instance] wordWithID:201],[[WordHelper instance] wordWithID:202],[[WordHelper instance] wordWithID:203]];
        CGRect frame = vc.view.frame;
        frame.origin.x += frame.size.width * 2;
        vc.view.frame = frame;
        [self.pageScrollView addSubview:vc.view];
        self.pageScrollView.contentSize = CGSizeMake(frame.size.width * 3, self.pageScrollView.frame.size.height);
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPageScrollView:nil];
    [super viewDidUnload];
}
@end
