//
//  HPClass.h
//  MarketMastro
//
//  Created by Harish Patra on 29/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPClass : NSObject

//@property (strong, nonatomic) UIColor *rateDownColor;
//@property (strong, nonatomic) UIColor *rateUpColor;

+ (id)sharedInstanse;

- (void)rateUpSetColor:(UIView*)bgView;
- (void)rateDownSetColor:(UIView*)bgView;

@end
