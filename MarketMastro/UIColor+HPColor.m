//
//  UIColor+HPColor.m
//  MarketMastro
//
//  Created by Harish Patra on 27/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "UIColor+HPColor.h"

@implementation UIColor (HPColor)

+ (UIColor *)colorwithHexString:(NSString *)hexStr
{
    return [self colorwithHexString:hexStr alpha:1.0];
}

+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

+ (UIColor *)colorwithAlphaHexString:(NSString *)hexStr {
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:((CGFloat) ((hexint & 0xFF0000) >> 24))/255];
    
    return color;
}
@end
