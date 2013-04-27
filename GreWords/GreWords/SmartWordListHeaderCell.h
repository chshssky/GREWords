//
//  SmartWordListHeaderCell.h
//  GreWords
//
//  Created by Song on 13-4-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartWordListHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

-(IBAction)soundPressed:(id)sender;

@end
