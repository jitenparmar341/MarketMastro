//
//  RequestViewController.m
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "RequestViewController.h"
#import "SWRevealViewController.h"
#import "webManager.h"
#import "AFURLRequestSerialization.h"
#import "MBProgressHUD.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "TPKeyboardAvoidingScrollView.h"


@interface RequestViewController ()<UITextViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    MBProgressHUD *HUD;
    FLAnimatedImageView *LoaderImageview;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation RequestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDoneKeypad];
    
    CGRect frame = _btnsend.frame;
    frame.origin.y = CGRectGetMaxY(textviewDescription.frame)+10;
    
    [txtCommodityName setReturnKeyType:UIReturnKeyDone];
    [textviewDescription setReturnKeyType:UIReturnKeyDone];
    
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    
    lblDesc.hidden = NO;
    
    self.title = @"Request";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIColor *color = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    txtCommodityName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Commodity name" attributes:@{NSForegroundColorAttributeName: color}];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    txtCommodityName.leftView = paddingView;
    txtCommodityName.leftViewMode = UITextFieldViewModeAlways;
    
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    txtCommodityName.layer.cornerRadius = 3;
    txtCommodityName.layer.masksToBounds=YES;
    txtCommodityName.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    txtCommodityName.layer.borderWidth= 1.0f;
    
    
    textviewDescription.layer.cornerRadius = 3;
    textviewDescription.layer.masksToBounds=YES;
    textviewDescription.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    textviewDescription.layer.borderWidth= 1.0f;
    
    [textviewDescription setTextContainerInset:UIEdgeInsetsMake(9, 13, 0, 12)];
}

-(void)viewWillLayoutSubviews
{
    [_mainScrollView contentSizeToFit];
    [_mainScrollView layoutIfNeeded];
    //self.mainScrollView.contentSize=self.mainView.bounds.size;
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, _btnsend.frame.origin.y+_btnsend.frame.size.height);
}

-(void)MethodCallRequestApi
{
    NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSDictionary *parameters = @{
                                 @"RequestCommodityName":txtCommodityName.text,
                                 @"RequestDescription":textviewDescription.text,
                                 @"UserID":strUserID
                                 };
    
    
    
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    if (isNetworkAvailable)
    {
        [[MethodsManager sharedManager]loadingView:self.view];
        
        [[webManager sharedObject] CallPostMethod:parameters withMethod:@"/api/CreateRequest" successResponce:^(id response)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"create request response = %@",response);
             [[[UIAlertView alloc]initWithTitle:@"Success" message:[response valueForKey:@"Success"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
         }
                                          failure:^(NSError *error)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"create request error = %@",error.description);
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)alertListBtnClick:(id)sender
{
    AlertViewController *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    calendarVC.is_NotFromDraw = YES;
    [self.navigationController pushViewController:calendarVC animated:YES];
}

- (IBAction)btnSendTapped:(id)sender
{
    NSString *rawString = [txtCommodityName text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    
    NSString *rawString2 = [textviewDescription text];
    NSCharacterSet *whitespace2 = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed2 = [rawString2 stringByTrimmingCharactersInSet:whitespace2];
    
    
    if (txtCommodityName.text.length > 0)
    {
        if (textviewDescription.text.length > 0)
        {
            if ([trimmed length] == 0)
            {
                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
            }
            else
            {
                if ([trimmed2 length] == 0)
                {
                    [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid description" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                }
                else
                {
                    [self MethodCallRequestApi];
                }
            }
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter description" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter commodity name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==txtCommodityName)
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        return YES;
    }
    else if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage])
    {
        return NO;
    }
    else if ([[[textviewDescription textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textviewDescription textInputMode] primaryLanguage])
    {
        return NO;
    }
    return YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView == textviewDescription)
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
        
        for (int i = 0; i < [text length]; i++)
        {
            unichar c = [text characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }
    }
    else if ([[[textviewDescription textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textviewDescription textInputMode] primaryLanguage])
    {
        return NO;
    }
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textviewDescription.text.length == 0){
        lblDesc.hidden = NO;
        textviewDescription.textColor = [UIColor lightGrayColor];
        [textviewDescription resignFirstResponder];
    }
    else
    {
        lblDesc.hidden = YES;
    }
}

//-(void)setupProgress
//{
//    HUD=[[MBProgressHUD alloc]initWithView:self.view];
//    [HUD setLabelText:@"Loading...."];
//    [self.view addSubview:HUD];
//    [HUD hide:YES];
//}


-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    txtCommodityName.inputAccessoryView = numberToolbar;
    textviewDescription.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad
{
    [txtCommodityName resignFirstResponder];
    [textviewDescription resignFirstResponder];
    
    if (txtCommodityName)
    {
        txtCommodityName.text = @"";
    }
    else if (textviewDescription)
    {
        textviewDescription.text = @"";
    }
}

-(void)doneWithNumberPad
{
    // NSString *numberFromTheKeyboard = numberTextField.text;
    [txtCommodityName resignFirstResponder];
    [textviewDescription resignFirstResponder];
}

@end
