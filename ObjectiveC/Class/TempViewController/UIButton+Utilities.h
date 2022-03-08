//
//  UIButton+Utilities.h
//  AddSub
//
//  Created by YXLONG on 15/12/21.
//  Copyright © 2015年 JDJR. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 扩展UIButton的点击区域
@interface UIButton (TouchExtendInset)

@property (nonatomic, assign) UIEdgeInsets jdsk_touchExtendInset;           /// 需要扩展的区域

@property (nonatomic,   copy) dispatch_block_t buttonActionBlock;     ///< buttonBlock

+ (instancetype)jdsk_initWithBlcok: (dispatch_block_t)blcok;

@end
