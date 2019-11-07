//
//  DataFormatterViewController.m
//  ObjectiveC
//
//  Created by zhcpeng on 2019/7/1.
//  Copyright © 2019 张春鹏. All rights reserved.
//

#import "DataFormatterViewController.h"

@interface DataFormatterViewController ()

@end

@implementation DataFormatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test1];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test2];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test3];
    });
    
}

/// stringFromDate
- (void)test1 {
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
- (void)test2 {
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


- (void)test3 {
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
