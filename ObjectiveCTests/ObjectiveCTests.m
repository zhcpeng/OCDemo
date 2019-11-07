//
//  ObjectiveCTests.m
//  ObjectiveCTests
//
//  Created by zhcpeng on 2019/6/11.
//  Copyright © 2019 张春鹏. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ObjectiveCTests : XCTestCase

@end

@implementation ObjectiveCTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
        [self test111];
    }];
}



/// stringFromDate
- (void)test111 {
    NSDateFormatter *foramtter = [[NSDateFormatter alloc] init];
    [foramtter setDateFormat:@"yyyy-MM-DD:HH-MM"];
    NSDate *date = [NSDate date];
    for (int i = 0; i < 10000; i++) {
        NSString *s = [foramtter stringFromDate:date];
    }
    NSDate *lastDate = [NSDate date];
    NSTimeInterval time = [lastDate timeIntervalSinceDate:date];
    NSLog(@"time:%f",time);
}

/// [[NSDateFormatter alloc] init];
- (void)test222 {
    NSDate *date = [NSDate date];
    for (int i = 0; i < 10000; i++) {
        NSDateFormatter *foramtter = [[NSDateFormatter alloc] init];
        [foramtter setDateFormat:@"yyyy-MM-DD:HH-MM"];
        //    NSString *s = [foramtter stringFromDate:date];
    }
    NSDate *lastDate = [NSDate date];
    NSTimeInterval time = [lastDate timeIntervalSinceDate:date];
    NSLog(@"time:%f",time);
}


- (void)test333 {
    NSDateFormatter *foramtter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    for (int i = 0; i < 10000; i++) {
        [foramtter setDateFormat:@"yyyy-MM-DD:HH-MM"];
        //        NSString *s = [foramtter stringFromDate:date];
    }
    NSDate *lastDate = [NSDate date];
    NSTimeInterval time = [lastDate timeIntervalSinceDate:date];
    NSLog(@"time:%f",time);
}


@end
