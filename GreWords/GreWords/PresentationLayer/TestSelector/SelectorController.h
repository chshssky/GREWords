//
//  SelectorController.h
//  GreWords
//
//  Created by xsource on 13-5-31.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SelectorController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *beginTestLabel;

- (void)ChangeTestOfBeginTestLabelWith:(NSString *)text;

@end
