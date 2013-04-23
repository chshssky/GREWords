//
//  ViewController.h
//  circle
//
//  Created by xsource on 13-4-11.
//  Copyright (c) 2013年 xsource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChart.h"



@interface DashboardViewController : UIViewController <PieChartDelegate, PieChartDataSource>
{
    UIImageView *shadowImageView;
    UIImageView *centerCircleView;
    UIImageView *circleLightView;
    float tempPercent;
}

@property(nonatomic) int nonFinishedNumber;
@property(nonatomic) int sumNumber;

@property (strong, nonatomic) PieChart *pieChartLeft;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
@end
