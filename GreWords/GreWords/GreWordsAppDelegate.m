//
//  GreWordsAppDelegate.m
//  GreWords
//
//  Created by 崔 昊 on 13-3-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreWordsAppDelegate.h"
#import "MyDataStorage.h"
#import "ConfigurationHelper.h"
#import "Crittercism.h"
#import "Flurry.h"

@implementation GreWordsAppDelegate

- (void)initUserDefault
{
    [NSUserDefaults initialize];
    
    NSDictionary *userDefaultsDefaults = @{@"firstTimeRun" : @YES};
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsDefaults];
}

- (void)initAnalytics
{
    //[Flurry setDebugLogEnabled:YES];
    //[Flurry setShowErrorInLogEnabled:YES];
    [Flurry setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [Flurry startSession:@"HKHP8FQG68VDNZ5J2DF3"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crittercism enableWithAppID:@"519c56bbc463c25c49000004"];
    
    [self initUserDefault];
    
    [self initAnalytics];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    for (NSString* fname in [UIFont familyNames])
//    {
//        NSLog(@"%@",fname);
//        for (NSString* name in [UIFont fontNamesForFamilyName:fname])
//        {
//            NSLog(@"    %@",name);
//        }
//    }
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
