//
//  WordTaskGenerator.m
//  GreWords
//
//  Created by xsource on 13-4-10.
//  Copyright (c) 2013年 Cui Hao. All rights reserved.
//

#import "WordTaskGenerator.h"

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
    return task;
}

- (NSArray *)newWordTask_twoList:(int)day
{
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
    
    return task;
}

- (NSArray *)reviewTask_twoList:(int)day
{
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
    return task;
}

- (NSArray *)testTaskWithOptions:(NSDictionary *)dict
{
    NSArray *task = [[NSArray alloc] init];
    
    return task;
}


@end
