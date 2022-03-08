//
//  SKFancyChartManager.m
//  JDStockCommonUI
//
//  Created by zhcpeng on 2019/12/11.
//  Copyright © 2019 JD. All rights reserved.
//

#import "SKFancyChartManager.h"

@implementation SKFancyChartManager

+ (NSArray<NSNumber *> *)calculateYScale: (NSArray<NSNumber *> *)datas {
    if (datas.count == 0) {
        return @[];
    }
    
//    short type = 0;
//    NSNumber *first = datas.firstObject;
//    if (strcmp([first objCType], @encode(double)) == 0) {
//        type = 1;
//    }
    
    long max = [datas.firstObject longValue];
    long min = [datas.firstObject longValue];
    for (NSNumber *num in datas) {
        double number = [num doubleValue];
        if (number > max) {
            max = number;
        }
        if (number < min) {
            min = number;
        }
    }
//    long distance = max - (min > 0 ? 0 : min);
    long distance = 0;
    if (max >= 0) {
        distance = max - (min > 0 ? 0 : min);
    } else {
        distance = 0 - min;
    }

    
//    double x = distance / 5.0;
//    if (x < 10) {
//        x = ceil(x);
//    }
//    long tempSpace = x;
    
    long tempSpace = (long)ceil(distance / 5.0);
    
    long i = 0, k = tempSpace;
    while (k > 0) {
        k = k / 10;
        i++;
    }
    long p = pow(10, MAX((i - 2), 0));
//    long space = (long)(ceil(tempSpace / pow(10, MAX((i - 2), 0))) * pow(10, MAX((i - 2), 0)));
    long space = (long)(ceil(tempSpace * 1.0 / p) * p);
//    if (space <= 10) {
//        space += 1;
//    }
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:6];
    if (min >= 0) {
        for (int i = 0; i < 6; i++) {
            [result addObject:[NSNumber numberWithLong:space * i]];
        }
    } else if (min < 0 && max > 0) {
//        int j = ceil(max / (space * 1.0));
//        for (int i = -5 + j; i <= j; i++) {
//            [result addObject:[NSNumber numberWithLong:space * i]];
//        }
        int j = 0;
        if (min < 0) {
            j = floor(min / (space * 1.0));
            for (int i = j; i <= 6 + j; i++) {
                [result addObject:[NSNumber numberWithLong:space * i]];
            }
        } else {
            j = ceil(max / (space * 1.0));
            for (int i = -5 + j; i <= j; i++) {
                [result addObject:[NSNumber numberWithLong:space * i]];
            }
        }
    } else {
        for (int i = -5; i <= 0; i++) {
            [result addObject:[NSNumber numberWithLong:space * i]];
        }
    }
    // 当倒数第二个大于最大值时删除最后一个
//    if (max > 0 && [result[result.count - 2] longValue] > max) {
//        [result removeLastObject];
//    }
    return result;
}

@end
