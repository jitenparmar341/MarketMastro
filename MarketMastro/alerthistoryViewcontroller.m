//
//  alerthistoryViewcontroller.m
//  MarketMastro
//
//  Created by DHARMESH on 06/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "alerthistoryViewcontroller.h"

@interface alerthistoryViewcontroller ()<UITableViewDataSource,UITableViewDelegate, GADBannerViewDelegate, GADInAppPurchaseDelegate, GADAdSizeDelegate>
{
    NSMutableArray *ArrayAlertHistory;
    NSArray *menuItems;
}
@end

@implementation alerthistoryViewcontroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Alerts";
    menuItems = @[@"market"];
    _lblNoDataFound.hidden = YES;
    
    //AdBanner
    [self bannerAd];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    ArrayAlertHistory = [[NSMutableArray alloc] init];
    [self MethodGetAlertHistory];
}

-(void)MethodGetAlertHistory
{
    //get alert history
    NSString *query1 = @"SELECT * from Alert where isExecuted=1";
    NSLog(@"Query %@ ",query1);
    
    [[MethodsManager sharedManager]loadingView:self.view];
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"select all rows from database = %@",result);
         ArrayAlertHistory = result.rows;
         NSLog(@"Array of history  = %@",ArrayAlertHistory);
         
         if (ArrayAlertHistory.count > 0)
         {
             _lblNoDataFound.hidden = YES;
         }
         else
         {
             _lblNoDataFound.hidden = NO;
         }
         [_tableAlertHistory reloadData];
     }
     failure:^(NSString *errorMessage)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Could not fetch rows , %@",errorMessage);
     }];
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrayAlertHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"HistoryCell";
    CurrentAlertListCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[CurrentAlertListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:MyIdentifier] ;
    }
    
    SQLiteRow *object = [ArrayAlertHistory objectAtIndex:indexPath.row];
    NSString *strText = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"HistoryText"]];
    //remove html tags from strhistorytext
    strText = [self removeHtmlTags:strText];
    cell.lblCommodityAlert.text = strText;
    NSString *dateString = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"CreatedDateTime"]];
    cell.lbldate.text = dateString;
    return cell;
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
        NSLog(@"= is not found");
    }
    return historyText;
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
    
    _tableAlertHistory.frame = CGRectMake(CGRectGetMinX(_tableAlertHistory.frame), CGRectGetMinY(_tableAlertHistory.frame), CGRectGetWidth(_tableAlertHistory.frame), CGRectGetHeight(_tableAlertHistory.frame)-height);
    
//    self.viewForEMC.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    NSLog(@"adViewDidReceiveAd");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    adBannerView.hidden = YES;

    _tableAlertHistory.frame = CGRectMake(CGRectGetMinX(_tableAlertHistory.frame), CGRectGetMinY(_tableAlertHistory.frame), CGRectGetWidth(_tableAlertHistory.frame), SCREEN_HEIGHT-CGRectGetMinY(_tableAlertHistory.frame));
    
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
