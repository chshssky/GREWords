//
//  GuideImageFactory.m
//  GreWords
//
//  Created by Song on 13-5-28.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GuideImageFactory.h"
#import "ConfigurationHelper.h"

@implementation GuideImageFactory


+ (GuideImageFactory*)instance
{
    static GuideImageFactory *loader = nil;
    static dispatch_once_t GuideImageFactoryPredicate;
    dispatch_once(&GuideImageFactoryPredicate, ^{
        loader = [[GuideImageFactory alloc] init];
    });
    return loader;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        dict = @{
                   @"dashboard":
                         @{
                             @"image3.5" : @"dashboard3.5.png",
                             @"image4" : @"dashboard4.png"
                          },
                   @"newwordfirst":
                        @{
                            @"image3.5" : @"newwordfirst3.5.png",
                            @"image4" : @"newwordfirst4.png"
                        },
                   @"newwordsecond":
                       @{
                           @"image3.5" : @"newwordsecond3.5.png",
                           @"image4" : @"newwordsecond4.png"
                           },
                   @"newwordthird":
                       @{
                           @"image3.5" : @"newwordthird3.5.png",
                           @"image4" : @"newwordthird4.png"
                           },
                   @"reviewfirst":
                       @{
                           @"image3.5" : @"reviewfirst3.5.png",
                           @"image4" : @"reviewfirst4.png"
                           },
                   @"reviewsecond":
                       @{
                           @"image3.5" : @"reviewsecond3.5.png",
                           @"image4" : @"reviewsecond4.png"
                           },
                   @"dashboardreview":
                       @{
                           @"image3.5" : @"dashboardreview3.5.png",
                           @"image4" : @"dashboardreview4.png"
                           },
                   @"list":
                       @{
                           @"image3.5" : @"list3.5.png",
                           @"image4" : @"list4.png"
                           }

                
                 };
    }
    return self;
}

- (NSString*)keyForType:(GuideType)type
{
    switch (type) {
        case GuideType_Dashboard:
            return @"dashboard";
            break;
        case GuideType_NewWordFirst:
            return @"newwordfirst";
            break;
        case GuideType_NewWordSecond:
            return @"newwordsecond";
            break;
        case GuideType_NewWordThird:
            return @"newwordthird";
            break;
        case GuideType_ReviewFirst:
            return @"reviewfirst";
            break;
        case GuideType_ReviewSecond:
            return @"reviewsecond";
            break;
        case GuideType_DashboardReview:
            return @"dashboardreview";
            break;
        case GuideType_List:
            return @"list";
            break;
        default:
            break;
    }
}

- (NSString*)imageNameFor4inchForType:(GuideType)type
{
    return dict[[self keyForType:type]][@"image4"];
}

- (NSString*)imageNameFor3_5inchForType:(GuideType)type
{
    return dict[[self keyForType:type]][@"image3.5"];
}


- (UIImageView*)guideViewForType:(GuideType)type
{
    UIImage *image = [UIImage imageNamed: iPhone5 ? [self imageNameFor4inchForType:type] : [self imageNameFor3_5inchForType:type] ];
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    UITapGestureRecognizer *tapRecer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    view.tag = type;
    [view addGestureRecognizer:tapRecer];
    view.userInteractionEnabled = YES;
    return view;
}

- (void)didTap:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.2 animations:^()
    {
        sender.view.alpha = 0;
    }
                     completion:^(BOOL c)
    {
        [[ConfigurationHelper instance] setGuideForTypeHasShown:sender.view.tag value:YES];
        [sender.view removeFromSuperview];
    }];
}

@end
