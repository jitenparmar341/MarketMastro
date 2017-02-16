//
//  UIImage+HPImage.m
//  MarketMastro
//
//  Created by Harish Patra on 08/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "UIImage+HPImage.h"

@implementation UIImage (HPImage)

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    return [self imageFromColor:color size:CGSizeMake(1, 1)];
}
@end
