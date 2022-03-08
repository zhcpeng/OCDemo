//
//  UIGestureRecognizer+Extension.m
//  JDCommonKit
//
//  Created by zhcpeng on 2020/9/22.
//  Copyright © 2020 yxlong. All rights reserved.
//

#import "UIGestureRecognizer+Extension.h"
#import <objc/runtime.h>


//@interface Temp : NSObject
//
//- (void)test;
//
//@end
//
//@implementation Temp
//
//+ (instancetype)share {
//    static dispatch_once_t onceToken;
//    static id temp;
//    dispatch_once(&onceToken, ^{
//        temp = [[Temp alloc] init];
//    });
//    return temp;
//}
//
//- (void)test {
//    NSLog(@"2222");
//}
//
//@end

//static void* kUIGestureRecognizerActionBlock = &kUIGestureRecognizerActionBlock;

@implementation UIGestureRecognizer (Extension)

+ (instancetype)jdsk_initWithBlcok:(dispatch_block_t)block {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer.actionBlock = block;
    return gestureRecognizer;
}

- (void)setActionBlock:(dispatch_block_t)actionBlock {
    if (actionBlock) {
        objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(actionBlockAction)];
    }
}

- (dispatch_block_t)actionBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)actionBlockAction {
    dispatch_block_t block = self.actionBlock;
    if (block) {
        block();
    }
}


@end
