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

- (void)displayWord:(WordEntity*)word
{
    WordEntity *wordEntity = word;
    NSDictionary *wordDictionary = wordEntity.data;
    NSString *theWord = [wordDictionary objectForKey:@"word"];
    if (theWord == nil) {
        //NSLog(@"找不到这个单词的名称");
    }else{
        //do nothing...
    }
    
    NSString *thePhonetic = [wordDictionary objectForKey:@"phonetic"];
    if (thePhonetic == nil) {
        //NSLog(@"找不到这个单词的音标");
    }else{
        //do nothing...
    }
    
    NSArray *theDetail = [wordDictionary objectForKey:@"detail"];
    if (theDetail == nil) {
        //NSLog(@"找不到这个单词的内容");
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
        //NSLog(@"找不到这个单词的释义");
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
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(85, h, 185, 25)];
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
            rectImage.frame = CGRectMake(10, h, 255, _sumHeight-h);
            [self.view addSubview:rectImage];
            [self.view sendSubviewToBack:rectImage];
            
            ////////////////////
            
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, _sumHeight, 255, 25)];
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            textView.text = [theUsage substringFromIndex:range.location+1];
            //label.lineBreakMode = NSLineBreakByWordWrapping;
            //label.numberOfLines = 0;
            [textView setEditable:NO];
            [textView sizeToFit];
            [textView setFrame:CGRectMake(10, _sumHeight, 255, textView.contentSize.height)];
            [self.view addSubview:textView];
            _sumHeight = textView.frame.origin.y + textView.frame.size.height;
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
            rectImage.frame = CGRectMake(10, h, 255, _sumHeight-h);
            [self.view addSubview:rectImage];
            [self.view sendSubviewToBack:rectImage];
            
            ////////////////////
            
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, _sumHeight, 255, 25)];
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            textView.text = [theUsage substringFromIndex:offset+1];
            //label.lineBreakMode = NSLineBreakByWordWrapping;
            //label.numberOfLines = 0;
            [textView sizeToFit];
            [textView setEditable:NO];
            [textView setFrame:CGRectMake(10, _sumHeight, 255, textView.contentSize.height)];
            [self.view addSubview:textView];
            _sumHeight = textView.frame.origin.y + textView.frame.size.height + 8.0;
            ///////////////////
            
        }
    }
}

@end