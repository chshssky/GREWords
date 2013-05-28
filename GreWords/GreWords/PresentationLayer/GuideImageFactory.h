//
//  GuideImageFactory.h
//  GreWords
//
//  Created by Song on 13-5-28.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    GuideType_Dashboard,
    GuideType_NewWordFirst,
    GuideType_NewWordSecond,
    GuideType_NewWordThird,
    GuideType_ReviewFirst,
    GuideType_ReviewSecond,
    GuideType_DashboardReview
} GuideType;

@interface GuideImageFactory : NSObject
{
    NSDictionary *dict;
}

- (UIImageView*)guideViewForType:(GuideType)type;
- (NSString*)keyForType:(GuideType)type;

+ (GuideImageFactory*)instance;

@end
