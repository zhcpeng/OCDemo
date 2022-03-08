//
//  DrawArcView.m
//  ObjectiveC
//
//  Created by zhcpeng on 2021/1/15.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import "DrawArcView.h"

@interface DrawArcView ()



@end

@implementation DrawArcView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat startAngle = 5.0/6 * M_PI;
        CGFloat angle = 1.0 / 20 * (2.0 / 3 * 2 * M_PI);
        
        CAGradientLayer *gradientLayerLeft = [ CAGradientLayer layer];
        gradientLayerLeft.frame = CGRectMake( .0, .0, self.bounds.size.width / 2, self.bounds.size.height);
        gradientLayerLeft.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent: 1.0].CGColor,
        (__bridge id)[[ UIColor redColor] colorWithAlphaComponent: 1.0].CGColor];
        gradientLayerLeft.locations = @[@( .0), @( .67)];
        gradientLayerLeft.startPoint = CGPointMake( .0, .0);
        gradientLayerLeft.endPoint = CGPointMake( .0, 1.0);
        [self.layer addSublayer:gradientLayerLeft];

        // 右侧渐变色 layer
        CAGradientLayer*gradientLayerRight = [ CAGradientLayer layer];
        gradientLayerRight.frame = CGRectMake(self.bounds.size.width / 2.0, .0, self.bounds.size.width / 2, self.bounds.size.height);
        gradientLayerRight.colors = @[(__bridge id)[[ UIColor blackColor] colorWithAlphaComponent: 1.0].CGColor,
        (__bridge id)[[ UIColor redColor] colorWithAlphaComponent: 1.0].CGColor];
        gradientLayerRight.locations = @[@( .0), @( .67)];
        gradientLayerRight.startPoint = CGPointMake( .0, .0);
        gradientLayerRight.endPoint = CGPointMake( .0, 1.0);
        [self.layer addSublayer:gradientLayerRight];
        
        
        
        
//        layer1.path

        // 弧段绘制 layer

        CGFloat lineWidth = 40.0;
        CGFloat rectSide = self.bounds.size.width - lineWidth;
//        UIBezierPath*path = [ UIBezierPath bezierPathWithArcCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:rectSide / 2 startAngle: -7.0/ 6 * M_PI endAngle: -11.0/ 6* M_PI clockwise: YES];
        UIBezierPath*path = [ UIBezierPath bezierPathWithArcCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:rectSide / 2 startAngle: startAngle endAngle: ((1.0/6) * M_PI) clockwise: true];
//        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:rectSide/2 startAngle:M_PI / 4 + M_PI / 2 endAngle:M_PI / 4 clockwise:YES];
        CAShapeLayer*shapeLayer = [ CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = [ UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [ UIColor whiteColor].CGColor;
        shapeLayer.lineWidth = lineWidth;
        // 两边圆角
//        shapeLayer.lineCap = @"round";
        self.layer.mask = shapeLayer;
        
        
        CGFloat lineWidth2 = 20.0;
        CGFloat rectSide2 = self.bounds.size.width - lineWidth2 - 20;
//        UIBezierPath*path2 = [ UIBezierPath bezierPathWithArcCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:rectSide2 / 2 startAngle: startAngle endAngle: startAngle + angle - 0.01 clockwise: YES];
//        CAShapeLayer*shapeLayer2 = [ CAShapeLayer layer];
//        shapeLayer2.path = path2.CGPath;
//        shapeLayer2.fillColor = [ UIColor clearColor].CGColor;
//        shapeLayer2.strokeColor = [ UIColor greenColor].CGColor;
//        shapeLayer2.lineWidth = lineWidth2;
//        [self.layer addSublayer:shapeLayer2];

        
        for (int i = 0; i < 20; i++) {
            UIBezierPath*path = [ UIBezierPath bezierPathWithArcCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:rectSide2 / 2 startAngle: startAngle + angle * i endAngle: startAngle + angle * (i + 1) - 0.01 clockwise: YES];
            CAShapeLayer*shapeLayer = [ CAShapeLayer layer];
            shapeLayer.path = path.CGPath;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.strokeColor = [UIColor greenColor].CGColor;
            shapeLayer.lineWidth = lineWidth2;
            [self.layer addSublayer:shapeLayer];
        }

    }
    return self;
}


//
//static inline float radians(double degrees) {
//    return degrees * M_PI / 180;
//}
//
//
//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();//获得当前view的图形上下文(context)
//        //设置填充颜色
//        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
//        //设置画笔颜色
//    //    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
//        //设置画笔线条粗细
//        CGContextSetLineWidth(context, 10);
//
//        //扇形参数
//        double radius; //半径
//        if(self.frame.size.width>self.frame.size.height){
//            radius=self.frame.size.height/2-self.frame.size.height/10;
//        }else{
//            radius=self.frame.size.width/2-self.frame.size.width/10;
//        }
//        int startX=self.frame.size.width/2;//圆心x坐标
//        int startY=self.frame.size.height/2;//圆心y坐标
//        double pieStart=270;//起始的角度
//        int clockwise=1;//0=逆时针,1=顺时针
//
//        //顺时针画扇形
//        CGContextMoveToPoint(context, startX, startY);
//        CGContextAddArc(context, startX, startY, radius, radians(360 * 0.5), radians(pieStart +360 * 0.5), clockwise);
//        CGContextClosePath(context);
//    //    CGContextDrawPath(context, kCGPathEOFillStroke);
//        CGContextFillPath(context);
//
//        clockwise=0;//0=逆时针,1=顺时针
//        CGContextSetRGBStrokeColor(context, 255, 153, 0, 1);
//        CGContextSetRGBFillColor(context, 255, 153, 0, 1);
//        //逆时针画扇形
//        CGContextMoveToPoint(context, startX, startY);
//        CGContextAddArc(context, startX, startY, radius, radians(360 * 0.5), radians(pieStart +360 * 0.5), clockwise);
//        CGContextClosePath(context);
//    //    CGContextDrawPath(context, kCGPathEOFillStroke);
//        CGContextFillPath(context);
//
//        //    画圆
//        CGContextBeginPath(context);
//        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
//        CGRect circle = CGRectInset(self.bounds, 10, 10);
//        CGContextAddEllipseInRect(context, circle);
//        CGContextFillPath(context);
//}

@end
