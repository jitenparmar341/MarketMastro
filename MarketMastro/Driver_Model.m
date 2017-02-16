//
//  Driver_Model.m
//  AsiavanDriver
//
//  Created by IsoDev1 on 11/2/15.
//  Copyright © 2015 edreamz. All rights reserved.
//

#import "Driver_Model.h"
#import <Foundation/Foundation.h>

@implementation Driver_Model

+(Driver_Model*)sharedObject
{
    static Driver_Model *objWeb = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objWeb = [[Driver_Model alloc] init];
    });
    return objWeb;
    
}
-(void)initWithData:(NSDictionary*)dict
{
    _driver_details_dict=dict;
}
@end
