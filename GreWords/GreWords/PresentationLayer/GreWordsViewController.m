//
//  GreWordsViewController.m
//  GreWords
//
//  Created by 崔 昊 on 13-3-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "GreWordsViewController.h"
#import "WordLayoutViewController.h"
#import "WordHelper.h"
#import "SmartWordListViewController.h"
#import "AwesomeMenu.h"
#import "HistoryStatisticsViewController.h"
#import "SettingsViewController.h"
#import "ExamViewController.h"
#import "NewWordDetailViewController.h"
#import "WordDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WholeSmartWordViewController.h"
#import "WordTaskGenerator.h"
#import "NewWordEvent.h"
#import "ReviewEvent.h"
#import "ExamEvent.h"
#import "HistoryManager.h"
#import "ConfigurationHelper.h"
#import "GuideImageFactory.h"
#import "TaskStatus.h"
#import "TestSelectorViewController.h"
#import "NSNotificationCenter+Addition.h"
#import "GuideSettingViewController.h"
#import "NSDate-Utilities.h"
#import "Flurry.h"

@interface GreWordsViewController ()<NewWordDetailViewControllerProtocol, WordDetailViewControllerProtocol>

@property (nonatomic, strong) UIImageView *slideBarView;
@property (nonatomic, strong) UIImageView *slideBarStatusView;
@property (nonatomic, strong) UIImageView *slideBarStatusTextView;
@property (nonatomic, strong) TestSelectorViewController *testSelectorController;
@property (nonatomic, strong) AwesomeMenu *menu;


@property (weak, nonatomic) IBOutlet UIImageView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (nonatomic, strong) NewWordEvent *nwEvent;
@property (nonatomic, strong) ReviewEvent *rEvent;
@property (nonatomic, strong) NSTimer *clockTimer;


@end

@implementation GreWordsViewController

- (void)initDashboard
{
    dashboard = [DashboardViewController instance];
    // Database: read from
    if ([TaskStatus instance].taskType == TASK_TYPE_REVIEW) {
        dashboard.nonFinishedNumber = [TaskStatus instance].rEvent.newWordCount - [TaskStatus instance].rEvent.indexOfWordToday;
        dashboard.sumNumber = [TaskStatus instance].rEvent.newWordCount;

        [dashboard changeTextViewToReview];
    } else {
        dashboard.nonFinishedNumber = [TaskStatus instance].nwEvent.newWordCount - [TaskStatus instance].nwEvent.maxWordID % 200;
        dashboard.sumNumber = [TaskStatus instance].nwEvent.newWordCount;

        [dashboard changeTextViewToNewWord];
    }
    dashboard.minNumber = dashboard.nonFinishedNumber;
    dashboard.delegate = self;
    [self.view addSubview:dashboard.view];
    [dashboard reloadData];

}

- (void)initslideBar
{
    self.slideBarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar.png"]];
    self.slideBarView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+190);
    self.slideBarView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.slideBarView.gestureRecognizers = self.view.gestureRecognizers;
    [self.view addSubview:self.slideBarView];
    
    
    //slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus1.png"]];
    self.slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus2.png"]];
    //slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus3.png"]];
    //slideBarStatusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideStatus4.png"]];
    
    self.slideBarStatusView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3+190);
    self.slideBarStatusView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.slideBarStatusView.gestureRecognizers = self.view.gestureRecognizers;
    //slideBarStatusView.alpha = 0.5;
    [self.view addSubview:self.slideBarStatusView];
    
    //slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text1.png"]];
    self.slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text2.png"]];
    //slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text3.png"]];
    //slideBarStatusTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Main menu_slideBar_text4.png"]];
    self.slideBarStatusTextView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3 + 215);
    self.slideBarStatusTextView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.slideBarStatusTextView.gestureRecognizers = self.view.gestureRecognizers;
    //slideBarStatusView.alpha = 0.5;
    [self.view addSubview:self.slideBarStatusTextView];
}

- (void)initAwesomeMenu
{ 
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xSettingButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xSettingButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xTestButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xTestButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xHistoryButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xHistoryButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Main menu_xListButton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"Main menu_xListButton_clicked.png"]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
    
    self.menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds menus:menus];
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"Main menu_xButton.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"Main menu_xButton_clicked.png"];
    
	// customize menu
    self.menu.image = storyMenuItemImage;
    self.menu.highlightedImage = storyMenuItemImagePressed;
    self.menu.contentImage = nil;
    self.menu.highlightedContentImage = nil;
    self.menu.rotateAngle = -0.1;
    self.menu.menuWholeAngle = M_PI / 2 + M_PI / 4;
    self.menu.timeOffset = 0.015f;
    self.menu.farRadius = 95.0f;
    self.menu.endRadius = 80.0f;
    self.menu.nearRadius = 70.0f;
    
    self.menu.startPoint = CGPointMake(40.0, self.view.bounds.size.height - 40.0);
    
	
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
    
    //[self.view makeKeyAndVisible];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[ConfigurationHelper instance] reSchedule];
    
    // 从数据库中读取现在的状态
    //初始化TaskStatus状态

    [[HistoryManager instance] readStatusIfNew];

    
    [self initDashboard];
    [self initslideBar];
    [self initAwesomeMenu];
    [self startAlertCounting];
        
    _whetherAllowViewFrameChanged = NO;
    
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_Dashboard])
    {
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_Dashboard];
        [self.view addSubview:guideImageView];
    }
    
    [NSNotificationCenter registerStartExamNotificationWithSelector:@selector(startExam:) target:self];
    
    // just for  test:
//    int x = [[HistoryManager instance] currentStage];
//    NSLog(@"stage:%d", x);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nowStatus) name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(void)dealloc
{
//    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewDidUnload {
    [self setTitleView:nil];
    [self setBackgroundImage:nil];
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"WIEW　ＷＩＬＬ　Ａｐｐaｅｒ!!!!!!!");
    
    
    
    [self nowStatus];
    
    
}





- (void)nowStatus
{
    NSDate *now = [self getNowDate];
    
    NSDate *newWordTime = [now nowdateWithHour:[[ConfigurationHelper instance].freshWordAlertTime hour] AndMinute:[[ConfigurationHelper instance].freshWordAlertTime minute]];
    
    NSLog(@"Hour : %d And Minute: %d", [[ConfigurationHelper instance].freshWordAlertTime hour], [[ConfigurationHelper instance].freshWordAlertTime minute]);
    //newWordTime = [newWordTime dateByAddingDays:1];
    
    
    NSLog(@"NowAlertTime: %@", newWordTime);
    
    
    NSDate *reviewTime = [now nowdateWithHour:[[ConfigurationHelper instance].reviewAlertTime hour] AndMinute:[[ConfigurationHelper instance].reviewAlertTime minute]];       //[now dateByAddingTimeInterval:60.0];
    
    NSLog(@"Hour : %d And Minute: %d", [[ConfigurationHelper instance].freshWordAlertTime hour], [[ConfigurationHelper instance].freshWordAlertTime minute]);
    
    
    NSLog(@"ReviewAlertTime: %@", reviewTime);
    if ([[TaskStatus instance] isReviewComplete] == YES) {
        [[DashboardViewController instance] changeTextViewToComplete];
        
        if ([[now laterDate:newWordTime] isEqualToDate:now]) {
            [self beginNewWordEvent];
        }
    } else if ([[TaskStatus instance] isNewWordComplete] == YES) {
        [[DashboardViewController instance] changeTextViewToHalfComplete];
        
        if ([[now laterDate:reviewTime] isEqualToDate:now]) {
            [self beginReviewEvent];
        }
    }
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.whetherAllowViewFrameChanged)
    {
        self.view.autoresizesSubviews = YES;
        
        self.view.transform = CGAffineTransformMakeScale(0.95f, 0.95f);
        
        [UIView animateWithDuration:0.5f animations:^{
            self.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
        }];
        
        self.whetherAllowViewFrameChanged = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - menu items

- (void)transaction
{
    UIImageView *blackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [blackView setBackgroundColor:[UIColor blackColor]];
    blackView.alpha = 0;
    [self.view addSubview:blackView];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)];
    scaleAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:scaleAnim, nil];
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup.duration = 0.5;
    [self.view.layer addAnimation:animGroup forKey:nil];
    
    CABasicAnimation *opacityAnim_black = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim_black.fromValue = [NSNumber numberWithFloat:0];
    opacityAnim_black.toValue = [NSNumber numberWithFloat:0.7];
    opacityAnim_black.removedOnCompletion = YES;
    CAAnimationGroup *animGroup_black = [CAAnimationGroup animation];
    animGroup_black.animations = [NSArray arrayWithObjects:opacityAnim_black, nil];
    animGroup_black.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup_black.duration = 0.5;
    [blackView.layer addAnimation:animGroup_black forKey:nil];
}

- (void)listController
{
    [self transaction];
    
    WholeSmartWordViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"zncb"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];

}

- (void)examController
{
    if (_testSelectorController == nil) {
        _testSelectorController = [[TestSelectorViewController alloc] init];
        
        //_note.delegate = self;
    }
    
    
    [_testSelectorController addTestSelectorAt:self];
    [_testSelectorController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_testSelectorController.view];
    
    if(![[ConfigurationHelper instance] guideForTypeHasShown:GuideType_Exam])
    {
        guideImageView = [[GuideImageFactory instance] guideViewForType:GuideType_Exam];
        [self.view addSubview:guideImageView];
    }
    [Flurry logEvent:@"selectExam"];
}

- (void)startExam:(NSNotification *)notification
{
    NSDictionary* examInfo = (NSDictionary*) notification.object;    
    NSArray *arr = [[WordTaskGenerator instance] testTaskWithOptions:examInfo whetherWithAllWords:NO];


    if (arr == nil) {
        //  SHOW NO WORD FOR TEST
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"求Button text API" message:[NSString stringWithFormat:@"您学习的词数太少了，请多学一些"] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
//        [alert setAlertViewStyle:UIAlertViewStyleDefault];
//        
//        [alert show];

        [_testSelectorController ChangeButtonTextWith:@"已学单词太少"];
    } else {
        [self transaction];
        if (_testSelectorController != nil) {
            [_testSelectorController.view removeFromSuperview];
            _testSelectorController = nil;
        }

        ExamViewController *vc = [[ExamViewController alloc] init];
        vc.examInfo = examInfo;
        vc.examArr = arr;
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:vc animated:YES];
     }
}

- (void)historyController
{
    [self transaction];
    
    HistoryStatisticsViewController *vc = [[HistoryStatisticsViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];

}

- (void)settingController
{
    [self transaction];
    
    SettingsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"setting"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:vc animated:YES];
}

#pragma mark - AwesomeMenu Response Delegate

- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    if (idx == 0) {
        [self performSelector:@selector(settingController) withObject:nil afterDelay:0.1];
    } else if (idx == 1) {
        [self performSelector:@selector(examController) withObject:nil afterDelay:0.1];
    } else if (idx == 2) {
        [self performSelector:@selector(historyController) withObject:nil afterDelay:0.1];
    } else if (idx == 3) {
        [self performSelector:@selector(listController) withObject:nil afterDelay:0.1];
    }
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    //NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    //NSLog(@"Menu is open!");
}

#pragma mark - DashBoardDelegate
-(void)bigButtonPressed
{
    [UIView animateWithDuration:0.5f animations:^{
        self.titleView.transform = CGAffineTransformMakeTranslation(-150, -100);
        self.slideBarView.transform = CGAffineTransformMakeTranslation(-300, 0);
        self.slideBarStatusTextView.transform = CGAffineTransformMakeTranslation(-300, 0);
        self.slideBarStatusView.transform = CGAffineTransformMakeTranslation(-300, 0);
        self.backgroundImage.alpha = 0;
        dashboard.textView.alpha = 0;
        dashboard.bigButton.alpha = 0;
        //dashboard.wordNumberTest.transform = CGAffineTransformMakeTranslation(0, 0);
        if (iPhone5) {
            dashboard.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.2f, 0.2f), CGAffineTransformMakeTranslation(-128, -252));
        } else {
            dashboard.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.2f, 0.2f), CGAffineTransformMakeTranslation(-128, -212));
        }
        self.menu.transform = CGAffineTransformMakeTranslation(-300, 0);
    } completion:^(BOOL finished) {
        
        
        if ([[TaskStatus instance] isReviewComplete] == YES) {
            
        } else if ([[TaskStatus instance] isNewWordComplete] == YES) {
            
        }
        
        
        
        if ([TaskStatus instance].taskType == TASK_TYPE_REVIEW) {
#warning read from Database
            [[HistoryManager instance] readStatusIfNew];
            WordDetailViewController *vc = [[WordDetailViewController alloc] init];
            vc.delegate = self;
            [self presentViewController:vc animated:NO completion:nil];
            
        } else {
            [[HistoryManager instance] readStatusIfNew];
        //根据MaxWordID和现在所在单词的ID 来判断 该跳转到 NewWord 还是 Review
        if ([[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:[TaskStatus instance].nwEvent.indexOfWordToday ] integerValue] < [TaskStatus instance].nwEvent.maxWordID || [TaskStatus instance].nwEvent.reviewEnable) {
            
            [TaskStatus instance].nwEvent.reviewEnable = NO;
            WordDetailViewController *vc = [[WordDetailViewController alloc] init];
            vc.delegate = self;
            [self presentViewController:vc animated:NO completion:nil];

        } else {
            if ([[HistoryManager instance] readStatusIfNew])
            {
                [self beginNewWordEvent];
            }
                    
            NewWordDetailViewController *vc = [[NewWordDetailViewController alloc] init];
            if ([TaskStatus instance].nwEvent.maxWordID > 3069) {
                vc.changePage =  4 - ([TaskStatus instance].nwEvent.maxWordID % 3);
                if (vc.changePage == 4) {
                    vc.changePage = 1;
                }
                
            } else {
                vc.changePage = 10 - ([TaskStatus instance].nwEvent.maxWordID % 10);
            }
            vc.delegate = self;
            vc.beginWordID = [TaskStatus instance].nwEvent.indexOfWordToday;
        
            SmartWordListViewController *leftController = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
            leftController.type = SmartListType_Slide;
            
            NSMutableArray *wordsArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < [TaskStatus instance].nwEvent.maxWordID; i++) {
                WordEntity *addWord = [[WordHelper instance] wordWithID:i];
                
                [wordsArr addObject:addWord];
            }
            leftController.array = wordsArr;


            IIViewDeckController* deckController =  [[IIViewDeckController alloc]
                                                 initWithCenterViewController:vc
                                                leftViewController:leftController
                                                rightViewController:nil];
        
            [self presentViewController:deckController animated:NO completion:nil];
        }
        }
    }];
}

- (NSDate *)getNowDate
{
//    NSTimeZone *zone = [NSTimeZone defaultTimeZone];//获得当前应用程序默认的时区
//    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];//以秒为单位返回当前应用程序与世界标准时间（格林威尼时间）的时差
////    NSDate *localeDate = [[NSDate date] dateByAddingTimeInterval:interval];
//    NSDate *nowDate=[NSDate dateWithTimeIntervalSinceNow:interval];
    NSDate *nowDate = [NSDate new];
    return nowDate;
}

- (void)resetIndexOfWordList:(int)remainWords
{
    if ([TaskStatus instance].taskType == TASK_TYPE_NEWWORD) {
        int theWordID = [TaskStatus instance].nwEvent.newWordCount - remainWords + 200 * [TaskStatus instance].nwEvent.dayOfSchedule;
        for (int index = 0; index < [[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] count]; index++) {
            
            
            if (theWordID == [[[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] objectAtIndex:index] intValue])
            {
                [TaskStatus instance].nwEvent.indexOfWordToday = index;
                [TaskStatus instance].nwEvent.maxWordID = theWordID;
                
                [[HistoryManager instance] updateEvent:[TaskStatus instance].nwEvent];
                
                return;
            }
        }
    } else {
        int index = [TaskStatus instance].rEvent.newWordCount - remainWords;
        
        [TaskStatus instance].rEvent.indexOfWordToday = index;
        
        [[HistoryManager instance] updateEvent:[TaskStatus instance].rEvent];
        
        return;

        
        
    }

}

#pragma mark - WordDetailDelegate

- (void)AnimationBack
{
    dashboard = [DashboardViewController instance];
    dashboard.delegate = self;
    [self.view insertSubview:dashboard.view atIndex:2];
    [dashboard mainViewGen];
        
    dashboard.textView.alpha = 0.0f;
    dashboard.bigButton.alpha = 0.0f;
    [UIView animateWithDuration:0.5f animations:^{
        self.titleView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(0, 0));
        self.slideBarView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(0, 0));
        self.slideBarStatusTextView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(0, 0));
        self.slideBarStatusView.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(0, 0));
        dashboard.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0f,1.0f), CGAffineTransformMakeTranslation(0, 0));
        self.menu.transform = CGAffineTransformMakeTranslation(0, 0);
        self.backgroundImage.alpha = 1.0f;
        if ([[TaskStatus instance] isReviewComplete] == NO && [[TaskStatus instance] isNewWordComplete] == NO) {
            dashboard.textView.alpha = 1.0f;
            dashboard.bigButton.alpha = 1.0f;
        }

        //dashboard.wordNumberTest.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)GoToReviewWithWord
{
    WordDetailViewController *vc = [[WordDetailViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:NO completion:nil];
    
}

- (void)GoToNewWord
{
    [self performSelectorOnMainThread:@selector(GotoNewWordSelector) withObject:nil waitUntilDone:NO];
}

- (void)GotoNewWordSelector
{
    NewWordDetailViewController *vc = [[NewWordDetailViewController alloc] init];

    vc.delegate = self;
    if ([TaskStatus instance].nwEvent.maxWordID == 3069) {
        vc.changePage = 3;
    } else {
        vc.changePage = 10;
    }
    vc.beginWordID = [TaskStatus instance].nwEvent.indexOfWordToday;
    
    [dashboard minusData];
    
    SmartWordListViewController *leftController = [self.storyboard instantiateViewControllerWithIdentifier:@"SmartWordList"];
    leftController.type = SmartListType_Slide;
    NSMutableArray *wordsArr = [[NSMutableArray alloc] init];
    for (int i = 0; i <= [TaskStatus instance].nwEvent.maxWordID; i++) {
        WordEntity *addWord = [[WordHelper instance] wordWithID:i];
        
        [wordsArr addObject:addWord];
    }
    leftController.array = wordsArr;

    
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:vc
                                                                                    leftViewController:leftController
                                                                                   rightViewController:nil];
    [self presentViewController:deckController animated:NO completion:nil];
}


#pragma mark - Event Methods

- (void)beginReviewEvent
{
    [self createReviewEvent];
    
    
    dashboard = [DashboardViewController instance];
    dashboard.nonFinishedNumber = [TaskStatus instance].rEvent.newWordCount - [TaskStatus instance].rEvent.indexOfWordToday;
    
    dashboard.minNumber = dashboard.nonFinishedNumber;
    dashboard.sumNumber = [TaskStatus instance].rEvent.newWordCount;
    [dashboard changeTextViewToReview];
    
    [dashboard reloadData];
}

- (void)createReviewEvent
{
    
    [[TaskStatus instance] beginReview];
    
    HistoryManager *historyManager = [HistoryManager instance];
    [historyManager addEvent:[TaskStatus instance].rEvent];
}



- (void)beginNewWordEvent
{
    [[WordTaskGenerator instance] clearTask];
        
    [[TaskStatus instance] beginNewWord];

    if ([[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] == nil || [[[WordTaskGenerator instance] newWordTask_twoList:[TaskStatus instance].nwEvent.dayOfSchedule] count] <= 0) {
        [self beginReviewEvent];
        return;
    }
    
    [self createNewWordEvent];

    
#warning  this may can be easier ~

    dashboard.nonFinishedNumber = [TaskStatus instance].nwEvent.newWordCount;
    dashboard.minNumber = dashboard.nonFinishedNumber;
    dashboard.sumNumber = [TaskStatus instance].nwEvent.newWordCount;
    
    [dashboard changeTextViewToNewWord];
    
    [dashboard reloadData];

}

- (void)createNewWordEvent
{
    HistoryManager *historyManager = [HistoryManager instance];
    [historyManager addEvent:[TaskStatus instance].nwEvent];
    
}


#pragma mark - time alert Methods
- (void)startAlertCounting
{
    [_clockTimer invalidate];
    
    _clockTimer = [NSTimer scheduledTimerWithTimeInterval: 60
                                                  target: self
                                                selector: @selector(tick)
                                                userInfo: nil
                                                 repeats: YES];
    [_clockTimer fire];
}

- (void)tick
{
    [self nowStatus];
}



@end
