//
//  ViewController.h
//  circle
//
//  Created by xsource on 13-4-11.
//  Copyright (c) 2013年 xsource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChart.h"
#import "FXLabel.h"



@interface DashboardViewController : UIViewController <PieChartDelegate, PieChartDataSource>
{
    UIImageView *slideBarView;
    UIImageView *slideBarStatusView;
    UIImageView *circleButtomView;
    UIImageView *centerCircleView;
    UIImageView *circleShadowView;
    UIImageView *circleLightView;
    UIImageView *circlePointView;
    UIImageView *slideBarStatusTextView;
    
    UIImageView *textView;
    UIImageView *startTextView;
    FXLabel *wordNumberTest;
}

@property(nonatomic) int nonFinishedNumber;
@property(nonatomic) int sumNumber;

@property (strong, nonatomic) PieChart *pieChartLeft;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
@end
