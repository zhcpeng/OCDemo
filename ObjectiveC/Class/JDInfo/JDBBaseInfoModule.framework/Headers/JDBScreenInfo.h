//
//  JDBScreenInfo.h
//  JDBBaseInfoModule
//
//  Created by Leven on 2021/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDBScreenInfo : NSObject

//[UIScreen mainScreen] 如果用户不同意返回为nil
+ (UIScreen *)mainScreen;
// 屏幕尺寸  [[UIScreen mainScreen] currentMode].size
+ (CGSize)getResolutionSize;
// 对应 :  [UIScreen mainScreen].bounds
+ (CGRect)getScreenBounds;
// 对应 : [UIScreen mainScreen].scale
+ (CGFloat)getScreenScale;
// 对应 : [UIScreen mainScreen].nativeBounds
+ (CGRect)getScreenNativeBounds;
// 对应 : [UIScreen mainScreen].nativeScale
+ (CGFloat)getScreenNativeScale;


@end

NS_ASSUME_NONNULL_END
