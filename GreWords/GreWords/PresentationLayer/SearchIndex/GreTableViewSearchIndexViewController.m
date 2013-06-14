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
    NSMutableArray *selectedViewArr;
    
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


- (int)numberOfTiles
{
    if([self useCustomViews])
    {
        return [self.delegate numberOfTiles];
    }
    else return [self.delegate sectionTitles].count;
}

- (NSArray*)sectionTitles
{
    return [self.delegate sectionTitles];
}


- (BOOL)useCustomViews
{
    if([self.delegate respondsToSelector:@selector(useCustomView)])
    {
        return [self.delegate useCustomView];
    }
    return NO;
}

- (void)generateLayouts
{
    NSArray *titles = [self sectionTitles];
    if([self numberOfTiles] == 0)
        return;
    frame = self.view.frame;
    averageHeight = (frame.size.height - CORNER)/ ([self numberOfTiles] + 1);
    CGFloat currentHeight = CORNER;
    labelArr = [@[] mutableCopy];
    
    if([self useCustomViews])
    {
        selectedViewArr = [@[] mutableCopy];
        int count = [self.delegate numberOfTiles];
        for(int i = 0; i < count; i++)
        {
            UIView *unv = [self.delegate unselectedCellViewAtIndex:i];
            UIView *sv = [self.delegate selectedCellViewAtIndex:i];
            [selectedViewArr addObject:sv];
            [labelArr addObject:unv];
            CGRect labelFrame = unv.frame;
            labelFrame.origin.y = currentHeight;
            labelFrame.origin.x = 3;
            currentHeight += averageHeight;
            //labelFrame.size.height = averageHeight;
            unv.frame = labelFrame;
            sv.frame = labelFrame;
            [self.view addSubview:unv];
        }
        CGRect vframe = self.view.frame;
        vframe.size.height = currentHeight - averageHeight + CORNER + [[labelArr lastObject] frame].size.height;
        self.view.frame = vframe;
    }
    else
    {
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
        if([self useCustomViews])
        {
            if (index == i) {
                UIView *v = selectedViewArr[i];
                if(v.superview == nil)
                {
                    [labelArr[i] removeFromSuperview];
                    [self.view addSubview:v];
                }
            }
            else
            {
                UIView *v = labelArr[i];
                if(v.superview == nil)
                {
                    [selectedViewArr[i] removeFromSuperview];
                    [self.view addSubview:v];
                }
            }
        }
        else
        {
            UIColor *color = YES ? [UIColor colorWithR:248 G:246 B:244] : [UIColor colorWithR:162 G:152 B:145];
            if(index == i)
            {
                color = YES ? [UIColor colorWithR:255 G:144 B:0] : [UIColor colorWithR:210 G:157 B:88];
            }
            UILabel *label = labelArr[i];
            [label setTextColor:color];
        }
    }
}


- (void)panned:(UIPanGestureRecognizer*)panner
{
    CGPoint curPoint = [panner locationInView:self.view];
    
    if(panner.state == UIGestureRecognizerStateBegan)
    {
        [self setBackgroundPressed:YES];
        [self.delegate startTouch];
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
        [self.delegate endTouch];
        indicator.view.hidden = YES;
        pressing = NO;
        [UIView animateWithDuration:0.2 animations:^(){
            self.view.alpha = 0.0;
        }];
    }
    
    int index = (curPoint.y - CORNER) / averageHeight;
    if(index >= [self numberOfTiles])
        index = [self numberOfTiles] - 1;
    if(curPoint.y < 0)
        index = 0;
    if(index >= 0)
    {
        [self setTileColorAtIndex:index];
        [self.delegate didSelectedIndex:index];
    }
    
    if([self useCustomViews])
    {
        indicator.indicatorLabel.text = [NSString stringWithFormat:@"%d星词",5-index];
    }
    else
    {
        indicator.indicatorLabel.text = [self sectionTitles][index];
    }
    UIView *label = labelArr[index];
    CGRect indicatorFrame = indicator.view.frame;
    indicatorFrame.origin.y = label.frame.origin.y - 26;
    indicator.view.frame = indicatorFrame;
}


- (void)initIndicator
{
    indicator = [self.storyboard instantiateViewControllerWithIdentifier:@"searchIndexIndicator"];
    CGRect indicatorFrame = indicator.view.frame;
    if([self useCustomViews])
    {
        UIImageView *v;
        UIImage *image = [UIImage imageNamed:@"words list_scrollBar_rectangle.png"];
        v = [[UIImageView alloc] initWithImage:image];
        indicatorFrame.size.width = v.frame.size.width;
        indicatorFrame.size.height = v.frame.size.height;
        indicator.backgroundImage.frame = v.frame;
        indicator.backgroundImage.image = image;
    }
    
    
    indicatorFrame.origin.x = -indicatorFrame.size.width - 40;
    indicator.view.frame = indicatorFrame;
    [self.view addSubview:indicator.view];
    indicator.view.hidden = YES;
}


- (void)initBackgroundViews
{
    CGRect vframe = self.backgroundView.frame;
    vframe.size.height = self.view.frame.size.height;
    self.backgroundView.frame = vframe;
    self.backroundViewPressed.frame = vframe;
    
    self.backroundViewPressed.image = [[UIImage imageNamed:@"words list_scrollBar_Pressdown.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10 , 0)];
    self.backroundViewPressed.alpha = 0;
    self.backgroundView.image = [[UIImage imageNamed:@"words list_scrollBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10 , 0)];
}

- (void)setBackgroundPressed:(BOOL)pressed
{
    if(pressed)
    {
        [UIView animateWithDuration:0.2f animations:^()
        {
            self.backgroundView.alpha = 0;
            self.backroundViewPressed.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2f animations:^()
         {
             self.backgroundView.alpha = 1;
             self.backroundViewPressed.alpha = 0;
         }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.sampleLabel removeFromSuperview];
    [self generateLayouts];
    
    UIPanGestureRecognizer *panRecg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    panRecg.delegate = self;
    [self.view addGestureRecognizer:panRecg];
    
    [self initIndicator];
    
    [self initBackgroundViews];
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
    [self setBackroundViewPressed:nil];
    [super viewDidUnload];
}


@end
