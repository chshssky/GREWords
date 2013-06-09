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

-(id)init
{
    self = [super init];
    if(self)
    {
        mottos = @[
                     @"考好GRE的唯一捷径就是重复，重复，再重复。",
                     @"壮丽的诗篇要以信念作为舞台，融着几多苦乐的拼搏历程是我想要延续的抚慰和寄托。",
                     @"没有风雨怎么见彩虹，无悔的拼搏为我带来加州的阳光和硅谷的清风。",
                     @"考G给予我们的，并不仅仅是一次拼搏和成功，而是向着更远更大目标的无畏与洒脱。",
                     @"最初的梦想要靠坚持才能到达，一路上的无限风景见证着我的勇敢与执着。",
                     @"Just do it. -- It pays.",
                     @"刷词，刷题，刷《要你命3000》，为你刷出新世界",
                     @"没有野心的人是给自己的懒惰找借口。",
                     @"背GRE单词的过程，让我们铭记的不仅仅是单词，更是周围人的关爱。我们刷的不是单词，而是关爱。",
                     @"其实可以将GRE这样看，它所考察的不仅是英文和逻辑，更是恒心和毅力。所以如果你相信自己的能力，不妨将GRE看作是最好的证明方式！",
                     @"真正努力过才能发现自己的潜能有多大。不要给自己犹豫后退的借口，让小宇宙爆发吧！",
                     @"未曾想与雄鹰争锋，来赢得他人艳羡的目光，我却凭着志在四方的信念和风雨兼程的决心，成为站在金字塔尖的蜗牛，沐浴着清风，唱响青春无悔的乐章！",
                     @"每当我们对未来充满了各种美好的期望与幻想时，就该反思一下自己现在的努力是否配得上这幻境中的将来。莫问收获，但问耕耘。",
                     @"所谓抱负就是对现状的永不满足，有变化的生活才精彩，永远不要停下追逐梦想的脚步。",
                     @"敢于不断挑战极限的你将发掘拥有无限潜力的自我。",
                     @"不要把背GRE单词当成一种负担，要把它当成记忆的游戏，扩展视角的平台。",
                     @"多看多背多做题，不烦不倦不放弃。",
                     @"生如夏花，在追求结果绚烂的同时享受过程中的美好。",
                     @"GRE所考验的不是脑力，不是体力，而是心力，踏踏实实地做好每一个细节，阳光真的就会出现在风雨后。",
                     @"每天比别人多放纵自己一点，日积月累就必然会落后。每天比别人多做一点，日积月累就成为竞争的优势。",
                     @"行百里者半九十,不要等到发现GRE成为自己申请的短板时才追悔不已。",
                     @"Widener地上六层，地下四层；背好GRE单词再在这里读书，便有通天入地的感觉。",
                     @"面对词藻堆砌的高峰，我们不应因身处词汇匮乏的谷底而绝望，征服，都是从脚下开始的。",
                     @"若干年前，有人跟我说，没有GRE的人生是不完整的。现在我跟别人说，没有GRE的人生确实是不完整的。",
                     @"信仰，勇敢的心和自我控制是最强者的本能。",
                     @"如果出国是一种信念，那GRE便是是否能坚守的第一道考验。",
                     @"人最大的杯具是眼睁睁地让梦想一点点蜕变成空想。与其纠结每个小节的意义，不如放手一搏，不求无憾，但求无悔。",
                     @"从对单词书的仰视畏惧， 到一遍两遍五十遍， 再到感激留恋——坚持过的人才最有感触：最焦头烂额的日子日后一定会成为一段最值得珍惜的回忆。GRE改变人生。",
                     @"‘独上高楼， 望尽天涯路。’ GRE是登高的小小台阶，在脚踏实地的同时，目光应时刻凝聚在更远大的理想上。"];
    }
    return self;
}

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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    if(!self.freshWordAlertTime || !self.reviewAlertTime)
        return;
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
        localNotif.alertBody = [NSString stringWithFormat:@"现在该背诵今天的新单词了哦~~%@",mottos[arc4random() % mottos.count]];
        
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
        localNotif.alertBody = [NSString stringWithFormat:@"现在该复习单词了哦~~%@",mottos[arc4random() % mottos.count]];
        
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
    [self initNotificationTime];
    //NSAssert(NO, @"function not implemented yet");
}

-(void)initNotificationTime
{
    {
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setDay:3];
        [dateComps setMonth:10];
        [dateComps setYear:1991];
        [dateComps setHour:8];
        [dateComps setMinute:0];
        [dateComps setSecond:0];
        NSDate *date = [calendar dateFromComponents:dateComps];
        self.freshWordAlertTime = date;
    }
    {
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setDay:3];
        [dateComps setMonth:10];
        [dateComps setYear:1991];
        [dateComps setHour:14];
        [dateComps setMinute:0];
        [dateComps setSecond:0];
        NSDate *date = [calendar dateFromComponents:dateComps];
        self.reviewAlertTime = date;
    }
}

-(void)initConfigsForStage:(int)stage
{
    if(stage == 0)
    {
        self.chineseMeaningVisibility = YES;
        self.englishMeaningVisibility = YES;
        self.autoSpeak = YES;
        self.homoionymVisibility = NO;
        self.antonymVisiblity = NO;
        self.sampleSentenceVisibility = NO;
    }
    else if(stage == 1)
    {
        self.chineseMeaningVisibility = YES;
        self.englishMeaningVisibility = YES;
        self.autoSpeak = YES;
        self.homoionymVisibility = NO;
        self.antonymVisiblity = NO;
        self.sampleSentenceVisibility = YES;
    }
    else if(stage == 2)
    {
        self.chineseMeaningVisibility = YES;
        self.englishMeaningVisibility = YES;
        self.autoSpeak = YES;
        self.homoionymVisibility = YES;
        self.antonymVisiblity = YES;
        self.sampleSentenceVisibility = YES;
    }
    else if(stage == 3)
    {
        self.chineseMeaningVisibility = YES;
        self.englishMeaningVisibility = YES;
        self.autoSpeak = YES;
        self.homoionymVisibility = YES;
        self.antonymVisiblity = YES;
        self.sampleSentenceVisibility = YES;
    }
}


-(bool)isFirstTimeRun
{
    return [self boolPlistGetter:@"firstTimeRun"];
}

@end


