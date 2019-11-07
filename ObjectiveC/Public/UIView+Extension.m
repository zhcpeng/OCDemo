//
//  UIView+Extension.m
//  JDStockCommonUI
//
//  Created by 张春鹏 on 2018/9/7.
//  Copyright © 2018年 yxlong. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

+ (NSString *)identifier {
    return [NSString stringWithFormat:@"%@.identifier", NSStringFromClass(self.class)];
}

- (void)addSubviews: (NSArray<UIView *> *)views {
    for (UIView *view in views) {
        [self addSubview: view];
    }
}

+ (UIWindow *)visibleWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *w = [UIApplication sharedApplication].keyWindow;
    for(UIWindow *elem in windows){
        if(elem.windowLevel == UIWindowLevelNormal){
            w = elem;
        }
    }
    return w;
}

@end

