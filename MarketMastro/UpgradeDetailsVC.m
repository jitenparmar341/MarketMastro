//
//  UpgradeDetailsVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "UpgradeDetailsVC.h"
#import "ConfirmVC.h"
#import "ModeOfPaymentVC.h"

@interface UpgradeDetailsVC ()

@end

@implementation UpgradeDetailsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Subscribe";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.txtPromoCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Do you have promocode?" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    self.btnApply.layer.cornerRadius = self.btnApply.frame.size.width/5.5;
    self.btnApply.clipsToBounds = true;

    // Do any additional setup after loading the view.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.txtPromoCode)
    {
        //abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@._
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCheckClicked:(UIButton *)sender
{
    sender.selected =! sender.selected;
}

- (IBAction)btnProceedClicked:(UIButton *)sender
{
    ConfirmVC *confirm = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmVC"];
    
    [[self navigationController]pushViewController:confirm animated:true];
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
