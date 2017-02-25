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
#import <UserNotifications/UserNotifications.h>

#import "SQLiteDatabase.h"

#import "Firebase.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface AppDelegate ()

@end


@implementation AppDelegate

int indexOfDrawer;

//UIApplicationDelegate,UNUserNotificationCenterDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //firebase
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self firebaseSetUp];
    
    [[SQLiteDatabase databaseWithFileName:@"LKSDB"] setAsSharedInstance];
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *Path=[DocumentsPath stringByAppendingPathComponent:@"LKSDB.db"];//@"staffDB.sqlite"
    NSString *bundlepath=[[NSBundle mainBundle]pathForResource:@"LKSDB" ofType:@"db"];
    
    [self registerForRemoteNotificationFrom:@"1"];
    
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
    NSLog(@"UUID : %@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]);
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

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"DeviceToken: %@", [deviceToken description]);
    NSString *deviceTokenStr = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSLog(@"Device Token : %@", deviceTokenStr);
    // Send token to server
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"APNsDeviceToken"] isEqualToString:deviceTokenStr]) {
        NSLog(@"Same");
    }
    else {
        NSLog(@"Change/New");
        [[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:@"APNsDeviceToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self methodForUpdateDeviceDetails];
    }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Error for getting device token = %@",str);
}

+ (AppDelegate *)sharedAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - UNUserNotificationCenterDelegate
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    //Called when a notification is delivered to a foreground app.
    
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    //Called to let your app know which action was selected by the user for a given notification.
    
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
}

#pragma mark - UIUserNotificationSettings
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

#pragma mark - ReceiveRemoteNotification
//- (vo id)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    NSLog(@"%ld---\nuserInfo : %@",(long)application.applicationState, userInfo);
    //    [self handleNotification:[[userInfo objectForKey:@"aps"] objectForKey:@"data"]];
//    [self handleNotification:[userInfo objectForKey:NewsKey]];
//}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    NSLog(@"%ld---\nuserInfo : %@",(long)application.applicationState, userInfo);
    // iOS 10 will handle notifications through other methods
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        NSLog(@"INACTIVE");
    }
    else if([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        NSLog(@"BACKGROUND");
    }
    else {
        NSLog(@"FOREGROUND");
    }
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        NSLog( @"iOS version >= 10. Let NotificationCenter handle this one." );
        // set a member variable to tell the new delegate that this is background
        return;
    }
    
    // custom code to handle notification content
//    NSDictionary *apsPayload = [userInfo objectForKey:@"aps"];
    if ([[userInfo objectForKey:@"msgtype"] isEqualToString:@"ALT"]) {
        [self notificationForALT:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
    else if ([[userInfo objectForKey:@"msgtype"] isEqualToString:@"MST"]) {
        [self notificationForMST:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
    else if ([[userInfo objectForKey:@"msgtype"] isEqualToString:@"OTH"]) {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}

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

#pragma mark - PushNotification
- (void)registerForRemoteNotificationFrom:(NSString*)isFrom {
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0") && FALSE) {
        UNUserNotificationCenter *uNUserNCenter = [UNUserNotificationCenter currentNotificationCenter];
        [uNUserNCenter setDelegate:self];
        [uNUserNCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted || !error) {
                NSLog(@"Notification Granted Success");
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            else {
                NSLog(@"Notification Granted Fail");
                NSLog(@"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription);
                NSLog(@"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion);
            }
        }];
    }
    else {
        UIUserNotificationSettings *userNotificationSetting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:userNotificationSetting];
    }
}

-(void)methodForUpdateDeviceDetails {
    NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if (strUserID.length==0) {
        return;
    }
    NSString *model = [[UIDevice currentDevice] model];
    NSString *iOSVersion = [[UIDevice currentDevice] systemVersion];
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *aPNDeviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"APNsDeviceToken"];
    
    NSDictionary *parameter = @{
                                @"UserID":strUserID,
                                @"DeviceUUID":UUID,
                                @"DeviceOSVersion":iOSVersion,
                                @"DeviceModel":model,
                                @"DeviceNotifyRegisterId":aPNDeviceToken,
                                @"DeviceIMEI":@"",
                                @"DeviceManufacturer":@"Apple",
                                @"DeviceOS":iOSVersion,
                                @"DeviceSerialNo":@"",
                                @"DeviceWifiMac":@"",
                                };
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager] isInternetAvailable];
    if (isNetworkAvailable) {
        [[webManager sharedObject] CallPostMethod:parameter withMethod:@"/api/UserDetails/PutDeviceDetails" successResponce:^(id response) {
             NSLog(@"api/UserDetails/PutDeviceDetails response = %@",response);
         }
                                          failure:^(NSError *error) {
             NSLog(@"api/UserDetails/PutDeviceDetails error = %@", error.localizedDescription);
         }];
    }
}

#pragma mark - NotificationReceivedProccess
- (void)notificationForALT:(NSDictionary*)payload {
    NSString *updateQuery;
//    updateQuery = [NSString stringWithFormat:@"UPDATE Alert SET isRead=0, isExecuted=1, CreatedDateTime=%@, Text=%@, CreatedOn=%@ WHERE AlertID=%@", time, alertText, timeInSeconds, AlertID];
    [[SQLiteDatabase sharedInstance] executeUpdate:updateQuery withParams:nil success:^(SQLiteResult *result) {
        if (!result) {
            NSLog(@"QueryFail : %@", updateQuery);
        }
    } failure:^(NSString *errorMessage) {
        NSLog(@"QueryFail : %@\ErrorMSG : %@", updateQuery, errorMessage);
    }];
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        NSLog(@"ACTIVE");
        //To Show Custom PopUp
    }
}
- (void)notificationForMST:(NSDictionary*)payload {
    
}
@end
