//
//  AppConstants.m
//  MarketMastro
//
//  Created by DHARMESH on 21/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "AppConstants.h"

@implementation AppConstants

static AppConstants *instance = nil;

+(AppConstants *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [AppConstants new];
        }
    }
    return instance;
}

@end
