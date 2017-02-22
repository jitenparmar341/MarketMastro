//
//  UpdateUserProfileViewController.m
//  MarketMastro
//
//  Created by DHARMESH on 17/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "UpdateUserProfileViewController.h"
#import "DropDownCell.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "webManager.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface UpdateUserProfileViewController ()
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *locationArray;
    NSString *strCityID;
    FLAnimatedImageView *LoaderImageview;
    NSMutableArray *ArrayUserDetails;
    NSString *strcityName;
    NSDictionary *dicOfLoggedInuser;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation UpdateUserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Update Profile";
    
    // self.navigationController.navigationBarHidden = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self callGif];
    [self setUI];
    [self SetValues];
}

-(void)viewWillLayoutSubviews
{
    [_mainScrollView contentSizeToFit];
    [_mainScrollView layoutIfNeeded];
    //self.mainScrollView.contentSize=self.mainView.bounds.size;
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, btnUpdate.frame.origin.y+btnUpdate.frame.size.height);
    
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)SetValues
{
    locationArray = [[NSMutableArray alloc]init];
    ArrayUserDetails = [[NSMutableArray alloc]init];
    locationArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"CityList"];
    _viewForLocation.hidden = YES;
    
    [txtName setReturnKeyType:UIReturnKeyDone];
    [txtEmail setReturnKeyType:UIReturnKeyDone];
    [txtLocation setReturnKeyType:UIReturnKeyDone];
    [self setDoneKeypad];
    
    dicOfLoggedInuser = [[NSUserDefaults standardUserDefaults] valueForKey:@"DictOfLogedInuser"];
    
    // NSString *strcityID =[NSString stringWithFormat:@"%@",[dicOfLoggedInuser valueForKey:@"CityID"]];
    
    NSString *strcityID = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"CityID"]];
    
    
    //CityList
    NSArray *ArrCity = [[NSArray alloc] init];
    ArrCity = [[NSUserDefaults standardUserDefaults]valueForKey:@"CityList"];
    for (int i = 0; i<ArrCity.count; i++)
    {
        NSString *strgetCityID =[NSString stringWithFormat:@"%@",[[ArrCity valueForKey:@"CityID"] objectAtIndex:i]];
        if ([strcityID isEqualToString:strgetCityID])
        {
            strcityName = [[ArrCity valueForKey:@"CityName"] objectAtIndex:i];
        }
    }
    
    /*
     txtName.text = [dicOfLoggedInuser valueForKey:@"Name"];
     txtEmail.text = [dicOfLoggedInuser valueForKey:@"Email"];
     txtLocation.text = strcityName;
     */
    
    txtName.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"Name"];
    txtEmail.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"Email"];
    txtLocation.text = strcityName;
    
}

-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    txtName.inputAccessoryView = numberToolbar;
    txtLocation.inputAccessoryView = numberToolbar;
    txtEmail.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad
{
    [txtName resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtLocation resignFirstResponder];
    
    if (txtName)
    {
        txtName.text = @"";
    }
    else if (txtEmail)
    {
        txtEmail.text = @"";
    }
    else if (txtLocation)
    {
        txtLocation.text = @"";
    }
}

-(void)doneWithNumberPad
{
    // NSString *numberFromTheKeyboard = numberTextField.text;
    [txtName resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtLocation resignFirstResponder];
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

/*
 UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
 UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20,20)];//5,5,20,20
 UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
 UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 18, 14)];
 */


- (UIView*)paddingView:(UITextField *)txt withImageNamed:(NSString *)image {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20,20)];
    [viewImgTxtUser setImage:[UIImage imageNamed:image]];
    [paddingView addSubview:viewImgTxtUser];
    txt.leftViewMode = UITextFieldViewModeAlways;
    txt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    //[self paddingView:txtEmail withImageNamed:@"dro_contact_ico.png"];
    if ([image isEqualToString:@"dro_contact_ico.png"])
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 14)];
        [viewImgTxtUser setImage:[UIImage imageNamed:image]];
        [paddingView addSubview:viewImgTxtUser];
        txt.leftViewMode = UITextFieldViewModeAlways;
        //tf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        return paddingView;
    }
    return paddingView;
}


-(void)setUI
{
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    
    txtName.leftView = [self paddingView:txtName withImageNamed:@"reg_user_icon.png"];
    txtLocation.leftView = [self paddingView:txtLocation withImageNamed:@"reg_location_icon.png"];
    
    txtEmail.leftView =[self paddingView:txtEmail withImageNamed:@"dro_contact_ico.png"];//email.png
    
    txtName.layer.cornerRadius = 3;
    txtName.layer.masksToBounds=YES;
    txtName.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    txtName.layer.borderWidth= 1.0f;
    
    txtEmail.layer.cornerRadius = 3;
    txtEmail.layer.masksToBounds=YES;
    txtEmail.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    txtEmail.layer.borderWidth= 1.0f;
    
    txtLocation.layer.cornerRadius = 3;
    txtLocation.layer.masksToBounds=YES;
    txtLocation.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    txtLocation.layer.borderWidth= 1.0f;
    
    
    UIColor *color = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Full Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Email Address" attributes:@{NSForegroundColorAttributeName: color}];
    
    txtLocation.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Other" attributes:@{NSForegroundColorAttributeName: color}];
    
    btnUpdate.layer.cornerRadius = 3.0f; // this value vary as per your desire
    btnUpdate.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BtnUpdateTapped:(id)sender
{
    [txtName resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtLocation resignFirstResponder];
    
    NSString *rawString = [txtName text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    BOOL isValidEmail = [self NSStringIsValidEmail:txtEmail.text];
    
    
    if ([trimmed length] == 0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
    }
    else
    {
        if (txtName.text.length>0)
        {
            if (txtEmail.text.length >0)
            {
                if (txtLocation.text.length >0)
                {
                    if (isValidEmail)
                    {
                        [self CallUpdatedetailsApi];
                    }
                    else
                    {
                        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid email id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                    }
                }
                else
                {////////////
                    [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select location" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                }
            }
            else
            {/////////////
                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
            }
            
        }
        else
        {/////////////
            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter name." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
        }
    }
}

- (IBAction)btntextLocationTapped:(id)sender
{
    [txtName resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtLocation resignFirstResponder];
    
    _viewForLocation.hidden= !_viewForLocation.hidden;
    [_tableviewCity reloadData];
}


-(void)mathodUpdatedetails
{
    
}

-(void)CallUpdatedetailsApi
{
    //api/UserDetails/{UserId}/{generateOTP}
    /*
     UserId -of user
     generateOTP - true
     
     and
     {
     "UserID": 2,
     "Name": "Ajith", ////
     "MobileNo": "9876543210",////
     "Email": "ajith@millicent.in",
     "ReferralCode": "1234567890"////
     "CityId":1
     }
     */
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]valueForKey:@"DictOfLogedInuser"];
    NSString *strMobile = [dic valueForKey:@"MobileNo"];
    NSString *strUSerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    NSDictionary *parameter;
    if (strCityID != nil)
    {
        parameter = @{
                      @"Name":txtName.text,
                      @"CityID":strCityID,
                      @"UserID":strUSerID,
                      @"Email":txtEmail.text,
                      @"MobileNo":strMobile
                      };
    }
    else
    {
        parameter = @{
                      @"Name":txtName.text,
                      @"CityID":@"0",
                      @"UserID":strUSerID,
                      @"Email":txtEmail.text,
                      @"MobileNo":strMobile
                      };
    }
    
    
    
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        [[MethodsManager sharedManager]loadingView:self.view];
        
        [[webManager sharedObject]CallPutMethodwithParameters:parameter withMethod:[NSString stringWithFormat:@"api/UserDetails/%@/false",strUSerID]
                                              successResponce:^(id response)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"response = %@",response);
             ArrayUserDetails = [response mutableCopy];
             
             [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Profile Updated successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
             
             NSString *strUserId;
             
             if ([response valueForKey:@"UserID"])
             {
                 strUserId = [NSString stringWithFormat:@"%@",[response valueForKey:@"UserID"]];
             }
             
             [[NSUserDefaults standardUserDefaults] setObject:strUserId forKey:@"UserID"];
             
             [self saveUserInformation:response];
         }
                                                      failure:^(NSError *error)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"response error = %@",error);
         }];
    }
    
}


#pragma tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return locationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    
    DropDownCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[DropDownCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:MyIdentifier] ;
    }
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1.0];
    cell.lblCityName.text = [[locationArray valueForKey:@"CityName"] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    txtLocation.text = [[locationArray valueForKey:@"CityName"] objectAtIndex:indexPath.row];
    _viewForLocation.hidden = YES;
    strCityID = [[locationArray valueForKey:@"CityID"] objectAtIndex:indexPath.row];
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


#pragma textfield delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == txtName)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    
    if (textField == txtEmail)
    {
        //abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@._
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@._"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    //    if (textField == _txtMobileNumber)
    //    {
    //        NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //        return resultText.length <= 10;
    //    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)saveUserInformation:(id)response
{
    [[NSUserDefaults standardUserDefaults] setObject:txtName.text forKey:@"Name"];
    [[NSUserDefaults standardUserDefaults] setObject:txtEmail.text forKey:@"Email"];
    [[NSUserDefaults standardUserDefaults] setObject:txtLocation.text forKey:@"Location"];
    
    NSString *strcityNamee = txtLocation.text;
    NSString *strCityIDd;
    
    //CityList
    NSArray *ArrCity = [[NSArray alloc] init];
    ArrCity = [[NSUserDefaults standardUserDefaults]valueForKey:@"CityList"];
    for (int i = 0; i<ArrCity.count; i++)
    {
        NSString *strgetCityName =[NSString stringWithFormat:@"%@",[[ArrCity valueForKey:@"CityName"] objectAtIndex:i]];//CityID
        if ([strgetCityName isEqualToString:strcityNamee])
        {
            strCityIDd = [[ArrCity valueForKey:@"CityID"] objectAtIndex:i];
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:strCityID forKey:@"CityID"];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _viewForLocation.hidden = YES;
    return YES;
}

@end



