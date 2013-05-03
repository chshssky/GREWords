//
//  SmartWordListViewController.m
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Song. All rights reserved.
//

#import "SmartWordListViewController.h"
#import "WordLayoutViewController.h"
#import "SmartWordListContentCell.h"
#import "SmartWordListSectionController.h"
#import "WordHelper.h"

@interface SmartWordListViewController ()

@end

@implementation SmartWordListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    _array = [[WordHelper instance] wordsAlphabeticOrder];
    
    retractableControllers = [@[] mutableCopy];
    
    for(int i = 0; i < _array.count;i++)
    {
        SmartWordListSectionController* sectionController = [[SmartWordListSectionController alloc] initWithViewController:self];
        sectionController.wordID = ((WordEntity*)_array[i]).wordID;
        sectionController.sectionID = i;
        sectionController.type = self.type;
        [retractableControllers addObject:sectionController];
    }

    topTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -568.0f, 320.0f, 568.0f)];
    topTexture.image = [UIImage imageNamed:@"learning list_up_and_down_moreBg.png"];
    
    [self.tableView addSubview:topTexture];
    // Do any additional setup after loading the view from its nib.
    
//    
//    EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
//    refreshView.delegate = self;
//    //将下拉刷新控件作为子控件添加到UITableView中
//    [self.tableView addSubview:refreshView];
//    
//    LoadMoreTableFooterView *view = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.0f, self.tableView.contentSize.height, self.tableView.frame.size.width, self.tableView.frame.size.height)];
//    view.delegate = self;
//    [self.tableView addSubview:view];
//    _loadMoreTableFooter = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    self.tableView = nil;
    [super viewDidUnload];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCRetractableSectionController* sectionController = [retractableControllers objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCRetractableSectionController* sectionController = [retractableControllers objectAtIndex:indexPath.section];
    return [sectionController heightForRow:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [retractableControllers objectAtIndex:indexPath.section];
    
    [sectionController didSelectCellNoScrollAtRow:indexPath.row];
    
    [self.tableView beginUpdates];
    //[sectionController closeOthers];
    for(int i = 0; i < retractableControllers.count; i++)
    {
        if(i == indexPath.section)
            continue;
        GCRetractableSectionController* aController = [retractableControllers objectAtIndex:i];
        [aController close];
    }
    [self.tableView endUpdates];
    
    [sectionController scroll];
    
    
}


@end
