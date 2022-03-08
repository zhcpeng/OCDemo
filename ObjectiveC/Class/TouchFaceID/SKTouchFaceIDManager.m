//
//  SKTouchFaceIDManager.m
//  ObjectiveC
//
//  Created by zhcpeng on 2020/9/7.
//  Copyright © 2020 张春鹏. All rights reserved.
//

#import "SKTouchFaceIDManager.h"

#import <LocalAuthentication/LocalAuthentication.h>
#import <Security/Security.h>

// SKBiometryAuthenticationManager

@implementation SKTouchFaceIDManager

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static id manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[SKTouchFaceIDManager alloc] init];
    });
    return manager;
}


- (short)supportType {
    short type = 0;
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        if (@available(iOS 11.0, *)) {
            if (context.biometryType == LABiometryTypeFaceID) {
                type = 2;
            } else if (context.biometryType == LABiometryTypeTouchID) {
                type = 1;
            }
        }
    }
    return type;
}


- (void)authenticationWithBiometrics: (void(^)(BOOL success, NSError *error))completion {
    short type = [self supportType];
    if (type > 0) {
        LAContext *context = [[LAContext alloc] init];
//        context.localizedCancelTitle = @"取消";
        context.localizedFallbackTitle = @"";
//        NSError *error = nil;
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:type == 2 ? @"面容ID": @"请验证指纹" reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 验证成功，回到主线程做后续操作
                    if (completion) {
                        completion(true, nil);
                    }
                });
            } else {
                NSLog(@"error: %@", error.domain);
                NSError *resultError = nil;
                if (@available(iOS 11.0, *)) {
                    switch (error.code) {
                        // 失败
                        case LAErrorAuthenticationFailed:
                            resultError = [NSError errorWithDomain:@"验证失败" code:LAErrorAuthenticationFailed userInfo:nil];
                            break;
                        // 用户未设置密码 -5
                        case LAErrorPasscodeNotSet:
                            resultError = [NSError errorWithDomain:@"用户未设置密码" code:LAErrorPasscodeNotSet userInfo:nil];
                            break;
                        // 用户没有设置TouchID/FaceID -7
                        case LAErrorBiometryNotEnrolled:
                            resultError = [NSError errorWithDomain:@"用户没有设置TouchID/FaceID" code:LAErrorBiometryNotEnrolled userInfo:nil];
                            break;
                        // TouchID/FaceID 无效 -6
                        case LAErrorBiometryNotAvailable:
                            resultError = [NSError errorWithDomain:@"TouchID/FaceID无效" code:LAErrorBiometryNotAvailable userInfo:nil];
                            break;
                        // TouchID/FaceID 被锁定
                        case LAErrorBiometryLockout:
                            resultError = [NSError errorWithDomain:@"TouchID/FaceID被锁定" code:LAErrorBiometryLockout userInfo:nil];
                            break;
                        // 手动取消
                        case LAErrorUserCancel:
                        // 用户选择输入密码
                        case LAErrorUserFallback:
                        // 来电 等系统取消
                        case LAErrorSystemCancel:
                        // 当前软件被挂起并取消了授权
                        case LAErrorAppCancel:
                        // context 无效
                        case LAErrorInvalidContext:
                            
                        default:
                            // 忽略不处理
                            resultError = [NSError errorWithDomain:@"" code:0 userInfo:nil];
                            break;
                    }
                } else {
                    switch (error.code) {
                        // 失败
                        case LAErrorAuthenticationFailed:
                            resultError = [NSError errorWithDomain:@"验证失败" code:LAErrorAuthenticationFailed userInfo:nil];
                            break;
                        // 用户未设置密码 -5
                        case LAErrorPasscodeNotSet:
                            resultError = [NSError errorWithDomain:@"用户未设置密码" code:LAErrorPasscodeNotSet userInfo:nil];
                            break;
                        // 用户没有设置TouchID/FaceID -7
                        case LAErrorTouchIDNotEnrolled:
                            resultError = [NSError errorWithDomain:@"用户没有设置TouchID/FaceID" code:LAErrorTouchIDNotEnrolled userInfo:nil];
                            break;
                        // TouchID/FaceID 无效 -6
                        case LAErrorTouchIDNotAvailable:
                            resultError = [NSError errorWithDomain:@"TouchID/FaceID无效" code:LAErrorTouchIDNotAvailable userInfo:nil];
                            break;
                        // TouchID/FaceID 被锁定
                        case LAErrorTouchIDLockout:
                            resultError = [NSError errorWithDomain:@"TouchID/FaceID被锁定" code:LAErrorTouchIDLockout userInfo:nil];
                            break;
                        // 手动取消
                        case LAErrorUserCancel:
                        // 用户选择输入密码
                        case LAErrorUserFallback:
                        // 来电 等系统取消
                        case LAErrorSystemCancel:
                        // 当前软件被挂起并取消了授权
                        case LAErrorAppCancel:
                        // context 无效
                        case LAErrorInvalidContext:
                        default:
                            // 忽略不处理
                            resultError = [NSError errorWithDomain:@"" code:0 userInfo:nil];
                            break;
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 验证失败
                    if (completion) {
                        completion(false, resultError);
                    }
                });
            }
        }];
    } else {
        if (completion) {
            completion(false, [NSError errorWithDomain:@"设备不支持" code:-111 userInfo:nil]);
        }
    }
}



@end
