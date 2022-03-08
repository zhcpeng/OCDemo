//
//  UIGestureRecognizer+Extension.h
//  JDCommonKit
//
//  Created by zhcpeng on 2020/9/22.
//  Copyright © 2020 yxlong. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 手势 增加 block
@interface UIGestureRecognizer (Extension)

@property (nonatomic,   copy) dispatch_block_t actionBlock;     ///< buttonBlock

+ (instancetype)jdsk_initWithBlcok: (dispatch_block_t)block;

- (void)actionBlockAction;

@end

