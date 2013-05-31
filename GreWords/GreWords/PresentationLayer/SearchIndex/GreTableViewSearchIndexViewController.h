//
//  GreTableViewSearchIndexViewController.h
//  GreWords
//
//  Created by Song on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GreTableViewSearchIndexDelegate <NSObject>

- (NSArray*)sectionTitles;
- (void)didSelectedIndex:(int)index;

@end

@interface GreTableViewSearchIndexViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UILabel *sampleLabel;

@property (retain,nonatomic) id<GreTableViewSearchIndexDelegate> delegate;

@end
