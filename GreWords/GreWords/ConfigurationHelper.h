//
//  ConfigurationHelper.h
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConfigurationHelper : NSObject

@property (nonatomic) bool meaningVisibility;
@property (nonatomic) bool sampleSentenceVisibility;
@property (nonatomic) bool homoionymVisibility;
@property (nonatomic) bool antonymVisiblity;

@property (nonatomic,retain) NSDate* freshWordAlertTime;
@property (nonatomic,retain) NSDate* reviewAlertTime;

@end
