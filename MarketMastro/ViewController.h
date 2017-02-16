//
//  ViewController.h
//  MarketMastro
//
//  Created by Mac on 10/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController {
    BOOL keyboardIsShowing;

}

@property(nonatomic,copy)NSString *strIsSigned;
@property (weak, nonatomic) IBOutlet UIButton *btnTerms;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivacy;
@property (weak, nonatomic) IBOutlet UILabel *lblAnd;
@property (weak, nonatomic) IBOutlet UILabel *lblAccept;


@property (nonatomic, strong) IBOutlet UITextField *txtFieldFullName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldMobileNumber;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldLocation;

@property (weak, nonatomic) IBOutlet UIButton *btnTxtLocation;

@property (weak, nonatomic) IBOutlet UITableView *tableLocation;

@property (weak, nonatomic) IBOutlet UIView *viewForLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnTxtReferalCode;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldReferalCode;
@property (nonatomic, strong) IBOutlet UIButton *btnCheckAndUncheckPrivacy;
@property (nonatomic, strong) IBOutlet UIButton *btnRegister;
@property (nonatomic, strong) IBOutlet UIButton *btnSignIn;
@property (nonatomic, strong) IBOutlet UILabel *lableTerms;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckUncheck;


- (IBAction)btnRegisterTapped:(id)sender;
- (IBAction)btnTxtLocationTapped:(id)sender;
- (IBAction)btnReferalCodeTapped:(id)sender;
- (IBAction)btnTermsOfserviceTapped:(id)sender;
- (IBAction)btnPrivacyPolicyTapped:(id)sender;
- (IBAction)btnSignInTapped:(id)sender;

- (IBAction)MethodForTermsOfService:(id)sender;


@end

