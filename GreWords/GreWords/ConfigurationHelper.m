//
//  ConfigurationHelper.m
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "ConfigurationHelper.h"

@implementation ConfigurationHelper

- (bool)boolPlistGetter:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];

}




@end


