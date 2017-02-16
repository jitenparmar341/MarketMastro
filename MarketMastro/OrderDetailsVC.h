//
//  OrderDetailsVC.h
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsVC : UIViewController


@property(nonatomic,copy)NSMutableArray *ArrayHistoryDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblOrderID;
@property (weak, nonatomic) IBOutlet UILabel *lblTxnID;
@property (weak, nonatomic) IBOutlet UILabel *lblDateSubscribedOn;
@property (weak, nonatomic) IBOutlet UILabel *lblPackageName;
@property (weak, nonatomic) IBOutlet UILabel *lblAdd;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiredOn;
@property (weak, nonatomic) IBOutlet UILabel *lblpaidVia;
@property (weak, nonatomic) IBOutlet UILabel *lblPackagedPrize;
@property (weak, nonatomic) IBOutlet UILabel *lblpromoCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCredit;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;

@property (weak, nonatomic) IBOutlet UIButton *btnPrize;

- (IBAction)btnprizeTapped:(id)sender;
- (IBAction)btnStatusTapped:(id)sender;

@end
