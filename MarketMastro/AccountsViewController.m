//
//  AccountsViewController.m
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "AccountsViewController.h"
#import "SWRevealViewController.h"
#import "SubscriptionHistoryVC.h"
#import "UpgradeViewController.h"
#import "webManager.h"
#import "MBProgressHUD.h"
#import "GetPackageListClass.h"
#import "UpgradeDetailsVC.h"
#import "UpdateUserProfileViewController.h"


@interface AccountsViewController ()
{
    NSMutableArray *packageListArray;
    MBProgressHUD *HUD;
    NSString *strCheckifFree;
    NSDateFormatter *dateFormatter;
}
@end

@implementation AccountsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
    [self setValues];
    
    self.title = @"Account";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _btnRenew.hidden = YES;
    packageListArray = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
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
    [self MethodCallPackageListApi];
    [_btnEdit.imageView setContentMode:UIViewContentModeScaleAspectFit];
}

-(void)setValues
{
    NSDictionary *dicOfLoggedInuser = [[NSUserDefaults standardUserDefaults] valueForKey:@"DictOfLogedInuser"];
    
    _lblName.text = [dicOfLoggedInuser valueForKey:@"Name"];
    _lblemail.text = [dicOfLoggedInuser valueForKey:@"Email"];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]valueForKey:@"DicwithCurreentActivePackDetails"];
    
    NSString *dateString =[NSString stringWithFormat:@"%@",[dic valueForKey:@"ExpiredOn"]];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"dd MMM,yyyy"];
    
    dateString = [dateFormatter stringFromDate:dateFromString];
    
    _lbladd.text = [dic valueForKey:@"PackageName"];
    _lblExpiresON.text = [NSString stringWithFormat:@"Expires on %@",dateString];
}

-(void)setUI
{
    //Lato-Bold.ttf
    _lblName.font = [UIFont fontWithName:@"Lato-Bold" size:20];
    _lblemail.font = [UIFont fontWithName:@"Lato-Bold" size:15];
    _lblCurrentSubscription.font = [UIFont fontWithName:@"Lato-Regular" size:14];
    _lbladd.font = [UIFont fontWithName:@"Lato-Regular" size:11];
    _lblExpiresON.font = [UIFont fontWithName:@"Lato-Regular" size:11];
    
    _btnRenew.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:11];
    _btnRenew.layer.cornerRadius = 4;
    _btnRenew.clipsToBounds = YES;
    
    _btnCreditHistory.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:15];
}


-(void)MethodCallPackageListApi
{
    //api/GetPackages
    [[webManager sharedObject]loginRequest:nil withMethod:@"api/GetPackages" successResponce:^(id response)
     {
         
         NSLog(@"get package list api response = %@",response);
         packageListArray = [response mutableCopy];
         [[NSUserDefaults standardUserDefaults]setObject:packageListArray forKey:@"SavedPackageListArray"];
         [self methodCheckPackageIdExistOrNot:packageListArray];
     }
                                   failure:^(NSError *error)
     {
         NSLog(@"get package list api error = %@",error);
     }];
}


-(void)methodCheckPackageIdExistOrNot:(NSMutableArray *)packagelistArray
{
    // GetPackageListClass *instanceGetPackage = [[GetPackageListClass alloc] init];
    // NSString *StrPackageIDFromDashboard = [NSString stringWithFormat:@"%@",instanceGetPackage.PackageID];
    //DicwithCurreentActivePackDetails //PackageID
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]valueForKey:@"DicwithCurreentActivePackDetails"];
    NSString *StrPackageIDFromDashboard = [NSString stringWithFormat:@"%@",[dic valueForKey:@"PackageID"]];
    
    for (int i = 0; i<packagelistArray.count; i++)
    {
        NSString *strpackageID = [NSString stringWithFormat:@"%@",[[packagelistArray objectAtIndex:i]valueForKey:@"PackageID"]];
        
        if ([StrPackageIDFromDashboard isEqualToString:strpackageID])
        {
            //show renew btn on dashboard
            _btnRenew.hidden = NO;
            NSString *str = [[packagelistArray objectAtIndex:i] valueForKey:@"isFree"];
            strCheckifFree = [NSString stringWithFormat:@"%@",str];
        }
        else
        {
            //dont show renew btn on dashboard
            _btnRenew.hidden = YES;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnSubscriberBtnClick:(id)sender
{
    SubscriptionHistoryVC *subscriptionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionHistoryVC"];
    [self.navigationController pushViewController:subscriptionVC animated:YES];
}

-(IBAction)btnUpgradeBtnClick:(id)sender
{
    UpgradeViewController *subscriptionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UpgradeViewController"];
    subscriptionVC.is_NotFromDraw = YES;
    [self.navigationController pushViewController:subscriptionVC animated:YES];
    
}
-(IBAction)alertListBtnClick:(id)sender
{
    AlertViewController *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    calendarVC.is_NotFromDraw = YES;
    
    [self.navigationController pushViewController:calendarVC animated:YES];
}

- (IBAction)btnCreditHistoryTapped:(id)sender
{
    ContactUsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnEditTapped:(id)sender
{
    UpdateUserProfileViewController *update = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateUserProfileViewController"];
    //    update.Dicupdatedetails
    [self.navigationController pushViewController:update animated:YES];
}

- (IBAction)btnRenewTapped:(id)sender
{
    //packageListArray
    if ([strCheckifFree isEqualToString:@"1"])
    {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"You cannot renew free package" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
    }
    else
    {
        UpgradeDetailsVC *upgrade = [self.storyboard instantiateViewControllerWithIdentifier:@"UpgradeDetailsVC"];
        [self.navigationController pushViewController:upgrade animated:YES];
    }
}

@end
