//
//  UIColor+HPColor.h
//  MarketMastro
//
//  Created by Harish Patra on 27/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HPColor)
/**
 Hex code to UIColor
 @param hexStr
 NSString formate Supported
 '123ABC'
 '#123ABC'
 '0x123ABC'
 **/
+ (UIColor *)colorwithHexString:(NSString *)hexStr;

/**
 Hex code to UIColor
 Alpha CGFloat value to transparent Color
 @param hexStr
 NSString formate Supported
 '123ABC'
 '#123ABC'
 '0x123ABC'
 
 @param alpha
 CGFloat value to transparent Color
 **/
+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

/**
 Hex code to UIColor.
 Hex code with Alpha
 @param hexStr
 
 NSString formate Supported
 'AARRGGBB'
 '#AARRGGBB'
 '0xAARRGGBB'
 
 
 @param alpha
 CGFloat value to transparent Color
 **/
+ (UIColor *)colorwithAlphaHexString:(NSString *)hexStr;
@end
