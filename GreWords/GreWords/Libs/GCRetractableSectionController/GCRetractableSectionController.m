//
//  GCRetractableSectionController.m
//  Mtl mobile
//
//  Created by Guillaume Campagna on 09-10-19.
//  Copyright 2009 LittleKiwi. All rights reserved.
//

#import "GCRetractableSectionController.h"
#import "WordSpeaker.h"

@interface GCRetractableSectionController ()

@property (nonatomic, assign) UIViewController *viewController;

- (void) setAccessoryViewOnCell:(UITableViewCell*) cell;

@end

@implementation GCRetractableSectionController

@synthesize useOnlyWhiteImages, titleTextColor, titleAlternativeTextColor;
@synthesize viewController;
@synthesize open, rowAnimation;

#pragma mark -
#pragma mark Initialisation

- (id) initWithViewController:(UIViewController*) givenViewController {
	if ((self = [super init])) {
                
		self.viewController = givenViewController;
		open = NO;
        self.useOnlyWhiteImages = NO;
        self.rowAnimation = UITableViewRowAnimationTop;
	}
	return self;
}

#pragma mark -
#pragma mark Getters


- (NSUInteger) numberOfRow {
    return (self.open) ? self.contentNumberOfRow + 1 : 1;
}

- (NSUInteger) contentNumberOfRow {
	return 0;
}

- (NSString*) title {
	return NSLocalizedString(@"No title",);
}

- (NSString*) titleContentForRow:(NSUInteger) row {
	return NSLocalizedString(@"No title",);
}

#pragma mark -
#pragma mark Cells

- (CGFloat) heightForRow:(NSUInteger)row {
	if (row == 0) return 60;
	else
    {
        UIView *cell = [self cellForRow:row];
        return cell.frame.size.height;
    }
}


- (UITableViewCell *) cellForRow:(NSUInteger)row {
	UITableViewCell* cell = nil;
	
	if (row == 0) cell = [self titleCell];
	else cell = [self contentCellForRow:row - 1];
	
	return cell;
}

- (UITableViewCell *) titleCell {
	NSString* titleCellIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"title"];
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:titleCellIdentifier];
	}
	
	cell.textLabel.text = self.title;
	if (self.contentNumberOfRow != 0) {
		cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%i items",), self.contentNumberOfRow];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        [self setAccessoryViewOnCell:cell];
	}
	else {
		cell.detailTextLabel.text = NSLocalizedString(@"No item",);
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryView = nil;
        cell.textLabel.textColor = [UIColor blackColor];
	}
	
	return cell;
}

- (UITableViewCell *) contentCellForRow:(NSUInteger)row {
	NSString* contentCellIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"content"];
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:contentCellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.textLabel.text = [self titleContentForRow:row];
	
	return cell;
}

- (void) setAccessoryViewOnCell:(UITableViewCell*) cell {
	NSString* path = nil;
	if (self.open) {
		path = @"UpAccessory";
        if (self.titleAlternativeTextColor == nil) cell.textLabel.textColor =  [UIColor colorWithRed:0.191 green:0.264 blue:0.446 alpha:1.000];
        else cell.textLabel.textColor = self.titleAlternativeTextColor;
	}	
	else {
		path = @"DownAccessory";
		cell.textLabel.textColor = (self.titleTextColor == nil ? [UIColor blackColor] : self.titleTextColor);
	}
	
	UIImage* accessoryImage = [UIImage imageNamed:path];
	UIImage* whiteAccessoryImage = [UIImage imageNamed:[[path stringByDeletingPathExtension] stringByAppendingString:@"White"]];
	
	UIImageView* imageView;
	if (cell.accessoryView != nil) {
		imageView = (UIImageView*) cell.accessoryView;
		imageView.image = (self.useOnlyWhiteImages ? whiteAccessoryImage : accessoryImage);
		imageView.highlightedImage = whiteAccessoryImage;
    }
	else {
		imageView = [[UIImageView alloc] initWithImage:(self.useOnlyWhiteImages ? whiteAccessoryImage : accessoryImage)];
		imageView.highlightedImage = whiteAccessoryImage;
		cell.accessoryView = imageView;
	}
}

#pragma mark -
#pragma mark Select Cell

- (void) didSelectCellAtRow:(NSUInteger)row {
	if (row == 0) [self didSelectTitleCell];
	else [self didSelectContentCellAtRow:row - 1];
}

- (void) didSelectCellNoScrollAtRow:(NSUInteger)row {
	if (row == 0) [self didSelectTitleCellNoScroll];
	else [self didSelectContentCellAtRow:row - 1];
}

- (void)close
{
    if([self.tableView numberOfRowsInSection:self.sectionID] == 1)
        return;
    NSIndexPath* indexPathToDelete = [NSIndexPath indexPathForRow:1 inSection:self.sectionID];
        [self.tableView deleteRowsAtIndexPaths:@[indexPathToDelete] withRowAnimation:UITableViewRowAnimationTop ];
    self.open = NO;
}

- (void)didSelectTitleCellNoScroll
{
    open = !open;
    //	if (self.contentNumberOfRow != 0) [self setAccessoryViewOnCell:[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]]];
	
	NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
	NSUInteger section = indexPath.section;
	NSUInteger contentCount = self.contentNumberOfRow;
	
	//[self.tableView beginUpdates];
	
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (self.open) [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:self.rowAnimation];
	else [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:self.rowAnimation];
	
	//[self.tableView endUpdates];

}



- (void) didSelectTitleCell {
    [self didSelectTitleCellNoScroll];
    [self scroll];
}

- (void) scroll {
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
	
	if (self.open) [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) didSelectContentCellAtRow:(NSUInteger)row {}

@end
