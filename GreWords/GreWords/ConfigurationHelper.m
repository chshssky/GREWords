//
//  ConfigurationHelper.m
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "ConfigurationHelper.h"

@implementation ConfigurationHelper

ConfigurationHelper* _configurationHelperInstance = nil;

+(ConfigurationHelper*)instance
{
    if(!_configurationHelperInstance)
    {
        _configurationHelperInstance = [[ConfigurationHelper alloc] init];
    }
    return _configurationHelperInstance;
}

#pragma mark Helper Methods

- (bool)boolPlistGetter:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];

}

-(void)boolPlistSetter:(bool)value key:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:value forKey:key];
    [ud synchronize];
}

#pragma mark bool getter and setters 

-(bool)meaningVisibility
{
    return [self boolPlistGetter:@"meaningVisibility"];
}
-(void)setMeaningVisibility:(bool)meaningVisibility
{
    [self boolPlistSetter:meaningVisibility key:@"meaningVisibility"];
}

-(bool)sampleSentenceVisibility
{
    return [self boolPlistGetter:@"sampleSentenceVisibility"];
}
-(void)setSampleSentenceVisibility:(bool)sampleSentenceVisibility
{
    [self boolPlistSetter:sampleSentenceVisibility key:@"sampleSentenceVisibility"];
}

-(bool)homoionymVisibility
{
    return [self boolPlistGetter:@"homoionymVisibility"];
}
-(void)setHomoionymVisibility:(bool)homoionymVisibility
{
    [self boolPlistSetter:homoionymVisibility key:@"homoionymVisibility"];
}

-(bool)antonymVisiblity
{
    return [self boolPlistGetter:@"antonymVisiblity"];
}
-(void)setAntonymVisiblity:(bool)antonymVisiblity
{
    [self boolPlistSetter:antonymVisiblity key:@"antonymVisiblity"];
}

#pragma mark NSDate setter and getter

-(NSDate*)freshWordAlertTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"freshWordAlertTime"];
}
-(void)setFreshWordAlertTime:(NSDate*)freshWordAlertTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:freshWordAlertTime  forKey:@"freshWordAlertTime"];
    [ud synchronize];
    
    [self schedulePushNotificationAt:freshWordAlertTime message:@"该学习新单词了"];
}


-(NSDate*)reviewAlertTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"reviewAlertTime"];
}
-(void)setReviewAlertTime:(NSDate*)reviewAlertTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:reviewAlertTime  forKey:@"reviewAlertTime"];
    [ud synchronize];
    
    [self schedulePushNotificationAt:reviewAlertTime message:@"该学习新单词了"];
}



#pragma mark notification system

-(void)schedulePushNotificationAt:(NSDate*)alertTime message:(NSString*)message
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    
    
    NSDate *fireDay = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 1];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
												   fromDate:fireDay];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit )
												   fromDate:alertTime];
    
	// Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
    [dateComps setMinute:[timeComponents minute]];
	[dateComps setSecond:0];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	
	// Notification details
    localNotif.alertBody = message;
	
    localNotif.applicationIconBadgeNumber = 1;
	
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}



#pragma mark system function

-(void)resetAllData
{
    NSAssert(NO, @"function not implemented yet");
}

-(void)initData
{
    NSAssert(NO, @"function not implemented yet");
}


@end


