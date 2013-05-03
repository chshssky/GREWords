//
//  WordSpeaker.m
//  GreWords
//
//  Created by Song on 13-4-14.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import "WordSpeaker.h"

@implementation WordSpeaker

static WordSpeaker* _wordSpeakerInstance = nil;

+(WordSpeaker*)instance
{
    if(!_wordSpeakerInstance)
    {
        _wordSpeakerInstance = [[WordSpeaker alloc] init];
    }
    return _wordSpeakerInstance;
}

-(NSString*)filePathForWord:(NSString*)word
{
//    NSArray* cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString* cachePath = [cachePathArray lastObject];
//    
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", cachePath ,word];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:word ofType:@"mp3"];
    
    return filePath;
}

-(void)readWord:(NSString*)word
{
    dispatch_async(kBgQueue, ^{
        [self readWordThread:word];
    });
}

-(void)readWordThread:(NSString*)word
{
    NSString *path = [self filePathForWord:word];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSLog(@"%@ voice not found at %@",word,path);
        return;
    }
        
    NSError  *error;
    player  = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    
    player.numberOfLoops = 0;
    [player play];
    
    if(error) NSLog(@"%@",[error localizedDescription]);
}

@end
