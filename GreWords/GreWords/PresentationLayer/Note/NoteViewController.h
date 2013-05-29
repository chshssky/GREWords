//
//  NoteViewController.h
//  GreWords
//
//  Created by xsource on 13-5-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NoteViewControllerProtocol <NSObject>
- (void)whenNoteAppeared;
- (void)whenNoteDismissed;
@end

@interface NoteViewController : UIViewController
-(void)addNoteAt:(UIViewController *)buttomController withWordID:(int)wordID;
-(void)removeNote;
@property (strong, nonatomic) id<NoteViewControllerProtocol> delegate;
@end
