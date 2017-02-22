//
//  HPClass.m
//  MarketMastro
//
//  Created by Harish Patra on 29/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "HPClass.h"

static HPClass *instance = nil;
static dispatch_queue_t SQLQueue;

@implementation HPClass

+ (id)sharedInstanse {
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc] init];
        });
    }
    return instance;
}

#pragma mark - UpDownRateColor
- (void)rateUpSetColor:(UIView*)bgView {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *newBezier = [UIBezierPath bezierPath];
    
    [newBezier moveToPoint:CGPointMake(0, 15)];//(3*tempBtn.frame.size.height)/4
    [newBezier addLineToPoint:CGPointMake(0, 0)];
    [newBezier addLineToPoint:CGPointMake(15, 0)];
    [newBezier addQuadCurveToPoint:CGPointMake(0, 15) controlPoint:CGPointMake(3, 3)];
    [newBezier closePath];
    
    shapeLayer.path = newBezier.CGPath;
    shapeLayer.fillColor = [UIColor colorWithRed:41/255.0f green:84/255.0f blue:134/255.0f alpha:1.0f].CGColor;
    shapeLayer.fillRule = kCAFillRuleNonZero;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineJoin = kCALineJoinMiter;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = RateDownCGColor;
    if ([[bgView.layer.sublayers lastObject] isKindOfClass:[CAShapeLayer class]]) {
        [bgView.layer replaceSublayer:[bgView.layer.sublayers lastObject] with:shapeLayer];
    }
    else {
        [bgView.layer addSublayer:shapeLayer];
    }
}
- (void)rateDownSetColor:(UIView*)bgView {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *newBezier = [UIBezierPath bezierPath];
    
    [newBezier moveToPoint:CGPointMake(0, CGRectGetHeight(bgView.bounds)-15)];//(3*tempBtn.frame.size.height)/4
    [newBezier addLineToPoint:CGPointMake(0, bgView.bounds.size.height)];
    [newBezier addLineToPoint:CGPointMake(15, CGRectGetHeight(bgView.bounds))];
    [newBezier addQuadCurveToPoint:CGPointMake(0, CGRectGetHeight(bgView.bounds)-15) controlPoint:CGPointMake(3, bgView.bounds.size.height-3)];
    [newBezier closePath];
    
    shapeLayer.path = newBezier.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.fillRule = kCAFillRuleNonZero;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineJoin = kCALineJoinMiter;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = RateDownCGColor;
    if ([[bgView.layer.sublayers lastObject] isKindOfClass:[CAShapeLayer class]]) {
        [bgView.layer replaceSublayer:[bgView.layer.sublayers lastObject] with:shapeLayer];
    }
    else {
        [bgView.layer addSublayer:shapeLayer];
    }
}
@end
