//
//  NewWordDetailViewController.m
//  GreWords
//
//  Created by xsource on 13-5-8.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "NewWordDetailViewController.h"
#import "NoteViewController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "WordSpeaker.h"
#import "WordTaskGenerator.h"
#import "SmartWordListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+ColorImage.h"
#import "UIImage+StackBlur.h"
#import "noCopyTextView.h"
#import "DashboardViewController.h"
#import "WordDetailViewController.h"
#import "WordCardLayoutViewController.h"
#import "WordNoteLayoutViewController.h"
#import "WordDetailViewController.h"
#import "GuideImageFactory.h"
#import "ConfigurationHelper.h"
#import "TaskStatus.h"
#import "HistoryManager.h"
#import "NewWordEvent.h"

@interface NewWordDetailViewController ()
{
    UIImageView *guideImageView;
    
    NSTimer *clockTimer;
    float currentWordTimeEsclaped;
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *clockAlertImageView;
@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UIImageView *DownImage;
@property (weak, nonatomic) IBOutlet UIButton *PronounceButton;
@property (weak, nonatomic) IBOutlet UIScrollView *pageControlView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordSoundLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic) int added_height;

@property (nonatomic) NoteViewController *note;
@property (strong, nonatomic) UISwipeGestureRecognizer* noteRecognizer;

@property (strong, nonatomic) UIImageView *tapCoverImageView;
@property (strong, nonatomic) UIImageView *downImageView;
@property (strong, nonatomic) UIImageView *rightButtonImage;
@property (strong, nonatomic) UIImageView *wrongButtonImage;

@property (nonatomic, retain) NSMutableArray *viewControlArray;
@property (nonatomic, retain) NSMutableArray *nameControlArray;
@property (nonatomic, retain) NSMutableArray *phoneticControlArray;
@property (strong, nonatomic) UIScrollView *WordParaphraseView;
@property (strong, nonatomic) UIImageView *blackView;
@property (strong, nonatomic) UIImageView *leftImageView;
@property (nonatomic) NSString *WordName;
@property (nonatomic) NSString *WordPhonetic;

@property (nonatomic) BOOL isSideOpen;
@property (nonatomic) BOOL isNextWord;

@property int currentPage;

@property (nonatomic, strong) NSDate *comingTime;

@property (strong, nonatomic) DashboardViewController *dashboardVC;

@end

@implementation NewWordDetailViewController

- (NewWordEvent *)nwEvent
{
    if (_nwEvent == nil) {
        _nwEvent = [[NewWordEvent alloc] init];
    }
    return _nwEvent;
}

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
    self.isSideOpen = NO;
    self.isNextWord = NO;
    self.dashboardVC = [DashboardViewController instance];
    self.viewControlArray = [[NSMutableArray alloc] init];
    self.nameControlArray = [[NSMutableArray alloc] init];
    self.phoneticControlArray = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    //添加左上角的进度圆~
    [self.dashboardVC wordDetailIndicatorGen];
    if (iPhone5) {
        self.dashboardVC.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.2f, 0.2f), CGAffineTransformMakeTranslation(-128, -252));
    } else {
        self.dashboardVC.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.2f, 0.2f), CGAffineTransformMakeTranslation(-128, -212));
        [self.backgroundImage setImage:[UIImage imageNamed:@"learning_backgournd_blank_mini.png"]];
    }
    [self.view addSubview:self.dashboardVC.view];
    
    //设置横向滑动的scroll view
    for (unsigned i = 0; i < (_changePage+1); i++) {
		[self.viewControlArray addObject:[NSNull null]];
        [self.nameControlArray addObject:[NSNull null]];
        [self.phoneticControlArray addObject:[NSNull null]];
    }
    
    self.pageControlView.pagingEnabled = YES;
    if (iPhone5) {
        self.pageControlView.contentSize = CGSizeMake(self.pageControlView.frame.size.width * (_changePage+1),
                                                      self.pageControlView.frame.size.height);
    }else{
        self.pageControlView.contentSize = CGSizeMake(self.pageControlView.frame.size.width * (_changePage+1),
                                                      360);
    }
    self.pageControlView.showsHorizontalScrollIndicator = NO;
    self.pageControlView.showsVerticalScrollIndicator = NO;
    self.pageControlView.scrollsToTop = NO;
    self.pageControlView.delegate = self;
    self.pageControlView.directionalLockEnabled = NO;
    self.pageControlView.bounces = NO;
    
    [self loadViewWithPage:0];
    
    //显示单词内容和单词名称
    self.WordParaphraseView = [self.viewControlArray objectAtIndex:0];
    self.wordLabel.text = [self.nameControlArray objectAtIndex:0];
    self.wordSoundLabel.text = [self.phoneticControlArray objectAtIndex:0];
    self.WordParaphraseView.showsHorizontalScrollIndicator = NO;
    self.WordParaphraseView.showsHorizontalScrollIndicator = NO;
    
    //添加抽屉
    self.viewDeckController.delegate = self;
    self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;
    
    //添加便签手势
    _noteRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    _noteRecognizer.delegate = self;
    _noteRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:_noteRecognizer];
    
    //给发音按钮添加事件
    [self.PronounceButton addTarget:self action:@selector(soundButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    [self.backButton.superview bringSubviewToFront:self.backButton];
    if([ConfigurationHelper instance].autoSpeak)
    {
       [[WordSpeaker instance] readWord:self.wordLabel.text]; 
    }
    //为了初始化maxID
    [TaskStatus instance].nwEvent.maxWordID = [[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:[TaskStatus instance].nwEvent.indexOfWordToday] intValue];
    
//    self.nwEvent.indexOfWordToday = [TaskStatus instance].nwEvent.indexOfWordToday;
//    self.nwEvent.maxWordID = [TaskStatus instance].nwEvent.maxWordID;
//    self.nwEvent.reviewEnable = [TaskStatus instance].nwEvent.reviewEnable;
//    self.nwEvent.stage_now = [TaskStatus instance].nwEvent.stage_now;
    
    
    [[HistoryManager instance] updateEvent:[TaskStatus instance].nwEvent];

    
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_NewWordFirst])
    {
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_NewWordFirst];
        [self.view addSubview:guideImageView];
        self.viewDeckController.panningMode = IIViewDeckNoPanning;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPageControlView:nil];
    [self setWordPhonetic:nil];
    [self setBackButton:nil];
    [self setBackgroundImage:nil];
    [self setClockAlertImageView:nil];
    [super viewDidUnload];
}



#pragma mark - sound and back button Methods

- (IBAction)soundButtonClicked:(id)sender {
    [[WordSpeaker instance] readWord:self.wordLabel.text];
}

- (IBAction)BackButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:NO];
    [self.delegate AnimationBack];
}





#pragma mark - add or remove note Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if([[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]] isEqualToString:@"UIPanGestureRecognizer"]) {
        return YES;
    }
    return NO;
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer*)recognizer
{
    if (_note == nil) {
        _note = [[NoteViewController alloc] init];
        _note.delegate = self;
    }
    [_note addNoteAt:self withWordID:[[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:self.beginWordID + _currentPage] intValue]];
    [_note.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_note.view];
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeDownImageAnimation_withDownImage"])
    {
        [_downImageView removeFromSuperview];
        _downImageView = nil;
    }
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeDownImageAnimation_withNoDownImage"])
    {
        [_downImageView removeFromSuperview];
        _downImageView = nil;
    }
}

#pragma mark - two scrollview and load detail Methods

//加载单词内容进入数组
- (void)loadWordView:(int)index
{
    // Do any additional setup after loading the view from its nib.
    WordLayoutViewController *vc = [[WordLayoutViewController alloc] init];
    //WordNoteLayoutViewController *vc = [[WordNoteLayoutViewController alloc] init];
    //WordCardLayoutViewController *vc = [[WordCardLayoutViewController alloc] init];
    
    
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
    
    NSDictionary *option = @{@"shouldShowChineseMeaning":@([ConfigurationHelper instance].chineseMeaningVisibility),
                             @"shouldShowEnglishMeaning":@([ConfigurationHelper instance].englishMeaningVisibility),
                             @"shouldShowSynonyms":@([ConfigurationHelper instance].homoionymVisibility),
                             @"shouldShowAntonyms":@([ConfigurationHelper instance].homoionymVisibility),
                             @"shouldShowSampleSentence":@([ConfigurationHelper instance].sampleSentenceVisibility)};
    
    int wordID =  [[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:index] intValue];
    [vc displayWord:[[WordHelper instance] wordWithID:wordID] withOption:option];

    
    self.WordParaphraseView.delegate = self;
    self.WordParaphraseView.contentSize = vc.view.frame.size;
    
    NSArray* subviews = [self.WordParaphraseView subviews];
    for(UIView* v in subviews)
    {
        [v removeFromSuperview];
    }
    
    [self.WordParaphraseView addSubview:vc.view];
    
    self.viewDeckController.panningView = self.WordParaphraseView;
    
}

- (void)nextWordAction
{
    [TaskStatus instance].nwEvent.indexOfWordToday = self.beginWordID + _currentPage;
    [TaskStatus instance].nwEvent.maxWordID =   [[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:[TaskStatus instance].nwEvent.indexOfWordToday] intValue];
    //把单词加入抽屉
    SmartWordListViewController *left = (SmartWordListViewController *)self.viewDeckController.leftController;
    
    for (int i = 1; i <=  _currentPage; i ++) {
        WordEntity *addWord = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:self.beginWordID + i - 1] intValue]];
        
        if ([left.array indexOfObject:addWord] == NSNotFound) {
            [left addWord:addWord];
        }
    }
    
    
    if([ConfigurationHelper instance].autoSpeak)
    {
        [[WordSpeaker instance] readWord:self.wordLabel.text];
    }
       
//    self.nwEvent.indexOfWordToday = [TaskStatus instance].nwEvent.indexOfWordToday;
//    self.nwEvent.maxWordID = [TaskStatus instance].nwEvent.maxWordID;
//    self.nwEvent.reviewEnable = [TaskStatus instance].nwEvent.reviewEnable;
//    self.nwEvent.stage_now = [TaskStatus instance].nwEvent.stage_now;
    
    
    [[HistoryManager instance] updateEvent:[TaskStatus instance].nwEvent];
    
    
    NSLog(@"Now Word is Index: %d || MaxWordID %d", [TaskStatus instance].nwEvent.indexOfWordToday, [TaskStatus instance].nwEvent.maxWordID);
    
}

//加载单词名称进入数组
- (void)loadWordName:(int)index
{
    self.WordName = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:index] intValue]].wordText;
}

//加载单词音标进入数组
- (void)loadWordPhonetic:(int)index
{
    self.WordPhonetic = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:index] intValue]].data[@"phonetic"];
}

//加载单词
- (void)loadViewWithPage:(int)page
{
    //int page = [pageNumber intValue];
    // replace the placeholder if necessary
    self.WordParaphraseView = [self.viewControlArray objectAtIndex:page];
    
    if ((NSNull *)self.WordParaphraseView == [NSNull null])
    {
        self.WordParaphraseView = [[UIScrollView alloc] init];
        self.WordParaphraseView.showsHorizontalScrollIndicator = NO;
        self.WordParaphraseView.showsVerticalScrollIndicator = NO;
        
        //把单词内容页面加入数组
        [self loadWordView:_beginWordID + page];
        [self.viewControlArray replaceObjectAtIndex:page withObject:self.WordParaphraseView];
        
        //把单词名称加入数组
        [self loadWordName:_beginWordID + page];
        [self.nameControlArray replaceObjectAtIndex:page withObject:self.WordName];
        
        //把单词音标加入数组
        [self loadWordPhonetic:_beginWordID + page];
        [self.phoneticControlArray replaceObjectAtIndex:page withObject:self.WordPhonetic];
    }
    
    // add the controller's view to the scroll view
    if (self.WordParaphraseView.superview == nil)
    {
        CGRect frame = self.pageControlView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        frame.size.height = frame.size.height-10;
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

//控制上阴影的动态显示
- (void)AddShadows
{
    int i = self.WordParaphraseView.contentOffset.y;
    if (i <= 10) {
        [self.UpImage setAlpha:i * 0.1];
    } else {
        [self.UpImage setAlpha:1];
    }
    if (i == 1) {
        [self.UpImage setAlpha:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断是哪个scrollview
    if (scrollView == self.pageControlView) {
        //禁止scrollview向右滑动///////////////////////////////////////////////////////////////////////
        CGPoint translation;
        for (id gesture in scrollView.gestureRecognizers){
            if ([[NSString stringWithFormat:@"%@",[gesture class]] isEqualToString:@"UIScrollViewPanGestureRecognizer"]){
                translation = [gesture translationInView:scrollView];
                break;
            }
        }
        if(translation.x > 0)
        {

            [scrollView setContentOffset:CGPointMake(self.pageControlView.frame.size.width*self.currentPage, scrollView.contentOffset.y) animated:NO];
            return;
        }
        /////////////////////////////////////////////////////////////////////////////////////////////
        
        //添加零件用以更换controller
        if (scrollView.contentOffset.x >= _changePage*320-320)
        {
            if (_downImageView == nil) {
                _downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_downCoverWithButton.png"]];
                CGRect frame = _downImageView.frame;
                frame.size.height = 168.0f;
                [_downImageView setFrame:frame];
                _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height + 168.0/2);
                [self.view addSubview:_downImageView];
            }
            
            if (_tapCoverImageView == nil) {
                _tapCoverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_tapCover.png"]];
                _tapCoverImageView.autoresizesSubviews = NO;
                [_tapCoverImageView setFrame:CGRectMake(self.pageControlView.frame.size.width*_changePage+8, 0, 304.0, 460.0)];
                [self.pageControlView addSubview:_tapCoverImageView];
            }
            _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height + 168.0/2 - 168.0/320 * (scrollView.contentOffset.x - (_changePage*320-320)));
            return;
        }
        
        //找到下一个应该显示的page//////////////////////////////////////////////////////////////////////
        CGFloat pageWidth = self.pageControlView.frame.size.width;
        int page = floor((self.pageControlView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        //换页
        if (_currentPage != page) {
            
            if (_currentPage < page) {
                self.isNextWord = YES;
                [self.dashboardVC performSelectorOnMainThread:@selector(minusData) withObject:nil waitUntilDone:NO];
                //[self.dashboardVC minusData];
            }else{
                self.isNextWord = NO;
                [self.dashboardVC performSelectorOnMainThread:@selector(plusData) withObject:nil waitUntilDone:NO];
                //[self.dashboardVC plusData];
            }
            _currentPage = page;
        }
        //[self performSelectorOnMainThread:@selector(loadViewWithPage:) withObject:[NSNumber numberWithInt:page+1] waitUntilDone:NO];
        [self loadViewWithPage:page+1];
        ///////////////////////////////////////////////////////////////////////////////
        //显示单词内容和单词名称
        self.WordParaphraseView = [self.viewControlArray objectAtIndex:page];
        self.wordLabel.text = [self.nameControlArray objectAtIndex:page];
        self.wordSoundLabel.text = [self.phoneticControlArray objectAtIndex:page];
        
        
    }else if (scrollView == self.WordParaphraseView){
        [self AddShadows];
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
}

- (void)addGuideSecond
{
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_NewWordSecond])
    {
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_NewWordSecond];
        [self.view addSubview:guideImageView];
        self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
    if (![self.wordLabel.text isEqualToString:@"abandon"]) {
        [self addGuideSecond];
    }

    if (self.isNextWord && !self.isSideOpen) {
        [self nextWordAction];
        self.isNextWord = NO;
        self.isSideOpen = NO;
    }

    
    if (scrollView == self.pageControlView) {
        
        if (scrollView.contentOffset.x >= _changePage*320) {
            scrollView.userInteractionEnabled = NO;
            [self.view removeGestureRecognizer:_noteRecognizer];
            [self dismissModalViewControllerAnimated:NO];
            
            [TaskStatus instance].nwEvent.indexOfWordToday = self.beginWordID + _currentPage + 1;
            
            [[HistoryManager instance] updateEvent:[TaskStatus instance].nwEvent];
            [self.delegate GoToReviewWithWord];
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
        }
    }
}


#pragma mark - IIViewDeckControllerDelegate Methods
- (void)viewDeckController:(IIViewDeckController*)viewDeckController didCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    self.isSideOpen = NO;
    self.view.userInteractionEnabled = YES;
    self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController willOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    self.view.userInteractionEnabled = NO;
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    self.isSideOpen = YES;
    self.viewDeckController.panningMode = IIViewDeckNavigationBarOrOpenCenterPanning;
    
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_NewWordThird])
    {
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_NewWordThird];
        [self.viewDeckController.view addSubview:guideImageView];
    }
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController didChangeOffset:(CGFloat)offset orientation:(IIViewDeckOffsetOrientation)orientation panning:(BOOL)panning
{
    SmartWordListViewController *left = (SmartWordListViewController *)self.viewDeckController.leftController;
    
    if (_blackView == NULL) {
        _blackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, left.view.frame.size.width, left.view.frame.size.height)];
        [_blackView setBackgroundColor:[UIColor blackColor]];
        [left.view addSubview:_blackView];
    }
    
    if (offset<=276.0) {
        left.view.transform = CGAffineTransformMakeScale(0.93f+0.05/276*offset, 0.97f+0.03/276*offset);
    }
    
    _blackView.alpha = 1.0/500.0*(300.0-offset);
    
}

#pragma mark - NoteViewControllerProtocol Methods
- (void)whenNoteAppeared
{
    [self.view removeGestureRecognizer:_noteRecognizer];
    self.viewDeckController.panningMode = IIViewDeckNoPanning;
}
- (void)whenNoteDismissed
{
    _noteRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    _noteRecognizer.delegate = self;
    _noteRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:_noteRecognizer];
    self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;
}

#pragma mark - time alert Methods
- (void)startAlertCounting
{
    [clockTimer invalidate];
    currentWordTimeEsclaped = 0;
    self.clockAlertImageView.hidden = YES;
    clockTimer = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                             target: self
                                           selector: @selector(tick)
                                           userInfo: nil
                                            repeats: YES];
}

- (void)tick
{
    currentWordTimeEsclaped += 0.5;
    if(currentWordTimeEsclaped > 25 && currentWordTimeEsclaped < 30)
    {
        int temp = currentWordTimeEsclaped * 2;
        if(temp % 2)
        {
            self.clockAlertImageView.hidden = NO;
        }
        else
        {
            self.clockAlertImageView.hidden = YES;
        }
    }
    else if(currentWordTimeEsclaped >= 30)
    {
        self.clockAlertImageView.hidden = NO;
        [clockTimer invalidate];
    }
}

#pragma mark - Add Duration

- (void)beginDuration
{
    _comingTime = nil;
    _comingTime = [NSDate new];
    
}

- (void)endDuration
{
    NSDate *now = [NSDate new];
    NSTimeInterval duration = [now timeIntervalSinceDate:_comingTime];
    
    if ([TaskStatus instance].taskType == TASK_TYPE_EXAM) {
        [[HistoryManager instance] updateEventWithDuration:duration];
    } else {
        [[HistoryManager instance] updateEventWithDuration:duration];
    }
}

@end
