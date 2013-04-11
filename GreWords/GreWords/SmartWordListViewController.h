//
//  SmartWordListViewController.h
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartWordListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_array;
    NSMutableArray* retractableControllers;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
