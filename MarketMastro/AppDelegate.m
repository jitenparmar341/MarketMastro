//
//  AppDelegate.m
//  MarketMastro
//
//  Created by Mac on 10/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FirstFourVC.h"
#import "SWRevealViewController.h"
#import "AccountsViewController.h"
#import "SidebarTableViewController.h"

#import "Firebase.h"

@interface AppDelegate ()

@end


@implementation AppDelegate
int indexOfDrawer;

//UIApplicationDelegate,UNUserNotificationCenterDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //firebase
    [self firebaseSetUp];
    
    [[SQLiteDatabase databaseWithFileName:@"LKSDB"] setAsSharedInstance];
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *Path=[DocumentsPath stringByAppendingPathComponent:@"LKSDB.db"];//@"staffDB.sqlite"
    NSString *bundlepath=[[NSBundle mainBundle]pathForResource:@"LKSDB" ofType:@"db"];
    // NSLog(@"library path= %@",libraryPath);
    
    if([[NSFileManager defaultManager]fileExistsAtPath:Path])
    {
        NSLog(@"database already exists");
    }
    else
    {
        [[NSFileManager defaultManager]copyItemAtPath:bundlepath toPath:Path error:nil];
    }
    
    NSLog(@"database path = %@",Path);
    
    [[NSUserDefaults standardUserDefaults]setObject:Path forKey:@"DBPath"];
    
    //0C1014  >>12, 16 ,20
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:12/255.0 green:16/255.0 blue:20/255.0 alpha:1.0]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    //status bar white color
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //Already Login code >>
    BOOL isAlreadyLogin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"AlreadyLogin"] boolValue];
    //isAlreadyLogin = YES;
    
    if(isAlreadyLogin == YES)
    {
        // [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"AlreadyLogin"];
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        FirstFourVC *home = (FirstFourVC *) [storyboard instantiateViewControllerWithIdentifier:@"FirstFourVC"];
        SidebarTableViewController *slidemenu = (SidebarTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SidebarTableViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        //        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:slidemenu frontViewController:nav];
        // make it as root
        self.window.rootViewController = revealController;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSString *str = [NSString stringWithFormat:@"Device Token=%@",deviceToken];
//    NSLog(@"Device Token = %@", str);
//}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    // Send token to server
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Error for getting device token = %@",str);
}


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)firebaseSetUp {
    [FIRApp configure];
    //    Live//    ca-app-pub-7827419066044802~1199975779
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-7827419066044802~1199975779"];
    [FIRAnalytics setUserID:@"Demo101"];
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"Demo101"],
                                     kFIRParameterItemName:@"Demo",
                                     kFIRParameterContentType:@"AppOpen"
                                     }];
}
@end
