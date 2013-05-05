//
//  wordLayoutViewController.m
//  GreWords
//
//  Created by Song on 13-4-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordLayoutViewController.h"

@interface WordLayoutViewController ()
/*
 word has a property "data" which is a dictionary
 key: word
 the word. eg: abondon
 
 key: phonetic
 the phonetic. eg:[ə'bændən]
 
 key: detail
 NSArray of meanings.
 Each detail is a dictionary;
 
    key: usage
    eg. n. 放纵： carefree, freedom from constraint
 
    key: homoionym
    eg. unconstraint, uninhibitedness, unrestraint
 
    key: antonym
    eg. keep, continue, maintain, carry on 继续
 
    key: example
    eg. added spices to the stew with complete abandon 肆无忌惮地向炖菜里面加调料
 
 
 options:
 key: shouldShowWord                default:[NSNumber numberWithBool:YES]
 key: shouldShowPhonetic            default:[NSNumber numberWithBool:YES]
 
 key: shouldShowChineseMeaning      default:[NSNumber numberWithBool:YES]（中文释义）
 key: shouldShowEnglishMeaning      default:[NSNumber numberWithBool:YES]（英文释义）
 key: shouldShowSampleSentence      default:[NSNumber numberWithBool:YES]（例句）
 key: shouldShowSynonyms            default:[NSNumber numberWithBool:YES]（同义词）
 key: shouldShowAntonyms            default:[NSNumber numberWithBool:YES]（反义词）
 this maybe nil to apply all default options
 */
- (void)showMeanings:(NSDictionary *)wordMeaningDictionary
        numberOfThisMeaning:(int)i
        whetherOnlyOneMeaning:(BOOL)b
        startHeight:(float)h
        withOptions:(NSDictionary*)options;
@end

@implementation WordLayoutViewController

float sumHeight = 5.0;//10.0;

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
            sumHeight += 5.0;
            [self showMeanings:theDetail[i] numberOfThisMeaning:i whetherOnlyOneMeaning:theDetail.count==0?YES:NO startHeight:sumHeight withOptions:options];
        }
    }
    self.view.frame = CGRectMake(0, 0, 320, sumHeight);
    NSLog(@"!!!!!!!!!%f",sumHeight);
    sumHeight = 5.0;
}

- (void)showMeanings:(NSDictionary *)wordMeaningDictionary
        numberOfThisMeaning:(int)i
        whetherOnlyOneMeaning:(BOOL)b
        startHeight:(float)h
        withOptions:(NSDictionary *)options
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
            if ([[options objectForKey:@"shouldShowChineseMeaning"] boolValue]) {
                label.text = [theUsage substringToIndex:range.location];
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                [label sizeToFit];
                [self.view addSubview:label];
                sumHeight = label.frame.origin.y + label.frame.size.height;
            }
            ////////////////////
            if ([[options objectForKey:@"shouldShowEnglishMeaning"] boolValue]) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(85, sumHeight, 215, 25)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
                label.text = [theUsage substringFromIndex:range.location+1];
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                [label sizeToFit];
                [self.view addSubview:label];
                sumHeight = label.frame.origin.y + label.frame.size.height;
            }
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
            if ([[options objectForKey:@"shouldShowChineseMeaning"] boolValue]) {
                label.text = [theUsage substringToIndex:offset];
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                [label sizeToFit];
                [self.view addSubview:label];
                sumHeight = label.frame.origin.y + label.frame.size.height;
            }
            ////////////////////
            if ([[options objectForKey:@"shouldShowEnglishMeaning"] boolValue]) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(85, sumHeight, 215, 25)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
                label.text = [theUsage substringFromIndex:offset+1];
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                [label sizeToFit];
                [self.view addSubview:label];
                sumHeight = label.frame.origin.y + label.frame.size.height;
            }
            ///////////////////
            
        }
        UIImageView *rectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning_meaning_rect.png"]];
        rectImage.frame = CGRectMake(10, h, 300, sumHeight-h);
        [self.view addSubview:rectImage];
        [self.view sendSubviewToBack:rectImage];
    }
    
    sumHeight += 8.0;
    
    NSString *theExample = [wordMeaningDictionary objectForKey:@"example"];
    if (theExample == nil) {
        NSLog(@"找不到这个单词的例句");
    }else{
        if ([[options objectForKey:@"shouldShowSampleSentence"] boolValue]) {
            ////////////////////
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, sumHeight, 65, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
            label.text = @"例";
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            ////////////////////
            label = [[UILabel alloc] initWithFrame:CGRectMake(85, sumHeight, 215, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            label.text = [theExample substringFromIndex:0];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            sumHeight = label.frame.origin.y + label.frame.size.height + 8.0;
            ////////////////////
        }
    }
    
    NSString *theHomoionym = [wordMeaningDictionary objectForKey:@"homoionym"];
    if (theHomoionym == nil) {
        NSLog(@"找不到这个单词的同义词");
    }else{
        if ([[options objectForKey:@"shouldShowSynonyms"] boolValue]) {
            ////////////////////
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, sumHeight, 65, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
            label.text = @"近";
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            ////////////////////
            label = [[UILabel alloc] initWithFrame:CGRectMake(85, sumHeight, 215, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            label.text = [theHomoionym substringFromIndex:0];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            sumHeight = label.frame.origin.y + label.frame.size.height + 8.0;
        }
    }
    NSString *theAntonym = [wordMeaningDictionary objectForKey:@"antonym"];
    if (theAntonym == nil) {
        NSLog(@"找不到这个单词的反义词");
    }else{
        if ([[options objectForKey:@"shouldShowAntonyms"] boolValue]) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, sumHeight, 65, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
            label.text = @"反";
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            ////////////////////
            label = [[UILabel alloc] initWithFrame:CGRectMake(85, sumHeight, 215, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
            label.text = [theAntonym substringFromIndex:0];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            [label sizeToFit];
            [self.view addSubview:label];
            sumHeight = label.frame.origin.y + label.frame.size.height + 5.0;
        }
    }
}

@end
