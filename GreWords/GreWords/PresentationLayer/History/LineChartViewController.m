//
//  LineChartViewController.m
//  GreWords
//
//  Created by Song on 13-6-2.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "LineChartViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
//    horizontalLinesProperties=[[NSDictionary alloc] initWithObjectsAndKeys:@"hide",@YES, nil];
//    verticalLinesProperties=[[NSDictionary alloc] initWithObjectsAndKeys:@"hide",@YES, nil];    
    
    
    //yValuesArray=[[NSArray alloc]initWithObjects:@"90",@"100",@"200",@"300",@"300",@"150",@"100",@"90",@"300",@"330",@"300",@"90",nil];
    
    yValuesArray=[[NSArray alloc]initWithObjects:@"20",@"100",@"30",@"50",@"30",@"40",@"100",@"90",@"20",@"33",@"30",@"90",nil];
    
    xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
    xTitlesArray=[[NSArray alloc]initWithObjects:@"12月12",
                  @"12月12",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
    [self initBackground];

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
    CGRect rect = self.chartContainer.frame;
    rect.origin.x = -50;
    rect.origin.y = 0;
    rect.size.width += 50;
    rect.size.height += 71;
    if(!iPhone5)
    {
        rect.size.height += 9;
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
            mLineGraph.scaleY = 1.0;
        }
    }
    else
    {
        mLineGraph.maxValue = 100;
        mLineGraph.minimumValue = 20;
        if(iPhone5)
        {
            mLineGraph.scaleY = 4.1;
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
