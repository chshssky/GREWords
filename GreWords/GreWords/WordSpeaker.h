//
//  WordSpeaker.h
//  GreWords
//
//  Created by Song on 13-4-14.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1


@interface WordSpeaker : NSObject
{
    AVAudioPlayer *player;
    NSString *_word;
}

-(void)readWord:(NSString*)word;
+(WordSpeaker*)instance;

@end
