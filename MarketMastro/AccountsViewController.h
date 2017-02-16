//
//  AccountsViewController.h
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic) BOOL is_NotFromDraw;


@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblemail;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilepic;

@property (weak, nonatomic) IBOutlet UIButton *btnCreditHistory;
@property (weak, nonatomic) IBOutlet UIButton *btnSubscription;
@property (weak, nonatomic) IBOutlet UIButton *btnUpgrade;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UILabel *lbladd;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiresON;
@property (weak, nonatomic) IBOutlet UIButton *btnRenew;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentSubscription;


- (IBAction)btnCreditHistoryTapped:(id)sender;
- (IBAction)btnEditTapped:(id)sender;
- (IBAction)btnRenewTapped:(id)sender;

@end
