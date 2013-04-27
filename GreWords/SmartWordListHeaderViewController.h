//
//  SmartWordListHeaderViewController.h
//  GreWords
//
//  Created by Song on 13-4-11.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartWordListHeaderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@property (nonatomic,retain) NSString* text;
@end
