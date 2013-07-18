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
#import "ConfigurationHelper.h"
@interface GREWordsTest()
@property (nonatomic) NSArray *testArray;
@property (nonatomic) int testNumber;
@property (nonatomic) NSArray *taskArray;
@property (nonatomic) WordTaskGenerator *wordTaskGenerator;
@end


@implementation GREWordsTest

- (void)setUp
{
    [super setUp];
    _wordTaskGenerator = [[WordTaskGenerator alloc] init];
    [[ConfigurationHelper instance] initData];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
    _testArray = nil;
    _testNumber = 0;
    [[ConfigurationHelper instance] resetAllData];
}


- (void)testReviewTask_fourthCircle
{
    _testArray = [_wordTaskGenerator reviewTask_fourthCircle:0];
    STAssertTrue(_testArray.count == 500, @"读取第0天的新词列表有问题");
}



//- (void)testExamTask_easy
//{
////    [[[WordHelper instance] wordWithID:0] didMakeAMistakeOnDate:[NSDate new]];
////    [[[WordHelper instance] wordWithID:0] didRightOnDate:[NSDate new]];
////    [[[WordHelper instance] wordWithID:0] setNote:@"note"];
//    for (int i=0; i<500; i++) {
//        int key = arc4random() % 3073;
//        [[[WordHelper instance] wordWithID:key] didMakeAMistakeOnDate:[NSDate new]];
//
//    }
//    NSDictionary *examInfo = @{@"time":@"10min", @"level":@"easy"};
//    _testArray = [_wordTaskGenerator testTaskWithOptions:examInfo whetherWithAllWords:NO];
//    
//    for (int i = 0; i < _testArray.count; i++) {
//        WordEntity *wordEntity = [_testArray objectAtIndex:i];
//        STAssertFalse(wordEntity.wordID < 0, @"生成易测试单词列表出错，WordID < 0");
//        STAssertFalse(wordEntity.wordID > 3072, @"生成易测试单词列表出错，WordID > 3072");
//    }
//}
//
//- (void)testExamTask_medium
//{
//    //    [[[WordHelper instance] wordWithID:0] didMakeAMistakeOnDate:[NSDate new]];
//    //    [[[WordHelper instance] wordWithID:0] didRightOnDate:[NSDate new]];
//    //    [[[WordHelper instance] wordWithID:0] setNote:@"note"];
//    for (int i=0; i<500; i++) {
//        int key = arc4random() % 3073;
//        [[[WordHelper instance] wordWithID:key] didMakeAMistakeOnDate:[NSDate new]];
//        
//    }
//    NSDictionary *examInfo = @{@"time":@"10min", @"level":@"medium"};
//    _testArray = [_wordTaskGenerator testTaskWithOptions:examInfo whetherWithAllWords:NO];
//    
//    for (int i = 0; i < _testArray.count; i++) {
//        WordEntity *wordEntity = [_testArray objectAtIndex:i];
//        STAssertFalse(wordEntity.wordID < 0, @"生成中测试单词列表出错，WordID < 0");
//        STAssertFalse(wordEntity.wordID > 3072, @"生成中测试单词列表出错，WordID > 3072");
//    }
//}
//
//- (void)testExamTask_hard
//{
//    //    [[[WordHelper instance] wordWithID:0] didMakeAMistakeOnDate:[NSDate new]];
//    //    [[[WordHelper instance] wordWithID:0] didRightOnDate:[NSDate new]];
//    //    [[[WordHelper instance] wordWithID:0] setNote:@"note"];
//    for (int i=0; i<500; i++) {
//        int key = arc4random() % 3073;
//        [[[WordHelper instance] wordWithID:key] didMakeAMistakeOnDate:[NSDate new]];
//        
//    }
//    NSDictionary *examInfo = @{@"time":@"10min", @"level":@"hard"};
//    _testArray = [_wordTaskGenerator testTaskWithOptions:examInfo whetherWithAllWords:NO];
//    
//    for (int i = 0; i < _testArray.count; i++) {
//        WordEntity *wordEntity = [_testArray objectAtIndex:i];
//        STAssertFalse(wordEntity.wordID < 0, @"生成难测试单词列表出错，WordID < 0");
//        STAssertFalse(wordEntity.wordID > 3072, @"生成难测试单词列表出错，WordID > 3072");
//    }
//}



//- (void)testReviewTaskAtDay_min_minus
//{
//    _testArray = [_wordTaskGenerator reviewTask_twoList:-1];
//    STAssertTrue(_testArray.count == 0, @"读取第-1天的复习列表有问题");
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}
//- (void)testReviewTaskAtDay_min
//{
//    _testArray = [_wordTaskGenerator reviewTask_twoList:0];
//    STAssertTrue(_testArray.count == 200, @"读取第0天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 0, @"第0天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:2] intValue] == 2, @"第0天第2个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:101] intValue] == 101, @"第0天第101个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:198] intValue] == 198, @"第0天第198个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:199] intValue] == 199, @"第0天第199个单词读取错误");
//}
//- (void)testReviewTaskAtDay_min_plus
//{
//    _testArray = [_wordTaskGenerator reviewTask_twoList:2];
//    STAssertTrue(_testArray.count == 400, @"读取第0天的新词列表有问题");
//
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 200, @"第2天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:2] intValue] == 202, @"第2天第2个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:251] intValue] == 451, @"第2天第251个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:398] intValue] == 598, @"第2天第398个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:399] intValue] == 599, @"第2天第399个单词读取错误");
//}
//- (void)testReviewTaskAtDay_normal
//{
//    _testArray = [_wordTaskGenerator reviewTask_twoList:5];
//    STAssertTrue(_testArray.count == 600, @"读取第0天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 800, @"第5天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:199] intValue] == 999, @"第5天第199个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:200] intValue] == 400, @"第5天第200个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:399] intValue] == 599, @"第5天第399个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:400] intValue] == 1000, @"第5天第400个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:599] intValue] == 1199, @"第5天第599个单词读取错误");
//}
//- (void)testReviewTaskAtDay_max_minus
//{
//    _testArray = [_wordTaskGenerator reviewTask_twoList:15];
//    STAssertTrue(_testArray.count == 873, @"读取第0天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 2800, @"第15天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:199] intValue] == 2999, @"第15天第199个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:200] intValue] == 2400, @"第15天第200个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:399] intValue] == 2599, @"第15天第399个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:400] intValue] == 1600, @"第15天第400个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:599] intValue] == 1799, @"第15天第599个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:600] intValue] == 200, @"第15天第600个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:799] intValue] == 399, @"第15天第799个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:800] intValue] == 3000, @"第15天第800个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:872] intValue] == 3072, @"第15天第873个单词读取错误");
//}
//- (void)testReviewTaskAtDay_max
//{
//    _testArray = [_wordTaskGenerator reviewTask_twoList:28];
//    STAssertTrue(_testArray.count == 273, @"读取第0天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 2800, @"第28天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:272] intValue] == 3072, @"第28天第200个单词读取错误");
//}
//- (void)testReviewTaskAtDay_max_plus
//{
//    _testArray = [_wordTaskGenerator reviewTask_twoList:29];
//    STAssertTrue(_testArray.count == 0, @"读取第29天的新词列表有问题");
//}



//- (void)testNumberOfNewWordAtDay_min_minus
//{
//    _testNumber = [_wordTaskGenerator theNumberOfNewWordToday_twolist:-1];
//    STAssertTrue(_testNumber == 0, @"读取第-1天的新词数量有问题");
//}
//- (void)testNumberOfNewWordAtDay_min
//{
//    _testNumber = [_wordTaskGenerator theNumberOfNewWordToday_twolist:0];
//    STAssertTrue(_testNumber == 200, @"读取第-1天的新词数量有问题");
//}
//- (void)testNumberOfNewWordAtDay_min_plus
//{
//    _testNumber = [_wordTaskGenerator theNumberOfNewWordToday_twolist:1];
//    STAssertTrue(_testNumber == 200, @"读取第-1天的新词数量有问题");
//}
//- (void)testNumberOfNewWordAtDay_normal
//{
//    _testNumber = [_wordTaskGenerator theNumberOfNewWordToday_twolist:10];
//    STAssertTrue(_testNumber == 200, @"读取第-1天的新词数量有问题");
//}
//- (void)testNumberOfNewWordAtDay_max_minus
//{
//    _testNumber = [_wordTaskGenerator theNumberOfNewWordToday_twolist:14];
//    STAssertTrue(_testNumber == 200, @"读取第-1天的新词数量有问题");
//}
//- (void)testNumberOfNewWordAtDay_max
//{
//    _testNumber = [_wordTaskGenerator theNumberOfNewWordToday_twolist:15];
//    STAssertTrue(_testNumber == 73, @"读取第-1天的新词数量有问题");
//}
//- (void)testNumberOfNewWordAtDay_max_plus
//{
//    _testNumber = [_wordTaskGenerator theNumberOfNewWordToday_twolist:16];
//    STAssertTrue(_testNumber == 0, @"读取第-1天的新词数量有问题");
//}

//- (void)testReciteWordNumberAtDay_min_minus
//{
//    _testArray = [_wordTaskGenerator newWordTask_twoList:-1];
//    STAssertTrue(_testArray.count == 0, @"读取第-1天的新词列表有问题");
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}
//
//- (void)testReciteWordNumberAtDay_min
//{
//    _testArray = [_wordTaskGenerator newWordTask_twoList:0];
//    STAssertTrue(_testArray.count == 800, @"读取第0天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 0, @"第0天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:2] intValue] == 2, @"第0天第2个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:101] intValue] == 1, @"第0天第101个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:798] intValue] == 198, @"第0天第198个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:799] intValue] == 199, @"第0天第199个单词读取错误");
//
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}
//
//- (void)testReciteWordNumberAtDay_min_plus
//{
//    _testArray = [_wordTaskGenerator newWordTask_twoList:2];
//    STAssertTrue(_testArray.count == 800, @"读取第2天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 400, @"第2天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:2] intValue] == 402, @"第2天第2个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:101] intValue] == 401, @"第2天第101个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:798] intValue] == 598, @"第2天第198个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:799] intValue] == 599, @"第2天第199个单词读取错误");
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}
//
//- (void)testReciteWordNumberAtDay_normal
//{
//    _testArray = [_wordTaskGenerator newWordTask_twoList:9];
//    STAssertTrue(_testArray.count == 800, @"读取第9天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 1800, @"第9天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:2] intValue] == 1802, @"第9天第2个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:101] intValue] == 1801, @"第9天第101个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:798] intValue] == 1998, @"第9天第198个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:799] intValue] == 1999, @"第9天第199个单词读取错误");
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}
//
//- (void)testReciteWordNumberAtDay_max_minus
//{
//    _testArray = [_wordTaskGenerator newWordTask_twoList:14];
//    STAssertTrue(_testArray.count == 800, @"读取第14天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 2800, @"第14天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:2] intValue] == 2802, @"第14天第2个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:101] intValue] == 2801, @"第14天第101个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:798] intValue] == 2998, @"第14天第198个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:799] intValue] == 2999, @"第14天第199个单词读取错误");
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}
//
//- (void)testReciteWordNumberAtDay_max
//{
//    _testArray = [_wordTaskGenerator newWordTask_twoList:15];
//    STAssertTrue(_testArray.count == 269, @"读取第15天的新词列表有问题");
//    
//    STAssertTrue([[_testArray objectAtIndex:0] intValue] == 3000, @"第15天第0个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:2] intValue] == 3002, @"第15天第2个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:101] intValue] == 3001, @"第15天第101个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:267] intValue] == 3071, @"第15天第198个单词读取错误");
//    STAssertTrue([[_testArray objectAtIndex:268] intValue] == 3072, @"第15天第199个单词读取错误");
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}
//
//- (void)testReciteWordNumberAtDay_max_plus
//{
//    _testArray = [_wordTaskGenerator newWordTask_twoList:16];
//    STAssertTrue(_testArray.count == 0, @"读取第16天的新词列表有问题");
//    
//    //STFail(@"Unit tests are not implemented yet in GREWordsTest");
//}

@end
