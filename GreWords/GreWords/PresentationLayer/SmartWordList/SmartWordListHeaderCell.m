//
//  SmartWordListHeaderCell.m
//  GreWords
//
//  Created by Song on 13-4-27.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SmartWordListHeaderCell.h"
#import "WordSpeaker.h"
#import "NSNotificationCenter+Addition.h"
#import "WordHelper.h"

@implementation SmartWordListHeaderCell


- (void)updateNoteIcon:(NSNotification *)notification
{
    WordEntity* word = (WordEntity*) notification.object;
    if(_word != word)
        return;
    if(word.note)
    {
        [self.noteButton setImage:[UIImage imageNamed:@"words list_note.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.noteButton setImage:[UIImage imageNamed:@"words list_no_note.png"] forState:UIControlStateNormal];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [NSNotificationCenter registerAddNoteForWordNotificationWithSelector:@selector(updateNoteIcon:) target:self];
        [NSNotificationCenter registerRemoveNoteForWordNotificationWithSelector:@selector(updateNoteIcon:) target:self];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

-(IBAction)notePressed:(id)sender
{
    NSLog(@"notePressed");
}

@end
