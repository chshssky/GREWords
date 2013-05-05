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
    //[self.UpImage setFrame:CGRectMake(0, 0, 320, 175.5)];
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

    NSDictionary *option = @{@"shouldShowChineseMeaning":@YES,
                             @"shouldShowEnglishMeaning":@YES,
                             @"shouldShowSynonyms":@YES,
                             @"shouldShowSampleSentence":@YES};
    
    
    [vc displayWord:[[WordHelper instance] wordWithID:0] withOption:option];
    
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
    NSLog(@"height:%f", self.WordParaphraseView.contentSize.height);
    NSLog(@"height2:%f", self.WordParaphraseView.contentSize.height - self.WordParaphraseView.frame.size.height);
    //NSLog(@"height3:%f", self.WordParaphraseView..height);
    
    //self.RightUpImage.transform = CGAffineTransformMakeScale(0.5f, 0.5f);

}

-(UIImageView *) makeScale:(UIImageView *)image speedX:(float)X speedY:(float)Y
{
    if (Y < 0) {
        image.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    }else if(Y > 0){
        image.transform = CGAffineTransformMakeRotation(atanf(X/(-Y))-PI);
    }
    return image;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int i = self.WordParaphraseView.contentOffset.y;
    int height = self.WordParaphraseView.contentSize.height - self.WordParaphraseView.frame.size.height;
    if (i <= 10) {
        [self.UpImage setAlpha:i * 0.1];
    } else {
        [self.UpImage setAlpha:1];
    }
    if (i >= height - 10) {
        [self.DownImage setAlpha:(height - i) * 0.1];
    } else {
        [self.DownImage setAlpha:1];
    }
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
    [super viewDidUnload];
}

- (void)RightAnimation
{
    [self.RightDownImage setBounds:CGRectMake(216, 456, 76, 38)];
    [self.RightDownImage setBounds:CGRectMake(216, 493, 76, 0.001)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.25f animations:^(){
        self.RightUpImage.transform = CGAffineTransformMakeScale(1.0f, 0.001f);
        self.RightUpImage.center = CGPointMake(216 + 38, 493);
    }completion:^(BOOL finished){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView animateWithDuration:0.15f animations:^(){
            self.RightDownImage.transform = CGAffineTransformMakeScale(1.0f, 38000.0f);
            self.RightDownImage.center = CGPointMake(216 + 38, 493 + 18);
        }];
    }];
}

- (void)WrongAnimation
{
    [self.WrongUpImage setBounds:CGRectMake(29, 456, 76, 38)];
    [self.WrongDownImage setBounds:CGRectMake(29, 493, 76, 0.001)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.25f animations:^(){
        self.WrongUpImage.transform = CGAffineTransformMakeScale(1.0f, 0.001f);
        self.WrongUpImage.center = CGPointMake(29 + 38, 493);
    }completion:^(BOOL finished){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView animateWithDuration:0.15f animations:^(){
            self.WrongDownImage.transform = CGAffineTransformMakeScale(1.0f, 38000.0f);
            self.WrongDownImage.center = CGPointMake(29 + 38, 493 + 18);
        }];
    }];
}

- (IBAction)rightButtonPushed:(id)sender {
    [self RightAnimation];
}

- (IBAction)wrongButtonPushed:(id)sender {
    [self WrongAnimation];
}

- (IBAction)pronounceButtonPushed:(id)sender {
    
}


@end
