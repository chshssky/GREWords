//
//  GreTableViewSearchIndexViewController.m
//  GreWords
//
//  Created by Song on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreTableViewSearchIndexViewController.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER 16

@interface GreTableViewSearchIndexViewController ()
{
    CGRect frame;
    CGFloat averageHeight;
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


- (UILabel*)generateLabel:(NSString*)text
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: self.sampleLabel];
    UILabel* label = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
    label.text = text;
    return label;
}


- (NSArray*)sectionTitles
{
//    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
//                              @"H",@"I",@"J",@"K",@"L",@"M",@"N",
//                              @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
//                              @"V",@"W",@"X",@"Y",@"Z"
//             ];
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
    for(NSString *title in titles)
    {
        UILabel *label = [self generateLabel:title];
        CGRect labelFrame = label.frame;
        labelFrame.origin.y = currentHeight;
        currentHeight += averageHeight;
        labelFrame.size.height = averageHeight;
        label.frame = labelFrame;
        [self.view addSubview:label];
    }
}



- (void)panned:(UIPanGestureRecognizer*)panner
{
    CGPoint curPoint = [panner locationInView:self.view];
    
    if(panner.state == UIGestureRecognizerStateBegan || panner.state == UIGestureRecognizerStateChanged)
    {
        self.backgroundView.hidden = NO;
    }
    else
    {
        self.backgroundView.hidden = YES;
    }
    
    int index = (curPoint.y - CORNER) / averageHeight;
    if(index >= [self sectionTitles].count)
        index = [self sectionTitles].count - 1;
    if(index >= 0)
        [self.delegate didSelectedIndex:index];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundView.layer.cornerRadius = CORNER;
    self.backgroundView.layer.masksToBounds = YES;
    self.backgroundView.hidden = YES;
    [self.sampleLabel removeFromSuperview];
    [self generateLayouts];
    
    UIPanGestureRecognizer *panRecg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.view addGestureRecognizer:panRecg];
    
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
