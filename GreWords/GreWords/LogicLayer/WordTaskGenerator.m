//
//  WordTaskGenerator.m
//  GreWords
//
//  Created by xsource on 13-4-10.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordTaskGenerator.h"
#import "WordHelper.h"
#import <math.h>
@interface WordTaskGenerator ()
@property (nonatomic) NSArray *reciteTwolist;
@property (nonatomic) NSArray *reviewTwolist;
@property (nonatomic) NSArray *reciteThreelist;
@property (nonatomic) NSArray *reviewThreelist;
@end

@implementation WordTaskGenerator

WordTaskGenerator* _taskGeneratorInstance = nil;

+ (WordTaskGenerator*)instance
{
    if(!_taskGeneratorInstance)
    {
        _taskGeneratorInstance = [[WordTaskGenerator alloc] init];
    }
    return _taskGeneratorInstance;
}

- (void)setWhetherNoOrder:(bool)flag{
    self.whetherViewNoOrder = flag;
}




- (NSArray *)newWordTask_threeList:(int)day
{
    if (_reciteThreelist != nil && _reciteThreelist.count != 0) {
        return _reciteThreelist;
    }
    
    
    NSMutableArray *task = [[NSMutableArray alloc] init];
    [task removeAllObjects];
    
    if (day > 10) {
        return task;
    }
    
    if (day == 10) {
        for (int k=0; k<2; k++) {
            for (int i=0; i<10; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:0]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=10; i<20; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:10]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=20; i<30; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:20]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=30; i<40; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:30]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=40; i<50; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:40]];
        }
        
        for (int i=0; i<50; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        
        
        //50~72
        for (int k=0; k<2; k++) {
            for (int i=50; i<60; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:50]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=60; i<70; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:60]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=70; i<73; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        
        return task;
    }
    
    for (int listNumber=0; listNumber<3; listNumber++) {
        //0~50
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+0; i<listNumber*100+10; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+0]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+10; i<listNumber*100+20; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+10]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+20; i<listNumber*100+30; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+20]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+30; i<listNumber*100+40; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+30]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+40; i<listNumber*100+50; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+40]];
        }
        
        for (int i=listNumber*100+0; i<listNumber*100+50; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        
        
        //50~100
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+50; i<listNumber*100+60; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+50]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+60; i<listNumber*100+70; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+60]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+70; i<listNumber*100+80; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+70]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+80; i<listNumber*100+90; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+80]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+90; i<listNumber*100+100; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+90]];
        }
        
        for (int i=listNumber*100+50; i<listNumber*100+100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        
        for (int i=listNumber*100+0; i<listNumber*100+100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    for (int i=0; i<task.count; i++) {
        [task replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:day*300+[[task objectAtIndex:i] intValue]]];
    }
    
    _reciteThreelist = task;
    return task;
}

- (NSArray *)newWordTask_twoList:(int)day
{
    if (_reciteTwolist != nil && _reciteTwolist.count != 0) {
        return _reciteTwolist;
    }
    
    NSMutableArray *task = [[NSMutableArray alloc] init];
    [task removeAllObjects];
    
    if (day >15) {
        return task;
    }
    
    if (day == 15) {
        for (int k=0; k<2; k++) {
            for (int i=0; i<10; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:0]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=10; i<20; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:10]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=20; i<30; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:20]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=30; i<40; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:30]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=40; i<50; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:40]];
        }
        
        for (int i=0; i<50; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        
        
        //50~72
        for (int k=0; k<2; k++) {
            for (int i=50; i<60; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:50]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=60; i<70; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:60]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=70; i<73; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        
        return task;
    }
    
    for (int listNumber=0; listNumber<2; listNumber++) {
        //0~50
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+0; i<listNumber*100+10; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+0]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+10; i<listNumber*100+20; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+10]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+20; i<listNumber*100+30; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+20]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+30; i<listNumber*100+40; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+30]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+40; i<listNumber*100+50; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+40]];
        }
        
        for (int i=listNumber*100+0; i<listNumber*100+50; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        
        
        //50~100
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+50; i<listNumber*100+60; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+50]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+60; i<listNumber*100+70; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+60]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+70; i<listNumber*100+80; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+70]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+80; i<listNumber*100+90; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+80]];
        }
        
        for (int k=0; k<2; k++) {
            for (int i=listNumber*100+90; i<listNumber*100+100; i++) {
                [task addObject:[NSNumber numberWithInt:i]];
            }
        }
        if (self.whetherViewNoOrder == YES) {
            [task addObjectsFromArray:[self noOrderListFrom:listNumber*100+90]];
        }
        
        for (int i=listNumber*100+50; i<listNumber*100+100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        
        for (int i=listNumber*100+0; i<listNumber*100+100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    for (int i=0; i<task.count; i++) {
        [task replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:day*200+[[task objectAtIndex:i] intValue]]];
    }
    
    _reciteTwolist = task;
    
    return task;
}

- (NSArray *)noOrderListFrom:(int)startNumber
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i=startNumber+0; i<startNumber+10; i++) {
        [temp addObject:[NSNumber numberWithInt:i]];
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:temp];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    int i;
    int count = temp.count;
    for (i = 0; i < count; i ++) {
        int index = arc4random() % (count - i);
        [resultArray addObject:[tempArray objectAtIndex:index]];
        [tempArray removeObjectAtIndex:index];
    }
    return resultArray;
}

- (NSArray *)reviewTask_threeList:(int)day
{
    if (_reviewThreelist != nil && _reviewThreelist.count != 0) {
        return _reviewThreelist;
    }
    
    NSMutableArray *task = [[NSMutableArray alloc] init];
    
    
    if (day == 0) {
        for (int i=0; i<300; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 1) {
        for (int i=0; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 2) {
        for (int i=300; i<900; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 3) {
        for (int i=0; i<300; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=900; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 4) {
        for (int i=300; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=900; i<1500; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 5) {
        for (int i=600; i<900; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1200; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 6) {
        for (int i=900; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1500; i<2100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 7) {
        for (int i=0; i<300; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1200; i<1500; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1800; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 8) {
        for (int i=300; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1500; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2100; i<2700; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 9) {
        for (int i=600; i<900; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1800; i<2100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2400; i<3000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 10) {
        for (int i=900; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2100; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2800; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 11) {
        for (int i=1200; i<1500; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2400; i<2700; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=3000; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 12) {
        for (int i=1500; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2700; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 13) {
        for (int i=1800; i<2100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=3000; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 14) {
        for (int i=0; i<300; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2100; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 15) {
        for (int i=300; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2400; i<2700; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 16) {
        for (int i=600; i<900; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2700; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 17) {
        for (int i=900; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 18) {
        for (int i=1200; i<1500; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 19) {
        for (int i=1500; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 20) {
        for (int i=1800; i<2100; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 21) {
        for (int i=2100; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 22) {
        for (int i=2400; i<2700; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 23) {
        for (int i=2700; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else{
        //do nothing
    }
    _reviewThreelist = task;
    return task;
}

- (NSArray *)reviewTask_twoList:(int)day
{
    if (_reviewTwolist != nil && _reviewTwolist.count != 0) {
        return _reviewTwolist;
    }
    
    NSMutableArray *task = [[NSMutableArray alloc] init];
    if(day == 0) {
        for (int i=0; i<200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 1) {
        for (int i=0; i<400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 2) {
        for (int i=200; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 3) {
        for (int i=400; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=0; i<200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=600; i<800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 4) {
        for (int i=600; i<800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=200; i<400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=800; i<1000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 5) {
        for (int i=800; i<1000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=400; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1000; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 6) {
        for (int i=1000; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=600; i<800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1200; i<1400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 7) {
        for (int i=1200; i<1400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=800; i<1000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=0; i<200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1400; i<1600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 8) {
        for (int i=1400; i<1600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1000; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=200; i<400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1600; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 9) {
        for (int i=1600; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1200; i<1400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=400; i<700; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1800; i<2000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 10) {
        for (int i=1800; i<2000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1400; i<1600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=600; i<800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2000; i<2200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 11) {
        for (int i=2000; i<2200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1600; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=800; i<1000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2200; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 12) {
        for (int i=2200; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1800; i<2000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1000; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2400; i<2600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 13) {
        for (int i=2400; i<2600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2000; i<2200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1200; i<1400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2600; i<2800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 14) {
        for (int i=2600; i<2800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2200; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1400; i<1600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=0; i<200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2800; i<3000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 15) {
        for (int i=2800; i<3000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2400; i<2600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1600; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=200; i<400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=3000; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 16) {
        for (int i=3000; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2600; i<2800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1800; i<2000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=400; i<600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 17) {
        for (int i=2800; i<3000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2000; i<2200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=600; i<800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 18) {
        for (int i=3000; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=2200; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=800; i<1000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 19) {
        for (int i=2400; i<2600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1000; i<1200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 20) {
        for (int i=2600; i<2800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1200; i<1400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 21) {
        for (int i=2800; i<3000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1400; i<1600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 22) {
        for (int i=3000; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
        for (int i=1600; i<1800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 23) {
        for (int i=1800; i<2000; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 24) {
        for (int i=2000; i<2200; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 25) {
        for (int i=2200; i<2400; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 26) {
        for (int i=2400; i<2600; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 27) {
        for (int i=2600; i<2800; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else if(day == 28) {
        for (int i=2800; i<3072; i++) {
            [task addObject:[NSNumber numberWithInt:i]];
        }
    }else{
        //do nothing
    }
    
    _reviewTwolist = task;
    
    return task;
}

- (NSArray *)testTaskWithOptions:(NSDictionary *)examInfo whetherWithAllWords:(BOOL)allWords
{
    NSMutableArray *task = [[NSMutableArray alloc] init];
    
    NSString *level = [examInfo objectForKey:@"level"];
    
    NSArray *newArray = [[NSMutableArray alloc] initWithArray:[self getRandomArray]];
    
    
    if (allWords == YES) {
        newArray = [self addRandomWordsToArray:newArray];
    }else {
        if (newArray.count < 30) {
            return nil;
        }
    }
    
    if ([level isEqualToString: @"easy"]) {
        for (int i=0; i<ceilf(newArray.count/3); i++) {
            [task addObject:[newArray objectAtIndex:i]];
        }
    }else if ([level isEqualToString:@"medium"]) {
        for (int i=ceilf(newArray.count/3); i<ceilf(newArray.count/3)*2; i++) {
            [task addObject:[newArray objectAtIndex:i]];
        }
    }else if ([level isEqualToString:@"hard"]) {
        for (int i=ceilf(newArray.count/3)*2; i<newArray.count; i++) {
            [task addObject:[newArray objectAtIndex:i]];
        }
    }
    return task;
}

- (NSArray *)randomArrayWithArray:(NSArray *)arr
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:arr];
    int i = [array count];
    while(--i > 0) {
        int j = arc4random() % (i+1);
        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:array];
}

- (NSArray *)getRandomArray
{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSArray *fiveStarArray = [[WordHelper instance] recitedWordsWithRatioOfMistakeFrom:4.0/5.0 to:5.0/5.0];
    NSArray *fourStarArray = [[WordHelper instance] recitedWordsWithRatioOfMistakeFrom:3.0/5.0 to:4.0/5.0];
    NSArray *threeStarArray = [[WordHelper instance] recitedWordsWithRatioOfMistakeFrom:2.0/5.0 to:3.0/5.0];
    NSArray *twoStarArray = [[WordHelper instance] recitedWordsWithRatioOfMistakeFrom:1.0/5.0 to:2.0/5.0];
    NSArray *oneStarArray = [[WordHelper instance] recitedWordsWithRatioOfMistakeFrom:0.0/5.0 to:1.0/5.0];
    NSArray *zeroStarArray = [[WordHelper instance] recitedWordsWithRatioOfMistakeFrom:0.0/5.0 to:0.0/5.0];
    
    if (fiveStarArray.count != 0) {
        fiveStarArray = [self randomArrayWithArray:fiveStarArray];
    }
    if (fourStarArray.count != 0) {
        fourStarArray = [self randomArrayWithArray:fourStarArray];
    }
    if (threeStarArray.count != 0) {
        threeStarArray = [self randomArrayWithArray:threeStarArray];
    }
    if (twoStarArray.count != 0) {
        twoStarArray = [self randomArrayWithArray:twoStarArray];
    }
    if (oneStarArray.count != 0) {
        oneStarArray = [self randomArrayWithArray:oneStarArray];
    }
    if (zeroStarArray.count != 0) {
        zeroStarArray = [self randomArrayWithArray:zeroStarArray];
    }
    
    [newArray addObjectsFromArray:zeroStarArray];
    [newArray addObjectsFromArray:oneStarArray];
    [newArray addObjectsFromArray:twoStarArray];
    [newArray addObjectsFromArray:threeStarArray];
    [newArray addObjectsFromArray:fourStarArray];
    [newArray addObjectsFromArray:fiveStarArray];
    
    return newArray;   
}

- (NSArray *)addRandomWordsToArray:(NSArray *)array
{
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:array];
    
    for (int i=0; i<50; i++) {
        int key = arc4random() % 3073;
        NSString *randomWord = [[WordHelper instance] wordWithID:key].wordText;
        [newArray addObject:randomWord];
    }
    return newArray;
}

- (void)clearTask
{
    _reviewThreelist = nil;
    _reciteThreelist = nil;
    _reviewTwolist = nil;
    _reviewTwolist = nil;
}


@end
