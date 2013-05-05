//
//  SmartWordListSectionController.h
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import "GCRetractableSectionController.h"


typedef enum 
{
    SmartListType_Slide,
    SmartListType_Full,
    SmartListType_Homo
}SmartListType;

@interface SmartWordListSectionController : GCRetractableSectionController


@property (nonatomic) int wordID;

@property (nonatomic) SmartListType type;

@property (nonatomic) float scrollViewHeight;

- (id) initWithViewController:(UIViewController*) givenViewController;

- (void)showUpShadow;
- (void)showDownShadow;
- (void)closeShadow;
@end
