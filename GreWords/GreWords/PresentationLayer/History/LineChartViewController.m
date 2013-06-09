//
//  LineChartViewController.m
//  GreWords
//
//  Created by Song on 13-6-2.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "LineChartViewController.h"
#import "BaseEvent.h"
#import "NSDate-Utilities.h"

@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initData
{
    NSMutableArray *yArr = [@[] mutableCopy];
    NSMutableArray *xArr = [@[] mutableCopy];
    for(BaseEvent *aEvent in self.data)
    {
        NSTimeInterval durtaion = aEvent.duration;
        int value = durtaion / 60.0;
        if(self.type == HistoryChartRecite)
        {
            if(value < 90) value = 90;
            if(value > 330) value = 330;
        }
        else if(self.type == HistoryChartReview)
        {
            if(value < 20) value = 20;
            if(iPhone5)
            {
                if(value > 100) value = 100;
            }
            else
            {
                if(value > 110) value = 110;
            }
        }
        NSDate *date = aEvent.startTime;
        NSString *str = [NSString stringWithFormat:@"%d",value];
        [yArr addObject:str];
        [xArr addObject:[NSString stringWithFormat:@"%d/%d",[date month],[date day]]];
        
    }
    yValuesArray = yArr;
    xValuesArray = xTitlesArray= xArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBackground];

    [self initData];
}


-(void)initBackground
{
    if(!iPhone5 && self.type == HistoryChartRecite)
    {
        self.backgroundVIew.image = [UIImage imageNamed:@"history recite_cardBottom_mini.png"];
    }
    else if(iPhone5 && self.type == HistoryChartRecite)
    {
        self.backgroundVIew.image = [UIImage imageNamed:@"history recite_cardBottom.png"];
    }
    else if(iPhone5 && self.type == HistoryChartReview)
    {
        self.backgroundVIew.image = [UIImage imageNamed:@"history review_cardBottom.png"];
    }
    else if(!iPhone5 && self.type == HistoryChartReview)
    {
        self.backgroundVIew.image = [UIImage imageNamed:@"history review_cardBottom_mini.png"];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    if (!iPhone5) {
        CGRect frame = self.view.frame;
        frame.size.height = 337;
        self.view.frame = frame;
    }
    
    
    if(self.data == nil || self.data.count == 0)
        return;
        
    
    CGRect rect = self.chartContainer.frame;
    rect.origin.x = -50;
    rect.origin.y = 0;
    rect.size.width += 50;
    rect.size.height += 71;
    if(!iPhone5)
    {
        rect.size.height -= 5;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor redColor];
    view.alpha = 0.2;

    
    mLineGraph = [[MIMLineGraph alloc]initWithFrame:rect];
    mLineGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE], nil];
    
    mLineGraph.delegate=self;
    
    if(self.type == HistoryChartRecite)
    {
        mLineGraph.maxValue = 330;
        mLineGraph.minimumValue = 90;
        if(iPhone5)
        {
            mLineGraph.scaleY = 1.4;
        }
        else
        {
            mLineGraph.scaleY = 1.00;
        }
    }
    else
    {
        mLineGraph.maxValue = 100;
        mLineGraph.minimumValue = 20;
        if(iPhone5)
        {
            mLineGraph.scaleY = 4.15;
        }
        else
        {
            mLineGraph.maxValue = 110;
            mLineGraph.scaleY = 2.7;
        }
    }
    
    
    [mLineGraph drawMIMLineGraph];
    
    //[self.chartContainer addSubview:view];
    [self.chartContainer addSubview:mLineGraph];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setChartContainer:nil];
    [self setBackgroundVIew:nil];
    [super viewDidUnload];
}


#pragma mark - wall graph delegate
-(NSArray *)valuesForGraph:(id)graph
{
    return yValuesArray;
}

-(NSArray *)valuesForXAxis:(id)graph
{
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
    
    return xTitlesArray;
}


-(NSDictionary *)xAxisProperties:(id)graph
{
    return xProperty;
}
-(NSDictionary *)yAxisProperties:(id)graph
{
    return yProperty;
}

-(NSDictionary *)horizontalLinesProperties:(id)graph
{
    return horizontalLinesProperties;
    
}

-(NSDictionary*)verticalLinesProperties:(id)graph
{
    return verticalLinesProperties;
}

@end
