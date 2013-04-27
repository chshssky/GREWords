//
//  SmartWordListSectionController.m
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import "GCRetractableSectionController.h"
#import "SmartWordListSectionController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "SmartWordListHeaderCell.h"
#import "SmartWordListContentCell.h"

#define ScrollViewHeight 340

@implementation SmartWordListSectionController

#pragma mark -
#pragma mark Simple subclass

- (NSUInteger)contentNumberOfRow {
    return 1;
}


- (UITableViewCell *)titleCell {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SmartWordListStoryboard" bundle:[NSBundle mainBundle]];
//    storyboard in
    
    NSLog(@"%@",self.tableView);
    
    SmartWordListHeaderCell *cell=(SmartWordListHeaderCell *)[self.tableView dequeueReusableCellWithIdentifier:@"smartwordheader"];

    cell.wordLabel.text =  [[WordHelper instance] wordWithID:self.wordID].data[@"word"];
    //vc.text = [[WordHelper instance] wordWithID:self.wordID].data[@"word"];
    //[cell addSubview:vc.view];
	return cell;
}

- (UITableViewCell *) contentCellForRow:(NSUInteger)row {
    
    
    SmartWordListContentCell *cell=(SmartWordListContentCell *)[self.tableView dequeueReusableCellWithIdentifier:@"smartwordcontent"];
    
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
