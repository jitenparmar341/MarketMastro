//
//  SingInViewController.m
//  MarketMastro
//
//  Created by Mac on 13/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "SingInViewController.h"
#import "webManager.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "FirstFourVC.h"
#import "VerifyAndChangeMobileViewController.h"
#import "FLAnimatedImage.h"

@interface SingInViewController ()
{
    MBProgressHUD *HUD;
    NSString *strIsSignedIn;
    FLAnimatedImageView *LoaderImageview;
}
@end

@implementation SingInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDoneKeypad];
    
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    [_txtFieldMobileNumber setReturnKeyType:UIReturnKeyDone];
    
    
    // Do any additional setup after loading the view.
    //    self.txtFieldMobileNumber = [self borderColor:self.txtFieldMobileNumber withMask:YES];
    self.txtFieldMobileNumber = [self placeHolderColor:self.txtFieldMobileNumber withSting:@"Enter your registered Mobile No."];
    self.txtFieldMobileNumber.leftView =[self paddingView:self.txtFieldMobileNumber withImageNamed:@"reg_mobile_icon.png"];
    self.btnContinue.layer.cornerRadius = 3.0f; // this value vary as per your desire
    self.btnContinue.clipsToBounds = YES;
    
    _txtFieldMobileNumber.layer.cornerRadius = 3;
    _txtFieldMobileNumber.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtFieldMobileNumber.layer.borderWidth= 1.0f;
    _txtFieldMobileNumber.layer.masksToBounds=YES;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController.navigationBar setHidden:NO];
}
- (UITextField *)placeHolderColor:(UITextField *)txt withSting:(NSString *)placeHolderString {
    UIColor *color = [UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0];
    txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderString attributes:@{NSForegroundColorAttributeName: color}];
    return txt;
}
- (UITextField *)borderColor:(UITextField*)txt withMask:(BOOL)maskValue {
    txt.layer.borderColor=[[UIColor darkTextColor]CGColor];
    txt.layer.borderWidth= 0.1f;
    txt.layer.masksToBounds = maskValue;
    return txt;
    
}
- (UIView*)paddingView:(UITextField *)txt withImageNamed:(NSString *)image {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20,20)];
    [viewImgTxtUser setImage:[UIImage imageNamed:image]];
    [paddingView addSubview:viewImgTxtUser];
    txt.leftViewMode = UITextFieldViewModeAlways;
    return paddingView;
    
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)keyboardWillShow:(NSNotification *)note
//{
//    CGRect keyboardBounds;
//    NSValue *aValue = [note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
//
//    [aValue getValue:&keyboardBounds];
//    // int keyboardHeight = keyboardBounds.size.height;
//    if (!keyboardIsShowing)
//    {
//        keyboardIsShowing = YES;
//        CGRect frame = self.view.frame;
//        frame.size.height -= 210;
//
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:0.3f];
//        self.view.frame = frame;
//        [UIView commitAnimations];
//    }
//}
//
//- (void)keyboardWillHide:(NSNotification *)note
//{
//    CGRect keyboardBounds;
//    NSValue *aValue = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
//    [aValue getValue: &keyboardBounds];
//
//    // keyboardHeight = keyboardBounds.size.height;
//    if (keyboardIsShowing)
//    {
//        keyboardIsShowing = NO;
//        CGRect frame = self.view.frame;
//        frame.size.height += 210;
//
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:0.3f];
//        self.view.frame = frame;
//        [UIView commitAnimations];
//
//    }
//}

#pragma textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txtFieldMobileNumber resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)MethodDontHaveAccount:(id)sender
{
    //    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSignIntapped:(id)sender
{
    
    NSString *phoneNumber = _txtFieldMobileNumber.text;
    NSString *phoneRegex = @"[789][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:phoneNumber];
    
    
    if (_txtFieldMobileNumber.text.length!=0)
    {
        if (_txtFieldMobileNumber.text.length ==10)
        {
            if(matches == true)
            {
                [self MethodCallSignInApi];
            }
            else
            {
                NSLog(@"Mobile number should start with 7,8,9 only");
                
                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter a valid mobile number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
            }
        }
        else
        {
            NSLog(@"Mobile number should be 10 digit");
            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Mobile number should be 10 digit only" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        }
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter mobile number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok"
          , nil]show];
    }
    
}


-(void)MethodCallSignInApi
{
    ///api/UserDetails/ByMobileNo/{MobileNo}?generateOTP=true
    /*
     MobileNo - of user
     generateOTP - true
     */
    
    // LoaderImageview.hidden = NO;
    [[MethodsManager sharedManager]loadingView:self.view];
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/UserDetails/ByMobileNo/%@?generateOTP=true",_txtFieldMobileNumber.text]
                               successResponce:^(id response)
         {
             //LoaderImageview.hidden = YES;
             
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"Login api response = %@",response);
             NSDictionary *DicLoggedInUser = [response mutableCopy];
             
             [[NSUserDefaults standardUserDefaults]setObject:DicLoggedInUser forKey:@"DictOfLogedInuser"];
             
             
             //$$$ 26 jan
             NSString *strName = [DicLoggedInUser valueForKey:@"Name"];
             NSString *strEmail = [DicLoggedInUser valueForKey:@"Email"];
             NSString *strMobileNumber = [DicLoggedInUser valueForKey:@"MobileNo"];
             NSString *strCityID = [DicLoggedInUser valueForKey:@"CityID"];
             
             [[NSUserDefaults standardUserDefaults] setObject:strName forKey:@"Name"];
             [[NSUserDefaults standardUserDefaults] setObject:strEmail forKey:@"Email"];
             [[NSUserDefaults standardUserDefaults] setObject:strMobileNumber forKey:@"MobileNo"];
             [[NSUserDefaults standardUserDefaults] setObject:strCityID forKey:@"CityID"];
             
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             BOOL success = [[response valueForKey:@"Status"] boolValue];
             strIsSignedIn =@"SignedIN";
             
             ///// [[NSUserDefaults standardUserDefaults] setObject:strUserId forKey:@"UserID"];
             
             NSString *strUserID = [NSString stringWithFormat:@"%@",[response valueForKey:@"UserID"]];
             [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:@"UserID"];
             
             if (success)
             {
                 VerifyAndChangeMobileViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"VerifyAndChangeMobileViewController"];
                 
                 verify.strMobileNumber = _txtFieldMobileNumber.text;
                 verify.isSigned = strIsSignedIn;
                 
                 [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"UpdateUserDetails"];
                 [self.navigationController pushViewController:verify animated:YES];
             }
             else
             {
                 [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Failed to login" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
             }
         }
         failure:^(NSError *error)
         {
             [[MethodsManager sharedManager]StopAnimating];
             //LoaderImageview.hidden = YES;
             NSLog(@"response error = %@",error);
         }];
    }
}

-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    _txtFieldMobileNumber.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad
{
    [_txtFieldMobileNumber resignFirstResponder];
    
    if (_txtFieldMobileNumber)
    {
        _txtFieldMobileNumber.text = @"";
    }
}

-(void)doneWithNumberPad
{
    // NSString *numberFromTheKeyboard = numberTextField.text;
    [_txtFieldMobileNumber resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _txtFieldMobileNumber)
    {
        NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return resultText.length <= 10;
    }
    return YES;
}

@end
