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
 key: shouldShowMeaning             default:[NSNumber numberWithBool:YES]
 key: shouldShowSampleSentence      default:[NSNumber numberWithBool:YES]
 key: shouldShowSynonyms            default:[NSNumber numberWithBool:YES]
 key: shouldShowAntonyms            default:[NSNumber numberWithBool:YES]
 this maybe nil to apply all default options
 */
@end

@implementation WordLayoutViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayWord:(WordEntity*)word withOption:(NSDictionary*)options
{
    WordEntity *wordEntity = [[WordEntity alloc] init];
    
    
}


@end
