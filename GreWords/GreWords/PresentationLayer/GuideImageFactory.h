//
//  GuideImageFactory.h
//  GreWords
//
//  Created by Song on 13-5-28.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GuideImageFactory : NSObject
{
    NSDictionary *dict;
}

- (UIImageView*)guideViewForType:(GuideType)type;
- (NSString*)keyForType:(GuideType)type;

+ (GuideImageFactory*)instance;

@end
