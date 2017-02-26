//
//  VerifyAndChangeMobileViewController.m
//  MarketMastro
//
//  Created by Mac on 14/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "VerifyAndChangeMobileViewController.h"
#import "MBProgressHUD.h"
#import "webManager.h"
#import "FirstFourVC.h"
#import "ViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "UpgradeViewController.h"

@interface VerifyAndChangeMobileViewController ()
{
    MBProgressHUD *HUD;
    NSTimer* CountDownTimer;
    NSTimer *timer;
    NSString *strUserIDD;
    FLAnimatedImageView *LoaderImageview;
}
@end

@implementation VerifyAndChangeMobileViewController
@synthesize ChanegeMobileNumberDelegate;
int hours, minutes, seconds;
int secondsLeft;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = true;
    
    [self callGif];
    
    // Do any additional setup after loading the view.
    self.btnVerify.layer.cornerRadius = 3.0f; // this value vary as per your desire
    self.btnVerify.clipsToBounds = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    ViewForResendOTP.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    
    self.btnResendOTP.layer.cornerRadius = 3.0f; // this value vary as per your desire
    self.btnResendOTP.clipsToBounds = YES;
    
    self.btnOTPReceiveViaCall.layer.cornerRadius = 3.0f; // this value vary as per your desire
    self.btnOTPReceiveViaCall.clipsToBounds = YES;
    
    self.btnChangeMobileNumber.layer.cornerRadius = 3.0f; // this value vary as per your desire
    self.btnChangeMobileNumber.clipsToBounds = YES;
    
    _txtOtp.layer.cornerRadius = 3;
    _txtOtp.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtOtp.layer.borderWidth= 1.0f;
    _txtOtp.layer.masksToBounds=YES;
    
    _btnResendOTP.layer.cornerRadius = 3;
    _btnResendOTP.clipsToBounds = YES;
    _btnOTPReceiveViaCall.layer.cornerRadius = 3;
    _btnOTPReceiveViaCall.clipsToBounds = YES;
    
    _lblText.text = [NSString stringWithFormat:@"OTP sent over +91 %@",_strMobileNumber];
    
    [_txtOtp setReturnKeyType:UIReturnKeyDone];
    [self setDoneKeypad];
    [self setupValues];
    [self countdownTimer];
}

- (void)viewWillAppear:(BOOL)animated
{
    strUserIDD = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarHidden = false;
    
    [super viewWillDisappear:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [ChanegeMobileNumberDelegate sendDataToA:@"YES"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _txtOtp.inputAccessoryView = numberToolbar;
    
}

-(void)cancelNumberPad
{
    [_txtOtp resignFirstResponder];
    
    
    if (_txtOtp)
    {
        _txtOtp.text = @"";
    }
}

-(void)doneWithNumberPad
{
    // NSString *numberFromTheKeyboard = numberTextField.text;
    [_txtOtp resignFirstResponder];
}

-(void)callGif
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"loading" ofType: @"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile: filePath];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
    LoaderImageview = [[FLAnimatedImageView alloc] init];
    LoaderImageview.animatedImage = image;
    LoaderImageview.frame = CGRectMake(CGRectGetMidX(self.view.frame)-30, CGRectGetMidY(self.view.frame), 60, 10);
    [self.view addSubview:LoaderImageview];
    
    LoaderImageview.hidden = YES;
}

-(void)setupValues
{
    UIColor *color = [UIColor colorwithHexString:@"#959595"];
    _txtOtp.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Please enter the OTP received" attributes:@{NSForegroundColorAttributeName: color}];
    
    ViewForResendOTP.backgroundColor = [UIColor colorWithRed:22/255.0 green:24/255.0 blue:26/255.0 alpha:1.0];
    ViewForResendOTP.hidden = YES;
}

- (UITextField *)placeHolderColor:(UITextField *)txt withSting:(NSString *)placeHolderString {
    UIColor *color = [UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0];
    txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderString attributes:@{NSForegroundColorAttributeName: color}];
    return txt;
}



-(void)countdownTimer
{
    secondsLeft = hours = minutes = seconds = 0;
    if([timer isValid]) {
        
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    
}

- (void)updateCounter:(NSTimer *)theTimer
{
    if(secondsLeft > 0 )
    {
        secondsLeft -- ;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        _lblTimer.text = [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
        
        if ([_lblTimer.text isEqualToString:@"00:00"])
        {
            [timer invalidate];
            ViewForResendOTP.hidden = NO;
        }
    }
    else
    {
        secondsLeft = 45;
    }
    
    /*
     if (self.currentTime == 0)
     {
     [self.timer invalidate];
     [self exercisePopup];
     }
     */
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    int length = (int)[currentString length];
    
    if (length > 4)
    {
        NSLog(@"should be 4 digit only");
        return NO;
    }
    return YES;
}

-(void)CallVerifyOtpMethod
{
    
    if (_txtOtp.text.length >0)
    {
        // [timer invalidate];
        
        NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        strUserID = [NSString stringWithFormat:@"%@",strUserID];
        
        
        BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
        
        if (isNetworkAvailable)
        {
            [[MethodsManager sharedManager]loadingView:self.view];
            [[webManager sharedObject] CallPostMethod:nil withMethod:[NSString stringWithFormat:@"api/UserDetails/ValidateOTP/%@/%@",strUserID,_txtOtp.text]
                                      successResponce:^(id response)
             {
                 [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"response = %@",response);
                 BOOL isVerified = [[response valueForKey:@"isVerified"] boolValue];
                 if (isVerified == false)
                 {
                     
                     [[[UIAlertView alloc]initWithTitle:@"Error" message:@"OTP is incorrect" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
                 }
                 else
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:_txtOtp.text forKey:@"SavedOtp"];
                     [self MethodForGenerateToken];
                 }
             }
                                              failure:^(NSError *error)
             {
                 [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"response error = %@",error);
                 [[[UIAlertView alloc]initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
             }];
            
        }
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter OTP " delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }
}

-(void)MethodForGenerateToken
{
    //api/GenerateToken
    /*
     "OTP": "12345",
     "UserID": 1
     */
    
    NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strOtp = [[NSUserDefaults standardUserDefaults] valueForKey:@"SavedOtp"];
    
    NSDictionary *parameter = @{
                                @"UserID":strUserID,
                                @"OTP":strOtp,
                                };
    
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        [[webManager sharedObject] CallPostMethod:parameter withMethod:[NSString stringWithFormat:@"/api/GenerateToken"]
                                  successResponce:^(id response)
         {
             
             NSLog(@"response = %@",response);
             
             if ([response valueForKey:@"TokenID"])
             {
                 [[NSUserDefaults standardUserDefaults] setObject:[response valueForKey:@"TokenID"] forKey:@"TokenID"];
                 [self MethodForUpdateDeviceDetails];
             }
         }
                                          failure:^(NSError *error)
         {
             
             NSLog(@"response error = %@",error);
             [[[UIAlertView alloc]initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
         }];
    }
}

-(void)MethodForUpdateDeviceDetails {
    id strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    if ([strUserID isKindOfClass:[NSNumber class]]) {
//        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Couldnt get device token" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }
    else if ([strUserID isKindOfClass:[NSString class]]) {
    }
    else {
        return;
    }
    NSString *model = [[UIDevice currentDevice] model];
    NSString *iOSVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceOS = [[UIDevice currentDevice] systemName];
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *aPNDeviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"APNsDeviceToken"];
    if (!aPNDeviceToken) {
        aPNDeviceToken = @"";
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:iOSVersion forKey:@"SavedIosVersion"];
    [[NSUserDefaults standardUserDefaults] setObject:UUID forKey:@"SavedUUID"];
    
    NSDictionary *parameter = @{
                                @"UserID":strUserID,
                                @"DeviceUUID":UUID,
                                @"DeviceOSVersion":iOSVersion,
                                @"DeviceModel":model,
                                @"DeviceNotifyRegisterId":aPNDeviceToken,
                                @"DeviceIMEI":@"",
                                @"DeviceManufacturer":@"Apple",
                                @"DeviceOS":deviceOS,
                                @"DeviceSerialNo":@"",
                                @"DeviceWifiMac":@"",
                                };
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager] isInternetAvailable];
    if (isNetworkAvailable) {
        
        [[webManager sharedObject] CallPostMethod:parameter withMethod:@"/api/UserDetails/PutDeviceDetails" successResponce:^(id response) {
            
            NSLog(@"response = %@",response);
            if ([[response valueForKey:@"Success"]isEqualToString:@"Successfully updated"]) {
                //AlreadyLogin
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AlreadyLogin"];
                
                //Harish
                [self getCurrentActivePackage];
            }
        }
                                          failure:^(NSError *error) {
                                              
                                              NSLog(@"response error = %@",error);
                                              [[[UIAlertView alloc]initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
                                          }];
    }
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

- (IBAction)btnVerifyTapped:(id)sender
{
    //remove following after testing
    //    FirstFourVC *Dashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstFourVC"];
    //    [self.navigationController pushViewController:Dashboard animated:YES];
    //    return;
    
    [_txtOtp resignFirstResponder];
    [self CallVerifyOtpMethod];
}

- (IBAction)btnChangeMobileNumberTapped:(id)sender
{
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    vc.strIsSigned = _isSigned;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)MethodResendOTP:(id)sender
{
    /*
     If user click on Resend OTP, then call web service
     Api :: /api/UserDetails/ResendOTP/{UserID}
     para::: UserID -of user
     
     After successful resend OTP response, restart 45 sec timer and invisible buttons for Resend OTP and Received via Call
     */
    
    
    
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        
        [[MethodsManager sharedManager]loadingView:self.view];
        [[webManager sharedObject] CallPostMethod:nil withMethod:[NSString stringWithFormat:@"/api/UserDetails/ResendOTP/%@",strUserIDD]
                                  successResponce:^(id response)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"response = %@",response);
             
             if ([[response valueForKey:@"Success"]isEqualToString:@"Successfully Sent"])
             {
                 
                 ViewForResendOTP.hidden = YES;
                 timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
             }
         }
                                          failure:^(NSError *error)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"response error = %@",error);
             [[[UIAlertView alloc]initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
         }];
    }
}

- (IBAction)MethodReceiveOTPviaCall:(id)sender
{
    ViewForResendOTP.hidden = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txtOtp resignFirstResponder];
}

#pragma mark - ActivePackageList
-(void)getCurrentActivePackage
{
    NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    strUserID = [NSString stringWithFormat:@"%@", strUserID];
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager] isInternetAvailable];
    
    if (isNetworkAvailable) {
        if (strUserID !=nil) {
            [[MethodsManager sharedManager] loadingView:self.view];
            
            [[webManager sharedObject] loginRequest:nil withMethod:[NSString stringWithFormat:@"api/getActiveUserSubscription/%@", strUserID]
                                    successResponce:^(id response) {
                                        [[MethodsManager sharedManager] StopAnimating];
                                        NSLog(@"get current active package response = %@",response);
                                        
                                        NSDictionary *activePackDetails = response;
                                        if (activePackDetails.count>0) {
                                            [[NSUserDefaults standardUserDefaults] setObject:activePackDetails forKey:@"DicwithCurreentActivePackDetails"];
                                            [self successInActivePackage:activePackDetails];
                                        }
                                        else {
                                            [self navigateToPackagesFrom:1];
                                        }
                                    }
                                            failure:^(NSError *error) {
                                                NSLog(@"get current active package error = %@",error);
                                                [self navigateToPackagesFrom:1];
                                            }];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        }
    }
}
- (void)successInActivePackage:(NSDictionary*)packageDetail {
    //FirstFourVC
    
    //    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    //    [dateFormate setDateFormat:@"yyyy-MM-DD HH:mm"];
    //    NSDate *exprieDate = [dateFormate dateFromString:[packageDetail objectForKey:@"ExpiredOn"]];
    //    [exprieDate compare:[NSDate date]]==NSOrderedDescending
    if ([(NSNumber*)[packageDetail objectForKey:@"isExpired"] integerValue]==1) {
        [self navigateToPackagesFrom:2];
        return;
    }
    else if (![[packageDetail objectForKey:@"PurchasedStatus"] isEqual:@"Completed"]) {
        //        return;
    }
    
    FirstFourVC *Dashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstFourVC"];
    [self.navigationController pushViewController:Dashboard animated:YES];
}
- (void)navigateToPackagesFrom:(NSInteger)isFrom {
    //Temp
    [self subscribeToPackage:@{@"PackageID":@"9"}];

    //Temp
//    UpgradeViewController *subscriptionPage = [self.storyboard instantiateViewControllerWithIdentifier:@"UpgradeViewController"];
//    subscriptionPage.isFrom = isFrom;
//    [self.navigationController pushViewController:subscriptionPage animated:YES];
}

#pragma mark - PostUserSubscription
- (void)subscribeToPackage:(NSDictionary*)packageDic {
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    if (isNetworkAvailable) {
        NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
        strUserID = [NSString stringWithFormat:@"%@",strUserID];
        
        NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
        [requestDic setObject:strUserID forKey:@"UserID"];
        [requestDic setObject:[packageDic objectForKey:@"PackageID"] forKey:@"PackageID"];
        [requestDic setObject:@"" forKey:@"PCUsed"];
        [requestDic setObject:@"0" forKey:@"PCValue"];
        [requestDic setObject:@"0" forKey:@"CPUsed"];
        [requestDic setObject:@"0" forKey:@"CreditValue"];
        [requestDic setObject:@"Offline" forKey:@"PaymentMode"];
        [requestDic setObject:@"0" forKey:@"PaymentMade"];
        [requestDic setObject:@"Completed" forKey:@"PurchasedStatus"];
        [requestDic setObject:@"0" forKey:@"TransactionID"];
        
        [[webManager sharedObject] CallPostMethod:requestDic withMethod:@"api/PostUserSubscription" successResponce:^(id response) {
            NSDictionary *responseDic;
            if ([response isKindOfClass:[NSDictionary class]]) {
                responseDic = (NSDictionary*)response;
                
//                [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Thank You" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
                //FirstFourVC
                FirstFourVC *dashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstFourVC"];
                [self.navigationController pushViewController:dashboard animated:YES];
            }
        } failure:^(NSError *error) {
            NSLog(@"api/PostUserSubscription error = %@", error);
        }];
    }
}
@end
