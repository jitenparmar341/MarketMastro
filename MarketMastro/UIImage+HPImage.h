//
//  UIImage+HPImage.h
//  MarketMastro
//
//  Created by Harish Patra on 08/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HPImage)

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageFromColor:(UIColor *)color;

@end
