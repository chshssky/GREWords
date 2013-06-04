//
//  LineChartViewController.h
//  GreWords
//
//  Created by Song on 13-6-2.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMLineGraph.h"


typedef enum
{
    HistoryChartRecite,
    HistoryChartReview
} HistoryChartType;

@interface LineChartViewController : UIViewController<LineGraphDelegate>
{
    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xTitlesArray;
    
    NSDictionary *xProperty;
    NSDictionary *yProperty;
    
    NSDictionary *horizontalLinesProperties;
    NSDictionary *verticalLinesProperties;
    
    MIMLineGraph *mLineGraph;

}
@property (strong, nonatomic) IBOutlet UIView *chartContainer;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundVIew;

@property (nonatomic) HistoryChartType type;

@end
