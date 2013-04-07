//
//  wordLayoutViewController.h
//  GreWords
//
//  Created by Song on 13-4-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordEntity.h"

@interface WordLayoutViewController : UIViewController




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
- (void)displayWord:(WordEntity*)word withOption:(NSDictionary*)options;

@end
