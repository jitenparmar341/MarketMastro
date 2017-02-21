//
//  ViewController.m
//  MarketMastro
//
//  Created by Mac on 10/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "webManager.h"
#import "MBProgressHUD.h"
#import "DropDownViewController.h"
#import "DropDownCell.h"
#import "VerifyAndChangeMobileViewController.h"
#import "SingInViewController.h"
#import "TermsAndPrivacyViewController.h"
#import "FLAnimatedImage.h"
#import "SQLiteDatabase.h"
#import "Database.h"
#import "DBQueryHelper.h"
#import "TPKeyboardAvoidingScrollView.h"


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ViewController ()
{
    MBProgressHUD *HUD;
    NSMutableArray *LocationArray;
    NSString *strCityID;
    BOOL checked;
    NSString *strPoppedd;
    // FLAnimatedImageView *LoaderImageview;
    NSMutableArray *array;
    
    DBQueryHelper *qhObj;
    NSMutableArray *ArrayDatabase;
    
    NSString* CommodityID;
    
    NSString* ScriptCodee;
    NSString* Symbol;
    NSString* Name;
    NSString* CommodityType;
    NSString* Exch;
    NSString* ExchType;
    NSString* SubTitle;
    NSString* Series;
    NSString* CreatedDate;
    NSString* TimeSpan;
    
    NSString* ShortName;
    NSString* Digits;
    NSString* Type;
    NSString* BidTopic;
    NSString* BidItem;
    NSString* AskTopic;
    NSString* AskItem;
    NSString* Date;
    NSString* Description;
    NSString* CreatedID;
    NSString* ModifiedID;
    NSString* ModifiedDate;
    
    NSString* CityID;
    NSString* StateID;
    NSString* CountryID;
    NSString* CompanyID;
    NSString* CPTypeInt;
    NSString* TickSize;
    NSString* LotSize;
    NSString* ULToken;
    NSString* OFISTypeInt;
    NSString* CALevel;
    NSString* SortOrder;
    
    NSString* Expiry;
    double StrikeRate;
    BOOL isPopular;
    BOOL AllowOnUpdate;
    BOOL Status;
    BOOL DeletedFlag;
    BOOL UpdateFlag;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSString *strCommodity = [NSString ];
    ArrayDatabase = [[NSMutableArray alloc] init];
    
    CGRect frame = _btnSignIn.frame;
    frame.origin.y = CGRectGetMaxY(_btnRegister.frame)+10;
    _btnSignIn.frame = frame;
    
    [self MethodForDatabase];
    // [self callGif];
    [self MethodCallApiGetCommodityMaster];
    qhObj = [[DBQueryHelper alloc] init];
    array = [[NSMutableArray alloc]init];
    
    [_txtFieldFullName setReturnKeyType:UIReturnKeyDone];
    [_txtFieldReferalCode setReturnKeyType:UIReturnKeyDone];
    [_txtFieldMobileNumber setReturnKeyType:UIReturnKeyDone];
    
    
    //    CGRect btntermsFrame = _btnTerms.frame;
    //    btntermsFrame.origin.x = CGRectGetMinX(_btnTerms.frame)+5;
    //    _btnTerms.frame =btntermsFrame;
    //
    //    CGRect lblFrame = _lblAnd.frame;
    //    lblFrame.origin.x = CGRectGetMaxX(_btnTerms.frame)+1;
    //    _lblAnd.frame = lblFrame;
    //
    //    CGRect btnprivacyFrame = _btnPrivacy.frame;
    //    btnprivacyFrame.origin.x = CGRectGetMaxX(_lblAnd.frame)+1;
    
    _txtFieldLocation.userInteractionEnabled = NO;
    [self CallCityListApi];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //ss
    //    CALayer *bottomBorder = [CALayer layer];
    //    bottomBorder.frame = CGRectMake(0.0f, self.txtFieldFullName.frame.size.height - 1, self.txtFieldFullName.frame.size.width, 2.0f);
    //    bottomBorder.backgroundColor = [UIColor redColor].CGColor;
    //    [self.txtFieldFullName.layer addSublayer:bottomBorder];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.txtFieldFullName = [self borderColor:self.txtFieldFullName withMask:YES];
    self.txtFieldFullName = [self placeHolderColor:self.txtFieldFullName withSting:@"Full Name*"];
    self.txtFieldFullName.leftView =[self paddingView:self.txtFieldFullName withImageNamed:@"reg_user_icon.png"];
    
    self.txtFieldMobileNumber = [self borderColor:self.txtFieldMobileNumber withMask:YES];
    self.txtFieldMobileNumber = [self placeHolderColor:self.txtFieldMobileNumber withSting:@"Mobile Number*"];
    self.txtFieldMobileNumber.leftView =[self paddingView:self.txtFieldMobileNumber withImageNamed:@"reg_mobile_icon.png"];
    
    self.txtFieldLocation = [self borderColor:self.txtFieldLocation withMask:YES];
    self.txtFieldLocation = [self placeHolderColor:self.txtFieldLocation withSting:@"City Name"];//mumbai
    self.txtFieldLocation.leftView =[self paddingView:self.txtFieldLocation withImageNamed:@"reg_location_icon.png"];
    
    self.txtFieldReferalCode = [self borderColor:self.txtFieldReferalCode withMask:YES];
    self.txtFieldReferalCode = [self placeHolderColor:self.txtFieldReferalCode withSting:@"Referral Code (optional)"];
    self.txtFieldReferalCode.leftView =[self paddingView:self.txtFieldReferalCode withImageNamed:@"reg_mobile_icon.png"];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20,20)];
    [viewImgTxtUser setImage:[UIImage imageNamed:@"reg_target_icon.png"]];
    [paddingView addSubview:viewImgTxtUser];
    self.txtFieldLocation.rightViewMode = UITextFieldViewModeAlways;
    self.txtFieldLocation.rightView = paddingView;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.lableTerms.text]];
    NSRange rangeOne = [self.lableTerms.text rangeOfString:@"Terms of service"];
    NSRange rangeTwo = [self.lableTerms.text rangeOfString:@"Privacy Policy"];
    
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rangeOne];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rangeTwo];
    self.lableTerms.attributedText = string;
    
    self.btnRegister.layer.cornerRadius = 3.0f; // this value vary as per your desire
    self.btnRegister.clipsToBounds = YES;
    
    // [string addAttributes:[NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue Medium" size:12.0]]];
    
    _txtFieldFullName.layer.cornerRadius = 3;
    _txtFieldFullName.layer.masksToBounds=YES;
    _txtFieldFullName.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtFieldFullName.layer.borderWidth= 1.0f;
    
    _txtFieldMobileNumber.layer.cornerRadius = 3;
    _txtFieldMobileNumber.layer.masksToBounds=YES;
    _txtFieldMobileNumber.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtFieldMobileNumber.layer.borderWidth= 1.0f;
    
    _txtFieldLocation.layer.cornerRadius = 3;
    _txtFieldLocation.layer.masksToBounds=YES;
    _txtFieldLocation.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtFieldLocation.layer.borderWidth= 1.0f;
    
    _txtFieldReferalCode.layer.cornerRadius = 3;
    _txtFieldReferalCode.layer.masksToBounds=YES;
    _txtFieldReferalCode.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtFieldReferalCode.layer.borderWidth= 1.0f;
    
    [self setupvalues];
    
}

-(void)viewWillLayoutSubviews
{
    [_mainScrollView contentSizeToFit];
    [_mainScrollView layoutIfNeeded];
    //self.mainScrollView.contentSize=self.mainView.bounds.size;
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, _btnSignIn.frame.origin.y+_btnSignIn.frame.size.height);
}


-(void)MethodForDatabase
{
    [[SQLiteDatabase databaseWithFileName:@"LKSDB"] setAsSharedInstance];
    
    NSString * DocumentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *staffPath=[DocumentPath stringByAppendingPathComponent:@"LKSDB.db"];//@"staffDB.sqlite"
    NSString *staffbundlepath=[[NSBundle mainBundle]pathForResource:@"LKSDB" ofType:@"db"];
    //  NSLog(@"library path= %@",libraryPath);
    
    if([[NSFileManager defaultManager]fileExistsAtPath:staffPath])
    {
        NSLog(@"database already exists");
    }
    else
    {
        [[NSFileManager defaultManager]copyItemAtPath:staffbundlepath toPath:staffPath error:nil];
    }
    // NSLog(@"database path = %@",staffPath);
    [self refreshData];
}

- (void)refreshData {
    
    // select query
    NSString *query1 = @"delete from Alert";
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result)
     {
         NSLog(@"Delete all data from alert = %@",result);
         ArrayDatabase = result.rows;
         //        NSLog(@"Arraydatabase = %@",ArrayDatabase);
         
         
         //        SQLiteRow *object = [ArrayDatabase objectAtIndex:0];
         //        NSString *strName  = [NSString stringWithFormat:@"CommodityID - %@",[object stringForColumnName:@"CommodityID"]];
         //        NSLog(@"name = %@",strName);
     }
                                          failure:^(NSString *errorMessage)
     {
         NSLog(@"Could not fetch rows , %@",errorMessage);
     }];
    NSLog(@"Query %@ ",query1);
}

/*
 /api/GetCommodities
 /api/Settings
 */

-(void)MethodCallApiGetCommodityMaster
{
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    if (isNetworkAvailable)
    {
        [[webManager sharedObject] loginRequest:nil withMethod:@"/api/GetCommodities" successResponce:^(id response)
         {
             NSLog(@"get commodity master response = %@",response);
             [self MethodForAddCommodityToDatabase:response];
             
         }
                                        failure:^(NSError *error)
         {
             NSLog(@"get commodity master error = %@",error);
         }];
    }
}


-(void)checkNullvalues
{
    
    if (Symbol == nil)
    {
        Symbol =@"NA";
    }
    
    if (Name == nil)
    {
        Name = @"NA";
    }
    
    if (CommodityType == nil)
    {
        CommodityType = @"NA";
    }
    
    if (Exch == nil)
    {
        Exch = @"NA";
    }
    
    if ( ExchType == nil)
    {
        ExchType = @"NA";
    }
    
    if (SubTitle == nil)
    {
        SubTitle = @"NA";
    }
    
    if (Series == nil)
    {
        Series = @"NA";
    }
    
    if (CreatedDate == nil)
    {
        CreatedDate = @"NA";
    }
    
    if (TimeSpan == nil)
    {
        TimeSpan = @"NA";
    }
    
    if (ShortName == nil)
    {
        ShortName =@"NA";
    }
    
    if (Digits == nil)
    {
        Digits = @"NA";
    }
    
    if (Type == nil)
    {
        Type = @"NA";
    }
    
    if (BidTopic == nil)
    {
        BidTopic = @"NA";
    }
    
    if ( BidItem == nil)
    {
        BidItem = @"NA";
    }
    
    if (AskTopic == nil)
    {
        AskTopic = @"NA";
    }
    
    if (AskItem == nil)
    {
        AskItem = @"NA";
    }
    
    if (Date == nil)
    {
        Date = @"NA";
    }
    
    if (Description == nil)
    {
        Description = @"NA";
    }
    
    if ( CreatedID == nil)
    {
        CreatedID = @"NA";
    }
    
    if (ModifiedID == nil)
    {
        ModifiedID = @"NA";
    }
    
    if (ModifiedDate == nil)
    {
        ModifiedDate = @"NA";
    }
    
    if ( StateID == nil)
    {
        StateID = @"NA";
    }
    
    if ( CityID == nil)
    {
        CityID = @"NA";
    }
    if ( CountryID == nil)
    {
        CountryID = @"NA";
    }
    if ( CompanyID == nil)
    {
        CompanyID = @"NA";
    }
    if ( CPTypeInt == nil)
    {
        CPTypeInt = @"NA";
    }
    if ( TickSize == nil)
    {
        TickSize = @"NA";
    }
    
    if ( LotSize == nil)
    {
        LotSize = @"NA";
    }
    if ( ULToken == nil)
    {
        ULToken = @"NA";
    }
    if ( OFISTypeInt == nil)
    {
        OFISTypeInt = @"NA";
    }
    if ( CALevel == nil)
    {
        CALevel = @"NA";
    }
    if ( SortOrder == nil)
    {
        SortOrder = @"NA";
    }
    
    if ( Expiry == nil)
    {
        Expiry = @"NA";
    }
    if ( StrikeRate == (int)nil)
    {
        StrikeRate = 0;
    }
    if ( isPopular == (bool)nil)
    {
        isPopular = 0;
    }
    
    if ( AllowOnUpdate == (bool)nil)
    {
        AllowOnUpdate = 0;
    }
    if ( Status == (bool)nil)
    {
        Status = 0;
    }
    if ( DeletedFlag == (bool)nil)
    {
        DeletedFlag = 0;
    }
    if ( UpdateFlag == (bool)nil)
    {
        UpdateFlag = 0;
    }
    if ( ScriptCodee == nil)
    {
        ScriptCodee = @"dcdc";
    }
}


-(void)MethodForAddCommodityToDatabase:(id)response
{
    
    NSMutableArray *ArrayResponse = [response mutableCopy];
    
    /*
     NSString *query = [NSString stringWithFormat:@"INSERT INTO %s (ScripCode,Name,Exch,ExchType,Tab,EC,ShortName) VALUES (:ScripCode,:Name,:Exch,:ExchType,:Tab,:EC,:ShortName)",TABLE_SEARCH_MASTER];
     
     [[SQLiteDatabase sharedInstance] executeQuery:query withParams:@{@"ScripCode" : ScripCode, @"Name" : Name, @"Exch" : Exch, @"ExchType" : ExchType, @"Tab" : Tab, @"EC" : EC, @"ShortName" : ShortName} success:^(SQLiteResult *result)
     */
    
    
    // NSString *query = @"INSERT INTO Commodity (CommodityID) VALUES (:CommodityID)";
    
    
    
    ArrayResponse = [response valueForKey:@"insert"];
    
    
    for (int i = 0; i < ArrayResponse.count; i++)
    {
        NSDictionary *dic = [ArrayResponse objectAtIndex:i];
        
        // [dic valueForKey:@"CommodityID"];
        
        CommodityID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"CommodityID"]];
        
        Symbol   = [dic valueForKey:@"Symbol"];
        Name= [dic valueForKey:@"Name"];
        CommodityType =[NSString stringWithFormat:@"%@",[dic valueForKey:@"CommodityType"]];
        Exch = [dic valueForKey:@"Exch"];
        ExchType = [dic valueForKey:@"ExchType"];
        SubTitle = [dic valueForKey:@"SubTitle"];
        Series = [dic valueForKey:@"Series"];
        CreatedDate = [dic valueForKey:@"CreatedDate"];
        TimeSpan = [dic valueForKey:@"TimeSpan"];
        ShortName = [dic valueForKey:@"ShortName"];
        Digits = [dic valueForKey:@"Digits"];
        Type = [dic valueForKey:@"Type"];
        BidTopic = [dic valueForKey:@"BidTopic"];
        BidItem = [dic valueForKey:@"BidItem"];
        AskTopic = [dic valueForKey:@"AskTopic"];
        AskItem = [dic valueForKey:@"AskItem"];
        Date = [dic valueForKey:@"Date"];
        Description = [dic valueForKey:@"Description"];
        CreatedID = [dic valueForKey:@"CreatedID"];
        ModifiedID = [dic valueForKey:@"ModifiedID"];
        ModifiedDate = [dic valueForKey:@"ModifiedDate"];
        
        
        // [NSString stringWithFormat:@"%@",[dic valueForKey:@"CityID"]];
        
        CityID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"CityID"]];
        StateID = [NSString stringWithFormat:@"%@", [dic valueForKey:@"StateID"]];
        CountryID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"CountryID"]];
        CompanyID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"CompanyID"]];
        CPTypeInt =[NSString stringWithFormat:@"%@",[dic valueForKey:@"CPTypeInt"]] ;
        TickSize = [NSString stringWithFormat:@"%@",[dic valueForKey:@"TickSize"]];
        LotSize= [NSString stringWithFormat:@"%@",[dic valueForKey:@"LotSize"]];
        ULToken= [NSString stringWithFormat:@"%@",[dic valueForKey:@"ULToken"]];
        OFISTypeInt= [NSString stringWithFormat:@"%@",[dic valueForKey:@"OFISTypeInt"]];
        CALevel= [NSString stringWithFormat:@"%@",[dic valueForKey:@"CALevel"]];
        SortOrder= [NSString stringWithFormat:@"%@",[dic valueForKey:@"SortOrder"]];
        
        Expiry= [NSString stringWithFormat:@"%@",[dic valueForKey:@"Expiry"]];
        StrikeRate = [[dic valueForKey:@"StrikeRate"] doubleValue];
        isPopular= [[dic valueForKey:@"isPopular"] boolValue];
        AllowOnUpdate= [[dic valueForKey:@"AllowOnUpdate"]boolValue];
        Status= [[dic valueForKey:@"Status"]boolValue];
        DeletedFlag= [[dic valueForKey:@"DeletedFlag"]boolValue];
        UpdateFlag= [[dic valueForKey:@"UpdateFlag"]boolValue];
        ScriptCodee = [dic valueForKey:@"ScriptCode"];
        
        if (CommodityID == nil)
        {
            continue;
        }
        
        [self checkNullvalues];
        [self MethodExcuteQuery];
    }
}


-(void)MethodExcuteQuery
{
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Commodity (CommodityID,ScriptCode,Symbol,Name,CommodityType,Exch,ExchType,SubTitle,Series,CreatedDate,TimeSpan, ShortName, Digits,Type , BidTopic, BidItem, AskTopic,AskItem , Date ,Description , CreatedID,ModifiedID , ModifiedDate,CityID ,StateID , CountryID,CompanyID , CPTypeInt,TickSize ,LotSize ,ULToken , OFISTypeInt,CALevel ,SortOrder,Expiry,StrikeRate,isPopular,AllowOnUpdate,Status,DeletedFlag,UpdateFlag)VALUES (:CommodityID,:ScriptCode,:Symbol,:Name,:CommodityType,:Exch,:ExchType,:SubTitle,:Series,:CreatedDate,:TimeSpan, :ShortName, :Digits,:Type , :BidTopic, :BidItem, :AskTopic,:AskItem , :Date ,:Description , :CreatedID,:ModifiedID , :ModifiedDate,:CityID ,:StateID , :CountryID,:CompanyID , :CPTypeInt,:TickSize ,:LotSize ,:ULToken , :OFISTypeInt,:CALevel ,:SortOrder,:Expiry,:StrikeRate,:isPopular,:AllowOnUpdate,:Status,:DeletedFlag,:UpdateFlag)"];
    
    
    if ([CommodityID isEqualToString:@""])
    {
        NSLog(@"present commodityID");
    }
    
    
    NSDictionary *parameter = @{
                                @"CommodityID":CommodityID,
                                @"Symbol":@" ",
                                @"Name":Name,
                                @"CommodityType":CommodityType,
                                @"Exch":Exch,
                                @"ExchType":ExchType,
                                @"SubTitle":SubTitle,
                                @"Series":Series,
                                @"CreatedDate":CreatedDate,
                                @"TimeSpan":TimeSpan,
                                @"ShortName":ShortName,
                                @"Digits":Digits,
                                @"Type":Type,
                                @"BidTopic":BidTopic,
                                @"BidItem":BidItem,
                                @"AskTopic":AskTopic,
                                @"AskItem":AskItem,
                                @"Date":Date,
                                @"Description":Description,
                                @"CreatedID":CreatedID,
                                @"ModifiedID":ModifiedID,
                                @"ModifiedDate":ModifiedDate,
                                @"CityID":CityID,
                                @"StateID":StateID,
                                @"CountryID":CountryID,
                                @"CompanyID":CompanyID,
                                @"CPTypeInt":CPTypeInt,
                                @"TickSize":TickSize,
                                @"LotSize":LotSize,
                                @"ULToken":ULToken,
                                @"OFISTypeInt":OFISTypeInt,
                                @"CALevel":CALevel,
                                @"SortOrder":SortOrder,
                                @"Expiry":Expiry,
                                @"StrikeRate":[NSNumber numberWithInt:StrikeRate],
                                @"isPopular":[NSNumber numberWithBool:isPopular],
                                @"AllowOnUpdate":[NSNumber numberWithBool:AllowOnUpdate],
                                @"Status":[NSNumber numberWithBool:Status],
                                @"DeletedFlag":[NSNumber numberWithBool:DeletedFlag],
                                @"UpdateFlag":[NSNumber numberWithBool:UpdateFlag],
                                @"ScriptCode":ScriptCodee
                                };
    
    
    [[SQLiteDatabase sharedInstance] executeUpdate:query withParams:parameter
                                           success:^(SQLiteResult *result)
     {
         NSLog(@"result = %@",result);
     }
                                           failure:^(NSString *errorMessage)
     {
         NSLog(@"Could not insert new row , %@",errorMessage);
     }];
}

-(void)setupvalues
{
    [self setDoneKeypad];
    self.navigationController.navigationBarHidden = YES;
    _viewForLocation.hidden = YES;
    LocationArray = [[NSMutableArray alloc] init];
    checked = NO;
}

-(void)setDoneKeypad
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    _txtFieldMobileNumber.inputAccessoryView = numberToolbar;
    _txtFieldReferalCode.inputAccessoryView = numberToolbar;
    _txtFieldFullName.inputAccessoryView = numberToolbar;
    
}

-(void)cancelNumberPad
{
    [_txtFieldMobileNumber resignFirstResponder];
    [_txtFieldReferalCode resignFirstResponder];
    [_txtFieldFullName resignFirstResponder];
    
    if (_txtFieldMobileNumber)
    {
        _txtFieldMobileNumber.text = @"";
    }
    else if (_txtFieldReferalCode)
    {
        _txtFieldReferalCode.text = @"";
    }
    else if (_txtFieldFullName)
    {
        _txtFieldFullName.text = @"";
    }
}

-(void)doneWithNumberPad
{
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, _btnSignIn.frame.origin.y+_btnSignIn.frame.size.height);
    
    // NSString *numberFromTheKeyboard = numberTextField.text;
    [_txtFieldReferalCode resignFirstResponder];
    [_txtFieldMobileNumber resignFirstResponder];
    [_txtFieldFullName resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
    
    NSDictionary *dicOfLoggedInUser = [[NSUserDefaults standardUserDefaults] valueForKey:@"DictOfLogedInuser"];
    
    if ([strPoppedd isEqualToString:@"YES"])
    {
        _txtFieldFullName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Name"];
        _txtFieldMobileNumber.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"MobileNumber"];
        _txtFieldLocation.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Location"];
        // _txtFieldReferalCode.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"RefCode"];
        strPoppedd = @"NO";
    }
    else
    {
        if([_strIsSigned isEqualToString:@"SignedIN"])
        {
            [_btnRegister setTitle:@"Update details" forState:UIControlStateNormal];
            _txtFieldFullName.text = [dicOfLoggedInUser valueForKey:@"Name"];
            _txtFieldMobileNumber.text = [dicOfLoggedInUser valueForKey:@"MobileNo"];
        }
    }
}

-(void)mathodUpdatedetails
{
    [self.txtFieldFullName resignFirstResponder];
    [self.txtFieldMobileNumber resignFirstResponder];
    [self.txtFieldLocation resignFirstResponder];
    [self.txtFieldReferalCode resignFirstResponder];
    
    NSString *phoneNumber = _txtFieldMobileNumber.text;
    NSString *phoneRegex = @"[789][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:phoneNumber];
    
    
    NSString *rawString = [_txtFieldFullName text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    
    if ([trimmed length] == 0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
    }
    else
    {
        if (_txtFieldFullName.text.length>0)
        {
            if (_txtFieldLocation.text.length >0)
            {
                if (_txtFieldMobileNumber.text.length >0)
                {
                    
                    if (_txtFieldMobileNumber.text.length == 10)
                    {
                        if(matches == true)
                        {
                            if (checked == YES)
                            {
                                
                                [self CallUpdatedetailsApi];
                                
                            }
                            else
                            {
                                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please accept Terms of Service and Privacy Policy." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                            }
                        }
                        else
                        {
                            NSLog(@"Mobile number should start with 7,8,9 only");
                            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter a valid mobile number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
                        }
                    }
                    else
                    {
                        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Mobile number should be 10 digit" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                    }
                }
                else
                {
                    [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter mobile number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                }
            }
            else
            {
                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter city name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
            }
        }
        else
        {
            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter name." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
        }
    }
    
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
    
    NSString *strUSerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    NSDictionary *parameter;
    if (strCityID != nil)
    {
        parameter = @{
                      @"Name":_txtFieldFullName.text,
                      @"MobileNo":_txtFieldMobileNumber.text,
                      @"CityID":strCityID,
                      @"ReferralCode":_txtFieldMobileNumber.text,
                      @"UserID":strUSerID
                      };
    }
    else
    {
        parameter = @{
                      @"Name":_txtFieldFullName.text,
                      @"MobileNo":_txtFieldMobileNumber.text,
                      @"CityID":@"0",
                      @"ReferralCode":_txtFieldMobileNumber.text,
                      @"UserID":strUSerID
                      };
    }
    
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        [[webManager sharedObject]CallPutMethodwithParameters:parameter withMethod:[NSString stringWithFormat:@"api/UserDetails/%@/true",strUSerID]
                                              successResponce:^(id response)
         {
             
             
             NSLog(@"response = %@",response);
             
             NSString *strUserId;
             if ([response valueForKey:@"UserID"])
             {
                 strUserId = [NSString stringWithFormat:@"%@",[response valueForKey:@"UserID"]];
             }
             [[NSUserDefaults standardUserDefaults] setObject:strUserId forKey:@"UserID"];
             
             [self saveUserInformation];
             
             VerifyAndChangeMobileViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"VerifyAndChangeMobileViewController"];
             verify.strMobileNumber = _txtFieldMobileNumber.text;
             verify.ChanegeMobileNumberDelegate =self;
             [self.navigationController pushViewController:verify animated:YES];
             
         }
                                                      failure:^(NSError *error)
         {
             
             NSLog(@"response error = %@",error);
         }];
    }
}


- (UITextField *)placeHolderColor:(UITextField *)txt withSting:(NSString *)placeHolderString {
    UIColor *color = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderString attributes:@{NSForegroundColorAttributeName: color}];
    return txt;
}
- (UITextField *)borderColor:(UITextField*)txt withMask:(BOOL)maskValue {
    txt.layer.borderColor=[[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0]CGColor];
    txt.layer.borderWidth= 0.1f;
    txt.layer.masksToBounds = maskValue;
    return txt;
    
}

- (UIView*)paddingView:(UITextField *)txt withImageNamed:(NSString *)image {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *viewImgTxtUser=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20,20)];
    [viewImgTxtUser setImage:[UIImage imageNamed:image]];
    [paddingView addSubview:viewImgTxtUser];
    txt.leftViewMode = UITextFieldViewModeAlways;
    return paddingView;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        CGRect keyboardBounds;
        NSValue *aValue = [note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
        
        [aValue getValue:&keyboardBounds];
        // int keyboardHeight = keyboardBounds.size.height;
        /*
         if (!keyboardIsShowing)
         {
         keyboardIsShowing = YES;
         CGRect frame = self.view.frame;
         frame.size.height -= 210;
         
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationBeginsFromCurrentState:YES];
         [UIView setAnimationDuration:0.3f];
         self.view.frame = frame;
         [UIView commitAnimations];
         }
         */
        
        if (!keyboardIsShowing)
        {
            keyboardIsShowing = YES;
            CGRect frame = self.view.frame;
            
            //Harish
            //            frame.size.height -= 210;
            if ([_txtFieldFullName isEditing]) {
                if (CGRectGetMaxY(_txtFieldFullName.frame)>frame.size.height-270) {
                    frame.origin.y -= (CGRectGetMaxY(_txtFieldFullName.frame)-(frame.size.height-255)) + 51;
                }
            }
            else if ([_txtFieldMobileNumber isEditing]) {
                if (CGRectGetMaxY(_txtFieldMobileNumber.frame)>frame.size.height-270) {
                    frame.origin.y -= (CGRectGetMaxY(_txtFieldMobileNumber.frame)-(frame.size.height-255)) + 51;
                }
            }
            else if ([_txtFieldReferalCode isEditing]) {
                if (CGRectGetMaxY(_txtFieldReferalCode.frame)>frame.size.height-270) {
                    frame.origin.y -= (CGRectGetMaxY(_txtFieldReferalCode.frame)-(frame.size.height-255)) + 51;
                }
            }
            //Harish
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.3f];
            self.view.frame = frame;
            [UIView commitAnimations];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)note
{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        CGRect keyboardBounds;
        NSValue *aValue = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        [aValue getValue: &keyboardBounds];
        
        // keyboardHeight = keyboardBounds.size.height;
        if (keyboardIsShowing)
        {    /*
              keyboardIsShowing = NO;
              CGRect frame = self.view.frame;
              frame.size.height += 210;
              
              [UIView beginAnimations:nil context:NULL];
              [UIView setAnimationBeginsFromCurrentState:YES];
              [UIView setAnimationDuration:0.3f];
              self.view.frame = frame;
              [UIView commitAnimations];
              */
            
            keyboardIsShowing = NO;
            CGRect frame = self.view.frame;
            //Harish
            //            frame.size.height += 210;
            if (frame.origin.y!=0) {
                frame.origin.y = 0;
                //                frame.origin.y += frame.origin.y * -1;
            }
            //Harish
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.3f];
            self.view.frame = frame;
            [UIView commitAnimations];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txtFieldFullName resignFirstResponder];
    [self.txtFieldMobileNumber resignFirstResponder];
    [self.txtFieldLocation resignFirstResponder];
    [self.txtFieldReferalCode resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _viewForLocation.hidden = YES;
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _txtFieldFullName)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        
        if (_txtFieldFullName.text.length >150)
        {
            NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return resultText.length <= 10;
        }
        
        return [string isEqualToString:filtered];
    }
    if(textField == _txtFieldMobileNumber || textField == _txtFieldReferalCode)
    {
        NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return resultText.length <= 10;
        
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRegisterTapped:(id)sender
{
    
    if([_strIsSigned isEqualToString:@"SignedIN"])
    {
        [self mathodUpdatedetails];
    }
    else
    {
        
        [self.txtFieldFullName resignFirstResponder];
        [self.txtFieldMobileNumber resignFirstResponder];
        [self.txtFieldLocation resignFirstResponder];
        [self.txtFieldReferalCode resignFirstResponder];
        
        
        NSString *phoneNumber = _txtFieldMobileNumber.text;
        NSString *phoneRegex = @"[789][0-9]{6}([0-9]{3})?";
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        BOOL matches = [test evaluateWithObject:phoneNumber];
        
        
        NSString *rawString = [_txtFieldFullName text];
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
        if ([trimmed length] == 0)
        {
            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
        }
        else
        {
            if (_txtFieldFullName.text.length>0)
            {
                if (_txtFieldLocation.text.length >0)
                {
                    if (_txtFieldMobileNumber.text.length >0)
                    {
                        
                        if (_txtFieldMobileNumber.text.length == 10)
                        {
                            if(matches == true)
                            {
                                if (checked == YES)
                                {
                                    //   LoaderImageview.hidden = NO;
                                    //$$$
                                    
                                    [[MethodsManager sharedManager]loadingView:self.view];
                                    
                                    NSDictionary *parameter;
                                    NSString *strRefCode;
                                    
                                    strRefCode = _txtFieldReferalCode.text;
                                    
                                    if (strCityID != nil)
                                    {
                                        parameter = @{
                                                      @"Name":_txtFieldFullName.text,
                                                      @"MobileNo":_txtFieldMobileNumber.text,
                                                      @"CityID":strCityID,
                                                      @"ReferCode":strRefCode
                                                      };
                                    }
                                    else
                                    {
                                        parameter = @{
                                                      @"Name":_txtFieldFullName.text,
                                                      @"MobileNo":_txtFieldMobileNumber.text,
                                                      @"CityID":@"0",
                                                      @"ReferCode":strRefCode
                                                      };
                                    }
                                    
                                    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
                                    
                                    if (isNetworkAvailable)
                                    {
                                        [[webManager sharedObject] CallPostMethod:parameter withMethod:@"api/UserDetails"
                                                                  successResponce:^(id response)
                                         {
                                             [[MethodsManager sharedManager]StopAnimating];
                                             
                                             NSString *strEmail = @"";
                                             [[NSUserDefaults standardUserDefaults] setObject:strEmail forKey:@"Email"];
                                             
                                             //Location
                                             [[NSUserDefaults standardUserDefaults]setObject:_txtFieldLocation.text forKey:@"Location"];
                                             
                                             NSLog(@"response = %@",response);
                                             NSString *strUserId;
                                             if ([response valueForKey:@"UserID"])
                                             {
                                                 strUserId = [response valueForKey:@"UserID"];
                                             }
                                             [[NSUserDefaults standardUserDefaults] setObject:strUserId forKey:@"UserID"];
                                             
                                             [self saveUserInformation];
                                             VerifyAndChangeMobileViewController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"VerifyAndChangeMobileViewController"];
                                             verify.strMobileNumber = _txtFieldMobileNumber.text;
                                             verify.ChanegeMobileNumberDelegate =self;
                                             [self.navigationController pushViewController:verify animated:YES];
                                             
                                         }
                                                                          failure:^(NSError *error)
                                         {
                                             [[MethodsManager sharedManager]StopAnimating];
                                             //  LoaderImageview.hidden = YES;
                                             NSLog(@"response error = %@",error);
                                         }];
                                    }
                                }
                                else
                                {
                                    [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please accept Terms of Service and Privacy Policy." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                                }
                            }
                            else
                            {
                                NSLog(@"Mobile number should start with 7,8,9 only");
                                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter a valid mobile number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
                            }
                        }
                        else
                        {
                            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Mobile number should be 10 digit" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                        }
                    }
                    else
                    {
                        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter mobile number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                    }
                }
                else
                {
                    [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter city name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                }
            }
            else
            {
                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter name." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
            }
        }
    }
}

-(void)saveUserInformation
{
    [[NSUserDefaults standardUserDefaults] setObject:_txtFieldFullName.text forKey:@"Name"];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Name"]);
    
    [[NSUserDefaults standardUserDefaults] setObject:_txtFieldMobileNumber.text forKey:@"MobileNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:_txtFieldLocation.text forKey:@"Location"];
    // [[NSUserDefaults standardUserDefaults] setObject:_txtFieldReferalCode.text forKey:@"RefCode"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationController.navigationBar setHidden:NO];
}

- (IBAction)btnTxtLocationTapped:(id)sender
{
    [_txtFieldFullName resignFirstResponder];
    [_txtFieldMobileNumber resignFirstResponder];
    [_txtFieldReferalCode resignFirstResponder];
    
    if (LocationArray!=nil)
    {
        _viewForLocation.hidden = !_viewForLocation.hidden;
    }
}

- (IBAction)btnReferalCodeTapped:(id)sender
{
    //_txtFieldReferalCode.text = _txtFieldMobileNumber.text;
}

#pragma change mobile number delegate
-(void)sendDataToA:(NSString *)strPopped
{
    strPoppedd = strPopped;
}


- (IBAction)MethodForTermsOfService:(id)sender
{
    //this method is for checkbox
    checked = !checked;
    [sender setImage:[UIImage imageNamed:((checked) ? @"checked.png" : @"unchecked.png")] forState:UIControlStateNormal];
}

- (IBAction)btnTermsOfserviceTapped:(id)sender
{
    //terms_of_service:http://admin.marketmastro.com/StaticPage/sPage?pagename=tos"
    //privacy_policy:http://admin.marketmastro.com/StaticPage/sPage?
    //    pagename=pp
    
    //TermsOfService
    TermsAndPrivacyViewController *tos = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndPrivacyViewController"];
    tos.strPrivacyOrService = @"Terms Of Service";
    [self.navigationController pushViewController:tos animated:YES];
}

- (IBAction)btnPrivacyPolicyTapped:(id)sender
{
    TermsAndPrivacyViewController *tos = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndPrivacyViewController"];
    tos.strPrivacyOrService = @"Privacy Policy";
    [self.navigationController pushViewController:tos animated:YES];
}

- (IBAction)btnSignInTapped:(id)sender
{
    SingInViewController *sign = [self.storyboard instantiateViewControllerWithIdentifier:@"SingInViewController"];
    [self.navigationController pushViewController:sign animated:YES];
}

-(void)CallCityListApi
{
    // LoaderImageview.hidden = NO;
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        [[webManager sharedObject]loginRequest:nil withMethod:@"api/GetCity"
                               successResponce:^(id response)
         {
             // LoaderImageview.hidden = YES;
             NSLog(@"feedback  response = %@",response);
             LocationArray = [response mutableCopy];
             
             /*
              historialServicios = [[NSMutableDictionary alloc]init];
              array = [NSMutableArray new];
              
              
              for (dictionary in messageArray) {
              //datos de nivel objects
              NSString * code = [dictionary objectForKey:@"code"];
              NSString * date = [dictionary objectForKey:@"date"];
              
              //datos de nivel client
              NSDictionary *level2Dict = [dictionary objectForKey:@"client"];
              id someObject = [level2Dict objectForKey:@"email"];
              
              // ADDING TO ARRAY
              [array addObject:@{@"code": code, @"date": date, @"email":someObject}];
              
              NSLog(@"NOMBRE===%@",someObject);
              NSString * email = someObject;
              NSLog(@"EMAIL=%@",email);
              NSLog(@"CODE=%@",code);
              NSLog(@"DATE=%@",date);
              
              //insertamos objetos en diccionario historialServicios
              }
              */
             
             
             NSString *StrCityID = @"0";
             NSString *StrStateID = @"0";
             NSString *StrCityName = @"Other";
             
             [LocationArray addObject:@{@"CityID": StrCityID, @"CityName": StrCityName, @"StateID":StrStateID}];
             
             [[NSUserDefaults standardUserDefaults]setObject:LocationArray forKey:@"CityList"];
             
             _txtFieldLocation.text = [[LocationArray valueForKey:@"CityName"] objectAtIndex:0];
             [_tableLocation reloadData];
         }
                                       failure:^(NSError *error)
         {
             // LoaderImageview.hidden = YES;
             NSLog(@"feedback error = %@",error);
             [[[UIAlertView alloc]initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
         }];
    }
}


#pragma tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return LocationArray.count;
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
    cell.lblCityName.text = [[LocationArray valueForKey:@"CityName"] objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _txtFieldLocation.text = [[LocationArray valueForKey:@"CityName"] objectAtIndex:indexPath.row];
    _viewForLocation.hidden = YES;
    strCityID = [[LocationArray valueForKey:@"CityID"] objectAtIndex:indexPath.row];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txtFieldMobileNumber resignFirstResponder];
}


@end
