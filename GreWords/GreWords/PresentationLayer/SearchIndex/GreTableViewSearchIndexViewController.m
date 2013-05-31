//
//  GreTableViewSearchIndexViewController.m
//  GreWords
//
//  Created by Song on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreTableViewSearchIndexViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+RGB.h"
#define CORNER 12

@interface GreTableViewSearchIndexViewController ()
{
    CGRect frame;
    CGFloat averageHeight;
    NSMutableArray *labelArr;
    BOOL pressing;
}

@end

@implementation GreTableViewSearchIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (BOOL)isTouching
{
    return pressing;
}

- (UILabel*)generateLabel:(NSString*)text
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: self.sampleLabel];
    UILabel* label = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
    label.text = text;
    return label;
}


- (NSArray*)sectionTitles
{
    return [self.delegate sectionTitles];
}


- (void)generateLayouts
{
    NSArray *titles = [self sectionTitles];
    if([titles count] == 0)
        return;
    frame = self.view.frame;
    averageHeight = (frame.size.height - CORNER)/ (titles.count + 1);
    CGFloat currentHeight = CORNER;
    labelArr = [@[] mutableCopy];
    for(NSString *title in titles)
    {
        UILabel *label = [self generateLabel:title];
        CGRect labelFrame = label.frame;
        labelFrame.origin.y = currentHeight;
        currentHeight += averageHeight;
        labelFrame.size.height = averageHeight;
        label.frame = labelFrame;
        [self.view addSubview:label];
        [labelArr addObject:label];
    }
    [self setTileColorAtIndex: -1];
}


- (void)setCurrentIndex:(int)index
{
    [self setTileColorAtIndex:index];
}

- (void)setTileColorAtIndex:(int)index
{
    for(int i = 0; i < labelArr.count; i++)
    {
        UIColor *color = pressing ? [UIColor colorWithR:248 G:246 B:244] : [UIColor colorWithR:162 G:152 B:145];
        if(index == i)
        {
            color = pressing ? [UIColor colorWithR:255 G:144 B:0] : [UIColor colorWithR:210 G:157 B:88];
        }
        UILabel *label = labelArr[i];
        [label setTextColor:color];
    }
}


- (void)panned:(UIPanGestureRecognizer*)panner
{
    CGPoint curPoint = [panner locationInView:self.view];
    
    if(panner.state == UIGestureRecognizerStateBegan)
    {
        [self setBackgroundPressed:YES];
        indicator.view.hidden = NO;
        pressing = YES;
    }
    else if(panner.state == UIGestureRecognizerStateChanged)
    {
        
    }
    else
    {
        [self setBackgroundPressed:NO];
        [self setTileColorAtIndex:-1];
        indicator.view.hidden = YES;
        pressing = NO;
        [UIView animateWithDuration:0.2 animations:^(){
            self.view.alpha = 0.0;
        }];
    }
    
    int index = (curPoint.y - CORNER) / averageHeight;
    if(index >= [self sectionTitles].count)
        index = [self sectionTitles].count - 1;
    if(index >= 0)
    {
        [self setTileColorAtIndex:index];
        [self.delegate didSelectedIndex:index];
    }
    if(curPoint.y < 0)
        index = 0;
    indicator.indicatorLabel.text = [self sectionTitles][index];
    UILabel *label = labelArr[index];
    CGRect indicatorFrame = indicator.view.frame;
    indicatorFrame.origin.y = label.frame.origin.y - 26;
    indicator.view.frame = indicatorFrame;
}


- (void)initIndicator
{
    indicator = [self.storyboard instantiateViewControllerWithIdentifier:@"searchIndexIndicator"];
    CGRect indicatorFrame = indicator.view.frame;
    indicatorFrame.origin.x = -90;
    indicator.view.frame = indicatorFrame;
    [self.view addSubview:indicator.view];
    indicator.view.hidden = YES;
}


- (void)setBackgroundPressed:(BOOL)pressed
{
    if(pressed)
    {
        self.backgroundView.image = [[UIImage imageNamed:@"words list_scrollBar_Pressdown.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10 , 0)];
    }
    else
    {
        self.backgroundView.image = [[UIImage imageNamed:@"words list_scrollBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10 , 0)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.sampleLabel removeFromSuperview];
    [self generateLayouts];
    
    UIPanGestureRecognizer *panRecg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.view addGestureRecognizer:panRecg];
    
    [self initIndicator];
    
    [self setBackgroundPressed:NO];
    pressing = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBackgroundView:nil];
    [self setSampleLabel:nil];
    [super viewDidUnload];
}
@end
