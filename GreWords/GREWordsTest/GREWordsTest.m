//
//  GREWordsTest.m
//  GREWordsTest
//
//  Created by Song on 13-6-26.
//  Copyright (c) 2013年 TAC. All rights reserved.
//

#import "GREWordsTest.h"
#import "WordTaskGenerator.h"
#import "WordHelper.h"

@implementation GREWordsTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    WordTaskGenerator *f = [[WordTaskGenerator alloc] init];
    NSArray * arr = [f newWordTask_twoList:2];
    STFail(@"Unit tests are not implemented yet in GREWordsTest");
}

@end
