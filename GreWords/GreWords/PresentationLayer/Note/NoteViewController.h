//
//  NoteViewController.h
//  GreWords
//
//  Created by xsource on 13-5-26.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController
-(void)addNoteAt:(UIViewController *)buttomController withWordID:(int)wordID;
-(void)removeNote;
@end
