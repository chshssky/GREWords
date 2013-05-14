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
#import "WordTaskGenerator.h"
#import "SmartWordListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+ColorImage.h"
#import "UIImage+StackBlur.h"


@interface NewWordDetailViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UIImageView *DownImage;
@property (weak, nonatomic) IBOutlet UIButton *PronounceButton;
@property (weak, nonatomic) IBOutlet UIScrollView *pageControlView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordSoundLabel;
@property (weak, nonatomic) IBOutlet UIImageView *soundImage;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic) int added_height;
@property (nonatomic) BOOL noteIsVisible;


@property (strong, nonatomic) UIImageView *noteUp;
@property (strong, nonatomic) UIImageView *noteDown;
@property (strong, nonatomic) UIImageView *blackImageView;
@property (strong, nonatomic) UIImageView *blurImageView;

@property (nonatomic, retain) NSMutableArray *viewControlArray;
@property (nonatomic, retain) NSMutableArray *nameControlArray;
@property (nonatomic, retain) NSMutableArray *phoneticControlArray;
@property (strong, nonatomic) UIScrollView *WordParaphraseView;
@property (strong, nonatomic) UIImageView *blackView;
@property  NSString *WordName;
@property  NSString *WordPhonetic;

- (void)loadViewWithPage:(int)page;
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
    
    //给发音按钮添加事件
    [self.PronounceButton addTarget:self action:@selector(soundButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.PronounceButton addTarget:self action:@selector(soundButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    [self.PronounceButton addTarget:self action:@selector(soundButtonReleased:) forControlEvents:UIControlEventTouchCancel];
    
    self.day = 0;
    self.noteIsVisible = NO;
    
    int wordCount = [[WordHelper instance] wordCount];
    self.viewControlArray = [[NSMutableArray alloc] init];
    self.nameControlArray = [[NSMutableArray alloc] init];
    self.phoneticControlArray = [[NSMutableArray alloc] init];

    for (unsigned i = 0; i < wordCount; i++) {
		[self.viewControlArray addObject:[NSNull null]];
        [self.nameControlArray addObject:[NSNull null]];
        [self.phoneticControlArray addObject:[NSNull null]];
    }
    
    self.pageControlView.pagingEnabled = YES;
    self.pageControlView.contentSize = CGSizeMake(self.pageControlView.frame.size.width * 300,
                                                  self.pageControlView.frame.size.height);
    self.pageControlView.showsHorizontalScrollIndicator = NO;
    self.pageControlView.showsVerticalScrollIndicator = NO;
    self.pageControlView.scrollsToTop = NO;
    self.pageControlView.delegate = self;
    self.pageControlView.directionalLockEnabled = NO;
    
    [self loadViewWithPage:0];
    [self loadViewWithPage:1];
    
    //显示单词内容和单词名称
    self.WordParaphraseView = [self.viewControlArray objectAtIndex:0];
    self.wordLabel.text = [self.nameControlArray objectAtIndex:0];
    self.wordSoundLabel.text = [self.phoneticControlArray objectAtIndex:0];
    
    
    //添加抽屉
    self.viewDeckController.delegate = self;
    self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;
    
    //添加便签手势
    UISwipeGestureRecognizer* downRecognizer;
    downRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    downRecognizer.delegate = self;
    downRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:downRecognizer];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    if (_noteIsVisible) {
//        if([[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]] isEqualToString:@"UISwipeGestureRecognizer"])
//            return YES;
//    } else {
//        if([[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]] isEqualToString:@"UIScrollViewPanGestureRecognizer"]) {
//            return NO;
//        }else{
//            if([[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]] isEqualToString:@"UIPanGestureRecognizer"])
//                return YES;
//            return NO;
//        }
//    }
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]]);
    
    if([[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]] isEqualToString:@"UIPanGestureRecognizer"]) {
        return YES;
    }
    
    
    
    return NO;
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer*)recognizer {
    _noteIsVisible = YES;
    _backButton.userInteractionEnabled = NO;
    _PronounceButton.userInteractionEnabled = NO;
    _WordParaphraseView.userInteractionEnabled = NO;
    _pageControlView.userInteractionEnabled = NO;
    
    [self addBlurBackground];
    [self addBlackToBackground];
//    [self performSelector:@selector(addDownNoteImageAnimation) withObject:nil afterDelay:0.1];
//    [self performSelector:@selector(addUpNoteImageAnimation) withObject:nil afterDelay:0.1];
    [self addDownNoteImageAnimation];
    [self addUpNoteImageAnimation];
    [self.view removeGestureRecognizer:recognizer];
    
    self.viewDeckController.panningMode = IIViewDeckNoPanning;
    
    UISwipeGestureRecognizer* upRecognizer;
    upRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    upRecognizer.delegate = self;
    upRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:upRecognizer];
    
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer*)recognizer {
     _noteIsVisible = NO;
    _backButton.userInteractionEnabled = YES;
    _PronounceButton.userInteractionEnabled = YES;
    _WordParaphraseView.userInteractionEnabled = YES;
    _pageControlView.userInteractionEnabled = YES;

    
    [self removeBlurBackground];
    [self removeBlackToBackground];
    [self removeDownNoteImageAnimation];
    [self removeUpNoteImageAnimation];
    [self.view removeGestureRecognizer:recognizer];
    
    self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;
    
    UISwipeGestureRecognizer* downRecognizer;
    downRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    downRecognizer.delegate = self;
    downRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:downRecognizer];
}

- (void)removeBlurBackground
{
    [_blurImageView removeFromSuperview];
    _blurImageView = nil;
}

- (void)removeBlackToBackground
{
    [_blackImageView removeFromSuperview];
    _blackImageView = nil;
}

- (void)removeDownNoteImageAnimation
{
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"removeDownNoteImageAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, self.view.frame.size.height/4);
    CGPathAddLineToPoint(path, NULL, 50, -250);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteUp.layer addAnimation:lineAnimation forKey:nil];
}

- (void)removeUpNoteImageAnimation
{
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"removeUpNoteImageAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, self.view.frame.size.height/4);
    CGPathAddLineToPoint(path, NULL, 50, -250);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteDown.layer addAnimation:lineAnimation forKey:nil];
    
    

}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeUpNoteImageAnimation"])
    {
        [_noteDown removeFromSuperview];
        _noteDown = nil;
        //NSLog(@"removeDown");
    }
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeUpNoteImageAnimation"])
    {
        [_noteUp removeFromSuperview];
        _noteUp = nil;
        //NSLog(@"removeUp");
    }
}

- (void)addUpNoteImageAnimation
{
    if (_noteUp == nil) {
        _noteUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_note.png"]];
        [_noteUp setCenter:CGPointMake(50, -250)];
        _noteUp.layer.anchorPoint = CGPointMake(0.08, 0.08);
        [self.view addSubview:_noteUp];
        NSLog(@"新建up");
    }
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, -250);
    CGPathAddLineToPoint(path, NULL, 50, self.view.frame.size.height/4);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteUp.layer addAnimation:lineAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(radians(5) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.15f;
    rotateAnimation.beginTime = CACurrentMediaTime()+0.1f;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteUp.layer addAnimation:rotateAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(radians(0) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.2f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.35f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_noteUp.layer addAnimation:rotateAnimation2 forKey:nil];
}

- (void)addDownNoteImageAnimation
{
    if (_noteDown == nil) {
        _noteDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_note.png"]];
        [_noteDown setCenter:CGPointMake(50, -250)];
        _noteDown.layer.anchorPoint = CGPointMake(0.08, 0.08);
        [self.view addSubview:_noteDown];
        NSLog(@"新建down");
    }
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, -250);
    CGPathAddLineToPoint(path, NULL, 50, self.view.frame.size.height/4);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteDown.layer addAnimation:lineAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(radians(5) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.15f;
    rotateAnimation.beginTime = CACurrentMediaTime()+0.1f;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteDown.layer addAnimation:rotateAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(radians(2.5) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.2f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.35f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_noteDown.layer addAnimation:rotateAnimation2 forKey:nil];
}

- (void)addBlurBackground
{
    if (_blurImageView == nil) {
        UIImage *blurImage = [self getImageFromView:self.view];
        blurImage = [blurImage stackBlur:3];
        
        _blurImageView = [[UIImageView alloc] initWithImage:blurImage];
        [_blurImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        [self.view addSubview:_blurImageView];
    }
}

- (void)addBlackToBackground
{
    if (_blackImageView ==nil) {
        UIImage *blackImage = [UIImage imageWithColor:[UIColor blackColor]];
        _blackImageView = [[UIImageView alloc] initWithImage:blackImage];
        [_blackImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _blackImageView.alpha = 0.2;
        [self.view addSubview:_blackImageView];
    }
    
//    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
//    opacityAnimation.toValue = [NSNumber numberWithFloat:0.2];
//    opacityAnimation.removedOnCompletion = NO;
//    opacityAnimation.fillMode = kCAFillModeForwards;
//    opacityAnimation.duration = 0.3f;
//    [_blackImageView.layer addAnimation:opacityAnimation forKey:nil];
}

-(UIImage *)getImageFromView:(UIView *)theView
{
    //UIGraphicsBeginImageContext(theView.bounds.size);
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

double radians(float degrees) {
    return ( degrees * 3.14159265 ) / 180.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载单词内容进入数组
- (void)loadWordView:(int)numberOfPage
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
                             @"shouldShowAntonyms":@YES,
                             @"shouldShowSampleSentence":@YES};
    
    
    [vc displayWord:[[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:numberOfPage] intValue]] withOption:option];
    
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
- (void)loadWordName:(int)numberOfPage
{
    self.WordName = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:numberOfPage] intValue]].data[@"word"];
}

//加载单词音标进入数组
- (void)loadWordPhonetic:(int)numberOfPage
{
    self.WordPhonetic = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:numberOfPage] intValue]].data[@"phonetic"];
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
//        if (!scrollView.zoomBouncing) {
//            NSLog(@"到底了！！！");
//        }
//        
        
        
        //禁制scrollview向右滑动///////////////////////////////////////////////////////////////////////
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
        
        
        //找到下一个应该显示的page//////////////////////////////////////////////////////////////////////
        CGFloat pageWidth = self.pageControlView.frame.size.width;
        int page = floor((self.pageControlView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.currentPage = page;
        // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
        
        
        [self loadViewWithPage:page];
        [self loadViewWithPage:page + 1];
        /////////////////////////////////////////////////////////////////////////////////////////////
        
        
        //显示单词内容和单词名称
        self.WordParaphraseView = [self.viewControlArray objectAtIndex:page];
        self.wordLabel.text = [self.nameControlArray objectAtIndex:page];
        self.wordSoundLabel.text = [self.phoneticControlArray objectAtIndex:page];
      
        
    }else if (scrollView == self.WordParaphraseView){
        [self AddShadows];
    }
}

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
        [self loadWordView:page];
        [self.viewControlArray replaceObjectAtIndex:page withObject:self.WordParaphraseView];
        
        //把单词名称加入数组
        [self loadWordName:page];
        [self.nameControlArray replaceObjectAtIndex:page withObject:self.WordName];
        
        //把单词音标加入数组
        [self loadWordPhonetic:page];
        [self.phoneticControlArray replaceObjectAtIndex:page withObject:self.WordPhonetic];
        
        
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


- (IBAction)soundButtonClicked:(id)sender {
    
    //SmartWordListViewController *vc = (SmartWordListViewController *)self.viewDeckController.leftController;
    //[vc addWord:[[WordHelper instance] wordWithID:200]];
    
    [[WordSpeaker instance] readWord:self.wordLabel.text];
    [self.soundImage setImage:[UIImage imageNamed:@"learning_sound_clicked.png"]];
}

- (IBAction)soundButtonReleased:(id)sender {
    [self.soundImage setImage:[UIImage imageNamed:@"learning_sound.png"]];
}

- (IBAction)BackButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate AnimationBack];
}

- (void)viewDidUnload {
    [self setPageControlView:nil];
    [self setWordPhonetic:nil];
    [self setSoundImage:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (int i=self.viewControlArray.count-1; i>self.currentPage; i--) {
        if ((NSNull *)[self.viewControlArray objectAtIndex:i] != [NSNull null]) {
            [[self.viewControlArray objectAtIndex:i] setContentOffset:CGPointMake(0, self.UpImage.alpha*10) animated:YES];
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
    
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController didChangeOffset:(CGFloat)offset orientation:(IIViewDeckOffsetOrientation)orientation panning:(BOOL)panning
{
    SmartWordListViewController *left = (SmartWordListViewController *)self.viewDeckController.leftController;
    if (_blackView == NULL) {
        _blackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, left.view.frame.size.width, left.view.frame.size.height)];
        [_blackView setBackgroundColor:[UIColor blackColor]];
        [left.view addSubview:_blackView];
    }
    
    _blackView.alpha = 1.0/500.0*(300.0-offset);
    
    [left.view clipsToBounds];
    [left.view setFrame:CGRectMake(5-5.0/276.0*offset, 5-5/276.0*offset, 300+20.0/276.0*offset, 538.25+10/276.0*offset)];
    
    
    
}

@end
