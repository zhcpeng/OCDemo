//
//  UIView+Extension.h
//  JDStockCommonUI
//
//  Created by 张春鹏 on 2018/9/7.
//  Copyright © 2018年 yxlong. All rights reserved.
//

#import <UIKit/UIKit.h>

/// UIView 扩展
@interface UIView (Extension)

+ (NSString *)identifier;

- (void)addSubviews: (NSArray<UIView *> *)views;

+ (UIWindow *)visibleWindow;

@end
