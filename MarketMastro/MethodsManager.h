//
//  MethodsManager.h
//  MarketMastro
//
//  Created by DHARMESH on 23/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodsManager : NSObject
{
    // whatever instance vars you want
    UIImageView *imgViewLoading;
    UIView *transperentView;
}

+ (MethodsManager *)sharedManager;   // class method to return the singleton object

- (void)customMethod; // add optional methods to customize the singleton class

- (BOOL)isInternetAvailable;
- (void)loadingView:(UIView*)view;
- (void)StopAnimating;

@end
