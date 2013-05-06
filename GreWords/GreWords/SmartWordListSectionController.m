//
//  SmartWordListSectionController.m
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import "GCRetractableSectionController.h"
#import "SmartWordListSectionController.h"
#import "WordSmallLayoutViewController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "SmartWordListHeaderCell.h"
#import "SmartWordListContentCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SmartWordListSectionController

#pragma mark -
#pragma mark Simple subclass


static NSDictionary* typeDict = nil;

- (id) initWithViewController:(UIViewController*) givenViewController 
{
    if(self = [super  initWithViewController:givenViewController ])
    {
        if(!typeDict)
        {
            typeDict = @{
              @"normal":@{@"height":@60,@"identifer":@"smartwordheader"},
              @"slide":@{@"height":@38,@"identifer":@"smartwordheader_slide"}
              };
        }
        _type = SmartListType_Slide;
        self.scrollViewHeight = 279;
    }
    return self;
}


- (NSUInteger)contentNumberOfRow {
    return 1;
}

-(NSDictionary*)configurationForTpye:(SmartListType)type
{
    switch (type) {
        case SmartListType_Slide:
            return typeDict[@"slide"];
            break;
        case SmartListType_Full:
            return typeDict[@"normal"];
        default:
            return typeDict[@"normal"];
            break;
    }
}

- (CGFloat) heightForRow:(NSUInteger)row {
	if (row == 0)
    {
        NSNumber * n = [self configurationForTpye:self.type][@"height"];
        return [n floatValue];
    }
	return [super heightForRow:row];
}

- (UITableViewCell *)titleCell {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SmartWordListStoryboard" bundle:[NSBundle mainBundle]];
//    storyboard in
    
    SmartWordListHeaderCell *cell=(SmartWordListHeaderCell *)[self.tableView dequeueReusableCellWithIdentifier:([self configurationForTpye:self.type][@"identifer"])];

    cell.wordLabel.text =  [[WordHelper instance] wordWithID:self.wordID].data[@"word"];
    
    cell.wordLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
    
    //vc.text = [[WordHelper instance] wordWithID:self.wordID].data[@"word"];
    //[cell addSubview:vc.view];

    return cell;
}

- (UITableViewCell *) contentCellForRow:(NSUInteger)row {
    
    
    SmartWordListContentCell *cell=(SmartWordListContentCell *)[self.tableView dequeueReusableCellWithIdentifier:@"smartwordcontent"];
    
    
    WordSmallLayoutViewController *vc = [[WordSmallLayoutViewController alloc] init];
    [vc displayWord:[[WordHelper instance] wordWithID:self.wordID] withOption:nil];
    CGRect frame = vc.view.frame;
    
    NSArray* tobeRemove = [cell.contentView subviews];
    for(UIView* v in tobeRemove)
    {
        [v removeFromSuperview];
    }
    
    
    if(frame.size.height >  self.scrollViewHeight)
    {
        frame.size.height =  self.scrollViewHeight;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:cell.contentView.frame];
        scrollView.contentSize = vc.view.frame.size;
        [scrollView addSubview:vc.view];
        scrollView.clipsToBounds = YES;
        [scrollView setScrollsToTop:NO];
        [cell.contentView addSubview:scrollView];
        //[cell sendSubviewToBack:scrollView];
    }
    else
    {
        [cell.contentView addSubview:vc.view];
    }
    
    //cell.contentView.layer;
    
    //cell.contentView.frame = frame;
    //cell.frame  = frame;
    
    //cell.clipsToBounds = NO;
	return cell;
}

@end
