//
//  WordDetailViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-4-25.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordDetailViewController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"

@interface WordDetailViewController () <UIScrollViewDelegate>


@end

@implementation WordDetailViewController


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
    // Do any additional setup after loading the view from its nib.
    WordLayoutViewController *vc = [[WordLayoutViewController alloc] init];
    [vc displayWord:[[WordHelper instance] wordWithID:0] withOption:nil];
    CGRect frame = vc.view.frame;
    
//    if(frame.size.height > ScrollViewHeight)
//    {
//        frame.size.height = ScrollViewHeight;
//        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
//        scrollView.contentSize = vc.view.frame.size;
//        [scrollView addSubview:vc.view];
//        [cell addSubview:scrollView];
//
//    }
//    else
//    {
//        [cell addSubview:vc.view];
//
//    }
    self.WordParaphraseView.delegate = self;
    self.WordParaphraseView.contentSize = vc.view.frame.size;
    [self.WordParaphraseView addSubview:vc.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"hehehehehe~");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWordParaphraseView:nil];
    [super viewDidUnload];
}
@end
