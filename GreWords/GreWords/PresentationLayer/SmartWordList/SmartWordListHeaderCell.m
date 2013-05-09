//
//  SmartWordListHeaderCell.m
//  GreWords
//
//  Created by Song on 13-4-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SmartWordListHeaderCell.h"
#import "WordSpeaker.h"

@implementation SmartWordListHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.wordLabel.contentMode = UIViewContentModeScaleToFill;
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)soundPressed:(id)sender
{
    NSLog(@"soundPressed");
    [[WordSpeaker instance] readWord:self.wordLabel.text];
}

@end
