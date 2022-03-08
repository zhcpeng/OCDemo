//
//  JDBAppInfo.h
//  JDBBaseInfoModule
//
//  Created by Leven on 2021/7/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDBAppInfo : NSObject
//  主站:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
// 非主站: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
+ (NSString *)getBuild;
// 主站: NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
// 非主站: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
+ (NSString *)getClientVersion;
// [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
+ (NSString *)getBundleIdentifier;
//
+ (NSString *)getSendBoxSize;

@end

NS_ASSUME_NONNULL_END
