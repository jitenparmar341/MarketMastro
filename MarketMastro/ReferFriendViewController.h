//
//  ReferFriendViewController.h
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferFriendViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnInviteFriend;
@property (weak, nonatomic) IBOutlet UILabel *lblCreditValue;
@property (weak, nonatomic) IBOutlet UIButton *btnCreditHistory;

- (void)dismissKeyboard;
- (IBAction)btnInviteFriendTapped:(id)sender;
- (IBAction)btnCreditHistoryTapped:(id)sender;

@end
