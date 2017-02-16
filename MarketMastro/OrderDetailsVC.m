//
//  OrderDetailsVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "OrderDetailsVC.h"

@interface OrderDetailsVC ()

@end

@implementation OrderDetailsVC
@synthesize ArrayHistoryDetail;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Order Details";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self setUpValues];
}

-(void)setUpValues
{
    
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    
    NSLog(@"ArrayHistoryDetail = %@",ArrayHistoryDetail);
    
    if ([ArrayHistoryDetail valueForKey:@"USOrderID"] != nil)
    {
        _lblOrderID.text = [NSString stringWithFormat:@"Order Id #%@",[ArrayHistoryDetail valueForKey:@"USOrderID"]];
    }
    else
    {
        _lblOrderID.hidden = YES;
    }
    
    
    if ([ArrayHistoryDetail valueForKey:@"TransactionID"] != nil)
    {
       _lblTxnID.text = [NSString stringWithFormat:@"Txn Id #%@",[ArrayHistoryDetail valueForKey:@"TransactionID"]];
    }
    else
    {
        _lblTxnID.hidden = YES;
    }

    
    if ([ArrayHistoryDetail valueForKey:@"PurchasedOn"] != nil)
    {
        _lblDateSubscribedOn.text = [NSString stringWithFormat:@"%@",[ArrayHistoryDetail valueForKey:@"PurchasedOn"]];
    }
    else
    {
        _lblDateSubscribedOn.hidden = YES;
    }
    
    if ([ArrayHistoryDetail valueForKey:@"PackageName"] != nil)
    {
         _lblPackageName.text = [NSString stringWithFormat:@"%@",[ArrayHistoryDetail valueForKey:@"PackageName"]];
    }
    else
    {
        _lblPackageName.hidden = YES;
    }
    
   
    
    BOOL isWithAdd = [[ArrayHistoryDetail valueForKey:@"WithAd"] boolValue];
    
    if (isWithAdd)
    {
        _lblAdd.text = @"With Ad";
    }
    else
    {
        _lblAdd.text = @"No Ad";
    }
    
    
    if ([ArrayHistoryDetail valueForKey:@"ExpiredOn"] != nil)
    {
         _lblExpiredOn.text = [NSString stringWithFormat:@"Expires On %@",[ArrayHistoryDetail valueForKey:@"ExpiredOn"]];
    }
    else
    {
        _lblExpiredOn.hidden = YES;
    }
    
    if ([ArrayHistoryDetail valueForKey:@"PaymentMode"] != nil)
    {
        _lblpaidVia.text =  [NSString stringWithFormat:@"Paid via %@",[ArrayHistoryDetail valueForKey:@"PaymentMode"]];
    }
    else
    {
        _lblpaidVia.hidden = YES;
    }
    
    
    if ([ArrayHistoryDetail valueForKey:@"Paid"] != nil)
    {
        NSString *strPrice = [NSString stringWithFormat:@"Paid ₹ %@",[ArrayHistoryDetail valueForKey:@"Paid"]];
        [_btnPrize setTitle:strPrice forState:UIControlStateNormal];
    }
    else
    {
        NSString *strPrice = [NSString stringWithFormat:@"Paid ₹ 0"];
        [_btnPrize setTitle:strPrice forState:UIControlStateNormal];
    }
    
    NSString *strPurchasedStatus = [NSString stringWithFormat:@"%@",[ArrayHistoryDetail valueForKey:@"PurchasedStatus"]];
    
    //#347A24  >>green color >>rgb >>52, 122,36
    //#BA1E1A  >>red color >>rgb >> 186,30,26
    
    if ([strPurchasedStatus isEqualToString:@"Completed"])
    {
        [_btnStatus setTitle:@"Success" forState:UIControlStateNormal];
        _btnStatus.backgroundColor = [UIColor colorWithRed:52/255.0 green:122/255.0 blue:36/255.0 alpha:1.0];
    }
    else if ([strPurchasedStatus isEqualToString:@"Failed"])
    {
        [_btnStatus setTitle:@"Transaction Failed" forState:UIControlStateNormal];
         _btnStatus.backgroundColor = [UIColor colorWithRed:186/255.0 green:30/255.0 blue:26/255.0 alpha:1.0];
    }
    else
    {
        [_btnStatus setTitle:strPurchasedStatus forState:UIControlStateNormal];
        _btnStatus.backgroundColor = [UIColor colorWithRed:186/255.0 green:30/255.0 blue:26/255.0 alpha:1.0];
    }
    _btnStatus.layer.cornerRadius = 3;
    _btnStatus.clipsToBounds = YES;
    _btnPrize.layer.cornerRadius = 3;
    _btnPrize.clipsToBounds = YES;
}


-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnprizeTapped:(id)sender {
}

- (IBAction)btnStatusTapped:(id)sender {
}
@end
