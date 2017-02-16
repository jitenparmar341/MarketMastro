//
//  TransactionVC.m
//  MarketMastro
//
//  Created by jiten on 16/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "TransactionVC.h"
#import "ModeOfPaymentVC.h"
#import "FirstFourVC.h"

@interface TransactionVC ()

@end

@implementation TransactionVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btnChngPay.layer.cornerRadius = 2;
    self.btnChngPay.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btnChngPay.layer.borderWidth = 1.0f;
    self.btnChngPay.clipsToBounds = true;
    
    self.btnCanOrd.layer.cornerRadius = 2;
    self.btnCanOrd.clipsToBounds = true;
    
    self.title = @"Transaction Failure";
    
    // Do any additional setup after loading the view.
}

#pragma mark - Button Click Method

- (IBAction)btnChangePaymentClicked:(UIButton *)sender
{
    ModeOfPaymentVC *mode = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeOfPaymentVC"];
    
    [[self navigationController]pushViewController:mode animated:true];
}

- (IBAction)btnCancelOrderClicked:(UIButton *)sender
{
    FirstFourVC *home = (FirstFourVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"FirstFourVC"];
    
    [[self navigationController]pushViewController:home animated:true];
}

-(IBAction)btnCallforAssist:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://11111111111"]];
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Received Memory Warning

- (void)didReceiveMemoryWarning
{
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

@end
