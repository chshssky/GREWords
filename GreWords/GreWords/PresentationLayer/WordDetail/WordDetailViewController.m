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
#import "WordSpeaker.h"
#import "WordTaskGenerator.h"
#import "DashboardViewController.h"
#import "NewWordEvent.h"
#import "ReviewEvent.h"
#import "ExamEvent.h"
#import "HistoryManager.h"
#import "ConfigurationHelper.h"
#import "GuideImageFactory.h"

#define PI M_PI

@interface WordDetailViewController () <UIScrollViewDelegate>
{
    UIImageView *guideImageView;
}
@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UIImageView *DownImage;
@property (weak, nonatomic) IBOutlet UIButton *PronounceButton;

@property (weak, nonatomic) IBOutlet UIButton *RightButton;
@property (weak, nonatomic) IBOutlet UIButton *WrongButton;

@property (strong, nonatomic) UIImageView *RightUpImageView;
@property (strong, nonatomic) UIImageView *RightDownImageView;
@property (strong, nonatomic) UIImageView *RightUpImageView0;
@property (strong, nonatomic) UIImageView *RightDownImageView0;
@property (strong, nonatomic) UIImageView *RightUpImageView1;
@property (strong, nonatomic) UIImageView *RightDownImageView1;
@property (strong, nonatomic) UIImageView *RightUpImageView2;
@property (strong, nonatomic) UIImageView *RightDownImageView2;
@property (strong, nonatomic) UIImageView *RightUpImageView3;
@property (strong, nonatomic) UIImageView *RightDownImageView3;
@property (strong, nonatomic) UIImageView *RightUpImageView4;
@property (strong, nonatomic) UIImageView *RightDownImageView4;

@property (strong, nonatomic) UIImageView *WrongUpImageView;
@property (strong, nonatomic) UIImageView *WrongDownImageView;
@property (strong, nonatomic) UIImageView *WrongUpImageView0;
@property (strong, nonatomic) UIImageView *WrongDownImageView0;
@property (strong, nonatomic) UIImageView *WrongUpImageView1;
@property (strong, nonatomic) UIImageView *WrongDownImageView1;
@property (strong, nonatomic) UIImageView *WrongUpImageView2;
@property (strong, nonatomic) UIImageView *WrongDownImageView2;
@property (strong, nonatomic) UIImageView *WrongUpImageView3;
@property (strong, nonatomic) UIImageView *WrongDownImageView3;
@property (strong, nonatomic) UIImageView *WrongUpImageView4;
@property (strong, nonatomic) UIImageView *WrongDownImageView4;
@property (strong, nonatomic) UIImageView *WrongUpImageView5;
@property (strong, nonatomic) UIImageView *WrongDownImageView5;


@property (weak, nonatomic) IBOutlet UILabel *pronounceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeImage;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) DashboardViewController *dashboardVC;


@property (strong, nonatomic) UIButton *showMeaningButton;
@property (strong, nonatomic) UIImageView *showMeaningImageView;
@property (nonatomic) int added_height;

@property (nonatomic) int day;

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

- (void)loadWord:(int)index
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
    
    int wordID =  [[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:index] intValue];
    
    [vc displayWord:[[WordHelper instance] wordWithID:wordID] withOption:option];
    
    self.wordLabel.text = [[WordHelper instance] wordWithID:wordID].data[@"word"];
    self.pronounceLabel.text = [[WordHelper instance] wordWithID:wordID].data[@"phonetic"];
    self.WordParaphraseView.delegate = self;
    self.WordParaphraseView.contentSize = vc.view.frame.size;
    
    NSArray* subviews = [self.WordParaphraseView subviews];
    for(UIView* v in subviews)
    {
        [v removeFromSuperview];
    }
    
    if(self.WordParaphraseView.contentSize.height <= self.WordParaphraseView.frame.size.height)
    {
        self.added_height = self.WordParaphraseView.frame.size.height - self.WordParaphraseView.contentSize.height;
        CGSize size = self.WordParaphraseView.contentSize;
        size.height = self.WordParaphraseView.frame.size.height + 1;
        self.WordParaphraseView.contentSize = size;
        
    }
    
    [self.WordParaphraseView addSubview:vc.view];
    [self.WordParaphraseView scrollsToTop];
    
    [[WordSpeaker instance] readWord:self.wordLabel.text];
    [self.delegate resetWordIndexto:self.indexOfWordIDToday + 1];

    [self DontShowMeaning];
    self.indexOfWordIDToday ++;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadWord:self.indexOfWordIDToday];
    _RightButton.userInteractionEnabled = NO;
    _WrongButton.userInteractionEnabled = NO;
    _showMeaningButton.userInteractionEnabled = YES;

    self.dashboardVC = [DashboardViewController instance];
    _showMeaningButton.userInteractionEnabled = YES;
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
    
    [self.backButton.superview bringSubviewToFront:self.backButton];
    [self.timeImage setImage:[UIImage imageNamed:nil]];
    
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_ReviewFirst])
    {
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_ReviewFirst];
        [self.view addSubview:guideImageView];
    }
}

- (void)ShowMeaning
{
    [self AddShadows];
    [self Show_RightAnimation];
    [self Show_WrongAnimation];
}

- (void)DontShowMeaning
{
    [self AddShowButton];
    [self.UpImage setAlpha:0];
    [self.DownImage setAlpha:1];
}

- (void)AddShadows
{
    int i = self.WordParaphraseView.contentOffset.y;
    int height = self.WordParaphraseView.contentSize.height - self.WordParaphraseView.frame.size.height - self.added_height;
    
    if (0 < i <= 10) {
        [self.UpImage setAlpha:i * 0.1];
    } else {
        [self.UpImage setAlpha:1];
    }
    if (i == 1) {
        [self.UpImage setAlpha:0];
    }
    
    if (i >= height - 10) {
        [self.DownImage setAlpha:(height - i) * 0.1];
    } else {
        [self.DownImage setAlpha:1];
    }
    if (i == 9) {
        [self.UpImage setAlpha:1];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self AddShadows];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWordParaphraseView:nil];
    [self setUpImage:nil];
    [self setDownImage:nil];
    [self setPronounceButton:nil];
    [self setRightButton:nil];
    [self setWrongButton:nil];
    [self setWordLabel:nil];
    [self setWordPronounceLabel:nil];
    [self setPronounceLabel:nil];
    [self setTimeImage:nil];
    [super viewDidUnload];
}


#pragma mark - show rightButton Methods
- (void)Show_RightAnimation
{
    [self Show_InitRightImage];
    _RightButton.userInteractionEnabled = NO;
    _WrongButton.userInteractionEnabled = NO;
    _showMeaningButton.userInteractionEnabled = NO;
    
    //[self Show_RightAnimationWith:_RightUpImageView4 and:_RightDownImageView4 atTime:CACurrentMediaTime() withString:@"Show_removeRightImage4"];
    //[self Show_RightAnimationWith:_RightUpImageView3 and:_RightDownImageView3 atTime:CACurrentMediaTime()+0.13f withString:@"Show_removeRightImage3"];
    [self Show_RightAnimationWith:_RightUpImageView2 and:_RightDownImageView2 atTime:CACurrentMediaTime() withString:@"Show_removeRightImage2"];
    [self Show_RightAnimationWith:_RightUpImageView1 and:_RightDownImageView1 atTime:CACurrentMediaTime()+0.13f withString:@"Show_removeRightImage1"];
    [self Show_RightAnimationWith:_RightUpImageView0 and:_RightDownImageView0 atTime:CACurrentMediaTime()+0.13f*2 withString:@"Show_removeRightImage0"];

}

- (void)Show_InitRightImage
{
    if (_RightUpImageView0 == nil) {
        _RightUpImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page.png"]];
        [_RightUpImageView0 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView0.frame.size.width, _RightUpImageView0.frame.size.height-1)];
        _RightUpImageView0.alpha = 0;
        _RightUpImageView0.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView0];
    }
    if (_RightDownImageView4 == nil)
    {
        _RightDownImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_down_page.png"]];
        [_RightDownImageView4 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView4.frame.size.width, _RightDownImageView4.frame.size.height-3)];
        _RightDownImageView4.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView4];
    }
    if (_RightUpImageView1 == nil) {
        _RightUpImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page.png"]];
        [_RightUpImageView1 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView1.frame.size.width, _RightUpImageView1.frame.size.height-1)];
        _RightUpImageView1.alpha = 0;
        _RightUpImageView1.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView1];
    }
    if (_RightDownImageView3 == nil)
    {
        _RightDownImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_down_page.png"]];
        [_RightDownImageView3 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView3.frame.size.width, _RightDownImageView3.frame.size.height-3)];
        _RightDownImageView3.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView3];
    }
    if (_RightUpImageView2 == nil) {
        _RightUpImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page.png"]];
        [_RightUpImageView2 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView2.frame.size.width, _RightUpImageView2.frame.size.height-1)];
        _RightUpImageView2.alpha = 0;
        _RightUpImageView2.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView2];
    }
    if (_RightDownImageView2 == nil)
    {
        _RightDownImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_down_page.png"]];
        [_RightDownImageView2 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView2.frame.size.width, _RightDownImageView2.frame.size.height-3)];
        _RightDownImageView2.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView2];
    }
    if (_RightUpImageView3 == nil) {
        _RightUpImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page.png"]];
        [_RightUpImageView3 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView3.frame.size.width, _RightUpImageView3.frame.size.height-1)];
        _RightUpImageView3.alpha = 0;
        _RightUpImageView3.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView3];
    }
    if (_RightDownImageView1 == nil)
    {
        _RightDownImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_down_page.png"]];
        [_RightDownImageView1 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView1.frame.size.width, _RightDownImageView1.frame.size.height-3)];
        _RightDownImageView1.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView1];
    }
    if (_RightUpImageView4 == nil) {
        _RightUpImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page.png"]];
        [_RightUpImageView4 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView4.frame.size.width, _RightUpImageView4.frame.size.height-1)];
        _RightUpImageView4.alpha = 0;
        _RightUpImageView4.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView4];
    }
    if (_RightDownImageView0 == nil)
    {
        _RightDownImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_rightButton_page.png"]];
        [_RightDownImageView0 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView0.frame.size.width, _RightDownImageView0.frame.size.height-3)];
        _RightDownImageView0.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView0];
    }
}

- (void)Show_RightAnimationWith:(UIImageView *)up and:(UIImageView *)down atTime:(CFTimeInterval) time withString:(NSString *)value
{
    CABasicAnimation *scaleAnimation;
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
    animationGroup.removedOnCompletion = NO;
    animationGroup.duration = 0.3f;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.beginTime = time;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [up.layer addAnimation:animationGroup forKey:nil];
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.duration =0.2f;
    scaleAnimation.delegate = self;
    scaleAnimation.fillMode = kCAFillModeBoth;
    scaleAnimation.beginTime = time + 0.3f;
    [scaleAnimation setValue:value forKey:@"id"];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [down.layer addAnimation:scaleAnimation forKey:nil];
    
}

#pragma mark - show wrongButton Methods
- (void)Show_WrongAnimation
{
    [self Show_InitWrongImage];
    _RightButton.userInteractionEnabled = NO;
    _WrongButton.userInteractionEnabled = NO;
    _showMeaningButton.userInteractionEnabled = NO;
    
    //[self Show_WrongAnimationWith:_WrongUpImageView4 and:_WrongDownImageView4 atTime:CACurrentMediaTime() withString:@"Show_removeWrongImage4"];
    //[self Show_WrongAnimationWith:_WrongUpImageView3 and:_WrongDownImageView3 atTime:CACurrentMediaTime()+0.13f withString:@"Show_removeWrongImage3"];
    [self Show_WrongAnimationWith:_WrongUpImageView2 and:_WrongDownImageView2 atTime:CACurrentMediaTime()+0.13f withString:@"Show_removeWrongImage2"];
    [self Show_WrongAnimationWith:_WrongUpImageView1 and:_WrongDownImageView1 atTime:CACurrentMediaTime()+0.13f*2 withString:@"Show_removeWrongImage1"];
    [self Show_WrongAnimationWith:_WrongUpImageView0 and:_WrongDownImageView0 atTime:CACurrentMediaTime()+0.13f*3 withString:@"Show_removeWrongImage0"];
    
}

- (void)Show_InitWrongImage
{
    if (_WrongUpImageView0 == nil) {
        _WrongUpImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page.png"]];
        [_WrongUpImageView0 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView0.frame.size.width, _WrongUpImageView0.frame.size.height-1)];
        _WrongUpImageView0.alpha = 0;
        _WrongUpImageView0.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView0];
    }
    if (_WrongDownImageView4 == nil)
    {
        _WrongDownImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_down_page.png"]];
        [_WrongDownImageView4 setFrame:CGRectMake(27, self.view.frame.size.height-77, _WrongDownImageView4.frame.size.width, _WrongDownImageView4.frame.size.height-3)];
        _WrongDownImageView4.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView4];
    }
    if (_WrongUpImageView1 == nil) {
        _WrongUpImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page.png"]];
        [_WrongUpImageView1 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView1.frame.size.width, _WrongUpImageView1.frame.size.height-1)];
        _WrongUpImageView1.alpha = 0;
        _WrongUpImageView1.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView1];
    }
    if (_WrongDownImageView3 == nil)
    {
        _WrongDownImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_down_page.png"]];
        [_WrongDownImageView3 setFrame:CGRectMake(27, self.view.frame.size.height-77, _WrongDownImageView3.frame.size.width, _WrongDownImageView3.frame.size.height-3)];
        _WrongDownImageView3.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView3];
    }
    if (_WrongUpImageView2 == nil) {
        _WrongUpImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page.png"]];
        [_WrongUpImageView2 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView2.frame.size.width, _WrongUpImageView2.frame.size.height-1)];
        _WrongUpImageView2.alpha = 0;
        _WrongUpImageView2.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView2];
    }
    if (_WrongDownImageView2 == nil)
    {
        _WrongDownImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_down_page.png"]];
        [_WrongDownImageView2 setFrame:CGRectMake(27, self.view.frame.size.height-77, _WrongDownImageView2.frame.size.width, _WrongDownImageView2.frame.size.height-3)];
        _WrongDownImageView2.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView2];
    }
    if (_WrongUpImageView3 == nil) {
        _WrongUpImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page.png"]];
        [_WrongUpImageView3 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView3.frame.size.width, _WrongUpImageView3.frame.size.height-1)];
        _WrongUpImageView3.alpha = 0;
        _WrongUpImageView3.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView3];
    }
    if (_WrongDownImageView1 == nil)
    {
        _WrongDownImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_down_page.png"]];
        [_WrongDownImageView1 setFrame:CGRectMake(27, self.view.frame.size.height-77, _WrongDownImageView1.frame.size.width, _WrongDownImageView1.frame.size.height-3)];
        _WrongDownImageView1.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView1];
    }
    if (_WrongUpImageView4 == nil) {
        _WrongUpImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page.png"]];
        [_WrongUpImageView4 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView4.frame.size.width, _WrongUpImageView4.frame.size.height-1)];
        _WrongUpImageView4.alpha = 0;
        _WrongUpImageView4.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView4];
    }
    if (_WrongDownImageView0 == nil)
    {
        _WrongDownImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrongButton_page.png"]];
        [_WrongDownImageView0 setFrame:CGRectMake(27, self.view.frame.size.height-77, _WrongDownImageView0.frame.size.width, _WrongDownImageView0.frame.size.height-3)];
        _WrongDownImageView0.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView0];
    }
}

- (void)Show_WrongAnimationWith:(UIImageView *)up and:(UIImageView *)down atTime:(CFTimeInterval) time withString:(NSString *)value
{
    CABasicAnimation *scaleAnimation;
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
    animationGroup.removedOnCompletion = NO;
    animationGroup.duration = 0.3f;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.beginTime = time;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [up.layer addAnimation:animationGroup forKey:nil];
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.duration =0.2f;
    scaleAnimation.delegate = self;
    scaleAnimation.fillMode = kCAFillModeBoth;
    scaleAnimation.beginTime = time + 0.3f;
    [scaleAnimation setValue:value forKey:@"id"];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [down.layer addAnimation:scaleAnimation forKey:nil];
    
}

#pragma mark - dismiss rightButton Methods
- (void)Dismiss_InitRightImage
{
    if (_RightUpImageView0 == nil) {
        _RightUpImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page2.png"]];
        [_RightUpImageView0 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView0.frame.size.width, _RightUpImageView0.frame.size.height-1)];
        _RightUpImageView0.alpha = 0;
        _RightUpImageView0.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView0];
    }
    if (_RightDownImageView4 == nil)
    {
        _RightDownImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_rightButton_page.png"]];
        [_RightDownImageView4 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView4.frame.size.width, _RightDownImageView4.frame.size.height-3)];
        _RightDownImageView4.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView4];
    }
    if (_RightUpImageView1 == nil) {
        _RightUpImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page2.png"]];
        [_RightUpImageView1 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView1.frame.size.width, _RightUpImageView1.frame.size.height-1)];
        _RightUpImageView1.alpha = 0;
        _RightUpImageView1.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView1];
    }
    if (_RightDownImageView3 == nil)
    {
        _RightDownImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_rightButton_page.png"]];
        [_RightDownImageView3 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView3.frame.size.width, _RightDownImageView3.frame.size.height-3)];
        _RightDownImageView3.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView3];
    }
    if (_RightUpImageView2 == nil) {
        _RightUpImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page2.png"]];
        [_RightUpImageView2 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView2.frame.size.width, _RightUpImageView2.frame.size.height-1)];
        _RightUpImageView2.alpha = 0;
        _RightUpImageView2.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView2];
    }
    if (_RightDownImageView2 == nil)
    {
        _RightDownImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_rightButton_page.png"]];
        [_RightDownImageView2 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView2.frame.size.width, _RightDownImageView2.frame.size.height-3)];
        _RightDownImageView2.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView2];
    }
    if (_RightUpImageView3 == nil) {
        _RightUpImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page2.png"]];
        [_RightUpImageView3 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView3.frame.size.width, _RightUpImageView3.frame.size.height-1)];
        _RightUpImageView3.alpha = 0;
        _RightUpImageView3.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView3];
    }
    if (_RightDownImageView1 == nil)
    {
        _RightDownImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_rightButton_page.png"]];
        [_RightDownImageView1 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView1.frame.size.width, _RightDownImageView1.frame.size.height-3)];
        _RightDownImageView1.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView1];
    }
    if (_RightUpImageView4 == nil) {
        _RightUpImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up_page2.png"]];
        [_RightUpImageView4 setFrame:CGRectMake(217, self.view.frame.size.height-80, _RightUpImageView4.frame.size.width, _RightUpImageView4.frame.size.height-1)];
        _RightUpImageView4.alpha = 0;
        _RightUpImageView4.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_RightUpImageView4];
    }
    if (_RightDownImageView0 == nil)
    {
        _RightDownImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_down_page.png"]];
        [_RightDownImageView0 setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView0.frame.size.width, _RightDownImageView0.frame.size.height-3)];
        _RightDownImageView0.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_RightDownImageView0];
    }
}

- (void)Dismiss_RightAnimation
{
    [self Dismiss_InitRightImage];
    _RightButton.userInteractionEnabled = NO;
    _WrongButton.userInteractionEnabled = NO;
    _showMeaningButton.userInteractionEnabled = NO;
    
    //[self Dismiss_RightAnimationWith:_RightUpImageView4 and:_RightDownImageView4 atTime:CACurrentMediaTime() withString:@"Dismiss_removeRightImage4"];
    //[self Dismiss_RightAnimationWith:_RightUpImageView3 and:_RightDownImageView3 atTime:CACurrentMediaTime()+0.13f withString:@"Dismiss_removeRightImage3"];
    [self Dismiss_RightAnimationWith:_RightUpImageView2 and:_RightDownImageView2 atTime:CACurrentMediaTime() withString:@"Dismiss_removeRightImage2"];
    [self Dismiss_RightAnimationWith:_RightUpImageView1 and:_RightDownImageView1 atTime:CACurrentMediaTime()+0.13f withString:@"Dismiss_removeRightImage1"];
    [self Dismiss_RightAnimationWith:_RightUpImageView0 and:_RightDownImageView0 atTime:CACurrentMediaTime()+0.13f*2 withString:@"Dismiss_removeRightImage0"];
}

- (void)Dismiss_RightAnimationWith:(UIImageView *)up and:(UIImageView *)down atTime:(CFTimeInterval) time withString:(NSString *)value
{
    CABasicAnimation *scaleAnimation;
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
    animationGroup.removedOnCompletion = NO;
    animationGroup.duration = 0.3f;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.beginTime = time;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [up.layer addAnimation:animationGroup forKey:nil];
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.duration =0.2f;
    scaleAnimation.delegate = self;
    scaleAnimation.fillMode = kCAFillModeBoth;
    scaleAnimation.beginTime = time + 0.3f;
    [scaleAnimation setValue:value forKey:@"id"];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [down.layer addAnimation:scaleAnimation forKey:nil];
    
}


#pragma mark - dismiss wrongButton Methods
- (void)Dismiss_InitWrongImage
{
    if (_WrongUpImageView0 == nil) {
        _WrongUpImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page2.png"]];
        [_WrongUpImageView0 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView0.frame.size.width, _WrongUpImageView0.frame.size.height-1)];
        _WrongUpImageView0.alpha = 0;
        _WrongUpImageView0.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView0];
    }
    if (_WrongDownImageView4 == nil)
    {
        _WrongDownImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrongButton_page.png"]];
        [_WrongDownImageView4 setFrame:CGRectMake(27, self.view.frame.size.height-78, _WrongDownImageView4.frame.size.width, _WrongDownImageView4.frame.size.height-3)];
        _WrongDownImageView4.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView4];
    }
    if (_WrongUpImageView1 == nil) {
        _WrongUpImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page2.png"]];
        [_WrongUpImageView1 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView1.frame.size.width, _WrongUpImageView1.frame.size.height-1)];
        _WrongUpImageView1.alpha = 0;
        _WrongUpImageView1.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView1];
    }
    if (_WrongDownImageView3 == nil)
    {
        _WrongDownImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrongButton_page.png"]];
        [_WrongDownImageView3 setFrame:CGRectMake(27, self.view.frame.size.height-78, _WrongDownImageView3.frame.size.width, _WrongDownImageView3.frame.size.height-3)];
        _WrongDownImageView3.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView3];
    }
    if (_WrongUpImageView2 == nil) {
        _WrongUpImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page2.png"]];
        [_WrongUpImageView2 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView2.frame.size.width, _WrongUpImageView2.frame.size.height-1)];
        _WrongUpImageView2.alpha = 0;
        _WrongUpImageView2.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView2];
    }
    if (_WrongDownImageView2 == nil)
    {
        _WrongDownImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrongButton_page.png"]];
        [_WrongDownImageView2 setFrame:CGRectMake(27, self.view.frame.size.height-78, _WrongDownImageView2.frame.size.width, _WrongDownImageView2.frame.size.height-3)];
        _WrongDownImageView2.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView2];
    }
    if (_WrongUpImageView3 == nil) {
        _WrongUpImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page2.png"]];
        [_WrongUpImageView3 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView3.frame.size.width, _WrongUpImageView3.frame.size.height-1)];
        _WrongUpImageView3.alpha = 0;
        _WrongUpImageView3.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView3];
    }
    if (_WrongDownImageView1 == nil)
    {
        _WrongDownImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrongButton_page.png"]];
        [_WrongDownImageView1 setFrame:CGRectMake(27, self.view.frame.size.height-78, _WrongDownImageView1.frame.size.width, _WrongDownImageView1.frame.size.height-3)];
        _WrongDownImageView1.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView1];
    }
    if (_WrongUpImageView4 == nil) {
        _WrongUpImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up_page2.png"]];
        [_WrongUpImageView4 setFrame:CGRectMake(27, self.view.frame.size.height-80, _WrongUpImageView4.frame.size.width, _WrongUpImageView4.frame.size.height-1)];
        _WrongUpImageView4.alpha = 0;
        _WrongUpImageView4.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:_WrongUpImageView4];
    }
    if (_WrongDownImageView0 == nil)
    {
        _WrongDownImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_down_page.png"]];
        [_WrongDownImageView0 setFrame:CGRectMake(27, self.view.frame.size.height-78, _WrongDownImageView0.frame.size.width, _WrongDownImageView0.frame.size.height-3)];
        _WrongDownImageView0.layer.anchorPoint = CGPointMake(0.5, 0);
        [self.view addSubview:_WrongDownImageView0];
    }
}

- (void)Dismiss_WrongAnimation
{
    [self Dismiss_InitWrongImage];
    _RightButton.userInteractionEnabled = NO;
    _WrongButton.userInteractionEnabled = NO;
    _showMeaningButton.userInteractionEnabled = NO;
    
    //[self Dismiss_WrongAnimationWith:_WrongUpImageView4 and:_WrongDownImageView4 atTime:CACurrentMediaTime() withString:@"removeRightImage4"];
    //[self Dismiss_RightAnimationWith:_WrongUpImageView3 and:_WrongDownImageView3 atTime:CACurrentMediaTime()+0.13f withString:@"removeRightImage3"];
    [self Dismiss_WrongAnimationWith:_WrongUpImageView2 and:_WrongDownImageView2 atTime:CACurrentMediaTime()+0.13f withString:@"Dismiss_removeWrongImage2"];
    [self Dismiss_WrongAnimationWith:_WrongUpImageView1 and:_WrongDownImageView1 atTime:CACurrentMediaTime()+0.13f*2 withString:@"Dismiss_removeWrongImage1"];
    [self Dismiss_WrongAnimationWith:_WrongUpImageView0 and:_WrongDownImageView0 atTime:CACurrentMediaTime()+0.13f*3 withString:@"Dismiss_removeWrongImage0"];
}

- (void)Dismiss_WrongAnimationWith:(UIImageView *)up and:(UIImageView *)down atTime:(CFTimeInterval) time withString:(NSString *)value
{
    CABasicAnimation *scaleAnimation;
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
    animationGroup.removedOnCompletion = NO;
    animationGroup.duration = 0.3f;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.beginTime = time;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [up.layer addAnimation:animationGroup forKey:nil];
    
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1.0)];
    
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.duration =0.2f;
    scaleAnimation.delegate = self;
    scaleAnimation.fillMode = kCAFillModeBoth;
    scaleAnimation.beginTime = time + 0.3f;
    [scaleAnimation setValue:value forKey:@"id"];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [down.layer addAnimation:scaleAnimation forKey:nil];
    
}


#pragma mark - animation START and STOP Methods
-(void)animationDidStart:(CAAnimation *)theAnimation
{
    if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeRightImage0"])
    {
        if (_RightUpImageView == nil) {
            _RightUpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_up.png"]];
            [_RightUpImageView setFrame:CGRectMake(230, self.view.frame.size.height-72, _RightUpImageView.frame.size.width, _RightUpImageView.frame.size.height-1)];
            _RightUpImageView.layer.anchorPoint = CGPointMake(0.5, 1);
            [self.view addSubview:_RightUpImageView];
        }
    }
    if ([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeWrongImage0"])
    {
        if (_WrongUpImageView == nil) {
            _WrongUpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_up.png"]];
            [_WrongUpImageView setFrame:CGRectMake(49, self.view.frame.size.height-76, _WrongUpImageView.frame.size.width, _WrongUpImageView.frame.size.height-1)];
            _WrongUpImageView.layer.anchorPoint = CGPointMake(0.5, 1);
            [self.view addSubview:_WrongUpImageView];
        }
    }
    if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeRightImage2"])
    {
        if (_RightUpImageView != nil) {
            [_RightUpImageView removeFromSuperview];
            _RightUpImageView = nil;
        }
    }
    if ([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeWrongImage2"])
    {
        if (_WrongUpImageView != nil) {
            [_WrongUpImageView removeFromSuperview];
            _WrongUpImageView = nil;
        }
    }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeRightImage4"])
    {
        [_RightDownImageView4 removeFromSuperview];
        _RightDownImageView4 = nil;
        [_RightUpImageView4 removeFromSuperview];
        _RightUpImageView4 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeRightImage3"])
    {
        [_RightDownImageView3 removeFromSuperview];
        _RightDownImageView3 = nil;
        [_RightUpImageView3 removeFromSuperview];
        _RightUpImageView3 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeRightImage2"])
    {
        [_RightDownImageView2 removeFromSuperview];
        _RightDownImageView2 = nil;
        [_RightUpImageView2 removeFromSuperview];
        _RightUpImageView2 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeRightImage1"])
    {
        [_RightDownImageView1 removeFromSuperview];
        _RightDownImageView1 = nil;
        [_RightUpImageView1 removeFromSuperview];
        _RightUpImageView1 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeRightImage0"])
    {
        [_RightDownImageView0 removeFromSuperview];
        _RightDownImageView0 = nil;
        [_RightUpImageView0 removeFromSuperview];
        _RightUpImageView0 = nil;
        
        if (_RightDownImageView == nil) {
            _RightDownImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_right_down.png"]];
            [_RightDownImageView setFrame:CGRectMake(217, self.view.frame.size.height-78, _RightDownImageView.frame.size.width, _RightDownImageView.frame.size.height-1)];
            _RightDownImageView.layer.anchorPoint = CGPointMake(0.5, 0);
            [self.view addSubview:_RightDownImageView];
        }
        
        _RightButton.userInteractionEnabled = YES;
    }
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeWrongImage4"])
    {
        [_WrongDownImageView4 removeFromSuperview];
        _WrongDownImageView4 = nil;
        [_WrongUpImageView4 removeFromSuperview];
        _WrongUpImageView4 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeWrongImage3"])
    {
        [_WrongDownImageView3 removeFromSuperview];
        _WrongDownImageView3 = nil;
        [_WrongUpImageView3 removeFromSuperview];
        _WrongUpImageView3 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeWrongImage2"])
    {
        [_WrongDownImageView2 removeFromSuperview];
        _WrongDownImageView2 = nil;
        [_WrongUpImageView2 removeFromSuperview];
        _WrongUpImageView2 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeWrongImage1"])
    {
        [_WrongDownImageView1 removeFromSuperview];
        _WrongDownImageView1 = nil;
        [_WrongUpImageView1 removeFromSuperview];
        _WrongUpImageView1 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Show_removeWrongImage0"])
    {
        [_WrongDownImageView0 removeFromSuperview];
        _WrongDownImageView0 = nil;
        [_WrongUpImageView0 removeFromSuperview];
        _WrongUpImageView0 = nil;
        
        if (_WrongDownImageView == nil) {
            _WrongDownImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_wrong_down.png"]];
            [_WrongDownImageView setFrame:CGRectMake(27, self.view.frame.size.height-78, _WrongDownImageView.frame.size.width, _WrongDownImageView.frame.size.height-1)];
            _WrongDownImageView.layer.anchorPoint = CGPointMake(0.5, 0);
            [self.view addSubview:_WrongDownImageView];
        }
        _WrongButton.userInteractionEnabled = YES;
        
        
        if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_ReviewSecond])
        {
            guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_ReviewSecond];
            [self.view addSubview:guideImageView];
        }
        
    }
    
    ////////////////////////////////////////////////////////
    
    if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeRightImage4"])
    {
        [_RightDownImageView4 removeFromSuperview];
        _RightDownImageView4 = nil;
        [_RightUpImageView4 removeFromSuperview];
        _RightUpImageView4 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeRightImage3"])
    {
        [_RightDownImageView3 removeFromSuperview];
        _RightDownImageView3 = nil;
        [_RightUpImageView3 removeFromSuperview];
        _RightUpImageView3 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeRightImage2"])
    {
        [_RightDownImageView2 removeFromSuperview];
        _RightDownImageView2 = nil;
        [_RightUpImageView2 removeFromSuperview];
        _RightUpImageView2 = nil;
        
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeRightImage1"])
    {
        [_RightDownImageView1 removeFromSuperview];
        _RightDownImageView1 = nil;
        [_RightUpImageView1 removeFromSuperview];
        _RightUpImageView1 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeRightImage0"])
    {
        [_RightDownImageView0 removeFromSuperview];
        _RightDownImageView0 = nil;
        [_RightUpImageView0 removeFromSuperview];
        _RightUpImageView0 = nil;
        
        if (_RightDownImageView != nil) {
            [_RightDownImageView removeFromSuperview];
            _RightDownImageView = nil;
        }
        
        _showMeaningButton.userInteractionEnabled = YES;
        
    }
    
    /////////////////////////////////////////////////////////////
    
    if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeWrongImage4"])
    {
        [_WrongDownImageView4 removeFromSuperview];
        _WrongDownImageView4 = nil;
        [_WrongUpImageView4 removeFromSuperview];
        _WrongUpImageView4 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeWrongImage3"])
    {
        [_WrongDownImageView3 removeFromSuperview];
        _WrongDownImageView3 = nil;
        [_WrongUpImageView3 removeFromSuperview];
        _WrongUpImageView3 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeWrongImage2"])
    {
        [_WrongDownImageView2 removeFromSuperview];
        _WrongDownImageView2 = nil;
        [_WrongUpImageView2 removeFromSuperview];
        _WrongUpImageView2 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeWrongImage1"])
    {
        [_WrongDownImageView1 removeFromSuperview];
        _WrongDownImageView1 = nil;
        [_WrongUpImageView1 removeFromSuperview];
        _WrongUpImageView1 = nil;
    }else if([[theAnimation valueForKey:@"id"] isEqual:@"Dismiss_removeWrongImage0"])
    {
        [_WrongDownImageView0 removeFromSuperview];
        _WrongDownImageView0 = nil;
        [_WrongUpImageView0 removeFromSuperview];
        _WrongUpImageView0 = nil;
        
        if (_WrongDownImageView != nil) {
            [_WrongDownImageView removeFromSuperview];
            _WrongDownImageView = nil;
        }
        
        _showMeaningButton.userInteractionEnabled = YES;

    }
}



- (void)AddShowButton
{
    self.showMeaningButton = [[UIButton alloc] init];
    self.showMeaningImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_tapCover.png"]];
    self.showMeaningImageView.autoresizesSubviews = NO;
    [self.showMeaningImageView setFrame:CGRectMake( 8, 100, 304.0, 460.0)];
    [self.view insertSubview:self.showMeaningImageView aboveSubview:self.WordParaphraseView];
    
    [self.showMeaningButton addTarget:self action:@selector(showButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    if (iPhone5) {
        [self.showMeaningButton setFrame:CGRectMake( 8, 100, 304.0, 337.0)];
    }else{
        [self.showMeaningButton setFrame:CGRectMake( 8, 100, 304.0, 250.0)];
    }
    self.showMeaningButton.userInteractionEnabled = NO;
    [self.view addSubview:self.showMeaningButton];
}

- (void)showButtonPressed
{
    [self.showMeaningImageView removeFromSuperview];
    [self.showMeaningButton removeFromSuperview];
    self.showMeaningButton = nil;
    [self ShowMeaning];
}

- (IBAction)rightButtonPushed:(id)sender {
    [self viewWillAppear:YES];
    if (self.indexOfWordIDToday == [[[WordTaskGenerator instance] newWordTask_twoList:self.day] count])
    {
        [self newWordCompleted];
        return;
    }

    WordEntity *word = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday] intValue]];
    [word didRightOnDate:[NSDate new]];
    [self nextButtonPushed];
}

- (IBAction)wrongButtonPushed:(id)sender {
    [self viewWillAppear:YES];
    if (self.indexOfWordIDToday == [[[WordTaskGenerator instance] newWordTask_twoList:self.day] count])
    {
        [self newWordCompleted];
        return;
    }

    WordEntity *word = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday] intValue]];
    [word didMakeAMistakeOnDate:[NSDate new]];
    [self nextButtonPushed];
    self.wrongWordCount ++;
}

- (void)newWordCompleted
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"今日完成" message:@"今天错误率： 用时：" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert setAlertViewStyle:UIAlertViewStyleDefault];
    
    [alert show];
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate AnimationBack];

}

- (void)nextButtonPushed
{
    if ([[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday] intValue] > self.maxWordID) {
        if (_DownImage.alpha <= 0) {
            [self.delegate GoToNewWordWithWord:self.indexOfWordIDToday andThe:self.maxWordID withDownImage:NO];
        }else{
            [self.delegate GoToNewWordWithWord:self.indexOfWordIDToday andThe:self.maxWordID withDownImage:YES];
        }
        [self dismissModalViewControllerAnimated:NO];
    } else {
        [self Dismiss_RightAnimation];
        [self Dismiss_WrongAnimation];
        [self loadWord:self.indexOfWordIDToday];
    }
}

- (IBAction)pronounceButtonPushed:(id)sender {
    [[WordSpeaker instance] readWord:self.wordLabel.text];
}

- (IBAction)BackButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate AnimationBack];
    if ((self.indexOfWordIDToday % 10) == 0) {
        [self.delegate setReviewEnable];
    }
    [self.delegate resetWordIndexto:self.indexOfWordIDToday - 1];
}

@end
