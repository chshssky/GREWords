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
#import "noCopyTextView.h"
#import "DashboardViewController.h"
#import "WordDetailViewController.h"
#import "WordCardLayoutViewController.h"
#import "WordNoteLayoutViewController.h"
#import "WordDetailViewController.h"


@interface NewWordDetailViewController () <UIScrollViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UIImageView *DownImage;
@property (weak, nonatomic) IBOutlet UIButton *PronounceButton;
@property (weak, nonatomic) IBOutlet UIScrollView *pageControlView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordSoundLabel;
@property (weak, nonatomic) IBOutlet UIImageView *soundImage;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic) int added_height;


@property (strong, nonatomic) UIImageView *noteUp;
@property (strong, nonatomic) UIImageView *noteDown;
@property (strong, nonatomic) UIImageView *blackImageView;
@property (strong, nonatomic) UIImageView *blurImageView;
@property (strong, nonatomic) UITextView *noteTextView;
@property (strong, nonatomic) UISwipeGestureRecognizer* noteRecognizer;
@property (nonatomic) int noteHeight;

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

//- (void)loadViewWithPage:(int)index;
//- (void)scrollViewDidScroll:(UIScrollView *)sender;

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
    [self.delegate AnimationBack];
}





#pragma mark - add or remove note Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //NSLog(@"%@",[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]]);
    
    if([[NSString stringWithFormat:@"%@",[otherGestureRecognizer class]] isEqualToString:@"UIPanGestureRecognizer"]) {
        return YES;
    }
    return NO;
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer*)recognizer {
    _backButton.userInteractionEnabled = NO;
    _PronounceButton.userInteractionEnabled = NO;
    _WordParaphraseView.userInteractionEnabled = NO;
    _pageControlView.userInteractionEnabled = NO;
    
    [self addBlurBackground];
    [self addBlackToBackground];
    [self addDownNoteImageAnimation];
    [self addUpNoteImageAnimation];
    [self addNoteTextViewAnimation];
    [self.view removeGestureRecognizer:recognizer];
    
    self.viewDeckController.panningMode = IIViewDeckNoPanning;
    
    _noteRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    _noteRecognizer.delegate = self;
    _noteRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:_noteRecognizer];
    
    
    
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer*)recognizer {
    
    if (_noteTextView != nil) {
        [_noteTextView resignFirstResponder];
    }
    
    _backButton.userInteractionEnabled = YES;
    _PronounceButton.userInteractionEnabled = YES;
    _WordParaphraseView.userInteractionEnabled = YES;
    _pageControlView.userInteractionEnabled = YES;

    
    [self removeBlurBackground];
    [self removeBlackToBackground];
    [self removeDownNoteImageAnimation];
    [self removeUpNoteImageAnimation];
    [self removeNoteTextViewAnimation];
    [self.view removeGestureRecognizer:recognizer];
    
    self.viewDeckController.panningMode = IIViewDeckAllViewsPanning;
    
    _noteRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    _noteRecognizer.delegate = self;
    _noteRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:_noteRecognizer];
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
    CGPathMoveToPoint(path, NULL, _noteDown.center.x, _noteDown.center.y);
    CGPathAddLineToPoint(path, NULL, _noteDown.center.x, -250);
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

- (void)removeUpNoteImageAnimation
{
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"removeUpNoteImageAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _noteUp.center.x, _noteUp.center.y);
    CGPathAddLineToPoint(path, NULL, _noteUp.center.x, -250);

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

- (void)removeNoteTextViewAnimation
{
    [[WordHelper instance] wordWithString:_wordLabel.text].note = _noteTextView.text;
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"removeNoteTextViewAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _noteTextView.center.x, _noteTextView.center.y);
    CGPathAddLineToPoint(path, NULL, _noteTextView.center.x, -250);
    
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteTextView.layer addAnimation:lineAnimation forKey:nil];
    
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeUpNoteImageAnimation"])
    {
        [_noteDown removeFromSuperview];
        _noteDown = nil;
    }
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeUpNoteImageAnimation"])
    {
        [_noteUp removeFromSuperview];
        _noteUp = nil;
    }
    if([[theAnimation valueForKey:@"id"] isEqual:@"removeNoteTextViewAnimation"])
    {
        [_noteTextView removeFromSuperview];
        _noteTextView = nil;
    }
}

- (void)addUpNoteImageAnimation
{
    if (_noteUp == nil) {
        _noteUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_noteUp.png"]];
        [_noteUp setCenter:CGPointMake(55, -200)];
        _noteUp.layer.anchorPoint = CGPointMake(0.08, 0.08);
        [self.view addSubview:_noteUp];
    }
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 55, -200);
    CGPathAddLineToPoint(path, NULL, 55, self.view.frame.size.height/4);
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
    
    _noteUp.center = CGPointMake(55, self.view.frame.size.height/4);
}

- (void)addDownNoteImageAnimation
{
    if (_noteDown == nil) {
        _noteDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_noteDown.png"]];
        [_noteDown setCenter:CGPointMake(25, -200)];
        _noteDown.layer.anchorPoint = CGPointMake(0.08, 0.08);
        [self.view addSubview:_noteDown];
    }
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 25, -200);
    CGPathAddLineToPoint(path, NULL, 25, self.view.frame.size.height/4-25);
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
    
    _noteDown.center = CGPointMake(25, self.view.frame.size.height/4-25);
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
        _blackImageView.alpha = 0.3;
        [self.view addSubview:_blackImageView];
    }
}

- (void)addNoteTextViewAnimation
{
    if (_noteTextView == nil) {
        _noteTextView = [[noCopyTextView alloc] initWithFrame:CGRectMake(57, -170, 258, 220)];
        _noteTextView.delegate = self;
        _noteTextView.layer.anchorPoint = CGPointMake(0.08, 0);
        _noteTextView.editable = YES;
        //载入note
        _noteTextView.text = [[WordHelper instance] wordWithString:_wordLabel.text].note ;
        [_noteTextView setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:22]];
        [_noteTextView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_noteTextView];
    }
    
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 57, -170);
    CGPathAddLineToPoint(path, NULL, 57, self.view.frame.size.height/4-5);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.2f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteTextView.layer addAnimation:lineAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.delegate = self;
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(radians(5) , 0, 0, 1.0)];
    rotateAnimation.duration = 0.15f;
    rotateAnimation.beginTime = CACurrentMediaTime()+0.1f;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_noteTextView.layer addAnimation:rotateAnimation forKey:nil];
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation2.delegate = self;
    rotateAnimation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(radians(0) , 0, 0, 1.0)];
    rotateAnimation2.duration = 0.2f;
    rotateAnimation2.beginTime = CACurrentMediaTime()+0.35f;
    rotateAnimation2.fillMode = kCAFillModeForwards;
    rotateAnimation2.removedOnCompletion = NO;
    rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_noteTextView.layer addAnimation:rotateAnimation2 forKey:nil];
    
    _noteTextView.center = CGPointMake(57, self.view.frame.size.height/4-5);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    CAKeyframeAnimation *lineAnimation;
    CGMutablePathRef path;
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 57, self.view.frame.size.height/4-5);
    CGPathAddLineToPoint(path, NULL, 57, self.view.frame.size.height/4-85);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [_noteTextView.layer addAnimation:lineAnimation forKey:nil];
    
     _noteTextView.center = CGPointMake(57, self.view.frame.size.height/4-85);
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 55, self.view.frame.size.height/4);
    CGPathAddLineToPoint(path, NULL, 55, self.view.frame.size.height/4-80);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [_noteUp.layer addAnimation:lineAnimation forKey:nil];
    
     _noteUp.center = CGPointMake(55, self.view.frame.size.height/4-80);
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 25, self.view.frame.size.height/4-25);
    CGPathAddLineToPoint(path, NULL, 25, self.view.frame.size.height/4-105);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.delegate = self;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [_noteDown.layer addAnimation:lineAnimation forKey:nil];
    
    _noteDown.center = CGPointMake(25, self.view.frame.size.height/4-105);
    
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (textView.contentSize.height + 10 >=200)
        {
            return NO;
        }
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.contentSize.height >= 200)
    {
        //删除最后一行的第一个字符，以便减少一行。
        int tempLocation = textView.selectedRange.location;
        NSString *noteText1= textView.text;
        NSString *noteText2= textView.text;
        noteText1 = [textView.text substringToIndex:textView.selectedRange.location-1];
        noteText2 = [textView.text substringFromIndex:textView.selectedRange.location];
        NSString *noteText = [noteText1 stringByAppendingString:noteText2];
        textView.text = noteText;
        
        NSRange range;
        range.location = tempLocation-1;
        range.length = 0;
        textView.selectedRange = range;
  
    }
}

//获取当前屏幕图片
-(UIImage *)getImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

double radians(float degrees) {
    return ( degrees * 3.14159265 ) / 180.0;
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
    
    int wordID =  [[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:index] intValue];
    [vc displayWord:[[WordHelper instance] wordWithID:wordID] withOption:option];
    
    if (self.maxWordID < wordID) {
        self.maxWordID = wordID;
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
    self.WordName = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:index] intValue]].data[@"word"];
}

//加载单词音标进入数组
- (void)loadWordPhonetic:(int)index
{
    self.WordPhonetic = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:index] intValue]].data[@"phonetic"];
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
        [self loadWordView:_indexOfWordIDToday];
        [self.viewControlArray replaceObjectAtIndex:page withObject:self.WordParaphraseView];
        
        //把单词名称加入数组
        [self loadWordName:_indexOfWordIDToday];
        [self.nameControlArray replaceObjectAtIndex:page withObject:self.WordName];
        
        //把单词音标加入数组
        [self loadWordPhonetic:_indexOfWordIDToday];
        [self.phoneticControlArray replaceObjectAtIndex:page withObject:self.WordPhonetic];
        
        _indexOfWordIDToday++;
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
            [scrollView setContentOffset:CGPointMake(self.pageControlView.frame.size.width*self.currentPage, scrollView.contentOffset.y) animated:NO];
            return;
        }
        /////////////////////////////////////////////////////////////////////////////////////////////
        
        //添加零件用以更换controller
        if (scrollView.contentOffset.x >= _changePage*320-320)
        {
            if (_downImageView == nil) {
                _downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_downCoverWithButton.png"]];
                _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height + 178.0/2);
                [self.view addSubview:_downImageView];
            }
            if (_tapCoverImageView == nil) {
                _tapCoverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_tapCover.png"]];
                _tapCoverImageView.autoresizesSubviews = NO;
                [_tapCoverImageView setFrame:CGRectMake(self.pageControlView.frame.size.width*_changePage+8, 0, 304.0, 460.0)];
                NSLog(@"%d,%f",((int)self.pageControlView.frame.size.width*_changePage+8)%320,self.pageControlView.frame.origin.y);
                [self.pageControlView addSubview:_tapCoverImageView];
            }
            _downImageView.center =CGPointMake(320.0/2, self.view.frame.size.height + 178.0/2 - 178.0/320 * (scrollView.contentOffset.x - (_changePage*320-320)));
            return;
        }
        
        //找到下一个应该显示的page//////////////////////////////////////////////////////////////////////
        CGFloat pageWidth = self.pageControlView.frame.size.width;
        int page = floor((self.pageControlView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        //换页
        if (_currentPage != page) {
            //把单词加入抽屉
            SmartWordListViewController *left = (SmartWordListViewController *)self.viewDeckController.leftController;
            WordEntity *addWord = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday - 2] intValue]];
            if ([left.array indexOfObject:addWord] == NSNotFound) {
                
                [self.delegate ChangeWordWithIndex:self.indexOfWordIDToday - 1 WithMax:self.maxWordID];
                
                [left addWord:addWord];
            }
            
            if (_currentPage < page) {
                [self.dashboardVC minusData];
            }else{
                [self.dashboardVC plusData];
            }
            
            _currentPage = page;
        }
        
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
    if (scrollView.contentOffset.x >= _changePage*320) {
        scrollView.userInteractionEnabled = NO;
        [self.view removeGestureRecognizer:_noteRecognizer];
        
//        WordDetailViewController *vc = [[WordDetailViewController alloc] init];
//        vc.wordID = 100;
//        [self presentViewController:vc animated:NO completion:nil];
        
        [self dismissModalViewControllerAnimated:NO];
        
        [self.delegate GoToReviewWithWord:self.indexOfWordIDToday - 1 andThe:self.maxWordID];

        
        
//#warning 好有爱的项目组
//        NSLog(@"崔昊看这里~~~~~~~~~~看这里呀看这里~~~~~~~~~~~~在这里更换controller！！！");
//        NSLog(@"好感动，我找了好久");

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


#pragma mark - add wordDetailViewController Methods

- (void)addTapCoverImage:(int)page
{
    _tapCoverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_tapCover.png"]];
    _tapCoverImageView.autoresizesSubviews = NO;
    [_tapCoverImageView setFrame:CGRectMake(self.pageControlView.frame.size.width*page+8, self.view.frame.size.height, 304.0, 460.0)];
    [self.pageControlView addSubview:_tapCoverImageView];
    
}

- (void)addDownImage:(int)page
{
    _downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_downCover.png"]];
    _downImageView.autoresizesSubviews = NO;
    [_downImageView setFrame:CGRectMake(self.pageControlView.frame.size.width*page, self.view.frame.size.height, 320.0, 178.0)];
    [self.pageControlView addSubview:_downImageView];
    
}

- (void)addRightButtonImage:(int)page
{
    _rightButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_rightButton_first.png"]];
    _rightButtonImage.autoresizesSubviews = NO;
    [_rightButtonImage setFrame:CGRectMake(self.pageControlView.frame.size.width*page + 30, self.view.frame.size.height, 93.0, 93.0)];
    [self.pageControlView addSubview:_rightButtonImage];
}

-(void)addWrongButtonImage:(int)page
{
    _wrongButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrongButton_first.png"]];
    _wrongButtonImage.autoresizesSubviews = NO;
    [_wrongButtonImage setFrame:CGRectMake(self.pageControlView.frame.size.width*page + 320 - 30-93, self.view.frame.size.height, 93.0, 93.0)];
    [self.pageControlView addSubview:_wrongButtonImage];
}

- (void)addTapCoverImageAnimation
{
    if (_tapCoverImageView == nil) {
        [self addTapCoverImage:_changePage];
    }
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //[lineAnimation setValue:@"removeDownNoteImageAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _tapCoverImageView.frame.origin.x + _tapCoverImageView.frame.size.width/2, self.view.frame.size.height+ _tapCoverImageView.frame.size.height/2);
    CGPathAddLineToPoint(path, NULL, _tapCoverImageView.frame.origin.x + _tapCoverImageView.frame.size.width/2, self.view.frame.size.height - 355);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_tapCoverImageView.layer addAnimation:lineAnimation forKey:nil];
}

- (void)addDownCoverImageAnimation
{
    if (_downImageView == nil) {
        [self addDownImage:_changePage];
    }
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"addDownCoverImageAnimation" forKey:@"id"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _downImageView.frame.origin.x + _downImageView.frame.size.width/2, self.view.frame.size.height+ _downImageView.frame.size.height/2);
    CGPathAddLineToPoint(path, NULL, _downImageView.frame.origin.x + _downImageView.frame.size.width/2, self.view.frame.size.height - 178.0);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_downImageView.layer addAnimation:lineAnimation forKey:nil];
}

- (void)addDownRightAndWrongButtonImageAnimation
{
    if (_rightButtonImage == nil && _wrongButtonImage == nil) {
        [self addRightButtonImage:_changePage];
        [self addWrongButtonImage:_changePage];
    }
    CAKeyframeAnimation *lineAnimation;
    CGMutablePathRef path;
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [lineAnimation setValue:@"addRightButtonAnimation" forKey:@"id"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _rightButtonImage.frame.origin.x + _rightButtonImage.frame.size.width/2, self.view.frame.size.height+ _rightButtonImage.frame.size.height/2);
    CGPathAddLineToPoint(path, NULL, _rightButtonImage.frame.origin.x + _rightButtonImage.frame.size.width/2, self.view.frame.size.height - 150.0);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_rightButtonImage.layer addAnimation:lineAnimation forKey:nil];
    
    lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //[lineAnimation setValue:@"removeDownNoteImageAnimation" forKey:@"id"];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _wrongButtonImage.frame.origin.x + _wrongButtonImage.frame.size.width/2, self.view.frame.size.height+ _rightButtonImage.frame.size.height/2);
    CGPathAddLineToPoint(path, NULL, _wrongButtonImage.frame.origin.x + _wrongButtonImage.frame.size.width/2, self.view.frame.size.height - 150.0);
    lineAnimation.path = path;
    CGPathRelease(path);
    lineAnimation.duration = 0.3f;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.beginTime = CACurrentMediaTime();
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    lineAnimation.delegate = self;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_wrongButtonImage.layer addAnimation:lineAnimation forKey:nil];
    
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
    
//    [left.view clipsToBounds];
//    if (iPhone5) {
//        [left.view setFrame:CGRectMake(5-5.0/276.0*offset, 5-5/276.0*offset, 300+20.0/276.0*offset, 538.25+10/276.0*offset)];
//    }
//    else
//    {
//        [left.view setFrame:CGRectMake(5-5.0/276.0*offset, 5-5/276.0*offset, 300+20.0/276.0*offset, 454.25+10/276.0*offset)];
//    }
}

@end
