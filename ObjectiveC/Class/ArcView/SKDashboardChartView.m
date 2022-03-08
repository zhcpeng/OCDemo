//
//  SKDashboardChartView.m
//  StockQuotation
//
//  Created by zhcpeng on 2021/1/20.
//  Copyright © 2021 JD. All rights reserved.
//

#import "SKDashboardChartView.h"

@implementation SKDashboardChartConfig
@end

@interface SKDashboardChartView ()

@property (nonatomic, strong) UIView *chartView;           ///< chart
@property (nonatomic, strong) UIImageView *pointImageView;      ///< 指针

@end

@implementation SKDashboardChartView


// MARK: - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

// MARK: - Private Method
- (void)commonInit {
    self.clipsToBounds = true;
    
    _chartView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_chartView];
    
    _pointImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _pointImageView.image = [UIImage imageNamed:@"dashboard_point-skin0"];
    
    [self addSubview:_pointImageView];
    _pointImageView.hidden = true;
}

- (void)updateWithConfig: (SKDashboardChartConfig *)config {
    NSAssert(!(config.values.count == 0 || config.colors.count == 0 || config.values.count != config.colors.count), @"数据错误");
    
    if (config.values.count == 0 || config.colors.count == 0 || config.values.count != config.colors.count ) {
        return;
    }
    
    [self drawBase];
    
    CGFloat startAngle = 5.0/6 * M_PI;
    CGFloat total = (4.0 / 3 * M_PI);
    CGFloat max = [[config.values lastObject] floatValue];
    CGFloat lineWidth = 10.0;
    CGFloat rectSide = self.bounds.size.width - lineWidth - 10;
    CGFloat startPoint = 0;
    for (int i = 0; i < config.values.count; i++) {
        CGFloat value = [config.values[i] floatValue];
        CGFloat angle = value / max * total;
        
        UIBezierPath*path = [ UIBezierPath bezierPathWithArcCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:rectSide / 2 startAngle: startAngle + startPoint endAngle: startAngle + angle - 0.01 clockwise: YES];
        startPoint = angle;
        CAShapeLayer*shapeLayer = [ CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = config.colors[i].CGColor;
        shapeLayer.lineWidth = lineWidth;
        [self.chartView.layer addSublayer:shapeLayer];
    }
    
    CGFloat point = 4.0 / 3 * M_PI * ([config.currentValue floatValue] / [config.values.lastObject floatValue]);
    _pointImageView.hidden = false;
    self.pointImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, point - M_PI * 2 / 3.0);
    
}

- (void)drawBase {
    CAGradientLayer *gradientLayerLeft = [CAGradientLayer layer];
    gradientLayerLeft.frame = CGRectMake( .0, .0, self.bounds.size.width / 2, self.bounds.size.height * 0.75);
    gradientLayerLeft.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent: 0.5].CGColor,
    (__bridge id)[[UIColor redColor] colorWithAlphaComponent: 0.1].CGColor];
    gradientLayerLeft.locations = @[@(.7), @(1.0)];
    gradientLayerLeft.startPoint = CGPointMake( .0, .0);
    gradientLayerLeft.endPoint = CGPointMake( .0, 1.0);
    [self.chartView.layer addSublayer:gradientLayerLeft];

    // 右侧渐变色 layer
    CAGradientLayer*gradientLayerRight = [ CAGradientLayer layer];
    gradientLayerRight.frame = CGRectMake(self.bounds.size.width / 2.0, .0, self.bounds.size.width / 2, self.bounds.size.height * 0.75);
    gradientLayerRight.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent: 0.5].CGColor,
    (__bridge id)[[UIColor redColor] colorWithAlphaComponent: 0.1].CGColor];
    gradientLayerRight.locations = @[@(.7), @(1.0)];
    gradientLayerRight.startPoint = CGPointMake(.0,.0);
    gradientLayerRight.endPoint = CGPointMake(.0, 1.0);
    [self.chartView.layer addSublayer:gradientLayerRight];
    
    
    CGFloat lineWidth = 20.0;
    CGFloat rectSide = self.bounds.size.width - lineWidth;
    UIBezierPath*path = [ UIBezierPath bezierPathWithArcCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:rectSide / 2 startAngle: 5.0/6 * M_PI endAngle: ((1.0/6) * M_PI) clockwise: true];
    CAShapeLayer*shapeLayer = [ CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [ UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [ UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    // 两边圆角
//        shapeLayer.lineCap = @"round";
    self.chartView.layer.mask = shapeLayer;
}



@end
