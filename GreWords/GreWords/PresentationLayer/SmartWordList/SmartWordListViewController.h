//
//  SmartWordListViewController.h
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartWordListSectionController.h"

@class WordEntity;
@interface SmartWordListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* retractableControllers;
    UIImageView *topTexture;
    UIImageView *downTexture;
    float lastTableViewHeight;
}

@property (retain, nonatomic) NSArray *array;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) SmartListType type;

- (void)addWord:(WordEntity*)aWord;

@end
