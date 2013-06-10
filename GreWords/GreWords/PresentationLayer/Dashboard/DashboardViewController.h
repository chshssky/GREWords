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
#import "DashboardProtocal.h"

@interface DashboardViewController : UIViewController <PieChartDelegate, PieChartDataSource>
{
    UIImageView *circleButtomView;
    UIImageView *centerCircleView;
    UIImageView *circleShadowView;
    UIImageView *circleLightView;
    UIImageView *circlePointView;
    UIImageView *FimageView;
}
@property (nonatomic, strong)UIButton *bigButton;
@property (nonatomic, strong)UIImageView *textView;
@property (nonatomic, strong) UIImageView *theNewTextView;
@property (nonatomic, strong)FXLabel *wordNumberTest;

//@property (nonatomic) BOOL complete;

@property(nonatomic) int nonFinishedNumber;
@property(nonatomic) int sumNumber;
@property(nonatomic) int minNumber;

@property (strong, nonatomic) PieChart *pieChartLeft;
@property (retain,nonatomic) id<DashboardProtocal> delegate;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

- (void)wordDetailIndicatorGen;
- (void)changeTextViewToReview;
- (void)changeTextViewToNewWord;
- (void)changeTextViewToComplete;
- (void)changeTextViewToHalfComplete;
- (void)mainViewGen;
- (void)plusData;
- (void)minusData;
- (void)reloadData;
+ (DashboardViewController*)instance;

@end
