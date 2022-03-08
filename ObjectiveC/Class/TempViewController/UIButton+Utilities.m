//
//  UIButton+Utilities.m
//  AddSub
//
//  Created by YXLONG on 15/12/21.
//  Copyright © 2015年 JDJR. All rights reserved.
//

#import "UIButton+Utilities.h"

#import <objc/runtime.h>

static void* kUIButtonTouchExtendInset = &kUIButtonTouchExtendInset;
static void* kUIButtonActionBlock = &kUIButtonActionBlock;
@implementation UIButton (TouchExtendInset)

- (UIEdgeInsets)jdsk_touchExtendInset {
    NSString *rectString = objc_getAssociatedObject(self, kUIButtonTouchExtendInset);
    if (!rectString || rectString.length == 0) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsFromString(rectString);
}
- (void)setJdsk_touchExtendInset:(UIEdgeInsets)touchExtendInset {
    objc_setAssociatedObject(self, kUIButtonTouchExtendInset, NSStringFromUIEdgeInsets(touchExtendInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.jdsk_touchExtendInset, UIEdgeInsetsZero) || self.isHidden || !self.isEnabled) {
        return [super pointInside:point withEvent:event];
    }
    CGRect rect = UIEdgeInsetsInsetRect(self.bounds, self.jdsk_touchExtendInset);
    rect.size.width = MAX(rect.size.width, 0);
    rect.size.height = MAX(rect.size.height, 0);
    return CGRectContainsPoint(rect, point);
}


+ (instancetype)jdsk_initWithBlcok: (dispatch_block_t)blcok {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.buttonActionBlock = blcok;
    return button;
}

- (void)setButtonActionBlock:(dispatch_block_t)buttonActionBlock {
    if (buttonActionBlock) {
        objc_setAssociatedObject(self, &kUIButtonActionBlock, buttonActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (dispatch_block_t)buttonActionBlock {
    return (dispatch_block_t)objc_getAssociatedObject(self, &kUIButtonActionBlock);
}

- (void)buttonAction {
    dispatch_block_t block = (dispatch_block_t)objc_getAssociatedObject(self, &kUIButtonActionBlock);
    if (block) {
        block();
    }
}

@end
