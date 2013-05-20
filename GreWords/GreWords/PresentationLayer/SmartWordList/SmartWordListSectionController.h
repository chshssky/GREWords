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
    SmartListType_Homo,
    SmartListType_Note
}SmartListType;

@interface SmartWordListSectionController : GCRetractableSectionController


@property (nonatomic) int wordID;

@property (nonatomic) NSString* homotitle;
@property (nonatomic) NSDictionary* homoDict;

@property (nonatomic) SmartListType type;

@property (nonatomic) float scrollViewHeight;

- (id) initWithViewController:(UIViewController*) givenViewController;

@end
