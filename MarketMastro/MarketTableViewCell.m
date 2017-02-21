//
//  MarketTableViewCell.m
//  MarketMastro
//
//  Created by Harish Patra on 27/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MarketTableViewCell.h"

@implementation MarketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //    UILabel *tLbl;
    //    [_lblLiveRate addConstraint:[NSLayoutConstraint constraintWithItem:_lblLiveRate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20.0f]];
    [_btnOTime_Delete.titleLabel setTextAlignment:NSTextAlignmentRight];
    
    
    
    /*
     _viewBG.layer.shadowColor = [[UIColor whiteColor] colorWithAlphaComponent:.7].CGColor;
     _viewBG.layer.shadowOffset = CGSizeMake(-10.0, 10.0);
     _viewBG.layer.masksToBounds = NO;
     */
    //    [self setUpperDipper];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setUpperDipper {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *newBezier = [UIBezierPath bezierPath];
    
    [newBezier moveToPoint:CGPointMake(0, CGRectGetHeight(_viewBG.bounds)-15)];//(3*tempBtn.frame.size.height)/4
    [newBezier addLineToPoint:CGPointMake(0, _viewBG.bounds.size.height)];
    [newBezier addLineToPoint:CGPointMake(15, CGRectGetHeight(_viewBG.bounds))];
    [newBezier addQuadCurveToPoint:CGPointMake(0, CGRectGetHeight(_viewBG.bounds)-15) controlPoint:CGPointMake(3, _viewBG.bounds.size.height-3)];
    [newBezier closePath];
    
    shapeLayer.path = newBezier.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.fillRule = kCAFillRuleNonZero;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineJoin = kCALineJoinMiter;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [_viewBG.layer addSublayer:shapeLayer];
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_viewBG.bounds byRoundingCorners:(UIRectCornerBottomLeft) cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _viewBG.bounds;
    maskLayer.path  = maskPath.CGPath;
    //    _viewBG.layer.mask = maskLayer;
}
@end
