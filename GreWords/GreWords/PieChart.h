//
//  PieChart.h
//  circle
//
//  Created by xsource on 13-4-13.
//  Copyright (c) 2013年 xsource. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PieChart;
@protocol PieChartDataSource <NSObject>
@required
- (NSUInteger)numberOfSlicesInPieChart:(PieChart *)pieChart;
- (CGFloat)pieChart:(PieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;
@optional
- (UIColor *)pieChart:(PieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index;
- (NSString *)pieChart:(PieChart *)pieChart textForSliceAtIndex:(NSUInteger)index;
@end

@protocol PieChartDelegate <NSObject>
@optional
- (void)pieChart:(PieChart*)pieChart isDoingAnimationAtPercent:(float)percent;

- (void)pieChart:(PieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(PieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(PieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(PieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index;
@end

@interface PieChart : UIView
@property(nonatomic, weak) id<PieChartDataSource> dataSource;
@property(nonatomic, weak) id<PieChartDelegate> delegate;
@property(nonatomic, assign) CGFloat startPieAngle;
@property(nonatomic, assign) CGFloat animationSpeed;
@property(nonatomic, assign) CGPoint pieCenter;
@property(nonatomic, assign) CGFloat pieRadius;
@property(nonatomic, assign) BOOL    showLabel;
@property(nonatomic, strong) UIFont  *labelFont;
@property(nonatomic, strong) UIColor *labelColor;
@property(nonatomic, strong) UIColor *labelShadowColor;
@property(nonatomic, assign) CGFloat labelRadius;
@property(nonatomic, assign) CGFloat selectedSliceStroke;
@property(nonatomic, assign) CGFloat selectedSliceOffsetRadius;
@property(nonatomic, assign) BOOL    showPercentage;
- (id)initWithFrame:(CGRect)frame Center:(CGPoint)center Radius:(CGFloat)radius;
- (void)reloadData;
- (void)setPieBackgroundColor:(UIColor *)color;

- (void)setSliceSelectedAtIndex:(NSInteger)index;
- (void)setSliceDeselectedAtIndex:(NSInteger)index;

@end;
