//
//  SmartWordListViewController.h
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartWordListSectionController.h"
#import "GreTableViewSearchIndexViewController.h"

@class SmartWordListViewController;
@protocol SmartWordListScrollDelegate <NSObject>

-(void)smartWordListWillBeginDragging:(SmartWordListViewController*)list;
-(void)smartWordList:(SmartWordListViewController*)list didTranslationYSinceLast:(CGFloat)traslation;

-(void)smartWordListWillStartSearch:(SmartWordListViewController*)list;
-(void)smartWordListDidEndSearch:(SmartWordListViewController*)list;
@end


@class WordEntity;
@interface SmartWordListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,GreTableViewSearchIndexDelegate>
{
    NSMutableArray* retractableControllers;
    NSMutableArray* filteredRetractableControllers;
    
    CGFloat _contentOffsetBeforeScroll;
    
    BOOL isDragging;
    
    BOOL isSearching;
    
    GreTableViewSearchIndexViewController *searchIndex;
}

@property (retain, nonatomic) NSArray *array;
@property (strong,nonatomic) NSMutableArray *filteredArray;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) SmartListType type;

@property (nonatomic,retain) id<SmartWordListScrollDelegate> scrollDelegate;

@property IBOutlet UISearchBar *searchBar;

- (void)addWord:(WordEntity*)aWord;

- (UITableView*)currentTableView;

@end
