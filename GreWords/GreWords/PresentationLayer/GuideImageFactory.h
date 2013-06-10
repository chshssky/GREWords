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
    GuideType_DashboardReview,
    GuideType_List,
    GuideType_Rollback,
    GuideType_Note,
    GuideType_Exam
} GuideType;

@protocol GuideImageProtocal <NSObject>

@optional
-(void)guideEnded;

@end

@interface GuideImageFactory : NSObject
{
    NSDictionary *dict;
}

@property (nonatomic,retain) id<GuideImageProtocal> oneTimeDelegate;

- (UIImageView*)guideViewForType:(GuideType)type;
- (NSString*)keyForType:(GuideType)type;

+ (GuideImageFactory*)instance;

@end
