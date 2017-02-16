//
//  ContactUsViewController.h
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController
{
    UITextField *txtRef;
}
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

//@property (strong, nonatomic) UITableView *tableOfTypes;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *btnsend;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtType;
@property (weak, nonatomic) IBOutlet UITextView *textViewDesciption;
@property (weak, nonatomic) IBOutlet UITextField *txtname;
- (IBAction)btnsendTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *viewOfTable;
@property (weak, nonatomic) IBOutlet UITableView *tableOfTypes;

@end
