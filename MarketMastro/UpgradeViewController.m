//
//  UpgradeViewController.m
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "UpgradeViewController.h"
#import "UpgradeDetailsVC.h"
#import "SWRevealViewController.h"
#import "CustomSelPack.h"

#import "ModeOfPaymentVC.h"

#import "FirstFourVC.h"

@interface UpgradeViewController ()
{
    NSMutableArray *menuItems;
}
@end

@implementation UpgradeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select Package";
    menuItems = [NSMutableArray array];
    
    /*
    NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"Free - MCX only version" forKey:@"main"];
    [dicData setValue:@"30 Days Trial" forKey:@"sub"];
    [dicData setValue:@"₹25" forKey:@"price"];
    [menuItems addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"With Ad - MCX only version" forKey:@"main"];
    [dicData setValue:@"30 Days Trial" forKey:@"sub"];
    [dicData setValue:@"₹50" forKey:@"price"];
    [menuItems addObject:dicData];
    */
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if(!_is_NotFromDraw)
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if ( revealViewController )
        {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
    }
    else{
        [self.sidebarButton setImage:[UIImage imageNamed:@"back-button"]];
        [self.sidebarButton setTarget: self];
        [self.sidebarButton setAction: @selector( goBack: )];
        
    }
    
    // Do any additional setup after loading the view.
    [self callPackageListApi];//Harish
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
    return menuItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"market";
    
    CustomSelPack *cell = (CustomSelPack*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dicData = [menuItems objectAtIndex:indexPath.section];
    
    if (![[dicData allKeys] containsObject:@"main"]) {
        cell.lblMain.text = [dicData objectForKey:@"PackageName"];
        if ([[dicData objectForKey:@"PackageValidity"] isKindOfClass:[NSNumber class]]) {
            cell.lblSub.text = [[dicData objectForKey:@"PackageValidity"] stringValue];
        }
        else if ([[dicData objectForKey:@"PackageValidity"] isKindOfClass:[NSString class]]) {
            cell.lblSub.text = [dicData objectForKey:@"PackageValidity"];
        }
        if ([[dicData objectForKey:@"isFree"] isKindOfClass:[NSNumber class]]) {
            if ([[dicData objectForKey:@"isFree"] intValue] == 1)
                cell.lblPrice.text = @"Free";
            else
                cell.lblPrice.text = [dicData objectForKey:@"PackagePrice"];
        }
        else if ([[dicData objectForKey:@"isFree"] isKindOfClass:[NSString class]]) {
            if ([[dicData objectForKey:@"isFree"] isEqualToString:@"1"])
                cell.lblPrice.text = @"Free";
            else
                cell.lblPrice.text = [dicData objectForKey:@"PackagePrice"];
        }
    }
    else {
        cell.lblMain.text = [dicData objectForKey:@"main"];
        cell.lblSub.text = [dicData objectForKey:@"sub"];
        cell.lblPrice.text = [dicData objectForKey:@"price"];
    }
    
    cell.viewPrice.layer.cornerRadius = cell.viewPrice.frame.size.width/2;
    cell.viewPrice.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.viewPrice.layer.borderWidth = 0.5;
    cell.viewPrice.clipsToBounds = true;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Harish
    if (_isFrom==1) {
        NSDictionary *tDic = [menuItems objectAtIndex:indexPath.section];
        if ([[tDic objectForKey:@"isFree"] isKindOfClass:[NSNumber class]]) {
            if ([[tDic objectForKey:@"isFree"] intValue] == 1)
                [self subscribeToPackage:[menuItems objectAtIndex:indexPath.section]];
        }
        else if ([[tDic objectForKey:@"isFree"] isKindOfClass:[NSString class]]) {
            if ([[tDic objectForKey:@"isFree"] isEqualToString:@"1"])
                [self subscribeToPackage:[menuItems objectAtIndex:indexPath.section]];
        }
    }
    else {
        ModeOfPaymentVC *upgradeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeOfPaymentVC"];
        [self.navigationController pushViewController:upgradeVC animated:YES];
    }
}
//Harish
#pragma mark - PackagesList
-(void)callPackageListApi
{
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    //api/GetPackages
    if (isNetworkAvailable) {
        [[webManager sharedObject]loginRequest:nil withMethod:@"api/GetPackages" successResponce:^(id response)
         {
             
             NSLog(@"get package list api response = %@",response);
             NSMutableArray *packageArr = [response mutableCopy];
             menuItems = packageArr;
             [_tblView reloadData];//Harish
         }
                                       failure:^(NSError *error)
         {
             NSLog(@"get package list api error = %@",error);
             [_tblView reloadData];
         }];
    }
}
#pragma mark - PostUserSubscription
- (void)subscribeToPackage:(NSDictionary*)packageDic {
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    if (isNetworkAvailable) {
        NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        strUserID = [NSString stringWithFormat:@"%@",strUserID];
        
        NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
        [requestDic setObject:strUserID forKey:@"UserID"];
        [requestDic setObject:[packageDic objectForKey:@"PackageID"] forKey:@"PackageID"];
        [requestDic setObject:@"" forKey:@"PCUsed"];
        [requestDic setObject:@"0" forKey:@"PCValue"];
        [requestDic setObject:@"0" forKey:@"CPUsed"];
        [requestDic setObject:@"0" forKey:@"CreditValue"];
        [requestDic setObject:@"Offline" forKey:@"PaymentMode"];
        [requestDic setObject:@"0" forKey:@"PaymentMade"];
        [requestDic setObject:@"Completed" forKey:@"PurchasedStatus"];
        [requestDic setObject:@"0" forKey:@"TransactionID"];
        
        [[webManager sharedObject] CallPostMethod:requestDic withMethod:@"api/PostUserSubscription" successResponce:^(id response) {
            NSDictionary *responseDic;
            if ([response isKindOfClass:[NSDictionary class]]) {
                responseDic = (NSDictionary*)response;
                
                [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Thank You" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
                //FirstFourVC
                FirstFourVC *dashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstFourVC"];
                [self.navigationController pushViewController:dashboard animated:YES];
            }
        } failure:^(NSError *error) {
            NSLog(@"api/PostUserSubscription error = %@", error);
        }];
    }
}

@end
