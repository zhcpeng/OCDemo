//
//  JDBDeviceInfo.h
//  JDBBaseInfoModule
//
//  Created by Leven on 2021/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDBDeviceInfo : NSObject

// 信息刷新方法
+ (void)refreshInfo;
#pragma mark ---基础信息

// 设备型号 iPhone8,1 , iphone 11,2 这些
+ (NSString *)getDeviceModel;
// [UIDevice currentDevice].model
+ (NSString *)getCurrentDeviceModel;
// 系统版本: [UIDevice currentDevice].systemVersion
+ (NSString *)getOsVersion;
// 手机名: [UIDevice currentDevice].name
+ (NSString *)getDeviceName;
// 系统名: [UIDevice currentDevice].systemName
+ (NSString *)getOsName;
// 屏幕尺寸: [NSString stringWithFormat:@"%d*%d",[[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height]
+ (NSString *)getResolution;
// 屏幕尺寸: [[UIScreen mainScreen] currentMode].size, 如果需要CGRect 请移步 JDBScreenInfo
+ (CGSize)getResolutionSize;
// 缩放比例: [UIScreen mainScreen].scale 请移步 JDBScreenInfo
+ (CGFloat)getScreenScale;
// 国家代码: [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]
+ (NSString *)getCountryCode;
// 语言:    [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]
+ (NSString *)getLanguage;
// 运营商:  [carrier carrierName]
+ (NSString *)getCarrier;
// 获取IP
+ (NSString *)getIP;
// wifi名:  [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID]
+ (NSString *)wifi_ssid;
// wifi虚拟mac地址: [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID]
+ (NSString *)wifi_Bssid;

#pragma mark ---ID
// openudid
+ (NSString *)getOpenUDID;
//
+ (NSString *)getMacAddress;

+ (NSString *)getDeviceID;
// [NSUUID UUID]
+ (NSString *)createUUID;

// 广告id [[ASIdentifierManager sharedManager] advertisingIdentifier]
+ (NSString *)adid;

// 设备idfv [UIDevice currentDevice].identifierForVendor.UUIDString
+ (NSString *)idfv;

#pragma mark ---磁盘

// 获取内存大小
+ (NSString *)getTotalMemorySize;

//获取可用内存大小
+ (NSString *)getAvailableMemorySize;

// 获取磁盘大小
+ (NSString *)getTotalDiskSize;

// 获取可用磁盘大小
+ (NSString *)getAvailableDiskSize;

#pragma mark - Kern & HW
/// 通过系统层api'sysctl'获取设备名
+ (NSString *)kernHostName;

/// 通过系统层api'sysctl'获取设备型号
+ (NSString *)hwMachine;

/// 通过系统层api'sysctlbyname'获取设备型号
+ (NSString *)hwMachineByName;



@end

NS_ASSUME_NONNULL_END
