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
#import "WordCardLayoutViewController.h"
#import "WordNoteLayoutViewController.h"

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
              @"normal":@{@"height":@38,@"identifer":@"smartwordheader"},
              @"homo":@{@"height":@38,@"identifer":@"smartwordheader_homo"},
              @"slide":@{@"height":@38,@"identifer":@"smartwordheader_slide"}
              };
        }
        _type = SmartListType_Slide;
        self.scrollViewHeight = iPhone5 ?  358  : 270;
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
        case SmartListType_Homo:
            return typeDict[@"homo"];
        case SmartListType_Mistake:
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
    UITableView* tableView = [self.viewController performSelector:@selector(tableView)];
    SmartWordListHeaderCell *cell=(SmartWordListHeaderCell *)[tableView dequeueReusableCellWithIdentifier:([self configurationForTpye:self.type][@"identifer"])];

    if(self.type == SmartListType_Homo)
    {
        cell.wordLabel.text =  self.homotitle;
    }
    else
    {
        cell.wordLabel.text =  [[WordHelper instance] wordWithID:self.wordID].wordText;
        cell.word = [[WordHelper instance] wordWithID:self.wordID];
        cell.wordLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
        
        if([[WordHelper instance] wordWithID:self.wordID].note)
        {
            [cell.noteButton setImage:[UIImage imageNamed:@"words list_note.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.noteButton setImage:[UIImage imageNamed:@"words list_no_note.png"] forState:UIControlStateNormal];
        }
        
        if(self.type == SmartListType_Mistake)
        {
            cell.mistakeRatioIndicatorImageView.hidden = NO;
            int pointCount = [[WordHelper instance] wordWithID:self.wordID].ratioOfMistake * 100 / 20.0;
            [cell.mistakeRatioIndicatorImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"words list_point%d.png",pointCount]]];
            
        }
        else
        {
            cell.mistakeRatioIndicatorImageView.hidden = YES;
        }
    }
    
    
    
    //vc.text = [[WordHelper instance] wordWithID:self.wordID].wordText;
    //[cell addSubview:vc.view];

    return cell;
}

- (UITableViewCell *) contentCellForRow:(NSUInteger)row {
    
    UITableView* tableView = [self.viewController performSelector:@selector(tableView)];
    
    SmartWordListContentCell *cell=(SmartWordListContentCell *)[tableView dequeueReusableCellWithIdentifier:@"smartwordcontent"];
    
    NSArray* tobeRemove = [cell.contentView subviews];
    for(UIView* v in tobeRemove)
    {
        [v removeFromSuperview];
    }
    
    UIViewController *vc;
    if(self.type == SmartListType_Slide)
    {
        vc = [[WordSmallLayoutViewController alloc] init];
        WordSmallLayoutViewController *c = (WordSmallLayoutViewController*)vc;
        [c displayWord:[[WordHelper instance] wordWithID:self.wordID]];
    }
    else if(self.type == SmartListType_Full || self.type == SmartListType_Mistake)
    {
        vc = [[WordLayoutViewController alloc] init];
        NSDictionary *option = @{@"shouldShowChineseMeaning":@YES,
                                 @"shouldShowEnglishMeaning":@YES,
                                 @"shouldShowSynonyms":@YES,
                                 @"shouldShowAntonyms":@YES,
                                 @"shouldShowSampleSentence":@YES};
        WordLayoutViewController *c = (WordLayoutViewController*)vc;
        [c displayWord:[[WordHelper instance] wordWithID:self.wordID] withOption:option];
    }
    else if(self.type == SmartListType_Homo)
    {
        vc = [[WordCardLayoutViewController alloc] init];
        
        WordCardLayoutViewController *c = (WordCardLayoutViewController*)vc;
       
        [c displayCard:_homoDict];
    }
    else if(self.type == SmartListType_Note)
    {
        vc = [[WordNoteLayoutViewController alloc] init];
        
        WordNoteLayoutViewController *c = (WordNoteLayoutViewController*)vc;
        
        [c displayNote:[[WordHelper instance] wordWithID:self.wordID]];
    }
    CGRect frame = vc.view.frame;
    
    
    if(frame.size.height >  self.scrollViewHeight && self.type != SmartListType_Slide)
    {
        frame.size.height =  self.scrollViewHeight;
        cell.frame  = cell.contentView.frame = frame;
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
        if(self.type == SmartListType_Slide || self.type == SmartListType_Homo)
        {
            
        }
        else
        {
            frame.size.height =  self.scrollViewHeight;
        }
        
        cell.frame  = cell.contentView.frame = frame;
        [cell.contentView addSubview:vc.view];
        
    }
    
    //cell.contentView.layer;
    
    //cell.contentView.frame = frame;
    //cell.frame  = frame;
    
    //cell.clipsToBounds = NO;
	return cell;
}

@end
