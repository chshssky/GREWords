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
    
    
    yValuesArray=[[NSArray alloc]initWithObjects:@"90",@"100",@"200",@"300",@"300",@"150",@"100",@"90",@"300",@"330",@"300",@"90",nil];
    
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
    
    CGRect rect = self.view.frame;
    CGRect rect2 = self.view.frame;
    //rect2.origin.x += -50;
    rect2.size.width += 50;
    rect2.size.height += 50;
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor redColor];
    view.alpha = 0.2;
    
    mLineGraph = [[MIMLineGraph alloc]initWithFrame:rect2];
    mLineGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE], nil];
    
    mLineGraph.delegate=self;
    
    mLineGraph.maxValue = 330;
    mLineGraph.minimumValue = 90;
    
    [mLineGraph drawMIMLineGraph];

    
    [self.view addSubview:view];
    [self.view addSubview:mLineGraph];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
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
