//
//  ConfigurationHelper.h
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuideImageFactory.h"

@interface ConfigurationHelper : NSObject

#pragma mark -- setting property
@property (nonatomic) bool chineseMeaningVisibility;
@property (nonatomic) bool englishMeaningVisibility;
@property (nonatomic) bool sampleSentenceVisibility;
@property (nonatomic) bool homoionymVisibility;
@property (nonatomic) bool antonymVisiblity;
@property (nonatomic) bool autoSpeak;

@property (nonatomic,retain) NSDate* freshWordAlertTime;
@property (nonatomic,retain) NSDate* reviewAlertTime;


#pragma mark -- guide property

-(bool)guideForTypeHasShown:(GuideType)type;
-(void)setGuideForTypeHasShown:(GuideType)type value:(bool)value;

+(ConfigurationHelper*)instance;

-(void)resetAllData;
-(void)initData;
-(void)initConfigsForStage;

-(void)reSchedule;

-(bool)isFirstTimeRun;

@end
