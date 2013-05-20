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

@protocol DashboardProtocal <NSObject>

-(void)bigButtonPressed;

@end

@interface DashboardViewController : UIViewController <PieChartDelegate, PieChartDataSource>
{
    UIImageView *circleButtomView;
    UIImageView *centerCircleView;
    UIImageView *circleShadowView;
    UIImageView *circleLightView;
    UIImageView *circlePointView;
    FXLabel *wordNumberTest;
    UIImageView *FimageView;
    UIImageView *startTextView;
    UIImageView *textView;
}
@property(nonatomic) int nonFinishedNumber;
@property(nonatomic) int sumNumber;
@property(nonatomic) int minNumber;

@property (strong, nonatomic) PieChart *pieChartLeft;
@property (retain,nonatomic) id<DashboardProtocal> delegate;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

- (void)wordDetailIndicatorGen;
- (void)mainViewGen;

- (void)minusData;
+ (DashboardViewController*)instance;

@end
