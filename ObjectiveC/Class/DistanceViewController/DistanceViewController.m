//
//  DistanceViewController.m
//  ObjectiveC
//
//  Created by ext.zhangchunp1 on 2023/9/26.
//  Copyright © 2023 张春鹏. All rights reserved.
//

#import "DistanceViewController.h"

@interface DistanceViewController ()

@end

@implementation DistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawRectChart:@[[NSNumber numberWithInt:25], [NSNumber numberWithInt:49], [NSNumber numberWithInt:66], [NSNumber numberWithInt:78], [NSNumber numberWithInt:99]]];
    
    [self drawRectChart:@[[NSNumber numberWithInt:-25], [NSNumber numberWithInt:-49], [NSNumber numberWithInt:-66], [NSNumber numberWithInt:-78], [NSNumber numberWithInt:-99]]];
    
    [self drawRectChart:@[[NSNumber numberWithInt:-25], [NSNumber numberWithInt:-49], [NSNumber numberWithInt:-66], [NSNumber numberWithInt:-78], [NSNumber numberWithInt:1199]]];
    
    [self drawRectChart:@[[NSNumber numberWithInt:2.5], [NSNumber numberWithInt:49], [NSNumber numberWithInt:66], [NSNumber numberWithInt:78], [NSNumber numberWithInt:144]]];
    
}


- (void)drawRectChart: (NSArray<NSNumber *> *)_dataList {
    NSAssert(_dataList.count > 0, @"数据不能为空");
    
    
    double values[_dataList.count];
    double max = [_dataList.firstObject doubleValue];
    double min = [_dataList.firstObject doubleValue];
    for (int i = 0; i < _dataList.count; i++) {
        double number = [_dataList[i] doubleValue];
        values[i] = number;
        max = MAX(max, number);
        min = MIN(min, number);
    }
    
//    long i = 0, k = fabs(max);
//    while (k > 0) {
//        k = k / 10;
//        i++;
//    }
//    long p = pow(10, MAX((i - 1), 0));
//    max = ceil(max * 1.0 / p) * p;
//    NSLog(@"max: %.2f", max);
//
//    long j = 0, l = fabs(min);
//    while (l > 0) {
//        l = l / 10;
//        j++;
//    }
//    long p2 = pow(10, MAX((j - 1), 0));
//    min = floor(min * 1.0 / p2) * p2;
    
    max = ceil(max * 1.0 / 10) * 10;
    NSLog(@"max: %.2f", max);
    min = floor(min * 1.0 / 10) * 10;
    NSLog(@"min: %.2f", min);
    
    double distance = fabs(max - min);
//    distance = ;
//    if (max >= 0) {
//    } else {
//        distance = 0 - min;
//    }
    
    double space = 0;
    space = distance / 3.0;
    NSLog(@"space: %.2f", space);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        [result addObject:[NSNumber numberWithDouble:(min + space * i)]];
    }
    NSLog(@"%@", result);
    
//    return;
//    if (max >= 4.0) {
//        long tempSpace = (long)ceil(distance / 4.0);
//        long i = 0, k = tempSpace;
//        while (k > 0) {
//            k = k / 10;
//            i++;
//        }
//        long p = pow(10, MAX((i - 2), 0));
//        space = ceil(tempSpace * 1.0 / p) * p;
//    } else {
//        // 小数
//        space = ceil(distance * 100.0 / 5) / 100;
//    }
//    NSMutableArray *result = [NSMutableArray arrayWithCapacity:6];
//    if (min >= 0) {
//        for (int i = 0; i < 4; i++) {
//            [result addObject:[NSNumber numberWithDouble:space * i]];
//        }
//    } else if (min < 0 && max > 0) {
//        int j = 0;
//        if (min < 0) {
//            j = floor(min / (space * 1.0));
//            for (int i = j; i <= 6 + j; i++) {
//                [result addObject:[NSNumber numberWithDouble:space * i]];
//            }
//        } else {
//            j = ceil(max / (space * 1.0));
//            for (int i = -5 + j; i <= j; i++) {
//                [result addObject:[NSNumber numberWithDouble:space * i]];
//            }
//        }
//    } else {
//        for (int i = -5; i <= 0; i++) {
//            [result addObject:[NSNumber numberWithDouble:space * i]];
//        }
//    }
//    // 当倒数第二个大于最大值时删除最后一个
//    if (max > 0 && [result[result.count - 2] doubleValue] > max) {
//        [result removeLastObject];
//    }
    
    
    
    
}

@end
