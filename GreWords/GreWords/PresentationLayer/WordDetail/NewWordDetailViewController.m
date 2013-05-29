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

@interface NewWordDetailViewController ()
{
    UIImageView *guideImageView;
}

@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UIImageView *DownImage;
@property (weak, nonatomic) IBOutlet UIButton *PronounceButton;
@property (nonatomic) BOOL whetherWordIsRead;
@property (nonatomic) BOOL whetherSetNo;
@property (weak, nonatomic) IBOutlet UIScrollView *pageControlView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordSoundLabel;
@property (weak, nonatomic) IBOutlet UIImageView *soundImage;
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

@property int currentPage;

@property (strong, nonatomic) DashboardViewController *dashboardVC;

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
    [self.PronounceButton addTarget:self action:@selector(soundButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    [self.PronounceButton addTarget:self action:@selector(soundButtonReleased:) forControlEvents:UIControlEventTouchCancel];
    
    
    [self.backButton.superview bringSubviewToFront:self.backButton];
    
    [[WordSpeaker instance] readWord:self.wordLabel.text];
    _whetherWordIsRead = NO;
    _whetherSetNo = NO;
    
    //[self.delegate ChangeWordWithIndex:self.beginWordID + _currentPage WithMax:self.maxWordID];
    
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
    [self setSoundImage:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
}



#pragma mark - sound and back button Methods

- (IBAction)soundButtonClicked:(id)sender {
    [[WordSpeaker instance] readWord:self.wordLabel.text];
    [self.soundImage setImage:[UIImage imageNamed:@"learning_sound_clicked.png"]];
}

- (IBAction)soundButtonReleased:(id)sender {
    [self.soundImage setImage:[UIImage imageNamed:@"learning_sound.png"]];
}

- (IBAction)BackButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    //[self.delegate ChangeWordWithIndex:self.beginWordID - 2 WithMax:self.maxWordID];
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
    }
    int wordID =  [[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].day] objectAtIndex:self.beginWordID + _currentPage] intValue];
    [_note addNoteAt:self withWordID:wordID];
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
    
    NSDictionary *option = @{@"shouldShowChineseMeaning":@YES,
                             @"shouldShowEnglishMeaning":@YES,
                             @"shouldShowSynonyms":@YES,
                             @"shouldShowAntonyms":@YES,
                             @"shouldShowSampleSentence":@YES};
    
    int wordID =  [[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].day] objectAtIndex:index] intValue];
    [vc displayWord:[[WordHelper instance] wordWithID:wordID] withOption:option];
#warning is the MaxWordID should be changed here???
    if ([TaskStatus instance].maxWordID < wordID) {
        [TaskStatus instance].maxWordID = wordID;
    }
    //self.wordLabel.text = [[WordHelper instance] wordWithID:aWordID].data[@"word"];

    
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



//加载单词名称进入数组
- (void)loadWordName:(int)index
{
    self.WordName = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].day] objectAtIndex:index] intValue]].data[@"word"];
}

//加载单词音标进入数组
- (void)loadWordPhonetic:(int)index
{
    self.WordPhonetic = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].day] objectAtIndex:index] intValue]].data[@"phonetic"];
}

//加载单词
- (void)loadViewWithPage:(int)page
{
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
    if (i == 1)
    {
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
            if (_whetherSetNo) {
                _whetherSetNo = NO;
            } else {
                _whetherWordIsRead = YES;
            }
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
                frame.size.height = 171.0f;
                [_downImageView setFrame:frame];
                _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height + 171.0/2);
                [self.view addSubview:_downImageView];
            }
            
            if (_tapCoverImageView == nil) {
                _tapCoverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_tapCover.png"]];
                _tapCoverImageView.autoresizesSubviews = NO;
                [_tapCoverImageView setFrame:CGRectMake(self.pageControlView.frame.size.width*_changePage+8, 0, 304.0, 460.0)];
                [self.pageControlView addSubview:_tapCoverImageView];
            }
            _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height + 171.0/2 - 171.0/320 * (scrollView.contentOffset.x - (_changePage*320-320)));
            return;
        }
        
        //找到下一个应该显示的page//////////////////////////////////////////////////////////////////////
        CGFloat pageWidth = self.pageControlView.frame.size.width;
        int page = floor((self.pageControlView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        //换页
        if (_currentPage != page) {
            //把单词加入抽屉
            SmartWordListViewController *left = (SmartWordListViewController *)self.viewDeckController.leftController;
            WordEntity *addWord = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].day] objectAtIndex:self.beginWordID + _currentPage ] intValue]];
            if ([left.array indexOfObject:addWord] == NSNotFound) {
                
                
                
                [left addWord:addWord];
            }
            
            if (_currentPage < page) {
                [TaskStatus instance].indexOfWordIDToday = self.beginWordID + _currentPage + 1;
                [self.dashboardVC minusData];
            }else{
                [TaskStatus instance].indexOfWordIDToday = self.beginWordID + _currentPage;
                [self.dashboardVC plusData];
            }
            _currentPage = page;
        }
        
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
    

    
    if (scrollView == self.pageControlView) {
        if (!_whetherWordIsRead) {
            [[WordSpeaker instance] readWord:self.wordLabel.text];
            _whetherSetNo = NO;
        } else {
            _whetherWordIsRead = NO;
            _whetherSetNo = YES;
        }
        
        
        if (scrollView.contentOffset.x >= _changePage*320) {
            scrollView.userInteractionEnabled = NO;
            [self.view removeGestureRecognizer:_noteRecognizer];
            [self dismissModalViewControllerAnimated:NO];
            
            [TaskStatus instance].indexOfWordIDToday = self.beginWordID + _currentPage + 1;
            [self.delegate GoToReviewWithWord];
            
            
            
            //#warning 好有爱的项目组
            //        NSLog(@"崔昊看这里~~~~~~~~~~看这里呀看这里~~~~~~~~~~~~在这里更换controller！！！");
            //        NSLog(@"好感动，我找了好久"); 
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


#pragma mark - remove wordDetailViewController Methods
- (void)removeDownImageAnimation_withDownCover
{
    if (_downImageView == nil) {
        _downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_downCoverWithButton2.png"]];
        CGRect frame = _downImageView.frame;
        frame.size.height = 171.0f;
        [_downImageView setFrame:frame];
        _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height - 171.0/2);
        [self.view addSubview:_downImageView];
    }
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 320.0/2, self.view.frame.size.height - 171.0/2);
    CGPathAddLineToPoint(path, NULL, 320.0/2, self.view.frame.size.height + 171.0/2);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.6f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [lineAnimation setValue:@"removeDownImageAnimation_withDownImage" forKey:@"id"];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [_downImageView.layer addAnimation:lineAnimation forKey:nil];
}

- (void)removeDownImageAnimation_withNoDownCover
{
    if (_downImageView == nil) {
        _downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_downCoverWithButton3.png"]];
        CGRect frame = _downImageView.frame;
        frame.size.height = 171.0f;
        [_downImageView setFrame:frame];
        _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height - 171.0/2);
        [self.view addSubview:_downImageView];
    }
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 320.0/2, self.view.frame.size.height - 171.0/2);
    CGPathAddLineToPoint(path, NULL, 320.0/2, self.view.frame.size.height + 171.0/2);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.6f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [lineAnimation setValue:@"removeDownImageAnimation_withNoDownImage" forKey:@"id"];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [_downImageView.layer addAnimation:lineAnimation forKey:nil];
}




#pragma mark - IIViewDeckControllerDelegate Methods
- (void)viewDeckController:(IIViewDeckController*)viewDeckController didCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    self.view.userInteractionEnabled = YES;
    self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController willOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    self.view.userInteractionEnabled = NO;
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
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

@end
