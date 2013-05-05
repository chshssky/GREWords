//
//  WordSmallLayoutViewController.m
//  GreWords
//
//  Created by xsource on 13-5-4.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordSmallLayoutViewController.h"

@interface WordSmallLayoutViewController ()
- (void)showMeanings:(NSDictionary *)wordMeaningDictionary
 numberOfThisMeaning:(int)i
whetherOnlyOneMeaning:(BOOL)b
         startHeight:(float)h;

@end

@implementation WordSmallLayoutViewController

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
    _sumHeight = 5.0f;
    CGRect rect = CGRectMake(100, 200, 550, 50);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayWord:(WordEntity*)word withOption:(NSDictionary*)options
{
    WordEntity *wordEntity = word;
    NSDictionary *wordDictionary = wordEntity.data;
    NSString *theWord = [wordDictionary objectForKey:@"word"];
    if (theWord == nil) {
        NSLog(@"找不到这个单词的名称");
    }else{
        //do nothing...
    }
    
    NSString *thePhonetic = [wordDictionary objectForKey:@"phonetic"];
    if (thePhonetic == nil) {
        NSLog(@"找不到这个单词的音标");
    }else{
        //do nothing...
    }
    
    NSArray *theDetail = [wordDictionary objectForKey:@"detail"];
    if (theDetail == nil) {
        NSLog(@"找不到这个单词的内容");
    }else{
        for (int i=0; i<theDetail.count; i++) {
            _sumHeight += 5.0;
            [self showMeanings:theDetail[i] numberOfThisMeaning:i whetherOnlyOneMeaning:theDetail.count==0?YES:NO startHeight:_sumHeight];
        }
    }
    self.view.frame = CGRectMake(0, 0, 320, _sumHeight);
    _sumHeight = 5.0;
}

- (void)showMeanings:(NSDictionary *)wordMeaningDictionary
 numberOfThisMeaning:(int)i
whetherOnlyOneMeaning:(BOOL)b
         startHeight:(float)h
{
    NSString *theUsage = [wordMeaningDictionary objectForKey:@"usage"];
    if (theUsage == nil) {
        NSLog(@"找不到这个单词的释义");
    }else{
        //////////////////
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, h, 80, 25)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
        label.textColor = [UIColor colorWithRed:209.0/255.0 green:134.0/255.0 blue:39/255.0 alpha:1];
        if (b == YES) {
            label.text = @"【考法】";
        }else{
            label.text = [NSString stringWithFormat:@"%@%@%@",@"【考法", [NSString stringWithFormat:@"%d",i+1], @"】"];
        }
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        [label sizeToFit];
        [self.view addSubview:label];
        //////////////////
        label = [[UILabel alloc] initWithFrame:CGRectMake(85, h, 215, 25)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
        NSRange range = [theUsage rangeOfString:@"："];
        if(range.location != NSNotFound)
        {
            label.text = [theUsage substringToIndex:range.location];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            _sumHeight = label.frame.origin.y + label.frame.size.height;
            
            UIImageView *rectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_meaning_rect.png"]];
            rectImage.frame = CGRectMake(10, h, 300, _sumHeight-h);
            [self.view addSubview:rectImage];
            [self.view sendSubviewToBack:rectImage];
            ////////////////////
            label = [[UILabel alloc] initWithFrame:CGRectMake(85, _sumHeight, 215, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            label.text = [theUsage substringFromIndex:range.location+1];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            _sumHeight = label.frame.origin.y + label.frame.size.height + 8.0;
            ///////////////////
            
        }
        else
        {
            int offset = 0;
            for(int i=0; i< [theUsage length];i++){
                int a = [theUsage characterAtIndex:i];
                if( a > 0x4e00 && a < 0x9fff)
                    offset = i;
            }
            label.text = [theUsage substringToIndex:offset];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            _sumHeight = label.frame.origin.y + label.frame.size.height;
            
            UIImageView *rectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_meaning_rect.png"]];
            rectImage.frame = CGRectMake(10, h, 300, _sumHeight-h);
            [self.view addSubview:rectImage];
            [self.view sendSubviewToBack:rectImage];
            ////////////////////
            label = [[UILabel alloc] initWithFrame:CGRectMake(85, _sumHeight, 215, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            label.text = [theUsage substringFromIndex:offset+1];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            _sumHeight = label.frame.origin.y + label.frame.size.height + 8.0;
            ///////////////////
            
        }
    }
//    
//    NSString *theExample = [wordMeaningDictionary objectForKey:@"example"];
//    if (theExample == nil) {
//        NSLog(@"找不到这个单词的例句");
//    }else{
//        ////////////////////
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, _sumHeight, 65, 25)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
//        label.text = @"例";
//        label.lineBreakMode = NSLineBreakByWordWrapping;
//        label.numberOfLines = 0;
//        [label sizeToFit];
//        [self.view addSubview:label];
//        ////////////////////
//        label = [[UILabel alloc] initWithFrame:CGRectMake(85, _sumHeight, 215, 25)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
//        label.text = [theExample substringFromIndex:0];
//        label.lineBreakMode = NSLineBreakByWordWrapping;
//        label.numberOfLines = 0;
//        [label sizeToFit];
//        [self.view addSubview:label];
//        _sumHeight = label.frame.origin.y + label.frame.size.height + 8.0;
//        ////////////////////
//    }
//    NSString *theHomoionym = [wordMeaningDictionary objectForKey:@"homoionym"];
//    if (theHomoionym == nil) {
//        NSLog(@"找不到这个单词的同义词");
//    }else{
//        ////////////////////
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, _sumHeight, 65, 25)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
//        label.text = @"近";
//        label.lineBreakMode = NSLineBreakByWordWrapping;
//        label.numberOfLines = 0;
//        [label sizeToFit];
//        [self.view addSubview:label];
//        ////////////////////
//        label = [[UILabel alloc] initWithFrame:CGRectMake(85, _sumHeight, 215, 25)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
//        label.text = [theHomoionym substringFromIndex:0];
//        label.lineBreakMode = NSLineBreakByWordWrapping;
//        label.numberOfLines = 0;
//        [label sizeToFit];
//        [self.view addSubview:label];
//        _sumHeight = label.frame.origin.y + label.frame.size.height + 8.0;
//    }
//    NSString *theAntonym = [wordMeaningDictionary objectForKey:@"antonym"];
//    if (theAntonym == nil) {
//        NSLog(@"找不到这个单词的反义词");
//    }else{
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, _sumHeight, 65, 25)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
//        label.text = @"反";
//        label.lineBreakMode = NSLineBreakByWordWrapping;
//        label.numberOfLines = 0;
//        [label sizeToFit];
//        [self.view addSubview:label];
//        ////////////////////
//        label = [[UILabel alloc] initWithFrame:CGRectMake(85, _sumHeight, 215, 25)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
//        label.text = [theAntonym substringFromIndex:0];
//        label.lineBreakMode = NSLineBreakByWordWrapping;
//        label.numberOfLines = 0;
//        [label sizeToFit];
//        [self.view addSubview:label];
//        _sumHeight = label.frame.origin.y + label.frame.size.height + 5.0;
//    }
}

@end