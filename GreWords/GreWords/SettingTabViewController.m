//
//  SettingTabViewController.m
//  GreWords
//
//  Created by Song on 13-5-5.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SettingTabViewController.h"

@interface SettingTabViewController ()

@end

@implementation SettingTabViewController

- (id)init
{
    self = [super initWithNibName:nil  bundle:nil];
    if (self) {
        // Custom initialization
                
        _originalFrame =  self.view.frame;
        state = SettingTabViewStateUp;
        self.movableHeight = 50;
    }
    return self;
}


-(void) didPerformTapGesture:(UIPanGestureRecognizer*) recognizer
{
    //NSLog(@"TapTapTap");
    CGRect frame = _originalFrame;
   

    if(state == SettingTabViewStateDown)
    {
        state = SettingTabViewStateUp;
        frame.origin.y = _originalFrame.origin.y;
    }
    else
    {
         state = SettingTabViewStateDown;
         frame.origin.y = _originalFrame.origin.y + self.movableHeight;
    }
    frame.origin.y += _yOffset;
    [UIView animateWithDuration:0.2 animations:^()
     {
         self.view.frame = frame;
    }];
    [self.delegate SettingTabViewdidChangeState:self];

}

-(void)setYOffset:(float)yOffset
{
    CGRect frame = self.view.frame;
    frame.origin.y += _yOffset;
    self.view.frame = frame;
}

-(void)goDown
{
    CGRect frame = _originalFrame;
    frame.origin.y += _yOffset + self.movableHeight;
    [UIView animateWithDuration:0.2 animations:^()
     {
         self.view.frame = frame;
     }];
    state = SettingTabViewStateDown;
}

-(void)goUp
{
    CGRect frame = _originalFrame;
    frame.origin.y += _yOffset;
    [UIView animateWithDuration:0.2 animations:^()
     {
         self.view.frame = frame;
     }];
    state = SettingTabViewStateUp;
}

-(SettingTabViewState)state
{
    return state;
}

-(void) didPerformPanGesture:(UIPanGestureRecognizer*) recognizer
{
    //NSLog(@"Pan Pan Pan");
//    CGPoint location = [recognizer locationInView: self.view];
    CGPoint translation = [recognizer translationInView: self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        lastTranslate = translation;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        float originalY = self.view.frame.origin.y;
        CGRect frame = _originalFrame;
        float overHeight = 0;
        if(frame.origin.y + translation.y + (state == SettingTabViewStateUp ? 0 : self.movableHeight) > _originalFrame.origin.y + self.movableHeight)
        {
            overHeight = frame.origin.y + translation.y + (state == SettingTabViewStateUp ? 0 : self.movableHeight) - (_originalFrame.origin.y + self.movableHeight);
        }
        else if(frame.origin.y + translation.y + (state == SettingTabViewStateUp ? 0 : self.movableHeight) < _originalFrame.origin.y)
        {
            overHeight = frame.origin.y + translation.y + (state == SettingTabViewStateUp ? 0 : self.movableHeight) - (_originalFrame.origin.y + self.movableHeight);
        }
        
        if(overHeight == 0)
        {
            frame.origin.y += translation.y + (state == SettingTabViewStateUp ? 0 : self.movableHeight);
        }
        else
        {
            frame.origin.y = _originalFrame.origin.y + (overHeight > 0 ? self.movableHeight : 0) + overHeight * 0.03;
        }
//        if(frame.origin.y < _originalFrame.origin.y)
//            frame.origin.y = _originalFrame.origin.y;
        frame.origin.y += _yOffset;
        self.view.frame = frame;
        
        
        [self.delegate SettingTabView:self movedTranslation:CGPointMake(0, self.view.frame.origin.y - self.originalFrame.origin.y)];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect frame = _originalFrame;
        if(translation.y >= self.movableHeight / 2.0)
        {
            frame.origin.y += self.movableHeight;
            state = SettingTabViewStateDown;
            [self.delegate SettingTabViewdidChangeState:self];
        }
        else
        {
            frame.origin.y = _originalFrame.origin.y;
            state = SettingTabViewStateUp;
            [self.delegate SettingTabViewdidChangeState:self];
        }
        frame.origin.y += _yOffset;
        [UIView animateWithDuration:0.2 animations:^()
        {
            self.view.frame = frame;            
        }];
        
    }

    
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDescribeImage:nil];
    [super viewDidUnload];
}
@end
