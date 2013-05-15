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
@property (strong, nonatomic) UIButton *showMeaningButton;
@property (nonatomic) int added_height;

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
    
    self.wordLabel.text = [[WordHelper instance] wordWithID:aWordID].data[@"word"];
    
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
    
    
    [self DontShowMeaning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadWord:self.wordID];
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
    [self.DownImage setAlpha:0];
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
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self WrongAnimation];
    [self RightAnimation];
}

- (void)RightAnimation
{

    [self.RightUpImage setBounds:CGRectMake(216, self.view.frame.size.height - 92, 76, 38)];
    [self.RightDownImage setBounds:CGRectMake(216, self.view.frame.size.height - 92 + 37, 76, 0.001)];
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.25f animations:^(){
        self.RightUpImage.transform = CGAffineTransformMakeScale(1.0f, 0.001f);
        self.RightUpImage.center = CGPointMake(216 + 38, self.view.frame.size.height - 92 + 37);
    }completion:^(BOOL finished){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView animateWithDuration:0.15f animations:^(){
            self.RightDownImage.transform = CGAffineTransformMakeScale(1.0f, 38000.0f);
            self.RightDownImage.center = CGPointMake(216 + 38, self.view.frame.size.height - 92 + 37 + 18);
        }];
    }];
//    self.RightDownImage.transform = CGAffineTransformIdentity;
//    self.RightUpImage.transform = CGAffineTransformIdentity;

}

- (void)WrongAnimation
{
    [self.WrongUpImage setBounds:CGRectMake(29, self.view.frame.size.height - 92, 76, 38)];
    [self.WrongDownImage setBounds:CGRectMake(29, self.view.frame.size.height - 92 + 37, 76, 0.001)];
    
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.25f animations:^(){
        self.WrongUpImage.transform = CGAffineTransformMakeScale(1.0f, 0.001f);
        self.WrongUpImage.center = CGPointMake(29 + 38, self.view.frame.size.height - 92 + 37);
    }completion:^(BOOL finished){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView animateWithDuration:0.15f animations:^(){
            self.WrongDownImage.transform = CGAffineTransformMakeScale(1.0f, 38000.0f);
            self.WrongDownImage.center = CGPointMake(29 + 38, self.view.frame.size.height - 92 + 37 + 18);
        }];
    }];
    
//    self.WrongDownImage.transform = CGAffineTransformIdentity;
//    self.WrongUpImage.transform = CGAffineTransformIdentity;
}

- (void)AddShowButton
{
    self.showMeaningButton = [[UIButton alloc] init];
    [self.showMeaningButton setImage:[UIImage imageNamed:@"learning_tapCover.png"] forState:UIControlStateNormal];
    //self.showMeaningButton.backgroundColor = [UIColor blackColor];
    [self.showMeaningButton addTarget:self action:@selector(showButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showMeaningButton setCenter:self.WordParaphraseView.center];
    
    [self.showMeaningButton setFrame:self.WordParaphraseView.frame];
    [self.view addSubview:self.showMeaningButton];
}

- (void)showButtonPressed
{
    [self.showMeaningButton removeFromSuperview];
    self.showMeaningButton = nil;
    [self ShowMeaning];
}

- (IBAction)rightButtonPushed:(id)sender {
    self.wordID++;
    [self viewWillAppear:YES];
    [self loadWord:self.wordID];
    
}

- (IBAction)wrongButtonPushed:(id)sender {
    self.wordID++;
    [self viewWillAppear:YES];
    [self loadWord:self.wordID];
}

- (IBAction)pronounceButtonPushed:(id)sender {
    [[WordSpeaker instance] readWord:self.wordLabel.text];
}

- (IBAction)BackButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate AnimationBack];
}

@end
