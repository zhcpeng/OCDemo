//
//  SKFancyChartManager.h
//  JDStockCommonUI
//
//  Created by zhcpeng on 2019/12/11.
//  Copyright © 2019 JD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SKFancyChartManager : NSObject

+ (NSArray<NSNumber *> *)calculateYScale: (NSArray<NSNumber *> *)datas;

@end

