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
#import "NSNotificationCenter+Addition.h"

@interface SmartWordListViewController ()

@end

@implementation SmartWordListViewController


- (void)addWord:(WordEntity*)aWord
{
    if(self.type == SmartListType_Homo)
    {
        NSLog(@"Homo List Don't support add word");
        return;
    }
        
    
    _array = [_array arrayByAddingObject:aWord];
    SmartWordListSectionController* sectionController = [[SmartWordListSectionController alloc] initWithViewController:self];
    sectionController.wordID = aWord.wordID;
    sectionController.sectionID = _array.count - 1;
    sectionController.type = self.type;
    [retractableControllers addObject:sectionController];
    
//    NSArray *indexPath = @[[NSIndexPath indexPathForRow:0 inSection:_array.count - 1]];
//    //[self.tableView beginUpdates];
//    [self.tableView insertRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationBottom];
//    //[self.tableView endUpdates];
    [self.tableView reloadData];
    //[self performSelector:@selector(addButtomTexture) withObject:nil afterDelay:0.3];
    [self addButtomTexture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isDragging = NO;
    
    retractableControllers = [@[] mutableCopy];
    lastTableViewHeight = -1;
    
    for(int i = 0; i < _array.count;i++)
    {
        SmartWordListSectionController* sectionController = [[SmartWordListSectionController alloc] initWithViewController:self];
        if(self.type == SmartListType_Homo)
        {
            sectionController.homotitle = ((NSDictionary*)_array[i])[@"key"];
             sectionController.homoDict = ((NSDictionary*)_array[i]);
        }
        else
        {
            sectionController.wordID = ((WordEntity*)_array[i]).wordID;
        }
        sectionController.sectionID = i;
        sectionController.type = self.type;
        [retractableControllers addObject:sectionController];
    }

    topTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -570.0f, 320.0f, 568.0f)];
    topTexture.image = [UIImage imageNamed:@"learning list_up_and_down_moreBg.png"];
    [self.tableView addSubview:topTexture];
    if(self.type == SmartListType_Note)
    {
        [NSNotificationCenter registerAddNoteForWordNotificationWithSelector:@selector(addNoteItem:) target:self];
        [NSNotificationCenter registerRemoveNoteForWordNotificationWithSelector:@selector(removeNoteItem:) target:self];
    }
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
        lastTableViewHeight = self.tableView.contentSize.height;
        
        UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning list_line.png"]];
        
        CGRect frame = bottomLine.frame;
        frame.origin.y = -5;
        bottomLine.frame = frame;
        
        downTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, lastTableViewHeight, 320.0f, 1136.0f)];
        
        downTexture.image = [UIImage imageNamed:@"learning list_up_and_down_moreBg.png"];
        [downTexture addSubview:bottomLine];
        [self.tableView addSubview:downTexture];
    }
    else
    {
        lastTableViewHeight = 0;
        int sectionCount = [self numberOfSectionsInTableView:self.tableView];
        if(sectionCount > 0)
        {
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:[self tableView:self.tableView numberOfRowsInSection:sectionCount - 1] - 1  inSection:sectionCount - 1];
            CGRect lastRect = [self.tableView rectForRowAtIndexPath:lastIndex];
            
            lastTableViewHeight = lastRect.origin.y + lastRect.size.height ;
            
            NSLog(@"height:%f",lastTableViewHeight);
            
            [UIView animateWithDuration:0.3 animations:^()
             {
                 downTexture.frame = CGRectMake(0.0f, lastTableViewHeight, 320.0f, 1136.0f);
             }];
        }
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


#pragma mark table view delegate

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
    //[self performSelector:@selector(addButtomTexture) withObject:nil afterDelay:0.3];
    
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
    //[self performSelector:@selector(addButtomTexture) withObject:nil afterDelay:0.3];
    //[self performSelector:@selector(addButtomTexture) withObject:nil afterDelay:0.5];
    
    //[self addButtomTexture];
    //[downTexture removeFromSuperview];
    //downTexture = nil;
}

#pragma mark - scroll view delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.tableView == scrollView)
    {
        isDragging = YES;
        _contentOffsetBeforeScroll = self.tableView.contentOffset.y;
        [self.scrollDelegate smartWordListWillBeginDragging:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    isDragging = NO;
}

- (void)scrollViewDidScroll:(UIScrollView*)aScrollView
{
    if(self.tableView == aScrollView)
    {
        CGFloat contentOffsetY = self.tableView.contentOffset.y - _contentOffsetBeforeScroll;
        if(self.tableView.contentSize.height <= self.tableView.frame.size.height || self.tableView.contentOffset.x == 0)
        {
            if(!isDragging)
                return;
        }
        
        [self.scrollDelegate smartWordList:self didTranslationYSinceLast:contentOffsetY];
    }
}

#pragma mark - NSNotification Responder

- (void)addNoteItem:(NSNotification *)notification
{
    WordEntity* word = (WordEntity*) notification.object;
    _array = [@[word] arrayByAddingObjectsFromArray:_array];
    
    SmartWordListSectionController* sectionController = [[SmartWordListSectionController alloc] initWithViewController:self];
    sectionController.wordID = word.wordID;
    sectionController.sectionID = 0;
    sectionController.type = self.type;
    for(SmartWordListSectionController*  sc in retractableControllers)
    {
        sc.sectionID++;
    }
    [retractableControllers insertObject:sectionController atIndex:0];
    
    //NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
    [self addButtomTexture];
}

- (void)removeNoteItem:(NSNotification *)notification
{
    WordEntity* word = (WordEntity*) notification.object;
    int index = [_array indexOfObject:word];
    if(index == NSNotFound)
        return;
    //NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    NSMutableArray *arr = [_array mutableCopy];
    [arr removeObject:word];
    _array = arr;
    [retractableControllers removeObjectAtIndex:index];
    //[self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
    [self addButtomTexture];
}
@end
