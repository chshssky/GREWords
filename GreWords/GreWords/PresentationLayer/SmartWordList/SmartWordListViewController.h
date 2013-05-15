//
//  SmartWordListViewController.h
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartWordListSectionController.h"

@class SmartWordListViewController;
@protocol SmartWordListScrollDelegate <NSObject>

-(void)smartWordListWillBeginDragging:(SmartWordListViewController*)list;
-(void)smartWordList:(SmartWordListViewController*)list didTranslationYSinceLast:(CGFloat)traslation;

@end


@class WordEntity;
@interface SmartWordListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* retractableControllers;
    UIImageView *topTexture;
    UIImageView *downTexture;
    float lastTableViewHeight;
    
    CGFloat _contentOffsetBeforeScroll;
    
    BOOL isDragging;
}

@property (retain, nonatomic) NSArray *array;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) SmartListType type;

@property (nonatomic,retain) id<SmartWordListScrollDelegate> scrollDelegate;

- (void)addWord:(WordEntity*)aWord;

@end
