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
    
    [self setDoneKeypad];
    
    self.title = @"Subscribe";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.txtPromoCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Do you have promocode?" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    self.btnApply.layer.cornerRadius = self.btnApply.frame.size.width/5.5;
    self.btnApply.clipsToBounds = true;
    
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    txtRef = textField;
    
    return true;
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
    
    if (textField == self.txtBalance)
    {
        if ([string isEqualToString:@""])
            return true;
        
        if (self.txtBalance.text.length > 3)
            return false;
        
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        
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

- (IBAction)btnPromoApplyClicked:(id)sender
{
    if (self.txtPromoCode.text.length == 0)
    {
        [txtRef resignFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"MarketMastro" message:@"Please enter promocode" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
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

-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    self.txtBalance.inputAccessoryView = numberToolbar;
    self.txtPromoCode.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad
{
    [txtRef resignFirstResponder];
}

-(void)doneWithNumberPad
{
    [txtRef resignFirstResponder];
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
