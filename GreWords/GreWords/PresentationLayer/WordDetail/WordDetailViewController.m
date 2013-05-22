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

#define PI M_PI

@interface WordDetailViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UIImageView *DownImage;
@property (weak, nonatomic) IBOutlet UIButton *PronounceButton;
@property (weak, nonatomic) IBOutlet UIButton *RightButton;
@property (weak, nonatomic) IBOutlet UIButton *WrongButton;
@property (weak, nonatomic) IBOutlet UIImageView *RightUpImage;
@property (weak, nonatomic) IBOutlet UIImageView *RightDownImage;
@property (weak, nonatomic) IBOutlet UIImageView *WrongUpImage;
@property (weak, nonatomic) IBOutlet UIImageView *WrongDownImage;
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
    self.dashboardVC = [DashboardViewController instance];
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
    
    
//    UIImageView *a = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_downCoverWithButton.png"]];
//    CGRect frame = a.frame;
//    frame.size.height = 171.0f;
//    [a setFrame:frame];
//    a.alpha = 0.5;
//    a.center =CGPointMake(320.0/2, self.view.frame.size.height - 171.0/2);
//    [self.view addSubview:a];
    
}

- (void)ShowMeaning
{
    [self AddShadows];
    self.RightButton.enabled = true;
    self.WrongButton.enabled = true;
}

- (void)DontShowMeaning
{
    [self AddShowButton];
    [self.UpImage setAlpha:0];
    [self.DownImage setAlpha:1];
    self.RightButton.enabled = false;
    self.WrongButton.enabled = false;
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
    [self setRightUpImage:nil];
    [self setRightDownImage:nil];
    [self setWrongUpImage:nil];
    [self setWrongDownImage:nil];
    [self setWordLabel:nil];
    [self setWordPronounceLabel:nil];
    [self setPronounceLabel:nil];
    [self setTimeImage:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self WrongAnimation];
    [self RightAnimation];
}

- (void)RightAnimation
{
//    [self.RightUpImage setBounds:CGRectMake(216, self.view.frame.size.height - 92, 76, 38)];
//    [self.RightDownImage setBounds:CGRectMake(216, self.view.frame.size.height - 92 + 37, 76, 0.001)];
//    
//    
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView animateWithDuration:0.25f animations:^(){
//        self.RightUpImage.transform = CGAffineTransformMakeScale(1.0f, 0.001f);
//        self.RightUpImage.center = CGPointMake(216 + 38, self.view.frame.size.height - 92 + 37);
//    }completion:^(BOOL finished){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        [UIView animateWithDuration:0.15f animations:^(){
//            self.RightDownImage.transform = CGAffineTransformMakeScale(1.0f, 38000.0f);
//            self.RightDownImage.center = CGPointMake(216 + 38, self.view.frame.size.height - 92 + 37 + 18);
//        }];
//    }];

}

- (void)WrongAnimation
{
//    [self.WrongUpImage setBounds:CGRectMake(29, self.view.frame.size.height - 92, 76, 38)];
//    [self.WrongDownImage setBounds:CGRectMake(29, self.view.frame.size.height - 92 + 37, 76, 0.001)];
//
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView animateWithDuration:0.25f animations:^(){
//        self.WrongUpImage.transform = CGAffineTransformMakeScale(1.0f, 0.001f);
//        self.WrongUpImage.center = CGPointMake(29 + 38, self.view.frame.size.height - 92 + 37);
//    }completion:^(BOOL finished){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        [UIView animateWithDuration:0.15f animations:^(){
//            self.WrongDownImage.transform = CGAffineTransformMakeScale(1.0f, 38000.0f);
//            self.WrongDownImage.center = CGPointMake(29 + 38, self.view.frame.size.height - 92 + 37 + 18);
//        }];
//    }];
    
}

- (void)AddShowButton
{
    self.showMeaningButton = [[UIButton alloc] init];
    self.showMeaningImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_tapCover.png"]];
    self.showMeaningImageView.autoresizesSubviews = NO;
    [self.showMeaningImageView setFrame:CGRectMake( 8, 100, 304.0, 460.0)];
    [self.view insertSubview:self.showMeaningImageView aboveSubview:self.WordParaphraseView];
    
    [self.showMeaningButton addTarget:self action:@selector(showButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.showMeaningButton setFrame:CGRectMake( 8, 100, 304.0, 337.0)];
    [self.view addSubview:self.showMeaningButton];
    [self.view insertSubview:self.showMeaningButton belowSubview:_DownImage];
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
    NSLog(@"Right~~:!!!!!%d", self.indexOfWordIDToday);
    WordEntity *word = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday] intValue]];
    [word didRightOnDate:[NSDate new]];
    [self nextButtonPushed];

}

- (IBAction)wrongButtonPushed:(id)sender {
    [self viewWillAppear:YES];
    NSLog(@"Wrong:!!!!!%d", self.indexOfWordIDToday);
    WordEntity *word = [[WordHelper instance] wordWithID:[[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday] intValue]];
    [word didMadeAMistakeOnDate:[NSDate new]];
    [self nextButtonPushed];

}

- (void)nextButtonPushed
{
    NSLog(@"The index:%d", self.indexOfWordIDToday);
    NSLog(@"The wordID:%d", [[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday] intValue]);
    NSLog(@"The MaxID:%d", self.maxWordID);
    if ([[[[WordTaskGenerator instance] newWordTask_twoList:self.day] objectAtIndex:self.indexOfWordIDToday] intValue] > self.maxWordID) {
        if (_DownImage.alpha == 1) {
            [self.delegate GoToNewWordWithWord:self.indexOfWordIDToday andThe:self.maxWordID withDownImage:YES];
        }else{
            [self.delegate GoToNewWordWithWord:self.indexOfWordIDToday andThe:self.maxWordID withDownImage:NO];
        }
        [self dismissModalViewControllerAnimated:NO];
    } else {
        [self loadWord:self.indexOfWordIDToday];
    }
}

- (IBAction)pronounceButtonPushed:(id)sender {
    [[WordSpeaker instance] readWord:self.wordLabel.text];
}

- (IBAction)BackButtonPushed:(id)sender {
    self.indexOfWordIDToday --;
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate AnimationBack];
}

@end
