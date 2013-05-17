//
//  WordCardLayoutViewController.m
//  GreWords
//
//  Created by xsource on 13-5-17.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordCardLayoutViewController.h"

@interface WordCardLayoutViewController ()
@property (nonatomic) NSString *cardTitle;
@property (nonatomic) NSString *cardSubTitle;
@property (nonatomic) NSString *cardContent;
@property (nonatomic) NSString *cardSubContent;

@end

@implementation WordCardLayoutViewController
@synthesize sumHeight = _sumHeight;

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
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayCard:(NSDictionary *)wordDictionary{
    _sumHeight = 5.0f;
//    NSString *cardTitle = [wordDictionary objectForKey:@"key"];
    
    
    
    
    
    NSArray *cardSubTitleArray = [wordDictionary objectForKey:@"arr"];
    
    if (cardSubTitleArray.count == 1) {
        _cardContent = [[cardSubTitleArray objectAtIndex:0] objectForKey:@"content"];
        
        CGRect labelRect = CGRectMake(12, _sumHeight, 296, 25);
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:labelRect];
        contentLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
        contentLabel.text = _cardContent;
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        contentLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:contentLabel];
        
        _sumHeight = contentLabel.frame.origin.y + contentLabel.frame.size.height+ 5.0f;
        
    }else if (cardSubTitleArray.count != 1) {
        //display subtitle
        for (int i=0; i<cardSubTitleArray.count; i++) {
            _cardSubTitle = [[cardSubTitleArray objectAtIndex:i] objectForKey:@"key"];
            _cardSubContent = [[cardSubTitleArray objectAtIndex:i] objectForKey:@"content"];
            
            UIImageView *rectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_meaning_rect.png"]];
            rectImage.frame = CGRectMake(12, _sumHeight, 296, 25);
            [self.view addSubview:rectImage];
            [self.view sendSubviewToBack:rectImage];
            
            _sumHeight = _sumHeight+2;
            CGRect labelRect1 = CGRectMake(12, _sumHeight, 296, 25);
            UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:labelRect1];
            subTitleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
            subTitleLabel.textColor = [UIColor colorWithRed:209.0/255.0 green:134.0/255.0 blue:39/255.0 alpha:1];
            subTitleLabel.text = _cardSubTitle;
            subTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            subTitleLabel.numberOfLines = 0;
            subTitleLabel.backgroundColor = [UIColor clearColor];
            [subTitleLabel sizeToFit];
            [self.view addSubview:subTitleLabel];
            NSLog(@"%f",_sumHeight);
            
            _sumHeight = subTitleLabel.frame.origin.y + subTitleLabel.frame.size.height + 8.0;
            CGRect labelRect2 = CGRectMake(12, _sumHeight, 296, 25);
            UILabel *subContentLabel = [[UILabel alloc] initWithFrame:labelRect2];
            subContentLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            subContentLabel.text = _cardSubContent;
            subContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
            subContentLabel.numberOfLines = 0;
            subContentLabel.backgroundColor = [UIColor clearColor];
            [subContentLabel sizeToFit];
            [self.view addSubview:subContentLabel];
            
            _sumHeight = subContentLabel.frame.origin.y + subContentLabel.frame.size.height + 10.0;
            NSLog(@"%f",_sumHeight);
            
        }
    
    }
    
}

@end
