//
//  SmartWordListHeaderCell.h
//  GreWords
//
//  Created by Song on 13-4-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordEntity.h"

@interface SmartWordListHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upShadow;
@property (weak, nonatomic) IBOutlet UIImageView *downShadow;

@property (weak, nonatomic) IBOutlet UIButton *noteButton;
@property (strong, nonatomic) WordEntity *word;

-(IBAction)soundPressed:(id)sender;

-(IBAction)notePressed:(id)sender;


@end
