/*!
 * \file MHTabBarController.m
 *
 * Copyright (c) 2011 Matthijs Hollemans
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "MHTabBarController.h"

static const float TAB_BAR_HEIGHT = 44.0f;
static const NSInteger TAG_OFFSET = 1000;

@implementation MHTabBarController
{
	UIView *tabButtonsContainerView;
	UIImageView *indicatorImageView;
}

- (void)centerIndicatorOnButton:(UIButton *)button
{
	CGRect rect = indicatorImageView.frame;
	rect.origin.x = button.center.x - floorf(indicatorImageView.frame.size.width/2.0f);
	rect.origin.y = TAB_BAR_HEIGHT - indicatorImageView.frame.size.height;
	indicatorImageView.frame = rect;
	indicatorImageView.hidden = NO;
}

- (void)selectTabButton:(UIButton *)button
{
	[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

	UIImage *image = [[UIImage imageNamed:@"MHTabBarActiveTab.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setBackgroundImage:image forState:UIControlStateHighlighted];
	
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.5f] forState:UIControlStateNormal];
}

- (void)deselectTabButton:(UIButton *)button
{
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

	UIImage *image = [[UIImage imageNamed:@"MHTabBarInactiveTab.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setBackgroundImage:image forState:UIControlStateHighlighted];

	[button setTitleColor:[UIColor colorWithRed:175/255.0f green:85/255.0f blue:58/255.0f alpha:1.0f] forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)removeTabButtons
{
	NSArray *buttons = [tabButtonsContainerView subviews];
	for (UIButton *button in buttons)
		[button removeFromSuperview];
}

- (void)addTabButtons
{
	NSUInteger index = 0;
	for (NSString *title in self.viewControllerTitles)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = TAG_OFFSET + index;
		[button setTitle:title forState:UIControlStateNormal];
		[button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchDown];
		button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
		button.titleLabel.shadowOffset = CGSizeMake(0, 1);
		[self deselectTabButton:button];
        if(index == 0)
            [self selectTabButton:button];
		[tabButtonsContainerView addSubview:button];

		++index;
	}
    NSLog(@"%@",tabButtonsContainerView.subviews);
}

- (void)reloadTabButtons
{
	[self removeTabButtons];
	[self addTabButtons];

	// Force redraw of the previously active tab.
	_selectedIndex = 0;
	self.selectedIndex = 0;
}

- (void)setViewControllerTitles:(NSArray *)viewControllerTitles
{
    _viewControllerTitles = viewControllerTitles;
    [self reloadTabButtons];
}

- (void)layoutTabButtons
{
	NSUInteger index = 0;
	NSUInteger count = [self.viewControllerTitles count];

	CGRect rect = CGRectMake(0, 0, floorf(self.view.bounds.size.width / count), TAB_BAR_HEIGHT);

	//indicatorImageView.hidden = YES;

	NSArray *buttons = [tabButtonsContainerView subviews];
	for (UIButton *button in buttons)
	{
		if (index == count - 1)
			rect.size.width = self.view.bounds.size.width - rect.origin.x;

		button.frame = rect;
		rect.origin.x += rect.size.width;

		if (index == self.selectedIndex)
			[self centerIndicatorOnButton:button];

		++index;
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];

    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, TAB_BAR_HEIGHT);
	tabButtonsContainerView = [[UIView alloc] initWithFrame:rect];
	tabButtonsContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:tabButtonsContainerView];

	indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MHTabBarIndicator.png"]];
	[self.view addSubview:indicatorImageView];

    _selectedIndex = 0;
    
	[self reloadTabButtons];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	tabButtonsContainerView = nil;
	indicatorImageView = nil;
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	[self layoutTabButtons];
}


- (void)setViewControllers:(NSArray *)newViewControllers
{
	NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");

	if ([self isViewLoaded])
		[self reloadTabButtons];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
	[self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
    if(newSelectedIndex == _selectedIndex)
        return;
    
    if (_selectedIndex != NSNotFound)
    {
        UIButton *fromButton = (UIButton *)[tabButtonsContainerView viewWithTag:TAG_OFFSET + _selectedIndex];
        [self deselectTabButton:fromButton];
        NSLog(@"frome %@",fromButton);
    }
    
    UIButton *toButton;
    if (_selectedIndex != NSNotFound)
    {
        toButton = (UIButton *)[tabButtonsContainerView viewWithTag:TAG_OFFSET + newSelectedIndex];
        [self selectTabButton:toButton];
    }
    _selectedIndex = newSelectedIndex;
    NSLog(@"to %@",toButton);

    if (animated)
    {
        tabButtonsContainerView.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.3 animations:^()
         {
             [self centerIndicatorOnButton:toButton];
         }
                         completion:^(BOOL finished)
         {
             tabButtonsContainerView.userInteractionEnabled = YES;
             
         }];
    }
    else  // not animated
    {
        [self centerIndicatorOnButton:toButton];
    }

    [self.delegate mh_tabBarController:self didSelectIndex:newSelectedIndex];
}

- (void)tabButtonPressed:(UIButton *)sender
{
	[self setSelectedIndex:sender.tag - TAG_OFFSET animated:YES];
}

@end
