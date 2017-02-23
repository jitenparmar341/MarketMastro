//
//  UpdateUserProfileViewController.h
//  MarketMastro
//
//  Created by DHARMESH on 17/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateUserProfileViewController : UIViewController
{
    __weak IBOutlet UIImageView *imgProfile;
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtLocation;
    __weak IBOutlet UIButton *btnUpdate;
    NSMutableDictionary *dictOfLogedInUser;
}

@property (weak, nonatomic) IBOutlet UIButton *BtnTextLocation;
@property (nonatomic,copy)NSDictionary *Dicupdatedetails;
@property (weak, nonatomic) IBOutlet UITableView *tableviewCity;
@property (weak, nonatomic) IBOutlet UIView *viewForLocation;

- (IBAction)BtnUpdateTapped:(id)sender;
- (IBAction)btntextLocationTapped:(id)sender;

@end
