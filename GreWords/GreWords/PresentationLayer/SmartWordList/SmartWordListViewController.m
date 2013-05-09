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
#import <QuartzCore/QuartzCore.h>

@interface SmartWordListViewController ()

@end

@implementation SmartWordListViewController

- (void)addWord:(WordEntity*)aWord
{
    _array = [_array arrayByAddingObject:aWord];
    SmartWordListSectionController* sectionController = [[SmartWordListSectionController alloc] initWithViewController:self];
    sectionController.wordID = aWord.wordID;
    sectionController.sectionID = _array.count - 1;
    sectionController.type = self.type;
    [retractableControllers addObject:sectionController];
    
    [self.tableView reloadData];
    //NSArray *indexPath = @[[NSIndexPath indexPathForRow:0 inSection:sectionController.sectionID]];
    //[self.tableView beginUpdates];
    //[self.tableView insertRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationBottom];
    //[self.tableView endUpdates];
    [self addButtomTexture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    retractableControllers = [@[] mutableCopy];
    lastTableViewHeight = -1;
    
    for(int i = 0; i < _array.count;i++)
    {
        SmartWordListSectionController* sectionController = [[SmartWordListSectionController alloc] initWithViewController:self];
        sectionController.wordID = ((WordEntity*)_array[i]).wordID;
        sectionController.sectionID = i;
        sectionController.type = self.type;
        [retractableControllers addObject:sectionController];
    }

    topTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -570.0f, 320.0f, 568.0f)];
    topTexture.image = [UIImage imageNamed:@"learning list_up_and_down_moreBg.png"];
    [self.tableView addSubview:topTexture];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtomTexture
{
    if(lastTableViewHeight == -1)
    {
        lastTableViewHeight = self.tableView.contentSize.height + 2;
        
        UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning list_line.png"]];
        
        CGRect frame = bottomLine.frame;
        frame.origin.y = -5;
        bottomLine.frame = frame;
        
        downTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, lastTableViewHeight, 320.0f, 568.0f)];
        
        downTexture.image = [UIImage imageNamed:@"learning list_up_and_down_moreBg.png"];
        [downTexture addSubview:bottomLine];
        [self.tableView addSubview:downTexture];
    }
    else
    {
        lastTableViewHeight = self.tableView.contentSize.height + 1;
        [UIView animateWithDuration:0.3f animations:^()
        {
            downTexture.frame = CGRectMake(0.0f, lastTableViewHeight, 320.0f, 568.0f);
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self addButtomTexture];
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
    
    if(indexPath.row != 0)
        return;
    
    //BOOL isOpen = sectionController.open;
    
    [sectionController didSelectCellNoScrollAtRow:indexPath.row];
    
    
    [CATransaction begin];
    [self.tableView beginUpdates];
    //[sectionController closeOthers];
//    [CATransaction setCompletionBlock: ^{
//        // Code to be executed upon completion
//        NSLog(@"wuwuwuw");
//        [self performSelector:@selector(addButtomTexture) withObject:nil afterDelay:0.1f];
//    }];
    for(int i = 0; i < retractableControllers.count; i++)
    {
        SmartWordListSectionController* aController = [retractableControllers objectAtIndex:i];
        if(i == indexPath.section)
        {
            continue;
        }
        [aController close];
        
    }
    [self.tableView endUpdates];
    [CATransaction commit];
    
    [sectionController scroll];
    
    [self addButtomTexture];
    //[downTexture removeFromSuperview];
    //downTexture = nil;
}


@end
