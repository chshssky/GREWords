//
//  SettingsContentViewController.h
//  GreWords
//
//  Created by Song on 13-6-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMActionSheet.h"
#import <MessageUI/MessageUI.h> 
#import "SettingClockViewController.h"
#import "OHAttributedLabel.h"
#import "SettingClockViewController.h"

@interface SettingsContentViewController : UIViewController<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate,UIScrollViewDelegate,SettingClockProtocal>

@property (weak, nonatomic) IBOutlet OHAttributedLabel *remindTimeLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *remindTimePageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *remindTimeScrollView;
@property (weak, nonatomic) IBOutlet UIButton *chineseMeaningButton;
@property (weak, nonatomic) IBOutlet UIButton *englishMeaningButton;
@property (weak, nonatomic) IBOutlet UIButton *sentenceButton;
@property (weak, nonatomic) IBOutlet UIButton *homoButton;
@property (weak, nonatomic) IBOutlet UIButton *autoSpeakButton;
@property (weak, nonatomic) IBOutlet UIButton *tellFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *rateMeButton;
@property (weak, nonatomic) IBOutlet UIButton *suggestButton;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *xbyHan;
@property (weak, nonatomic) IBOutlet UIImageView *ltwHan;
@property (weak, nonatomic) IBOutlet UIImageView *sbhHan;
@property (weak, nonatomic) IBOutlet UIImageView *chHan;



-(IBAction)sendSuggestionEmail;
-(IBAction)rateMe;
-(IBAction)tellFriend;

- (IBAction)logout;

- (IBAction)headPressed:(id)sender;

- (IBAction)wordShowingComponentChange:(id)sender;

@end
