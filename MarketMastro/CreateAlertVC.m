//
//  CreateAlertVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "CreateAlertVC.h"
#import "CreatePortflioVC.h"
@interface CreateAlertVC ()<UITextFieldDelegate,MyAlertViewDelegate, GADBannerViewDelegate, GADInAppPurchaseDelegate, GADAdSizeDelegate>
{
    NSString *strCommodity;
    NSString *strCondition;
    NSString *strPrizeValue;
    NSString *stringSelectedCondition;
    NSString *strUpdateAlert;
}
@end

@implementation CreateAlertVC
NSString *selctedOption;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPrizeValidation];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    
   /*
    @"Condition"];
    [dictSelectedAlert setObject:strCommodity forKey:@"CommodityName"];
    [dictSelectedAlert setObject:strPrice forKey:@"Value"];
    */
    
    if (_isFromAertViewController)
    {
        self.title = @"Update Alert";
        [_btnSetAlert setTitle:@"Update Alert" forState:UIControlStateNormal];
        
        NSString *strcommodityName = [_DicSelectedAlert valueForKey:@"CommodityName"];
        NSString *strConditionn = [_DicSelectedAlert valueForKey:@"Condition"];
        NSString *strprice = [_DicSelectedAlert valueForKey:@"Value"];
        
        
        if ([strCondition isEqualToString:@"isLT"])
        {
            strCondition = @"Is Less Than (<)";
        }
        else if ([strCondition isEqualToString:@"isGT"])
        {
            strCondition = @"Is Greater Than (>)";
        }
        else if ([strCondition isEqualToString:@"isLTEq"])
        {
            strCondition = @"Is Less Than Equal To (<=)";
        }
        else if ([strCondition isEqualToString:@"isGTEq"])
        {
            strCondition = @"Is Greater Than Equal To (>=)";
        }
        else if ([strCondition isEqualToString:@"onChange"])
        {
            strCondition = @"Change %";
        }
        
        _txtFieldPrice.text = strprice;
        [_selectCondition setTitle:strConditionn forState:UIControlStateNormal];
        [_btnSelectComm setTitle:strcommodityName forState:UIControlStateNormal];
    }
    else
    {
         self.title = @"Set Alert";
    }
    selctedOption = @"";
    
    [_txtFieldPrice setReturnKeyType:UIReturnKeyDone];
    [self setDoneKeypad];
    
    //AdBanner
    [self bannerAd];
}

-(void)setPrizeValidation
{/*
    float twofortythreetwentyfive = 234.25;
    float onetwothreefourtwentyfive = 1234.25;
    float eleventwothreefourtwentyfive = 11234.25;
    
    NSNumberFormatter * formatter =  [[NSNumberFormatter alloc] init];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMaximumSignificantDigits:5];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    
    NSLog(@"%@", [formatter stringFromNumber:[NSNumber numberWithFloat:twofortythreetwentyfive]]);
    NSLog(@"%@", [formatter stringFromNumber:[NSNumber numberWithFloat:onetwothreefourtwentyfive]]);
    NSLog(@"%@", [formatter stringFromNumber:[NSNumber numberWithFloat:eleventwothreefourtwentyfive]]);
  */
    
   
     NSNumberFormatter * formatter =  [[NSNumberFormatter alloc] init];
     [formatter setUsesSignificantDigits:YES];
     [formatter setMaximumSignificantDigits:6];
     [formatter setMaximumFractionDigits:2];
     [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    
    float prize = [_txtFieldPrice.text floatValue];
    UILabel *lblPrize;
    lblPrize.text = [formatter stringFromNumber:[NSNumber numberWithFloat:prize]];
    _txtFieldPrice.text = lblPrize.text;
    
}

-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    _txtFieldPrice.inputAccessoryView = numberToolbar;
   
}

-(void)cancelNumberPad
{
    [_txtFieldPrice resignFirstResponder];
    if (_txtFieldPrice)
    {
        _txtFieldPrice.text = @"";
    }
}

-(void)doneWithNumberPad
{
    // NSString *numberFromTheKeyboard = numberTextField.text;
    [_txtFieldPrice resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    if([selctedOption length] > 0)
    {
        [_btnSelectComm setTitle:[NSString stringWithFormat:@"  %@",selctedOption] forState:UIControlStateNormal];
    }
    
    if([_selectedItem length] > 0)
    {
        [_btnSelectComm setTitle:[NSString stringWithFormat:@"  %@",_selectedItem] forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)selectCommoditeBtnClick:(id)sender
{
    [_txtFieldPrice resignFirstResponder];
    
    if([selctedOption length] > 0)
    {
        [_selectCondition setTitle:[NSString stringWithFormat:@"  %@",selctedOption] forState:UIControlStateNormal];
        [_selectCondition setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectCondition.font = [UIFont fontWithName:@"Lato-Bold" size:15.0];
    }
    
    CreatePortflioVC *createAlert = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatePortflioVC"];
    createAlert.isCreateAlert = YES;
    createAlert.isFromVC = @"Alert";
    [[NSUserDefaults standardUserDefaults]setObject:@"Alert" forKey:@"isFromVC"];
    
    [self.navigationController pushViewController:createAlert animated:YES];
}
- (IBAction)btnSelectConditionBtnClick:(id)sender
{
    [_txtFieldPrice resignFirstResponder];
    self.viewForAlertOption.frame =  self.view.frame;
    [self.view addSubview:self.viewForAlertOption];
}

- (IBAction)setAlertBtnClick:(id)sender
{
    /*
    //imp code for validation of prize ..while implementation check this.
    NSNumberFormatter * formatter =  [[NSNumberFormatter alloc] init];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMaximumSignificantDigits:8];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    
    float prize = [_txtFieldPrice.text floatValue];
    UILabel *lblPrize;
    lblPrize.text = [formatter stringFromNumber:[NSNumber numberWithFloat:prize]];
    _txtFieldPrice.text = lblPrize.text;
    */
    
    /*
     check this condition
     price = price entered by user
     if (selectedCommodity is NOT null) {
     int precision = selectedCommodity.Precision + 7;
     if (price.length > precision) {
     then show alert "Enter valid price."
     }else{
     Valid price
     }
     }
     */
    
    
    [_txtFieldPrice resignFirstResponder];
    
    //  Select Commodity
    if([self.btnSelectComm.currentTitle isEqualToString:@"  Select Commodity"])
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please select Commodity." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else
    {
        if([_selectCondition.currentTitle isEqualToString:@"  Select Condition"])
        {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"Please Select Condition." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            if([self.txtFieldPrice.text length] == 0)
            {
                [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Price value." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
            else
            {
                [self CallsetAlertApi];
            }
        }
    }
}

-(void)MethodForUpdateAlert
{
    //api/UpdateAlert
    //post
    /*
     parameters ::
     
     UserID- User ID of user
    // AlertID - Alert id of selected alert, to be updated
   //  CommodityID- Commodity ID of Commodity selected for alert
    // ScriptCode- Script code fo commodity
   //  Condition- Condition set by user
   //  Price- Entered by user
     ExpiresInDays- Set seven date by default
     Exch- Exchange of commodity
     PauseAlerts- false
    */
    
    NSString *strUserID = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
   // NSString *strcommodityName = [_DicSelectedAlert valueForKey:@"CommodityName"];
    NSString *strConditionn = [_DicSelectedAlert valueForKey:@"Condition"];
    NSString *strprice = [_DicSelectedAlert valueForKey:@"Value"];
    NSString *strAlertID =  [_DicSelectedAlert valueForKey:@"AlertID"];
    NSString *strCommodityID =  [_DicSelectedAlert valueForKey:@"CommodityID"];
    NSString *strScriptCode =  [_DicSelectedAlert valueForKey:@"ScriptCode"];
    
    
    NSDictionary *parameter = @{
                                @"UserID":strUserID,
                                @"AlertID":strAlertID,
                                @"CommodityID":strCommodityID,
                                @"ScriptCode":strScriptCode,
                                @"Condition":strConditionn,
                                @"Price":strprice,
                                @"ExpiresInDays":@"7",
                                @"Exch":@"0",
                                @"PauseAlerts":@"false"
                                };
    
    [[webManager sharedObject]CallPostMethod:parameter withMethod:@"api/UpdateAlert" successResponce:^(id response)
    {
        NSLog(@"update alert response = %@",response);
        [[[UIAlertView alloc]initWithTitle:@"Success" message:@"Alert updated successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        
        MyAlertViewController *alert = [[MyAlertViewController alloc]initWithNibName:@"MyAlertViewController" bundle:nil];
        alert.delegate = self;
        [self presentPopupViewController:alert animationType:MJPopupViewAnimationFade];
        
    }
    failure:^(NSError *error)
    {
        NSLog(@"update alert error = %@",error.description);
    }];
}

-(void)CallsetAlertApi
{
    
    if (_isFromAertViewController)
    {
        //UPDATE ALERT >>
        [self MethodForUpdateAlert];
    }
    else
    {
        //SET ALERT >>
        //api/CreateAlert/{UserID}
        //para:
        //post
        /*
         UserID- User ID of user
         CommodityID- Commodity ID of Commodity selected for alert  >>1
         ScriptCode- Script code fo commodity >>789480
         Condition- Condition set by user
         Price- Entered by user
         ExpiresInDays- Set seven date by default >>7int
         Exch- Exchange of commodity >>O
         PauseAlerts- false
         */
        
        NSString *strUserID = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
        NSString *strCommodityID = @"1";
        NSString *strScriptCode = @"789480";
        NSString *strcondition = strCondition;
        NSString *strExch = @"0";
        
        NSDictionary *dicParameter = @{
                                       @"UserID":strUserID,
                                       @"CommodityID":strCommodityID,
                                       @"ScriptCode":strScriptCode,
                                       @"Condition":strcondition,
                                       @"Price":_txtFieldPrice.text,
                                       @"ExpiresInDays":@"7",
                                       @"Exch":strExch,
                                       @"PauseAlerts":@"false"
                                       };
        
        
        [[MethodsManager sharedManager]loadingView:self.view];
        
        [[webManager sharedObject]CallPostMethod:dicParameter withMethod:@"api/CreateAlert/" successResponce:^(id response)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"create alert response = %@",response);
             
            strUpdateAlert = @"NewAlertCreated";
             
             MyAlertViewController *alert = [[MyAlertViewController alloc]initWithNibName:@"MyAlertViewController" bundle:nil];
             alert.delegate = self;
             [self presentPopupViewController:alert animationType:MJPopupViewAnimationFade];
         }
        failure:^(NSError *error)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"create alert error = %@",error.description);
         }];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
-(IBAction)optionSelectBtnClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [_selectCondition setTitle:[NSString stringWithFormat:@"  %@",btn.currentTitle] forState:UIControlStateNormal];
    NSLog(@"title is = %@",_selectCondition.titleLabel.text);
    
    
    if (btn.tag == 1)
    {
        strCondition = @"isLT";//isLT
    }
    else if (btn.tag == 2)//Is Greater Than (>)
    {
        strCondition = @"isGT";//isGT
    }
    else if (btn.tag == 3)//Is Less Than Equal To (<=)
    {
        strCondition = @"isLTEq";//isLTEq
    }
    else if (btn.tag == 4)//Is Greater Than Equal To (>=)
    {
        strCondition = @"isGTEq";//isGTEq
    }
    else if (btn.tag == 5)//Change %
    {
        strCondition = @"onChange";
    }
    [self.viewForAlertOption removeFromSuperview];
}

- (IBAction)btnForDismiss:(id)sender {
    [self.viewForAlertOption removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txtFieldPrice resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _txtFieldPrice)
    {
        
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        
        if (textField.text.length >9)
        {
            NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return resultText.length <= 9;
        }
        return [string isEqualToString:filtered];
    }
    return YES;
}

- (void)okButtonClick
{
    NSString *updateAlertString = strUpdateAlert;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateAlert" object:updateAlertString];
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - FirebaseAdBanner
- (void)bannerAd {
    adBannerView.adUnitID = BannerAdUnitID;
    //    _adView.rootViewController = self;
    //    adBannerView.adSizeDelegate = self;
    [adBannerView loadRequest:[GADRequest request]];
    [[GADRequest request] setGender:kGADGenderMale];
    [[GADRequest request] setBirthday:[NSDate date]];
    // [END firebase_banner_example]
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    CGFloat height = CGRectGetHeight(adBannerView.frame);
    [self.view bringSubviewToFront:adBannerView];
    [adBannerView setFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height)];
    
    adBannerView.hidden = NO;

//    self.viewForEMC.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    NSLog(@"adViewDidReceiveAd");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    adBannerView.hidden = YES;
//    self.viewForEMC.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
    NSLog(@"didFailToReceiveAdWithError");
}
- (void)adViewWillPresentScreen:(GADBannerView *)bannerView {
    NSLog(@"adViewWillPresentScreen");
}
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"adViewWillDismissScreen");
}
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"adViewDidDismissScreen");
}
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView {
    NSLog(@"adViewWillLeaveApplication");
}

#pragma mark - GADInAppPurchaseDelegate
- (void)didReceiveInAppPurchase:(GADInAppPurchase *)purchase {
    NSLog(@"didReceiveInAppPurchase");
}

#pragma mark - GADAdSizeDelegate
- (void)adView:(GADBannerView *)bannerView willChangeAdSizeTo:(GADAdSize)size {
    NSLog(@"willChangeAdSizeTo");
}
@end
