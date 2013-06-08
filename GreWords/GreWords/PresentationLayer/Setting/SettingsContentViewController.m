//
//  SettingsContentViewController.m
//  GreWords
//
//  Created by Song on 13-6-7.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "SettingsContentViewController.h"
#import <MessageUI/MessageUI.h> 
#import "SocialShareModal.h"
#import "UIDevice+IdentifierAddition.h"
#import "ConfigurationHelper.h"


#define RECOMMAND_TEXT @"小崔崔~~~"

@interface SettingsContentViewController ()

@end

@implementation SettingsContentViewController

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
    [self configVersionLabel];
    [self initWordShowingComponentIndicatorState];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRemindTimeLabel:nil];
    [self setRemindTimePageControl:nil];
    [self setRemindTimeScrollView:nil];
    [self setChineseMeaningButton:nil];
    [self setEnglishMeaningButton:nil];
    [self setSentenceButton:nil];
    [self setHomoButton:nil];
    [self setAutoSpeakButton:nil];
    [self setTellFriendButton:nil];
    [self setRateMeButton:nil];
    [self setSuggestButton:nil];
    [self setVersionLabel:nil];
    [super viewDidUnload];
}


#pragma mark Helper methods


- (void)initWordShowingComponentIndicatorState
{
    [self configButton:self.chineseMeaningButton toBoolState:[ConfigurationHelper instance].chineseMeaningVisibility];
    [self configButton:self.englishMeaningButton toBoolState:[ConfigurationHelper instance].englishMeaningVisibility];
    [self configButton:self.homoButton toBoolState:[ConfigurationHelper instance].homoionymVisibility];
    [self configButton:self.sentenceButton toBoolState:[ConfigurationHelper instance].sampleSentenceVisibility];
    [self configButton:self.autoSpeakButton toBoolState:[ConfigurationHelper instance].autoSpeak];
}


- (void)configButton:(UIButton*)button toBoolState:(BOOL)state
{
    NSString *filename = state ?@"Settings_swithButton_yes" :@"Settings_swithButton_no.png";
    [button setImage:[UIImage imageNamed:filename] forState:UIControlStateNormal];
}

- (void)configVersionLabel
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"v%@",appVersion];
}


#pragma mark - Word Showing Component Methods
- (IBAction)wordShowingComponentChange:(id)sender
{
    if(sender == self.chineseMeaningButton)
    {
        [ConfigurationHelper instance].chineseMeaningVisibility = ! [ConfigurationHelper instance].chineseMeaningVisibility;
    }
    else if(sender == self.englishMeaningButton)
    {
        [ConfigurationHelper instance].englishMeaningVisibility = ! [ConfigurationHelper instance].englishMeaningVisibility;
    }
    else if(sender == self.sentenceButton)
    {
        [ConfigurationHelper instance].sampleSentenceVisibility = ! [ConfigurationHelper instance].sampleSentenceVisibility;
    }
    else if(sender == self.autoSpeakButton)
    {
        [ConfigurationHelper instance].autoSpeak = ! [ConfigurationHelper instance].autoSpeak;
    }
    else if(sender == self.homoButton)
    {
        [ConfigurationHelper instance].homoionymVisibility = ! [ConfigurationHelper instance].homoionymVisibility;
    }
    [self initWordShowingComponentIndicatorState];
}

#pragma mark - About Methods
-(IBAction)sendSuggestionEmail
{
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"未设置邮件帐户", nil)
                                                        message:NSLocalizedString(@"可以在Mail中添加您的邮件帐户", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"好的", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        MFMailComposeViewController* picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        picker.modalPresentationStyle = UIModalPresentationPageSheet;
        
        
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        
        // Get the users Device Model, Display Name, Unique ID, Token & Version Number
        UIDevice *dev = [UIDevice currentDevice];
        NSString *deviceModel = [dev platformString];
        
        NSString *deviceSystemVersion = dev.systemVersion;
        
        
        
        NSString *subject = [NSString stringWithFormat:@"<好G友> v%@ 用户反馈",appVersion];
        
        NSString *receiver = [NSString stringWithFormat:@"haoGyou@gmail.com"];
        [picker setToRecipients:[NSArray arrayWithObject:receiver]];
        
        [picker setSubject:subject];
        NSString *emailBody = [NSString stringWithFormat:@"设备描述：\n   型号： %@\n   版本： %@\n\n您的宝贵意见：\n\n",deviceModel,deviceSystemVersion];
        [picker setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:picker animated:YES];
        //        [[[UIApplication sharedApplication] delegate].window.rootViewController presentModalViewController:picker animated:YES];
    }
    
}

-(IBAction)rateMe
{
#warning CHANGE THE　App Code Here!!!!
    NSString* appid = [NSString stringWithFormat:@"599472349"];
    
    NSString* url = [NSString stringWithFormat:  @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", appid];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    
}


-(IBAction)tellFriend
{
        CMActionSheet *actionSheet = [[CMActionSheet alloc] init];
        //actionSheet.title = @"Test Action sheet";
        
        // Customize
        [actionSheet addButtonWithTitle:@"短信分享" type:CMActionSheetButtonTypeWhite block:^{
            [self shareByMessage];
        }];
        [actionSheet addButtonWithTitle:@"邮件分享" type:CMActionSheetButtonTypeWhite block:^{
            [self shareByMail];
        }];
        if([SocialShareModal socialShareAvailable])
        {
            [actionSheet addButtonWithTitle:@"微博分享" type:CMActionSheetButtonTypeWhite block:^{
                [self shareByWeibo];
            }];
        }
        //    [actionSheet addButtonWithTitle:@"更多" type:CMActionSheetButtonTypeWhite block:^{
        //        [self shareByMore];
        //    }];
        [actionSheet addSeparator];
        [actionSheet addButtonWithTitle:@"取消" type:CMActionSheetButtonTypeGray block:^{
            NSLog(@"Dismiss action sheet with \"Close Button\"");
        }];
        
        // Present
        [actionSheet present];
}

//- (IBAction)wordShowingComponentChange:(id)sender {
//    
//}

#pragma mark - Share methods
- (void)shareByWeibo
{
    SocialShareModal *socialModal = [[SocialShareModal alloc] init];
    socialModal.targetViewController = self;
    socialModal.postText = RECOMMAND_TEXT;
    
    //UIImage *image = [UIImage imageNamed:@"ads.png"];
    //socialModal.postImageList = @[image];
    [socialModal sendWeiboMessage];
}

- (void)shareByMessage
{
    if (![MFMessageComposeViewController canSendText]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"无法发送信息", nil)
                                                        message:NSLocalizedString(@"可以在信息中添加您的帐户", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        MFMessageComposeViewController* picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        
        NSString *body = [NSString stringWithFormat:RECOMMAND_TEXT];
        [picker setBody:body];
        [self presentModalViewController:picker animated:YES];
    }
}

- (void)shareByMail
{
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"未设置邮件帐户", nil)
                                                        message:NSLocalizedString(@"可以在Mail中添加您的邮件帐户", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"好", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        MFMailComposeViewController* picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        picker.modalPresentationStyle = UIModalPresentationPageSheet;
        NSString *subject = [NSString stringWithFormat:@"推荐你使用<好G友>"];
        [picker setSubject:subject];
        
        //        NSString *infoSouceFile = [[NSBundle mainBundle] pathForResource:@"recommand_email" ofType:@"html"];
        NSString *infoText = RECOMMAND_TEXT;//[[NSString alloc] initWithContentsOfFile:infoSouceFile encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"Content: %@",infoText);
        [picker setMessageBody:infoText isHTML:NO];
        [self presentModalViewController:picker animated:YES];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    NSString *message = nil;
    switch (result)
    {
        case MFMailComposeResultCancelled: {
            //            message = NSLocalizedString(@"发送取消", nil);
            [self dismissModalViewControllerAnimated:YES];
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
            //                                                                message:nil
            //                                                               delegate:nil
            //                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
            //                                                      otherButtonTitles:nil];
            //            [alertView show];
            break;
        }
        case MFMailComposeResultSaved: {
            //            message = NSLocalizedString(@"保存成功", nil);
            [self dismissModalViewControllerAnimated:YES];
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
            //                                                                message:nil
            //                                                               delegate:nil
            //                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
            //                                                      otherButtonTitles:nil];
            //            [alertView show];
            break;
        }
        case MFMailComposeResultSent: {
            //            message = NSLocalizedString(@"发送成功", nil);
            ////            [((RKTabBarController*)[[UIApplication sharedApplication] delegate].window.rootViewController) dismissModalViewControllerAnimated:YES];
            [self dismissModalViewControllerAnimated:YES];
            //
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
            //                                                                message:NSLocalizedString(@"感谢您的使用！", nil)
            //                                                               delegate:nil
            //                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
            //                                                      otherButtonTitles:nil];
            //            [alertView show];
            break;
        }
        case MFMailComposeResultFailed: {
            message = NSLocalizedString(@"发送失败", nil);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil];
            [alertView show];
            break;
        }
        default: {
            return;
        }
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    NSString *message = nil;
    switch (result)
    {
        case MessageComposeResultCancelled: {
            //            message = NSLocalizedString(@"您已取消发送", nil);
            [self dismissModalViewControllerAnimated:YES];
            //
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
            //                                                                message:nil
            //                                                               delegate:nil
            //                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
            //                                                      otherButtonTitles:nil];
            //            [alertView show];
            break;
        }
        case MessageComposeResultSent: {
            //            message = NSLocalizedString(@"发送成功", nil);
            [self dismissModalViewControllerAnimated:YES];
            //
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
            //                                                                message:NSLocalizedString(@"感谢您的使用", nil)
            //                                                               delegate:nil
            //                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
            //                                                      otherButtonTitles:nil];
            //            [alertView show];
            break;
        }
        case MessageComposeResultFailed: {
            message = NSLocalizedString(@"发送失败", nil);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil];
            [alertView show];
            break;
        }
        default: {
            return;
        }
    }
}


@end
