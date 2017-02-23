//
//  AlertViewController.m
//  MarketMastro
//
//  Created by Mac on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "AlertViewController.h"
#import "SWRevealViewController.h"
#import "CreateAlertVC.h"
@interface AlertViewController ()<MyAlertViewDelegate,UIAlertViewDelegate, GADBannerViewDelegate, GADInAppPurchaseDelegate, GADAdSizeDelegate>

{
    NSMutableArray *ArrGetCurrentAlertList;
    NSString *strCommodityName;
    NSString *strAlertID;
    NSString *strPauseAlerts;
    NSMutableArray *ArrayGetAlertFromDB;
    NSString *strLastUpdatedDate;
    NSString *strLastUpdatedTime;
    NSMutableArray *ArrayInsertWithLudt;
    NSMutableArray *ArrayUpdateWithLudt;
    
    
    //DB
    NSString *CommodityName;
    NSString *Condition;
    NSString *ScriptCodee;
    NSString *Text;
    NSString *CreatedDateTime;
    NSString *ExpiryDateTime;
    NSString *Value;
    NSString *HistoryText;
    NSString *AlertID;
    int CommodityID;
    NSString *PauseAlerts;
    NSString *CreatedOn;
    int isExecuted;
    int isRead;
    
    //AdMob
    CGFloat tableY;
}
@property (nonatomic, strong) IBOutlet UILabel *label;
@end

@implementation AlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Alert Center";
    tableY = _tableCurrentAlerts.frame.origin.y;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    /*
     [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     */
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    ArrayGetAlertFromDB = [[NSMutableArray alloc] init];
    ArrayInsertWithLudt = [[NSMutableArray alloc] init];
    ArrayUpdateWithLudt = [[NSMutableArray alloc] init];
    
    //get alert list api
    [self CallGetAlertListApi];
    
    self.tableCurrentAlerts.allowsMultipleSelectionDuringEditing = NO;
    if(!_is_NotFromDraw)
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if ( revealViewController )
        {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
    }
    else{
        [self.sidebarButton setImage:[UIImage imageNamed:@"back-button"]];
        [self.sidebarButton setTarget: self];
        [self.sidebarButton setAction: @selector( goBack: )];
    }
    
    //AdBanner
    [self bannerAd];
}

- (void)updateAlertList:(NSNotification*)notification
{
    self.label.text = notification.object;
    NSString *str = notification.object;
    
    //if get alert list is empty
    if (![str isEqualToString:@"NewAlertCreated"])
    {
        [self CallGetAlertListApi];
    }
    
    //    if (ArrayGetAlertFromDB.count >0)
    //    {
    if ([str isEqualToString:@"NewAlertCreated"])
    {
        //get alert list api
        [self CallLastRequestDateTime];
    }
    // }
}

-(void)CallLastRequestDateTime
{
    /*
     /api/getAllAlertForUser/{UserID}/{LastRequestDate?}/{Time?}
     
     in format -
     /api/getAllAlertForUser/UserID/yyyy-MM-dd/HH-mm-ss
     
     Eg:
     /api/getAllAlertForUser/1/2016-12-01/13-20-46
     */
    
    NSString *strUserID = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
    NSString *strLUDTdate = [[NSUserDefaults standardUserDefaults]valueForKey:@"LastUpdatedDate"];
    NSString *strLUDTtime = [[NSUserDefaults standardUserDefaults]valueForKey:@"LastUpdatedTime"];
    
    //GET >>
    [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/getAllAlertForUser/%@/%@/%@",strUserID,strLUDTdate,strLUDTtime]
                           successResponce:^(id response)
     {
         NSString *strLUDT = [response valueForKey:@"LUDT"];
         NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
         [dateFormatter setDateStyle:NSDateFormatterShortStyle];
         NSString *currentDateString = strLUDT;
         [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
         NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
         
         [dateFormatter setDateFormat:@"yyyy-MM-dd"];
         NSString *dateStr = [dateFormatter stringFromDate:currentDate];
         [dateFormatter setDateFormat:@"HH-mm-ss"];
         NSString *timeStr = [dateFormatter stringFromDate:currentDate];
         NSLog(@"CurrentDate:%@", currentDate);
         NSLog(@"DATE - %@",dateStr);
         NSLog(@"TIME - %@",timeStr);
         strLastUpdatedDate = dateStr;
         strLastUpdatedTime = timeStr;
         
         [[NSUserDefaults standardUserDefaults]setObject:strLastUpdatedDate forKey:@"LastUpdatedDate"];
         [[NSUserDefaults standardUserDefaults]setObject:strLastUpdatedTime forKey:@"LastUpdatedTime"];
         
         //$$$
         NSLog(@"get alert list with last updated date time success = %@",response);
         ArrayInsertWithLudt = [response valueForKey:@"insert"];
         NSMutableArray *ArrayDeleteWithLudt = [response valueForKey:@"delete"];
         ArrayUpdateWithLudt = [response valueForKey:@"update"];
         
         if (ArrayDeleteWithLudt.count >0)
         {
             for (int i =0; i<ArrayDeleteWithLudt.count; i++)
             {
                 NSString *strDeletedAlertID = [NSString stringWithFormat:@"%@",[ArrayDeleteWithLudt objectAtIndex:i]];
                 [self DeleteAlertIDFromTable:strDeletedAlertID];
             }
         }
         
         //first delete and then add
         if (ArrayInsertWithLudt.count >0)
         {
             [self deleteAllFromAlert];
         }
         
         //update issue pending >>
         
         if (ArrayUpdateWithLudt.count >0)
         {
             NSDictionary *dic = [ArrayUpdateWithLudt objectAtIndex:0];
             [self MethodForUpdateDataIntoDB:dic];
         }
         
     } failure:^(NSError *error)
     {
         NSLog(@"get alert list with last updated date time error = %@",error);
     }];
}

-(void)DeleteAlertIDFromTable:(NSString*)strDeletedAlertID
{
    NSString *query = [NSString stringWithFormat:@"delete from Alert where AlertID = '%@'",strDeletedAlertID];
    
    [[SQLiteDatabase sharedInstance]executeUpdate:query withParams:nil success:^(SQLiteResult *result)
     {
         NSLog(@"Deleted Alert id from alert table = %@",result);
         [self MethodSelectAllAlertsFromDB];
     }
                                          failure:^(NSString *errorMessage)
     {
         NSLog(@"delete alert id error message = %@",errorMessage);
     }];
}


- (void)dealloc
{
    // Clean up; make sure to add this
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateAlertList:) name:@"UpdateAlert" object:nil];
}

-(void)CallGetAlertListApi
{
    //api/getAllAlertForUser/{UserID}
    //para >> UserID - of user
    
    NSString *strUserId = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
    
    [[MethodsManager sharedManager]loadingView:self.view];
    
    [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/getAllAlertForUser/%@",strUserId] successResponce:^(id response)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Get alert list response = %@",response);
         ArrGetCurrentAlertList = [response valueForKey:@"insert"];
         
         NSString *strLUDT = [response valueForKey:@"LUDT"];
         NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
         [dateFormatter setDateStyle:NSDateFormatterShortStyle];
         NSString *currentDateString = strLUDT;
         [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
         NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
         
         [dateFormatter setDateFormat:@"yyyy-MM-dd"];
         NSString *dateStr = [dateFormatter stringFromDate:currentDate];
         [dateFormatter setDateFormat:@"HH-mm-ss"];
         NSString *timeStr = [dateFormatter stringFromDate:currentDate];
         NSLog(@"CurrentDate:%@", currentDate);
         NSLog(@"DATE - %@",dateStr);
         NSLog(@"TIME - %@",timeStr);
         strLastUpdatedDate = dateStr;
         strLastUpdatedTime = timeStr;
         
         [[NSUserDefaults standardUserDefaults]setObject:strLastUpdatedDate forKey:@"LastUpdatedDate"];
         [[NSUserDefaults standardUserDefaults]setObject:strLastUpdatedTime forKey:@"LastUpdatedTime"];
         
         //before inserting all data into table ,delete all rows from table
         [self deleteAllFromAlert];
     }
                                   failure:^(NSError *error)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Get alert list error = %@",error.description);
     }];
}


-(void)deleteAllFromAlert
{
    NSString *query = [NSString stringWithFormat:@"delete from Alert"];
    
    [[SQLiteDatabase sharedInstance]executeUpdate:query withParams:nil success:^(SQLiteResult *result)
     {
         NSMutableArray *Array = result.rows;
         
         if (Array.count == 0)
         {
             for (int i =0; i<ArrGetCurrentAlertList.count; i++)
             {
                 NSDictionary *dic = [ArrGetCurrentAlertList objectAtIndex:i];
                 // insert api response into database
                 [self MethodForInsertDataIntoDB:dic];
             }
         }
         
         if (ArrayInsertWithLudt.count >0)
         {
             NSDictionary *dic = [ArrayInsertWithLudt objectAtIndex:0];
             [self MethodForInsertDataIntoDB:dic];
         }
     }
                                          failure:^(NSString *errorMessage)
     {
         NSLog(@"delete all error message = %@",errorMessage);
     }];
}

-(void)MethodForUpdateDataIntoDB:(NSDictionary*)dic
{
    
    CommodityName= [dic valueForKey:@"CommodityName"];//string
    Condition   = [dic valueForKey:@"Condition"];//(String)
    //ScriptCode =  [dicResponse valueForKey:@"ScriptCode"];
    Text= [dic valueForKey:@"Text"];//(String) ;
    CreatedDateTime= [dic valueForKey:@"CreatedDateTime"];//(String) ;
    ExpiryDateTime = [dic valueForKey:@"ExpiryDateTime"];
    Value = [dic valueForKey:@"Value"];
    
    AlertID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"AlertID"]];
    PauseAlerts = [NSString stringWithFormat:@"%@",[dic valueForKey:@"PauseAlerts"]];
    
    CommodityID = [[dic valueForKey:@"CommodityID"] intValue];
    CreatedOn = [dic valueForKey:@"CreatedDateTime"];
    HistoryText= [dic valueForKey:@"HistoryText"];
    isExecuted= [[dic valueForKey:@"isHistory"] intValue];
    isRead=0; //0 set default
    NSString *strscriptcode = [dic valueForKey:@"ScriptCode"];
    ScriptCodee = strscriptcode;
    
    
    NSString *query1 = [NSString stringWithFormat:@"UPDATE Alert set PauseAlerts = %@ where AlertID = %@",PauseAlerts,AlertID];
    [[SQLiteDatabase sharedInstance] executeUpdate:query1 withParams:nil
                                           success:^(SQLiteResult *result)
     {
         NSLog(@"response of update alert = %@",result);
         [self MethodSelectAllAlertsFromDB];
     }
                                           failure:^(NSString *errorMessage)
     {
         NSLog(@"error of update alert = %@",errorMessage);
     }];
}


-(void)MethodForInsertDataIntoDB:(NSDictionary *)dicResponse
{
    CommodityName= [dicResponse valueForKey:@"CommodityName"];//string
    Condition   = [dicResponse valueForKey:@"Condition"];//(String)
    //ScriptCode =  [dicResponse valueForKey:@"ScriptCode"];
    Text= [dicResponse valueForKey:@"Text"];//(String) ;
    CreatedDateTime= [dicResponse valueForKey:@"CreatedDateTime"];//(String) ;
    ExpiryDateTime = [dicResponse valueForKey:@"ExpiryDateTime"];
    Value = [dicResponse valueForKey:@"Value"];
    
    AlertID = [NSString stringWithFormat:@"%@",[dicResponse valueForKey:@"AlertID"]];
    PauseAlerts = [NSString stringWithFormat:@"%@",[dicResponse valueForKey:@"PauseAlerts"]];
    
    CommodityID = [[dicResponse valueForKey:@"CommodityID"] intValue];
    CreatedOn = [dicResponse valueForKey:@"CreatedDateTime"];
    HistoryText= [dicResponse valueForKey:@"HistoryText"];
    isExecuted= [[dicResponse valueForKey:@"isHistory"] intValue];
    isRead=0; //0 set default
    NSString *strscriptcode = [dicResponse valueForKey:@"ScriptCode"];
    ScriptCodee = strscriptcode;
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Alert (AlertID,Condition,Value,PauseAlerts,Text,HistoryText,CommodityName,CreatedDateTime,ExpiryDateTime,isExecuted ,isRead,CreatedOn, CommodityID,ScriptCode) VALUES (:AlertID ,:Condition,:Value,:PauseAlerts,:Text,:HistoryText,:CommodityName,:CreatedDateTime,:ExpiryDateTime,:isExecuted ,:isRead,:CreatedOn,:CommodityID,:ScriptCode)"];
    
    NSDictionary *parameter = @{
                                @"CommodityName":[NSString stringWithFormat:@"%@",CommodityName],
                                @"Condition":[NSString stringWithFormat:@"%@",Condition],
                                @"ScriptCode":[NSString stringWithFormat:@"%@",ScriptCodee],
                                @"Text":[NSString stringWithFormat:@"%@",Text],
                                @"CreatedDateTime":[NSString stringWithFormat:@"%@",CreatedDateTime],
                                @"ExpiryDateTime":[NSString stringWithFormat:@"%@",ExpiryDateTime],
                                @"Value":[NSString stringWithFormat:@"%@",Value],
                                @"AlertID":[NSNumber numberWithInt:AlertID],
                                @"CommodityID":[NSNumber numberWithInt:CommodityID],
                                @"isExecuted":[NSNumber numberWithInt:isExecuted],
                                @"isRead":[NSNumber numberWithInt:isRead],
                                @"PauseAlerts":[NSNumber numberWithInt:PauseAlerts],
                                @"CreatedOn":CreatedOn,
                                @"HistoryText":[NSString stringWithFormat:@"%@",HistoryText]
                                };
    
    [[SQLiteDatabase sharedInstance] executeUpdate:query withParams:parameter
                                           success:^(SQLiteResult *result)
     {
         NSLog(@"response of insert into alert = %@",result);
         [self MethodSelectAllAlertsFromDB];
     }
                                           failure:^(NSString *errorMessage)
     {
         NSLog(@"error of insert into alert = %@",errorMessage);
     }];
}

-(void)MethodSelectAllAlertsFromDB
{
    
    /*
     if (isExecuted=0)
     {
     // for showing currentalert list
     }
     else if (isExecuted=1)
     {
     // for showing alert history list
     }
     */
    // NSString *query = [NSString stringWithFormat:@ "select * from Alert where isExecuted=0 order by CreatedOn DESC"];
    
    
    [ArrayGetAlertFromDB removeAllObjects];
    NSString *query1 = @"SELECT * from Alert where isExecuted=0";
    NSLog(@"Query %@ ",query1);
    
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"select all rows from database = %@",result);
         
         ArrayGetAlertFromDB = result.rows;
         NSLog(@"Arraydatabase = %@",ArrayGetAlertFromDB);
         [_tableCurrentAlerts reloadData];
         
     }
                                          failure:^(NSString *errorMessage)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Could not fetch rows , %@",errorMessage);
     }];
}


-(void)getCreatedOnInSeconds:(NSString *)str
{
    /*
     NSString *dateString = str;
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
     [dateFormatter setLocale:[NSLocale currentLocale]];
     [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
     [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
     
     NSDate *dateFromString = [[NSDate alloc] init];
     dateFromString = [dateFormatter dateFromString:dateString];
     NSTimeInterval timeInMiliseconds = [dateFromString timeIntervalSince1970]*1000;
     NSLog(@"%f",timeInMiliseconds);
     */
    
    
    //or descending order of date >>
    // NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    //  NSArray *descriptors=[NSArray arrayWithObject: descriptor];
    // NSArray *reverseOrder=[dateArray sortedArrayUsingDescriptors:descriptors];
    
}


-(void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)createAlertVIew:(id)sender {
    CreateAlertVC *createAlertvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAlertVC"];
    [self.navigationController pushViewController:createAlertvc animated:YES];
}


#pragma tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return ArrGetCurrentAlertList.count;
    return ArrayGetAlertFromDB.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    CurrentAlertListCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[CurrentAlertListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:MyIdentifier] ;
    }
    /*
     NSDictionary *dic = [ArrGetCurrentAlertList objectAtIndex:indexPath.row];
     strCommodityName = [dic valueForKey:@"CommodityName"];
     NSString *strHistoryText = [dic valueForKey:@"Text"];
     //remove html tags from strhistorytext
     strHistoryText = [self removeHtmlTags:strHistoryText];
     cell.lblCommodityAlert.text = strHistoryText;
     NSString *datestring = [dic valueForKey:@"CreatedDateTime"];
     cell.lbldate.text = datestring;
     //149,149,149
     cell.lblCommodityAlert.textColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
     
     
     NSMutableAttributedString *text =
     [[NSMutableAttributedString alloc]
     initWithAttributedString: cell.lblCommodityAlert.attributedText];
     
     [text addAttribute:NSForegroundColorAttributeName
     value:[UIColor whiteColor]
     range:NSMakeRange(11, 20)];
     
     //    NSString *str = [NSString stringWithFormat:@"%@",cell.lblCommodityAlert.attributedText];
     //    UIFont *font = [UIFont fontWithName:@"Lato-Bold" size:14.0];
     //    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
     //                                                                forKey:NSFontAttributeName];
     //    text = [[NSMutableAttributedString alloc] initWithString:str attributes:attrsDictionary];
     [cell.lblCommodityAlert setAttributedText: text];
     */
    
    
    SQLiteRow *object = [ArrayGetAlertFromDB objectAtIndex:indexPath.row];
    NSString *strText = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"Text"]];
    //remove html tags from strhistorytext
    strText = [self removeHtmlTags:strText];
    cell.lblCommodityAlert.text = strText;
    
    
    //IMP NSATTRIBUTE STRING
    /*
     NSMutableAttributedString *text =
     [[NSMutableAttributedString alloc]
     initWithAttributedString: cell.lblCommodityAlert.attributedText];
     
     [text addAttribute:NSForegroundColorAttributeName
     value:[UIColor whiteColor]
     range:NSMakeRange(11, 20)];
     [cell.lblCommodityAlert setAttributedText: text];
     */
    
    NSString *dateString = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"CreatedDateTime"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];//2017-02-03T13:36:08
    
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"dd MMM,yyyy hh:mm"];
    
    cell.lbldate.text = [dateFormatter stringFromDate:dateFromString];
    
    strCommodityName = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"CommodityName"]];
    strAlertID = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"AlertID"]];
    strPauseAlerts = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"PauseAlerts"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SQLiteRow *object = [ArrayGetAlertFromDB objectAtIndex:indexPath.row];
    NSString *strCommodity = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"CommodityName"]];
    NSString *strCondition = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"Condition"]];
    NSString *strPrice = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"Value"]];
    NSString *strAlertIDd = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"AlertID"]];
    NSString *strCommodityID = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"CommodityID"]];
    NSString *strscriptcode = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"ScriptCode"]];
    
    
    NSMutableDictionary *dictSelectedAlert = [NSMutableDictionary dictionary];
    [dictSelectedAlert setObject:strCondition forKey:@"Condition"];
    [dictSelectedAlert setObject:strCommodity forKey:@"CommodityName"];
    [dictSelectedAlert setObject:strPrice forKey:@"Value"];
    [dictSelectedAlert setObject:strAlertIDd forKey:@"AlertID"];
    [dictSelectedAlert setObject:strCommodityID forKey:@"CommodityID"];
    [dictSelectedAlert setObject:strscriptcode forKey:@"ScriptCode"];
    
    ////////
    CreateAlertVC *alert = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAlertVC"];
    alert.DicSelectedAlert = dictSelectedAlert;
    alert.isFromAertViewController = YES;
    [self.navigationController pushViewController:alert animated:YES];
}

-(NSString*)removeHtmlTags:(NSString*)historyText
{
    
    NSString *html = historyText;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                          NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)}
                                                     documentAttributes:nil
                                                                  error:nil];
    NSLog(@"html: %@", html);
    NSLog(@"attr: %@", attr);
    NSLog(@"string: %@", [attr string]);
    historyText = [attr string];
    
    
    NSString *str1 = historyText;
    NSRange range = [str1 rangeOfString:@":"];
    if (range.location != NSNotFound) {
        NSString *newString = [str1 substringToIndex:range.location];
        NSLog(@"%@",newString);
        historyText = newString;
        
    } else {
        NSLog(@": is not found");
    }
    return historyText;
}


/*
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return YES;
 }
 
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 //add code here for when you hit delete
 [[[UIAlertView alloc]initWithTitle:nil message:@"Remove Alerts for SILVER 03 MAR 2017" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil]show];
 }
 }
 */


-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *strTitle;
    
    if ([strPauseAlerts isEqualToString:@"0"])
    {
        strTitle = @"Pause";
    }
    else if ([strPauseAlerts isEqualToString:@"1"])
    {
        strTitle = @"Resume";
    }
    
    
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        
                                        NSLog(@"Action to perform with Button 1");
                                        UIAlertView *deleteAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Delete Alerts for %@",strCommodityName] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
                                        
                                        deleteAlert.delegate= self;
                                        deleteAlert.tag = 1;
                                        [deleteAlert show];
                                    }];
    button.backgroundColor = [UIColor colorWithRed:21/255.0 green:85/255.0 blue:140/255.0 alpha:1.0];
    
    CGRect frame = button.accessibilityFrame;
    frame.size.height = 85;
    button.accessibilityFrame = frame;
    
    //arbitrary color
    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:strTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         NSLog(@"Action to perform with Button2!");
                                         
                                         if ([strPauseAlerts isEqualToString:@"0"])
                                         {
                                             button2.title = @"Pause";
                                             UIAlertView *deleteAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Pause Alerts for %@",strCommodityName] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
                                             deleteAlert.delegate= self;
                                             deleteAlert.tag = 2;
                                             [deleteAlert show];
                                         }
                                         else if ([strPauseAlerts isEqualToString:@"1"])
                                         {
                                             button2.title = @"Resume";
                                             
                                             UIAlertView *deleteAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Resume Alerts for %@",strCommodityName] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
                                             deleteAlert.delegate= self;
                                             deleteAlert.tag = 2;
                                             [deleteAlert show];
                                             
                                             
                                         }
                                     }];
    button2.backgroundColor = [UIColor colorWithRed:21/255.0 green:85/255.0 blue:140/255.0 alpha:1.0];
    return @[button, button2];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)okButtonClick
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (alertView.tag == 1)
    {
        //delete
        if (buttonIndex == 1)
        {
            [self callDeleteApi];
        }
    }
    else if (alertView.tag == 2)
    {
        //pause
        if (buttonIndex == 1)
        {    //call for puase or resume api
            [self callPauseApi];
        }
    }
}

-(void)callDeleteApi
{
    //api/DeleteAlert/{AlertID}
    //AlertID - alertID of the alert to be deleted
    //post
    
    [[webManager sharedObject]CallPostMethod:nil withMethod:[NSString stringWithFormat:@"api/DeleteAlert/%@",strAlertID] successResponce:^(id response)
     {
         NSLog(@"Delete alert response = %@",response);
         [self CallLastRequestDateTime];
         
         [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Alert deleted Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
         
     } failure:^(NSError *error)
     {
         NSLog(@"delete alert error = %@",error.description);
     }];
}


-(void)callPauseApi
{
    
    if ([strPauseAlerts isEqualToString:@"0"])
    {
        //api/PauseAlert/{AlertID}/true
        //para : AlertID - alertID of the alert to be paused
        //POST
        
        //pause button action
        [[webManager sharedObject]CallPostMethod:nil withMethod:[NSString stringWithFormat:@"api/PauseAlert/%@/true",strAlertID] successResponce:^(id response)
         {
             NSLog(@"pause alert response = %@",response);
             [self CallLastRequestDateTime];
             [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Alert paused Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
             
         } failure:^(NSError *error)
         {
             NSLog(@"pause alert error = %@",error.description);
         }];
    }
    else if ([strPauseAlerts isEqualToString:@"1"])
    {
        //resume alert action
        //api/PauseAlert/{AlertID}/false>> //post
        [[webManager sharedObject]CallPostMethod:nil withMethod:[NSString stringWithFormat:@"api/PauseAlert/%@/false",strAlertID] successResponce:^(id response)
         {
             NSLog(@"resume alert response = %@",response);
             [self CallLastRequestDateTime];
             [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Alert resumed Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
         } failure:^(NSError *error)
         {
             NSLog(@"resume alert error = %@",error.description);
         }];
    }
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
    _tableCurrentAlerts.frame = CGRectMake(CGRectGetMinX(_tableCurrentAlerts.frame), CGRectGetMinY(_tableCurrentAlerts.frame), CGRectGetWidth(_tableCurrentAlerts.frame), CGRectGetHeight(_tableCurrentAlerts.frame)-height);
    NSLog(@"adViewDidReceiveAd");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    //    CGFloat height = CGRectGetHeight(adBannerView.frame);
    adBannerView.hidden = YES;
    _tableCurrentAlerts.frame = CGRectMake(CGRectGetMinX(_tableCurrentAlerts.frame), CGRectGetMinY(_tableCurrentAlerts.frame), CGRectGetWidth(_tableCurrentAlerts.frame), SCREEN_HEIGHT-CGRectGetMinY(_tableCurrentAlerts.frame));
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
