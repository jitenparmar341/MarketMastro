//
//  AppDelegate.h
//  MarketMastro
//
//  Created by Mac on 10/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertViewController.h"
#import <UserNotifications/UserNotifications.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>
{
    
}

@property (nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,readwrite) BOOL isListClicked;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * navController;
extern int indexOfDrawer;

+ (AppDelegate *)sharedAppDelegate;

//anurag commiited

@end
