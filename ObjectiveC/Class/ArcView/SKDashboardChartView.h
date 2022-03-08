//
//  SKDashboardChartView.h
//  StockQuotation
//
//  Created by zhcpeng on 2021/1/20.
//  Copyright © 2021 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKDashboardChartConfig : NSObject

@property (nonatomic, strong) NSMutableArray<UIColor *> *colors;           ///< color
@property (nonatomic, strong) NSMutableArray<NSNumber *> *values;           ///< value
@property (nonatomic, strong) NSNumber *currentValue;           ///< value 0-1.0

@end


@interface SKDashboardChartView : UIView

- (void)updateWithConfig: (SKDashboardChartConfig *)config;

@end

