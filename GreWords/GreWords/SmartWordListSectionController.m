//
//  SmartWordListSectionController.m
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import "GCRetractableSectionController.h"
#import "SmartWordListSectionController.h"
#import "SmartWordListCell.h"
#import "SmartWordListHeaderCell.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "SmartWordListHeaderViewController.h"

#define ScrollViewHeight 340

@implementation SmartWordListSectionController

#pragma mark -
#pragma mark Simple subclass

- (NSUInteger)contentNumberOfRow {
    return 1;
}


- (UITableViewCell *)titleCell {
    NSString* contentCellIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"title"];
	
    SmartWordListHeaderCell *cell=(SmartWordListHeaderCell *)[self.tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
    if(cell==nil)
    {
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"SmartWordListHeaderCell" owner:self options:nil];
        cell = [nibs lastObject];
    }
    SmartWordListHeaderViewController *vc = [[SmartWordListHeaderViewController alloc] init];
    vc.text = [[WordHelper instance] wordWithID:self.wordID].data[@"word"];
    [cell addSubview:vc.view];
	return cell;
}

- (UITableViewCell *) contentCellForRow:(NSUInteger)row {
	NSString* contentCellIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"content"];
	
	   SmartWordListCell *cell=(SmartWordListCell *)[self.tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
        if(cell==nil)
        {
            NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"SmartWordListCell" owner:self options:nil];
            cell = [nibs lastObject];
        }
    
    WordLayoutViewController *vc = [[WordLayoutViewController alloc] init];
    [vc displayWord:[[WordHelper instance] wordWithID:self.wordID] withOption:nil];
    CGRect frame = vc.view.frame;
    
    if(frame.size.height > ScrollViewHeight)
    {
        frame.size.height = ScrollViewHeight;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.contentSize = vc.view.frame.size;
        [scrollView addSubview:vc.view];
        [cell addSubview:scrollView];
    }
    else
    {
        [cell addSubview:vc.view];
    }
    cell.frame  = frame;
     
    cell.clipsToBounds = YES;
	return cell;
}

@end
