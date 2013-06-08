//
//  TestPageViewController.m
//  GreWords
//
//  Created by xsource on 13-6-4.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "TestPageViewController.h"
#import "TestPageCardViewController.h"


@interface TestPageViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *pageCardScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *pageText;
@property (strong, nonatomic) TestPageCardViewController *upCard;
@property (nonatomic, retain) NSMutableArray *upCardArray;
@property (nonatomic) int currentPage;

@end

@implementation TestPageViewController

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
    self.upCardArray = [[NSMutableArray alloc] init];
    self.currentPage = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPageCardScrollView:nil];
    [self setPageText:nil];
    [self setBackgroundImageView:nil];
    [super viewDidUnload];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTextInPageText];
    
    //调整图片大小
    if (!iPhone5) {
        [_backgroundImageView setImage:[UIImage imageNamed:@"history exam_cardBottom_mini.png"]];
        _backgroundImageView.center = CGPointMake(_backgroundImageView.center.x, _backgroundImageView.center.y - 3);
        [_backgroundImageView sizeToFit];
        
        _pageCardScrollView.center = CGPointMake(_pageCardScrollView.center.x, _pageCardScrollView.center.y - 15);
        [_pageCardScrollView setFrame:CGRectMake(_pageCardScrollView.frame.origin.x, _pageCardScrollView.frame.origin.y, _pageCardScrollView.frame.size.width, _pageCardScrollView.frame.size.height - 45)];
        
        _pageText.center = CGPointMake(_pageText.center.x, _pageText.center.y - 75);
        
    }
    if(self.data == nil || self.data.count == 0)
    {
        [self addNoExamCard];
    }
    
    //设置横向滑动的scroll view
    for (unsigned i = 0; i < self.data.count; i++) {
		[_upCardArray addObject:[NSNull null]];
    }
    _pageCardScrollView.contentSize = CGSizeMake(_pageCardScrollView.frame.size.width * self.data.count,
                                                      _pageCardScrollView.frame.size.height);
    _pageCardScrollView.pagingEnabled = YES;
    _pageCardScrollView.showsHorizontalScrollIndicator = NO;
    _pageCardScrollView.showsVerticalScrollIndicator = NO;
    _pageCardScrollView.scrollsToTop = NO;
    _pageCardScrollView.delegate = self;
    _pageCardScrollView.directionalLockEnabled = NO;
    
    if(self.data.count == 0)
        return;
    if(self.data.count == 1)
    {
        [self loadViewWithPage:0];
    }
    else if(self.data.count >= 2)
    {
        [self loadViewWithPage:0];
        [self loadViewWithPage:1];
    }
}

- (void)loadUpCardContentWithPage:(int)index
{
    NSLog(@"loadUpCardContent");
    
    ExamEvent *aEvent = self.data[index];
    _upCard.event = aEvent;
    
}

- (void)loadViewWithPage:(int)page
{
    _upCard = [_upCardArray objectAtIndex:page];
    
    if ((NSNull *)_upCard == [NSNull null])
    {
        _upCard = [[TestPageCardViewController alloc] init];
        [self loadUpCardContentWithPage:page];
        [_upCardArray replaceObjectAtIndex:page withObject:_upCard];
    }
    
    if (_upCard.view.superview == nil)
    {
        CGRect frame = _pageCardScrollView.frame;
        frame.origin.y = 0;
        frame.size.width = 275.0f;
        frame.size.height = 305.0f;
        frame.origin.x = frame.size.width * page;
        _upCard.view.frame = frame;
        [self addChildViewController:_upCard];
        [_pageCardScrollView addSubview:_upCard.view];
    }
}


- (void)addNoExamCard
{
    NSString *filename = iPhone5 ? @"history exam_upCardBottom_noTest.png" :  @"history exam_upCardBottom_noTest_mini.png";
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:filename]];
    
    [_pageCardScrollView addSubview:view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _pageCardScrollView.frame.size.width;
    int page = floor((_pageCardScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
    //换页
    if (_currentPage != page) {
        _currentPage = page;
        [self setTextInPageText];
    }
    
    if (_currentPage < self.data.count - 1) {
        [self loadViewWithPage:page+1];
    }
}

- (void)setTextInPageText
{
    if(self.data.count == 0)
    {
        _pageText.text = @"";
        return;
    }
    NSString *currentString = [NSString stringWithFormat:@"%d",_currentPage+1];
    NSString *sumString = [NSString stringWithFormat:@"%d",self.data.count];
    _pageText.text = [NSString stringWithFormat:@"%@%@%@%@%@",@"这是第",currentString,@"次测试, 一共有",sumString,@"次测试"];
    _pageText.textAlignment = NSTextAlignmentCenter;
    _pageText.textColor = [UIColor colorWithRed:135/255.0 green:168/255.0 blue:57.0/255.0 alpha:1];
    _pageText.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
}


@end
