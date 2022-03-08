//
//  CarrierViewController.m
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2021/8/12.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import "CarrierViewController.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import "STKNetworkReachabilityManager.h"

@interface CarrierViewController ()

@end

@implementation CarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[STKNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STKNetworkReachabilityStatus status = [[STKNetworkReachabilityManager sharedManager] networkReachabilityStatus];
        NSLog(@"%ld", status);
        [[STKNetworkReachabilityManager sharedManager] stopMonitoring];
    });
    
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *carrierName=[carrier carrierName];
    
    NSLog(@"%@", carrierName);
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy_MM_dd_HH_mm_ss_SSS";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    long long timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000.0];
    NSString *time = [formatter stringFromDate:date];
    NSLog(@"%@",time);
}

//+ (NSString *)getCarrierInfo{
//    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
//    NSString *carrierName=[carrier carrierName];
//    return carrierName;
//};

@end
