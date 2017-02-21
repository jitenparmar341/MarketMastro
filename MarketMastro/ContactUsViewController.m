//
//  ContactUsViewController.m
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "ContactUsViewController.h"
#import "SWRevealViewController.h"
#import "webManager.h"
#import "DropDownCell.h"
#import "TypeCell.h"
#import "MBProgressHUD.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface ContactUsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSArray *ArrayTypes;
    MBProgressHUD *HUD;
    FLAnimatedImageView *LoaderImageview;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self setupProgress];
    
    [self setUpvalues];
    [self setDoneKeypad];
    
    [_txtname setReturnKeyType:UIReturnKeyDone];
    [_txtMobileNumber setReturnKeyType:UIReturnKeyDone];
    [_txtEmail setReturnKeyType:UIReturnKeyDone];
    [_txtType setReturnKeyType:UIReturnKeyDone];
    [_textViewDesciption setReturnKeyType:UIReturnKeyDone];
    
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    
    
    self.title = @"Contact Us";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

-(void)viewWillLayoutSubviews
{
    [_mainScrollView contentSizeToFit];
    [_mainScrollView layoutIfNeeded];
    //self.mainScrollView.contentSize=self.mainView.bounds.size;
    
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, _btnsend.frame.origin.y+_btnsend.frame.size.height);
}

-(void)setUpvalues
{
    
    CGRect btnFrame = _btnsend.frame;
    btnFrame.origin.y = CGRectGetMaxY(_textViewDesciption.frame)+8;
    _btnsend.frame = btnFrame;
    
    _viewOfTable.hidden = YES;
    UIColor *color = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    _txtname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    _txtMobileNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{NSForegroundColorAttributeName: color}];
    _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    _txtType.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"   Type" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.txtname.leftView =[self paddingView:self.txtname withImageNamed:@"reg_user_icon.png"];
    
    self.txtMobileNumber.leftView =[self paddingView:self.txtMobileNumber withImageNamed:@"reg_mobile_icon.png"];
    self.txtEmail.leftView =[self paddingView:self.txtEmail withImageNamed:@"dro_contact_ico.png"];
    
    _txtname.layer.cornerRadius = 3;
    _txtname.layer.masksToBounds=YES;
    _txtname.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtname.layer.borderWidth= 1.0f;
    
    _txtMobileNumber.layer.cornerRadius = 3;
    _txtMobileNumber.layer.masksToBounds=YES;
    _txtMobileNumber.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    
    _txtMobileNumber.layer.borderWidth= 1.0f;
    
    _txtEmail.layer.cornerRadius = 3;
    _txtEmail.layer.masksToBounds=YES;
    _txtEmail.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtEmail.layer.borderWidth= 1.0f;
    
    _txtType.layer.cornerRadius = 3;
    _txtType.layer.masksToBounds=YES;
    _txtType.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtType.layer.borderWidth= 1.0f;
    
    _textViewDesciption.layer.cornerRadius = 3;
    _textViewDesciption.layer.masksToBounds=YES;
    _textViewDesciption.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _textViewDesciption.layer.borderWidth= 1.0f;
    
    [_textViewDesciption setTextContainerInset:UIEdgeInsetsMake(7, 7, 0, 12)];
    
    _viewOfTable.backgroundColor = self.view.backgroundColor;
    ArrayTypes = [[NSArray alloc] initWithObjects:@"Type",@"Suggestion",@"Issue",@"Enquiry",@"Custom Updates",@"Change Number Request", nil];
    _txtType.userInteractionEnabled = NO;
    
    _tableOfTypes.backgroundColor = _txtType.backgroundColor;
    [_tableOfTypes reloadData];
    
}

- (UIView*)paddingView:(UITextField *)txt withImageNamed:(NSString *)image {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20,20)];//5,5,20,20
    [viewImgTxtUser setImage:[UIImage imageNamed:image]];
    [paddingView addSubview:viewImgTxtUser];
    txt.leftViewMode = UITextFieldViewModeAlways;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)alertListBtnClick:(id)sender
{
    if (txtRef != nil)
        [txtRef resignFirstResponder];
    
    _viewOfTable.hidden = true;
    
    AlertViewController *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    calendarVC.is_NotFromDraw = YES;
    
    [self.navigationController pushViewController:calendarVC animated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    else if ([[[_textViewDesciption textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[_textViewDesciption textInputMode] primaryLanguage])
    {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    txtRef = textField;
    
    _viewOfTable.hidden = YES;
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _viewOfTable.hidden = true;
    _viewOfTable.hidden = YES;
    return YES;
}

- (IBAction)btnsendTapped:(id)sender
{
    NSString *phoneNumber = _txtMobileNumber.text;
    NSString *phoneRegex = @"[789][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:phoneNumber];
    
    
    BOOL isvalidEmail = [self NSStringIsValidEmail:_txtEmail.text];
    
    NSString *rawString = [_txtname text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    
    
    
    if (matches)
    {
        if (_txtMobileNumber.text.length >0)
        {
            if (![_txtType.text isEqualToString:@"Type"])
            {
                if (_textViewDesciption.text.length >0)
                {
                    if (isvalidEmail)
                    {
                        if (_txtEmail.text.length >0)
                        {
                            if ([trimmed length] == 0)
                            {
                                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                            }
                            else
                            {
                                [self MethodCallContactUs];
                            }
                        }
                        else
                        {
                            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter email id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
                        }
                    }
                    else
                    {
                        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid email id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
                    }
                }
                else
                {
                    [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter description" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
                }
            }
            else
            {
                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select type" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
            }
        }
        else
        {
            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter a 10 digit mobile number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        }
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter a valid Mobile Number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }
    
}

-(void)MethodCallContactUs
{
    NSString *strUserId = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    
    NSDictionary *parameters = @{
                                 @"UserID":strUserId,
                                 @"FeedbackType":_txtType.text,
                                 @"Description":_textViewDesciption.text
                                 };
    
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        [[webManager sharedObject]CallPostMethod:parameters withMethod:@"api/PostContactUs" successResponce:^(id response)
         {
             // LoaderImageview.hidden = YES;
             [[MethodsManager sharedManager]StopAnimating];
             
             NSLog(@"contact us api response = %@",response);
             [[[UIAlertView alloc]initWithTitle:@"Success" message:@"Request sent successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
         }
                                         failure:^(NSError *error)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"contact us api error = %@",error);
             [[[UIAlertView alloc]initWithTitle:@"Success" message:error.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
         }];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _txtname)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    
    if (textField == _txtEmail)
    {
        //abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@._
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@._"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    if (textField == _txtMobileNumber)
    {
        NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return resultText.length <= 10;
    }
    
    return YES;
}


#pragma tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrayTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[TypeCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:MyIdentifier] ;
    }
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:15/255.0 green:17/255.0 blue:20/255.0 alpha:1.0];
    cell.lblType.text= [ArrayTypes objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _txtType.text = [ArrayTypes objectAtIndex:indexPath.row];
    _viewOfTable.hidden = YES;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _txtType.leftView = paddingView;
    _txtType.leftViewMode = UITextFieldViewModeAlways;
}

- (IBAction)btnTypeTapped:(id)sender
{
    [txtRef resignFirstResponder];
    
    _viewOfTable.hidden = !_viewOfTable.hidden;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(_textViewDesciption.text.length == 0){
        _lblDescription.hidden = NO;
        _textViewDesciption.textColor = _txtname.textColor;
        [_textViewDesciption resignFirstResponder];
    }
    else
    {
        _lblDescription.hidden = YES;
    }
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

-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    _txtname.inputAccessoryView = numberToolbar;
    _txtEmail.inputAccessoryView = numberToolbar;
    _txtMobileNumber.inputAccessoryView = numberToolbar;
    _txtType.inputAccessoryView = numberToolbar;
    _textViewDesciption.inputAccessoryView = numberToolbar;
    
}

-(void)cancelNumberPad
{
    [_txtname resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtMobileNumber resignFirstResponder];
    [_txtType resignFirstResponder];
    [_textViewDesciption resignFirstResponder];
}

-(void)doneWithNumberPad
{
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, _btnsend.frame.origin.y+_btnsend.frame.size.height);
    
    
    [_txtname resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtMobileNumber resignFirstResponder];
    [_txtType resignFirstResponder];
    [_textViewDesciption resignFirstResponder];
}

@end
