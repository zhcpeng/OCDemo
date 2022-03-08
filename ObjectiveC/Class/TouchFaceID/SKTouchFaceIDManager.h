//
//  SKTouchFaceIDManager.h
//  ObjectiveC
//
//  Created by zhcpeng on 2020/9/7.
//  Copyright © 2020 张春鹏. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface SKTouchFaceIDManager : NSObject

+ (instancetype)share;


/// 判断是否支持 返回支持类型
- (short)supportType;


- (void)authenticationWithBiometrics: (void(^)(BOOL success, NSError *error))completion;

@end


