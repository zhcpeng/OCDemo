//
//  DrawViewController.m
//  ObjectiveC
//
//  Created by zhcpeng on 2021/1/15.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import "DrawViewController.h"

#import "DrawArcView.h"

#import "SKDashboardChartView.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    DrawArcView *v = [[DrawArcView alloc] initWithFrame:CGRectMake(30, 200, 300, 300)];
//
//    [self.view addSubview:v];
//
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 500, 100, 30)];
//    label.backgroundColor = [UIColor redColor];
//    label.text = @"100.00%";
//    [self.view addSubview:label];
//
//
//    CGFloat centerX = 50;
//    CGFloat height = 30;
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(centerX - 6, height)];
//    [path addLineToPoint:CGPointMake(centerX - 6 + 12, height)];
//    [path addLineToPoint:CGPointMake(centerX, height + 5)];
//    [path closePath];
//    CAShapeLayer *triangleLayer = [CAShapeLayer layer];
//    triangleLayer.bounds = CGRectMake(0, 0, 12, 5);
//    triangleLayer.path = path.CGPath;
//    triangleLayer.fillColor = [UIColor redColor].CGColor;
//    [label.layer addSublayer:triangleLayer];
    
    
    
    SKDashboardChartView *chartView = [[SKDashboardChartView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];
    SKDashboardChartConfig *config = [[SKDashboardChartConfig alloc] init];
    config.values = @[@(0.05), @(0.1), @(0.2), @(0.3), @(1.0)].mutableCopy;
    config.colors = @[[UIColor greenColor], [UIColor blueColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor redColor]].mutableCopy;
    config.currentValue = @0.05;
    [chartView updateWithConfig:config];
    [self.view addSubview:chartView];
    
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
////    UIGraphicsPushContext(context);
//    CGContextSaveGState(context);
//    [@"11111" drawAtPoint:CGPointMake(100, 400) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor redColor]}];
////    UIGraphicsPopContext();
//    CGContextRestoreGState(context);
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:lineView.bounds];
//    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[UIColor redColor].CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:3], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 100, 0);
    CGPathAddLineToPoint(path, NULL,100, 300);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
//    shapeLayer.bounds = CGRectMake(100, 200, 1, 100);
    
    //  把绘制好的虚线添加上来
    [self.view.layer addSublayer:shapeLayer];
    
    
}

@end
