//
//  NewWordDetailViewController.m
//  GreWords
//
//  Created by xsource on 13-5-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "NewWordDetailViewController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "WordSpeaker.h"

@interface NewWordDetailViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UIImageView *DownImage;
@property (weak, nonatomic) IBOutlet UIButton *PronounceButton;
@property (nonatomic) int added_height;

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
@property int currentPage;

@end

@implementation NewWordDetailViewController

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
    
    self.viewControlArray = [[NSMutableArray alloc] init];

    for (unsigned i = 0; i < 300; i++) {
		[self.viewControlArray addObject:[NSNull null]];
    }
    
    self.pageControlView.pagingEnabled = YES;
    self.pageControlView.contentSize = CGSizeMake(self.pageControlView.frame.size.width * 300,
                                                  self.pageControlView.frame.size.height);
    self.pageControlView.showsHorizontalScrollIndicator = NO;
    self.pageControlView.showsVerticalScrollIndicator = NO;
    self.pageControlView.scrollsToTop = NO;
    self.pageControlView.delegate = self;
    self.pageControlView.directionalLockEnabled = YES;
    self.pageControlView.bounces = NO;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    //显示单词内容和单词名称
    self.WordParaphraseView = [self.viewControlArray objectAtIndex:0];
    self.wordLabel.text = [[WordHelper instance] wordWithID:0].data[@"word"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWord:(int)aWordID
{
    // Do any additional setup after loading the view from its nib.
    WordLayoutViewController *vc = [[WordLayoutViewController alloc] init];
    /*
     key: shouldShowWord                default:[NSNumber numberWithBool:YES]
     key: shouldShowPhonetic            default:[NSNumber numberWithBool:YES]
     key: shouldShowMeaning             default:[NSNumber numberWithBool:YES]
     key: shouldShowSampleSentence      default:[NSNumber numberWithBool:YES]
     key: shouldShowSynonyms            default:[NSNumber numberWithBool:YES]
     key: shouldShowAntonyms            default:[NSNumber numberWithBool:YES]
     this maybe nil to apply all default options
     */
    
    self.added_height = 0;
    
    NSDictionary *option = @{@"shouldShowChineseMeaning":@YES,
                             @"shouldShowEnglishMeaning":@YES,
                             @"shouldShowSynonyms":@YES,
                             @"shouldShowSampleSentence":@YES};
    
    
    [vc displayWord:[[WordHelper instance] wordWithID:aWordID] withOption:option];
    
    //self.wordLabel.text = [[WordHelper instance] wordWithID:aWordID].data[@"word"];
    
    self.WordParaphraseView.delegate = self;
    self.WordParaphraseView.contentSize = vc.view.frame.size;
    
    NSArray* subviews = [self.WordParaphraseView subviews];
    for(UIView* v in subviews)
    {
        [v removeFromSuperview];
    }
    
    [self.WordParaphraseView addSubview:vc.view];
}

- (void)AddShadows
{
    int i = self.WordParaphraseView.contentOffset.y;
    if (i <= 10) {
        [self.UpImage setAlpha:i * 0.1];
    } else {
        [self.UpImage setAlpha:1];
    }
    if (i == 1)
    {
        [self.UpImage setAlpha:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断是哪个scrollview
    

    
    if (scrollView == self.pageControlView) {
        //禁制scrollview向右滑动
        CGPoint translation;  
        for (id gesture in scrollView.gestureRecognizers){
            if ([[NSString stringWithFormat:@"%@",[gesture class]] isEqualToString:@"UIScrollViewPanGestureRecognizer"]){
                
                translation = [gesture translationInView:scrollView];
                break;
            }
        }
        if(translation.x > 0)
        {
            //[panGesture requireGestureRecognizerToFail:panGesture];
            [scrollView setContentOffset:CGPointMake(self.pageControlView.frame.size.width*self.currentPage, scrollView.contentOffset.y) animated:NO];
            return;
        }
        
        
        //找到下一个应该显示的page
        CGFloat pageWidth = self.pageControlView.frame.size.width;
        int page = floor((self.pageControlView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.currentPage = page;
        // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
        
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page + 1];
        
        
        //显示单词内容
        self.WordParaphraseView = [self.viewControlArray objectAtIndex:page];
        
        //显示单词名称
        self.wordLabel.text = [[WordHelper instance] wordWithID:page].data[@"word"];
      
        
    }else if (scrollView == self.WordParaphraseView){
        [self AddShadows];
    }
}





- (IBAction)pronounceButtonPushed:(id)sender {
    [[WordSpeaker instance] readWord:self.wordLabel.text];
}
- (IBAction)BackButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate AnimationBack];
}

- (void)viewDidUnload {
    [self setPageControlView:nil];
    
    [super viewDidUnload];
}

- (void)loadScrollViewWithPage:(int)page
{
    // replace the placeholder if necessary
    self.WordParaphraseView = [self.viewControlArray objectAtIndex:page];
    
    if ((NSNull *)self.WordParaphraseView == [NSNull null])
    {
        self.WordParaphraseView = [[UIScrollView alloc] init];
        self.WordParaphraseView.showsHorizontalScrollIndicator = NO;
        self.WordParaphraseView.showsVerticalScrollIndicator = NO;
        [self loadWord:page];
        [self.viewControlArray replaceObjectAtIndex:page withObject:self.WordParaphraseView];
    }
    
    // add the controller's view to the scroll view
    if (self.WordParaphraseView.superview == nil)
    {
        CGRect frame = self.pageControlView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        self.WordParaphraseView.frame = frame;
        
        if(self.WordParaphraseView.contentSize.height <= self.WordParaphraseView.frame.size.height)
        {
            self.added_height = self.WordParaphraseView.frame.size.height - self.WordParaphraseView.contentSize.height;
            CGSize size = self.WordParaphraseView.contentSize;
            size.height = self.WordParaphraseView.frame.size.height + 1;
            self.WordParaphraseView.contentSize = size;
            
        }
        
        [self.pageControlView addSubview:self.WordParaphraseView];
    }
}



- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    for (int i=0; i<self.currentPage; i++) {
//        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
//            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
//        }
//    }
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    for (int i=0; i<self.currentPage; i++) {
//        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
//            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
//        }
//    }
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    for (int i=0; i<self.currentPage; i++) {
//        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
//            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
//        }
//    }
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    for (int i=0; i<self.currentPage; i++) {
//        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
//            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
//        }
//    }
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
}

@end
