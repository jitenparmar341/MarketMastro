//
//  SubscriptionHistoryVC.m
//  MarketMastro
//
//  Created by Vodlo iMac 022 on 22/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "SubscriptionHistoryVC.h"
#import "OrderDetailsVC.h"
#import "webManager.h"
#import "MBProgressHUD.h"
#import "SubscriptionHistoryCell.h"
#import "GetPackageListClass.h"
#import "UpgradeDetailsVC.h"

@interface SubscriptionHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menuItems;
    MBProgressHUD *HUD;
    NSMutableArray *ArraySubscriptionhistory;
    GetPackageListClass *instanceActivePackage;
    NSString *strUSorderID;
    NSString *StrSavedPackageID;
    
}
@end

@implementation SubscriptionHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpValues];
    
    self.title = @"Subscription History";
    
    [self MethodCallSubscriptionApi];
    
    menuItems = @[@"market",@"market2"];
  
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)setUpValues
{
    [self GetActivePackageValues];
    ArraySubscriptionhistory = [[NSMutableArray alloc] init];
}

-(void)GetActivePackageValues
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]valueForKey:@"DicwithCurreentActivePackDetails"];
    strUSorderID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"USOrderID"]];
    
    NSDictionary *dic2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"SavedPackageListArray"];
    StrSavedPackageID = [NSString stringWithFormat:@"%@",[[dic2 valueForKey:@"PackageID"]componentsJoinedByString:@""]];
    
}

-(void)MethodCallSubscriptionApi
{
    NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        if (strUserID != nil)
        {
            [[MethodsManager sharedManager]loadingView:self.view];
            [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/GetUserSubscriptionHistory/%@",strUserID] successResponce:^(id response)
             {
                  [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"get subscription histrory response = %@",response);
                 ArraySubscriptionhistory = [response mutableCopy];
                 [_tableviewSubscriptionHistory reloadData];
             }
            failure:^(NSError *error)
             {
                 [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"get subscription histrory error = %@",error);
             }];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        }
    }
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //    return menuItems.count;
    return ArraySubscriptionhistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"historyCell";
    SubscriptionHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[SubscriptionHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:MyIdentifier] ;
    }
    
    cell.btnActive.hidden = YES;
    cell.btnRenew.hidden = YES;
    cell.btnRenew.layer.cornerRadius = 4;
    cell.btnRenew.clipsToBounds = YES;
    cell.btnActive.layer.cornerRadius = 4;
    cell.btnActive.clipsToBounds = YES;
    
    
    cell.btnRenew.tag = indexPath.row;
    [cell.btnRenew addTarget:self action:@selector(btnRenewTapped) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *dic = [ArraySubscriptionhistory objectAtIndex:indexPath.row];
    
  
    BOOL isExpired = [[dic valueForKey:@"isExpired"] boolValue];
    
    cell.lblorderid.text = [NSString stringWithFormat:@"Order Id #%@",[dic valueForKey:@"USOrderID"]];
    
    cell.LblPackageName.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"PackageName"]];
    
    {
        NSString *strExpiredOn = [NSString stringWithFormat:@"%@",[dic valueForKey:@"ExpiredOn"]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSDate *dateFromString = [dateFormatter dateFromString:strExpiredOn];
        
        [dateFormatter setDateFormat:@"dd MMM, yyyy"];
        
        strExpiredOn = [dateFormatter stringFromDate:dateFromString];
        
        cell.lblValidDate.text = [NSString stringWithFormat:@"Valid Till %@",strExpiredOn];
    }
    
    {
        NSString *strExpiredOn = [NSString stringWithFormat:@"%@",[dic valueForKey:@"PurchasedOn"]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *dateFromString = [dateFormatter dateFromString:strExpiredOn];
        
        [dateFormatter setDateFormat:@"dd MMM, yyyy"];
        
        strExpiredOn = [dateFormatter stringFromDate:dateFromString];
        
        cell.lblSubscribedOn.text =  [NSString stringWithFormat:@"Subscribed On %@",strExpiredOn];
    }
    
    //PurchasedStatus
    
    NSString *strPurchasedStatus = [NSString stringWithFormat:@"%@",[dic valueForKey:@"PurchasedStatus"]];
    
    BOOL isFree = [[dic valueForKey:@"isFree"] boolValue];
    
    NSString *orderID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"USOrderID"]];
    
    if ([strUSorderID isEqualToString:orderID] && isExpired ==0)
    {
        cell.btnActive.hidden = NO;
        
        NSString *strpackageID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"PackageID"]];
        
        if ([StrSavedPackageID isEqualToString:strpackageID])
        {
            //show renew btn on dashboard
            cell.btnRenew.hidden = NO;
        }
        else
        {
            //dont show renew btn on dashboard
            cell.btnRenew.hidden = YES;
        }
    }
    else if (isExpired == 1)
    {
        [cell.btnActive setTitle:@"Expired" forState:UIControlStateNormal];
        cell.btnActive.backgroundColor = [UIColor redColor];
         cell.btnRenew.hidden = YES;
    }
    else if ([strPurchasedStatus isEqualToString:@"Failed"])
    {
        [cell.btnActive setTitle:@"Transaction Failed" forState:UIControlStateNormal];
        cell.btnActive.backgroundColor = [UIColor redColor];
        cell.btnRenew.hidden = YES;
    }
    else if (isExpired == 0)
    {
        [cell.btnActive setTitle:@"Upgraded" forState:UIControlStateNormal];
        cell.btnActive.backgroundColor = [UIColor redColor];
        cell.btnRenew.hidden = YES;
    }
    else
    {
        cell.btnRenew.hidden = YES;
    }
    
    if (isFree)
    {
        cell.btnRenew.hidden = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsVC *upgradeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailsVC"];
    upgradeVC.ArrayHistoryDetail = [ArraySubscriptionhistory objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:upgradeVC animated:YES];
}

-(void)btnRenewTapped
{
    UpgradeDetailsVC *upgrade = [self.storyboard instantiateViewControllerWithIdentifier:@"UpgradeDetailsVC"];
    [self.navigationController pushViewController:upgrade animated:YES];
}

@end
