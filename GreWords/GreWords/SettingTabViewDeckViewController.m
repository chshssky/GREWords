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
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(didPerformPanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(didPerformTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];

    
    
    SettingTabViewController *s1 = [[SettingTabViewController alloc] init];
    CGRect frame = s1.view.frame;
    frame.origin.y = -190;
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
    
    s1.movableHeight = 0;
    frame = s1.view.frame;
    frame.origin.y = -146;
    s1.view.frame = frame;
    
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
    
    tabArr = @[s4,s3,s2,s1];
    [self open:2];
    // Do any additional setup after loading the view from its nib.
}

-(void)open:(int)index
{
    for(int i = 0; i < tabArr.count; i++)
    {
        SettingTabViewController *vc = tabArr[i];
        if(i < index)
        {
            [vc goUp];
        }
        else
        {
            [vc goDown];
        }
    }
}


-(void) didPerformTapGesture:(UIPanGestureRecognizer*) recognizer
{
    for(int i = 0; i < tabArr.count; i++)
    {
        SettingTabViewController *vc = tabArr[i];
        CGPoint location = [recognizer locationInView: self.tabViews];
        //location.y += 25;
        if(CGRectContainsPoint(vc.view.frame,location))
        {
            if([vc state] == SettingTabViewStateDown)
            {
                if(i + 1 < tabArr.count)
                    [self open:i+1];
            }
            else
                [self open:i];
            break;
        }
    }
    {
        NSLog(@"selecting:%d",[self selectedIndex]);
    }

}

-(int)selectedIndex
{
    for(int i = 0; i < tabArr.count - 1; i++)
    {
        SettingTabViewController* vc = tabArr[i];
        if([vc state] == SettingTabViewStateDown)
            return i;
    }
    return tabArr.count - 1;
}


-(void) didPerformPanGesture:(UIPanGestureRecognizer*) recognizer
{
    CGPoint location = [recognizer locationInView: self.tabViews];
    //location.y += 25;
    CGPoint translation = [recognizer translationInView:self.tabViews];
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        for(int i = tabArr.count - 1; i >=0; i--)
        {
            SettingTabViewController* vc = tabArr[i];
            if(CGRectContainsPoint(vc.view.frame,location))
            {
                touchIndex = i;
            }
        }

    }
    //else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        //if(touchIndex == tabArr.count - 1)
        //    return;
        //NSLog(@"holding %d",touchIndex);
        if(translation.y > 0)//go down
        {
            for(int i = touchIndex; i < tabArr.count; i++)
            {
                SettingTabViewController* vc = tabArr[i];
                //if([vc state] == SettingTabViewStateUp)
                {
                    [vc didPerformPanGesture:recognizer];
                }
            }
        }
        else
        {
            for(int i = touchIndex; i >=0; i--)
            {
                SettingTabViewController* vc = tabArr[i];
                //if([vc state] == SettingTabViewStateDown)
                {
                    [vc didPerformPanGesture:recognizer];
                }
            }
            
        }
    }
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"selecting:%d",[self selectedIndex]);
    }
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



- (void)SettingTabViewdidChangeState:(SettingTabViewController*) tabView
{
    
}

- (void)SettingTabView:(SettingTabViewController *)tabView movedTranslation:(CGPoint)translation
{
    
}


@end
