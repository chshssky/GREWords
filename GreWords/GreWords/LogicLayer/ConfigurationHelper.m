//
//  ConfigurationHelper.m
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "ConfigurationHelper.h"
#import "MyDataStorage.h"
#import "Word.h"
#import "GuideImageFactory.h"

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


#pragma mark - Guide bool values

-(bool)guideForTypeHasShown:(GuideType)type
{
    return [self boolPlistGetter:[[GuideImageFactory instance] keyForType:type]];
}

-(void)setGuideForTypeHasShown:(GuideType)type value:(bool)value
{
    [self boolPlistSetter:value key:[[GuideImageFactory instance] keyForType:type]];
}

#pragma mark - Setting values
#pragma mark bool values


-(bool)chineseMeaningVisibility
{
    return [self boolPlistGetter:@"chineseMeaningVisibility"];
}
-(void)setChineseMeaningVisibility:(bool)meaningVisibility
{
    [self boolPlistSetter:meaningVisibility key:@"chineseMeaningVisibility"];
}

-(bool)englishMeaningVisibility
{
    return [self boolPlistGetter:@"englishMeaningVisibility"];
}
-(void)setEnglishMeaningVisibility:(bool)meaningVisibility
{
    [self boolPlistSetter:meaningVisibility key:@"englishMeaningVisibility"];
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

-(bool)autoSpeak
{
    return [self boolPlistGetter:@"autoSpeak"];
}
-(void)setAutoSpeak:(bool)autoSpeak
{
    [self boolPlistSetter:autoSpeak key:@"autoSpeak"];
}

#pragma mark NSDate values

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
    
    [self reSchedule];
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
    
    [self reSchedule];
}



#pragma mark notification system




-(void)reSchedule
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    for(int i = 0; i <= 30; i++)
    {
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        
        
        NSDate *fireDay = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * (i+1)];
        
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                       fromDate:fireDay];
        NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit )
                                                       fromDate:self.freshWordAlertTime];
        
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
        localNotif.alertBody = @"现在该背诵今天的新单词了哦~~↖(^ω^)↗";
        
        localNotif.applicationIconBadgeNumber = i+1;
        
        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
    for(int i = 0; i <= 30; i++)
    {
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        
        
        NSDate *fireDay = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * (i+1)];
        
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                       fromDate:fireDay];
        NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit )
                                                       fromDate:self.reviewAlertTime];
        
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
        localNotif.alertBody = @"现在该复习单词了哦~~↖(^ω^)↗";
        
        localNotif.applicationIconBadgeNumber = i+1;
        
        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
}





#pragma mark - system function

-(void)resetAllData
{
    [[MyDataStorage instance] deleteDaatabase];
    [self boolPlistSetter:YES key:@"firstTimeRun"];
    //NSAssert(NO, @"function not implemented yet");
}

-(void)initData
{
    NSManagedObjectContext *context = [[MyDataStorage instance] managedObjectContext];
    NSArray *arr;
    NSString *infoSouceFile = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSData* data = [NSData dataWithContentsOfFile:infoSouceFile];
    NSError *error;
    NSPropertyListFormat format;
    arr = [NSPropertyListSerialization propertyListWithData:data options:0 format:&format error:&error];
    int count = arr.count;
    arr = nil;
    for(int i = 0; i < count; i++)
    {
        Word *word = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Word"
                      inManagedObjectContext:context];
        word.plistID = [NSNumber numberWithInt:i];
    }
    [[MyDataStorage instance] saveContext];
    
    [self boolPlistSetter:NO key:@"firstTimeRun"];
    //NSAssert(NO, @"function not implemented yet");
}


-(void)initConfigsForStage
{
#warning TODO
}


-(bool)isFirstTimeRun
{
    return [self boolPlistGetter:@"firstTimeRun"];
}

@end


