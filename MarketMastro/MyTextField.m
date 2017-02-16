//
//  MyTextField.m
//  MarketMastro
//
//  Created by Vodlo iMac 022 on 22/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "MyTextField.h"

IB_DESIGNABLE
@implementation MyTextField

@synthesize padding;

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, padding, padding);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}
@end