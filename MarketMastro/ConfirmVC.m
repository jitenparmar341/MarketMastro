//
//  ConfirmVC.m
//  MarketMastro
//
//  Created by jiten on 16/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "ConfirmVC.h"
#import "ModeOfPaymentVC.h"
#import "TransactionVC.h"

@interface ConfirmVC ()

@end

@implementation ConfirmVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Confirmation";
    
    self.btnChangePayment.layer.cornerRadius = 2;
    self.btnChangePayment.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btnChangePayment.layer.borderWidth = 1.0f;
    self.btnChangePayment.clipsToBounds = true;
    
    self.btnCallAssistance.layer.cornerRadius = 2;
    self.btnCallAssistance.clipsToBounds = true;
    
    // Do any additional setup after loading the view.
}

#pragma mark - Button Click Method

- (IBAction)btnChangePaymentClicked:(UIButton *)sender
{
    ModeOfPaymentVC *mode = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeOfPaymentVC"];
    
    [[self navigationController]pushViewController:mode animated:true];
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)callingForDeposit:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://+91 9898005511"]];
}

-(IBAction)btnCallForAssist:(id)sender
{
    TransactionVC *transaction = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionVC"];
    
    [[self navigationController]pushViewController:transaction animated:true];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://+91 11111111111"]];
}

#pragma mark - Received Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
