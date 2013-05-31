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

- (UITableView*)currentTableView
{
    //return self.tableView;
    return isSearching ? self.searchDisplayController.searchResultsTableView :self.tableView;
}

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
    sectionController.tableView = self.tableView;
    [retractableControllers addObject:sectionController];
    
    [self.tableView reloadData];
    //[self performSelector:@selector(addButtomTexture) withObject:nil afterDelay:0.3];
    [self addButtomTexture:self.tableView];
}


- (void)configureSearchResultTableView
{
    UIImageView *topTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -1136.0f, 320.0f, 1136.0f)];
    topTexture.image = [UIImage imageNamed:@"learning list_up_and_down_moreBg.png"];
    [self.tableView addSubview:topTexture];
    [self.searchDisplayController.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.searchDisplayController.searchResultsTableView setBackgroundColor:[UIColor clearColor]];
    [self.searchDisplayController.searchResultsTableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning list_up_and_down_moreBg.png"]]];
}


- (void)addSearchIndex
{
    searchIndex = [self.storyboard instantiateViewControllerWithIdentifier:@"searchIndex"];
    searchIndex.delegate = self;
    CGRect frame = searchIndex.view.frame;
    frame.origin.x = 320 - frame.size.width - 2;
    frame.origin.y = (self.view.frame.size.height - frame.size.height) / 2;
    //frame.size.height = 490;
    searchIndex.view.frame = frame;
    searchIndex.view.hidden = YES;
    [self.view addSubview:searchIndex.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isDragging = NO;
    isSearching = NO;
    
    retractableControllers = [@[] mutableCopy];
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
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
        sectionController.tableView = self.tableView;
        [retractableControllers addObject:sectionController];
    }
    
    
    [self configureSearchResultTableView];
    
    if(self.type == SmartListType_Note)
    {
        [NSNotificationCenter registerAddNoteForWordNotificationWithSelector:@selector(addNoteItem:) target:self];
        [NSNotificationCenter registerRemoveNoteForWordNotificationWithSelector:@selector(removeNoteItem:) target:self];
    }
    
    if(self.type == SmartListType_Full)
    {
        [self addSearchIndex];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addButtomTexture:(UITableView*)aTableview
{
    UIImageView *downTexture = (UIImageView *)[aTableview viewWithTag:1024];
    float lastTableViewHeight;
    if(!downTexture)
    {
        lastTableViewHeight = self.tableView.contentSize.height;
        
        UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"learning list_line.png"]];
        
        CGRect frame = bottomLine.frame;
        frame.origin.y = -5;
        bottomLine.frame = frame;
        
        downTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, lastTableViewHeight, 320.0f, 1136.0f)];
        
        downTexture.image = [UIImage imageNamed:@"learning list_up_and_down_moreBg.png"];
        [downTexture addSubview:bottomLine];
        downTexture.tag = 1024;
        [aTableview addSubview:downTexture];
        
        
    }
    else
    {
        lastTableViewHeight = 0;
        int sectionCount = [self numberOfSectionsInTableView:aTableview];
        if(sectionCount > 0)
        {
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:[self tableView:self.tableView numberOfRowsInSection:sectionCount - 1] - 1  inSection:sectionCount - 1];
            CGRect lastRect;
            @try {
                lastRect = [aTableview rectForRowAtIndexPath:lastIndex];
            }
            @catch (NSException *exception) {
                downTexture.hidden = YES;
            }
            @finally {
                
            }
            
            lastTableViewHeight = lastRect.origin.y + lastRect.size.height ;
            
            [UIView animateWithDuration:0.3 animations:^()
             {
                 downTexture.frame = CGRectMake(0.0f, lastTableViewHeight, 320.0f, 1136.0f);
             }];
            downTexture.hidden = NO;
        }
        else
        {
            downTexture.hidden = YES;
        }

    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [self addButtomTexture:self.tableView];
}

- (void)viewDidUnload {
    self.tableView = nil;
    [super viewDidUnload];
}


#pragma mark table view delegate


//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    
//    return index % 2;
//}
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    if(self.type == SmartListType_Full)
//    {
//        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
//                 @"H",@"I",@"J",@"K",@"L",@"M",@"N",
//                 @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
//                 @"V",@"W",@"X",@"Y",@"Z",@"#",@" ",
//                 ];
//    }
//    else return nil;
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [_filteredArray count];
    }
	else
	{
        return [_array count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *arr = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        arr = filteredRetractableControllers;
    }
	else
	{
        arr = retractableControllers;
    }
    
    GCRetractableSectionController* sectionController = [arr objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        arr = filteredRetractableControllers;
    }
	else
	{
        arr = retractableControllers;
    }

    GCRetractableSectionController* sectionController = [arr objectAtIndex:indexPath.section];
    return [sectionController heightForRow:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    for(UIView *view in [tableView subviews])
//    {
//        if([[[view class] description] isEqualToString:@"UITableViewIndex"])
//        {
//            //[view performSelector:@selector(setIndexColor:) withObject:[UIColor redColor]];
//            CGRect frame = view.frame;
//            frame.size.height = 160;
//            view.frame = frame;
//            NSLog(@"aaaa %@",[[view class] description]);
//
//        }
//        
//    }
    NSMutableArray *arr = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        arr = filteredRetractableControllers;
    }
	else
	{
        arr = retractableControllers;
    }

    GCRetractableSectionController* sectionController = [arr objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *arr = nil;
    if(self.type == SmartListType_Note)
        return;
        
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        arr = filteredRetractableControllers;
    }
	else
	{
        arr = retractableControllers;
    }
    GCRetractableSectionController* sectionController = [arr objectAtIndex:indexPath.section];
    //[self performSelector:@selector(addButtomTexture) withObject:nil afterDelay:0.3];
    
    if(indexPath.row != 0)
        return;
    
    //BOOL isOpen = sectionController.open;
    
    [sectionController didSelectCellNoScrollAtRow:indexPath.row];
    
    
    [CATransaction begin];
    [tableView beginUpdates];

    for(int i = 0; i < arr.count; i++)
    {
        SmartWordListSectionController* aController = [arr objectAtIndex:i];
        if(i == indexPath.section)
        {
            continue;
        }
        [aController close];
        
    }
    [tableView endUpdates];
    [CATransaction commit];
    
    [sectionController scroll];
    
    if(tableView == self.tableView)
        [self addButtomTexture:tableView];
}

#pragma mark - scroll view delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.tableView == scrollView || scrollView == self.searchDisplayController.searchResultsTableView)
    {
        isDragging = YES;
        _contentOffsetBeforeScroll = scrollView.contentOffset.y;
        [self.scrollDelegate smartWordListWillBeginDragging:self];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    searchIndex.view.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^(){
        searchIndex.view.alpha = 1.0;
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if([searchIndex isTouching])
        return;
    [UIView animateWithDuration:0.2f animations:^()
    {
        searchIndex.view.alpha = 0.0;
    }
                     completion:^(BOOL c)
    {
        searchIndex.view.hidden = YES;
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    isDragging = NO;
}

- (void)scrollViewDidScroll:(UIScrollView*)aScrollView
{
    if(self.tableView == aScrollView || aScrollView == self.searchDisplayController.searchResultsTableView)
        
    {
        CGFloat contentOffsetY = aScrollView.contentOffset.y - _contentOffsetBeforeScroll;
        if(aScrollView.contentSize.height <= aScrollView.frame.size.height || aScrollView.contentOffset.x == 0)
        {
            if(!isDragging)
                return;
        }
        
        [self.scrollDelegate smartWordList:self didTranslationYSinceLast:contentOffsetY];
    }
}


#pragma mark - UISearchDisplayController Delegate Methods

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    isSearching = YES;
    [self configureSearchResultTableView];
    [self performSelector:@selector(removeOverlay) withObject:nil afterDelay:.01f];
    [self.scrollDelegate smartWordListWillStartSearch:self];
}

- (void)removeOverlay
{
//    for(UIView *v in self.view.subviews)
//    {
//        
//    }
    //[[self.view.subviews lastObject] removeFromSuperview];
    UIControl *control = (UIControl *)[self.view.subviews lastObject];
    control.alpha = 0.02f;
    [control setBackgroundColor:[UIColor clearColor]];
    
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    isSearching = NO;
    [self.scrollDelegate smartWordListDidEndSearch:self];
}

- (void) searchBarCancelButtonClicked:(UISearchBar*)searchBar {
    
    //isSearching = NO;
}

- (void)configureNoResultLabel
{
    for (UIView* v in self.searchDisplayController.searchResultsTableView.subviews) {
        if ([v isKindOfClass: [UILabel class]])
        {
            UILabel *label = (UILabel*)v;
            label.textColor = [UIColor colorWithRed:209/255.0 green:134/255.0 blue:39/255.0 alpha:1.0];
            //label.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            //label.shadowOffset = CGSizeMake(0, 1);
            break;
        }
    }
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"searching:%@",searchString);
//    if([searchString isEqualToString:@""])
//    {
//        [self removeOverlay];
//    }
    [self performSelector:@selector(configureNoResultLabel) withObject:nil afterDelay:0.1f];
    //[self configureNoResultLabel];
    [self filterContentForSearchText:searchString];
    
        // Return YES to cause the search result table view to be reloaded.
    return YES;
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
	// Filter the array using NSPredicate
    if(self.type == SmartListType_Homo)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.key  contains[c] %@",searchText];
        self.filteredArray = [[self.array filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    else if(self.type == SmartListType_Note)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.wordText contains[c] %@ or SELF.note contains[c] %@",searchText,searchText];
        self.filteredArray = [[self.array filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    else
    {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.wordText  contains[c] %@",searchText];
        self.filteredArray = [[self.array filteredArrayUsingPredicate:predicate] mutableCopy];
        
        [self.filteredArray sortUsingComparator: ^(id obj1, id obj2) {
            NSString *prefixObj1 = ((WordEntity*)obj1).wordText;
            NSString *prefixObj2 = ((WordEntity*)obj2).wordText;
            NSNumber *r1 = @0;
            NSNumber *r2 = @0;
            if([prefixObj1 hasPrefix:searchText])
            {
                r1 = @1;
            }
            if([prefixObj2 hasPrefix:searchText])
            {
                r2 = @1;
            }
            return [r2 compare:r1];
        }];

    }
    
    
    filteredRetractableControllers = [@[] mutableCopy];
    for(int i = 0; i < _filteredArray.count;i++)
    {
        SmartWordListSectionController* sectionController = [[SmartWordListSectionController alloc] initWithViewController:self];
        if(self.type == SmartListType_Homo)
        {
            sectionController.homotitle = ((NSDictionary*)_filteredArray[i])[@"key"];
            sectionController.homoDict = ((NSDictionary*)_filteredArray[i]);
        }
        else
        {
            sectionController.wordID = ((WordEntity*)_filteredArray[i]).wordID;
        }
        sectionController.sectionID = i;
        sectionController.type = self.type;
        sectionController.tableView = self.searchDisplayController.searchResultsTableView;
        [filteredRetractableControllers addObject:sectionController];
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
    [self addButtomTexture:self.tableView];
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
    [self addButtomTexture:self.tableView];
}


#pragma mark - GreTableViewSearchIndexDelegate


- (NSDictionary*)alphabetInfo
{
    static NSDictionary* info = nil;
    if(info)
        return info;
    NSMutableDictionary *dict = [@{} mutableCopy];
    for(int i = _array.count - 1; i >= 0; i--)
    {
        WordEntity *word = _array[i];
        NSString *firstLetter = [[word.wordText substringToIndex:1] uppercaseString];
        dict[firstLetter] = [NSNumber numberWithInt:i];
    }
    info = dict;
    return info;
}


- (NSArray*)sectionTitles
{
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
             @"H",@"I",@"J",@"K",@"L",@"M",@"N",
             @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
             @"V",@"W",@"X",@"Y",@"Z"
             ];
}

- (void)didSelectedIndex:(int)index
{
    NSDictionary *info = [self alphabetInfo];
    NSNumber *number = info[[self sectionTitles][index]];
    if(!number)
        return;
    int section = [number intValue];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

@end
