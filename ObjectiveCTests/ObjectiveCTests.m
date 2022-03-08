//
//  ObjectiveCTests.m
//  ObjectiveCTests
//
//  Created by zhcpeng on 2019/6/11.
//  Copyright © 2019 张春鹏. All rights reserved.
//

#import <XCTest/XCTest.h>


#include <time.h>


#include <syslog.h>

//#import "NSDate+SAMAdditions.h"


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
        
//        [self test111];
//        [self testNumber];
        
//        [self testNSLog];
//        [self testsyslog];
        [self testprint];
        
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


- (void)testStringFormat {
    NSDate *date = [NSDate date];
    for (int i = 0; i < 1000; i++) {
        NSString *string = [NSString stringWithFormat:@"%ld", i];
//        [foramtter setDateFormat:@"yyyy-MM-DD:HH-MM"];
        //        NSString *s = [foramtter stringFromDate:date];
    }
    NSDate *lastDate = [NSDate date];
    NSTimeInterval time = [lastDate timeIntervalSinceDate:date];
    NSLog(@"time:%f",time);
}

- (void)testNumber {
    NSDate *date = [NSDate date];
    for (int i = 0; i < 1000; i++) {
//        NSString *string = [@(i) stringValue];
        NSString *string = @(i).description;
    }
    NSDate *lastDate = [NSDate date];
    NSTimeInterval time = [lastDate timeIntervalSinceDate:date];
    NSLog(@"time:%f",time);
}

- (void)testDateOC {
    
}

- (void)testNSLog {
    NSString *test = @"11111";
    for (int i = 0; i < 1000; i++) {
        NSLog(@"%@", test);
    }
}

- (void)testsyslog {
    NSString *test = @"11111";
    for (int i = 0; i < 1000; i++) {
        syslog(0, "%s", test.UTF8String);
    }
}

- (void)testprint {
    NSString *test = @"11111";
    for (int i = 0; i < 1000; i++) {
        printf("%s\n", test.UTF8String);
    }
}

+ (NSDate *)dateFromISO8601String:(NSString *)string {
    if (!string) {
        return nil;
    }

    struct tm tm;
    time_t t;

    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);

    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}


- (NSString *)ISO8601String {
    struct tm *timeinfo;
    char buffer[80];

    time_t rawtime = [[NSDate date] timeIntervalSince1970] - [[NSTimeZone localTimeZone] secondsFromGMT];
    timeinfo = localtime(&rawtime);

    strftime(buffer, 80, "%Y-%m-%dT%H:%M:%S%z", timeinfo);

    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}


@end
