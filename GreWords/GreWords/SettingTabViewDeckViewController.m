//
//  SettingTabViewDeckViewController.m
//  GreWords
//
//  Created by Song on 13-5-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SettingTabViewDeckViewController.h"
#import "SettingTabViewController.h"

@interface SettingTabViewDeckViewController ()

@end

@implementation SettingTabViewDeckViewController

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
    
    SettingTabViewController *s1 = [[SettingTabViewController alloc] init];
    CGRect frame = s1.view.frame;
    frame.origin.y = -150;
    s1.view.frame = frame;
    s1.describeImage.image = [UIImage imageNamed:@"Settings_dataCover.png"];
    SettingTabViewController *s2 = [[SettingTabViewController alloc] init];
    frame.origin.y -= 35;
    s2.view.frame = frame;
    s2.describeImage.image = [UIImage imageNamed:@"Settings_viewCover.png"];
    SettingTabViewController *s3 = [[SettingTabViewController alloc] init];
    frame.origin.y -= 35;
    s3.view.frame = frame;
    s3.describeImage.image = [UIImage imageNamed:@"Settings_reviewCover.png"];
    SettingTabViewController *s4 = [[SettingTabViewController alloc] init];
    frame.origin.y -= 35;
    s4.view.frame = frame;
    s4.describeImage.image = [UIImage imageNamed:@"Settings_taskCover.png"];
    
    s1.originalFrame = s1.view.frame;
    s2.originalFrame = s2.view.frame;
    s3.originalFrame = s3.view.frame;
    s4.originalFrame = s4.view.frame;
    
    s1.delegate = self;
    s2.delegate = self;
    s3.delegate = self;
    s4.delegate = self;

    [self.tabViews addSubview:s1.view];
    [self.tabViews addSubview:s2.view];
    [self.tabViews addSubview:s3.view];
    [self.tabViews addSubview:s4.view];
    
    tabArr = @[s1,s2,s3,s4];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTabViews:nil];
    [super viewDidUnload];
}

- (NSArray*) controllerCardBelowCard:(SettingTabViewController*) tabView {
    NSInteger index = [tabArr indexOfObject: tabView];
    
    return [tabArr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(SettingTabViewController* controllerCard, NSDictionary *bindings) {
        NSInteger currentIndex = [tabArr indexOfObject:controllerCard];
        
        //Only return cards with an index greater than the one being compared to
        return index > currentIndex;
    }]];
}

- (void)SettingTabViewdidChangeState:(SettingTabViewController*) tabView
{
    NSLog(@"tab changed state");
}

- (void)SettingTabView:(SettingTabViewController *)tabView movedTranslation:(CGPoint)translation
{
    NSArray* below = [self controllerCardBelowCard:tabView];
    for(SettingTabViewController* vc in below)
    {
        vc.yOffset = translation.y;
    }
}


@end
