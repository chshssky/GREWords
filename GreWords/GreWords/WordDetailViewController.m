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
    [vc displayWord:[[WordHelper instance] wordWithID:0] withOption:nil];    
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
    
    for (int i = 0; i < 20; i ++) {
        if ( i < 10) {
            [self.RightUpImage setBounds:CGRectMake(187, 456 - i * 4, 76, 38 - i * 4)];
        } else {
            [self.RightDownImage setBounds:CGRectMake(188, 492, 76, (i - 10) * 4)];
        }
        
    }

}

-(UIImageView *) makeRotation:(UIImageView *)image speedX:(float)X speedY:(float)Y
{
    if (Y < 0) {
        image.transform = CGAffineTransformMakeRotation(atan(X/(-Y)));
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
    [super viewDidUnload];
}

- (IBAction)rightButtonPushed:(id)sender {
    
}

- (IBAction)wrongButtonPushed:(id)sender {
    
}

- (IBAction)pronounceButtonPushed:(id)sender {
    
}


@end
