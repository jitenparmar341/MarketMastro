//
//  FirstFourVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "FirstFourVC.h"
#import "SWRevealViewController.h"
#import "CalendarDetailsVC.h"
#import "NewDetailsVC.h"
#import "AlertViewController.h"
#import "webManager.h"
#import "GetPackageListClass.h"
#import "AFNetworkReachabilityManager.h"
#import "MBProgressHUD.h"
#import "ADPageControl.h"
#import "MarketViewController.h"

#import "NetworkManager.h"
#import "DBQueryHelper.h"
#import "SQLiteDatabase.h"
#import "NewsTableViewCell.h"

@import FirebaseAnalytics;

//Live//ca-app-pub-7827419066044802/2676708973
//Test//ca-app-pub-3940256099942544/2934735716
//static NSString *const kBannerAdUnitID = @"ca-app-pub-7827419066044802/2676708973";
//static NSString *const kInterstitialAdUnitID = @"ca-app-pub-3940256099942544/4411468910";

@interface FirstFourVC ()<UIAlertViewDelegate, ADPageControlDelegate, GADBannerViewDelegate, GADInAppPurchaseDelegate, GADAdSizeDelegate>
{
    NSArray *menuItems;
    NSArray *arrOfCollctionList;
    MBProgressHUD *HUD;
    
    //MarketPage
    __weak IBOutlet UIView *viewMarketTables;
    ADPageControl *marketPageControl;
    NSMutableArray *marketTabs;
    //Portfoliopage
    MarketViewController *portfolioVCObj;
    //News
    NSMutableArray *newsList;
    UIView *vTestView;
    
    //EMC
    NSMutableArray *eMCTabs;
    ADPageControl *eMCPageControl;
    
    //Comman
    NSMutableDictionary *seletedPageViewsDic;
    NSString *seletedPage;
    
    NSMutableArray *arrCategoryLabels, *arrCategoryIds;
}

@end

@implementation FirstFourVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"commodity_types"];
    
    [self checkNetwork];
    
    _btnMarket.selected = YES;
    _btnNews.selected = NO;
    _btnCalender.selected = NO;
    _btnPortfolio.selected = NO;
    
    
    /*[self setUpPageUI];
     
     marketTabs = @[@"Bullion", @"Expected MCX", @"Costing & Difference", @"Base metals", @"Energy", @"Local Spot", @"International Markets"];
     eMCTabs = @[@"Expected MCX", @"Costing & Difference"];
     
     seletedPageViewsDic = [[NSMutableDictionary alloc] init];
     [seletedPageViewsDic setObject:marketTabs forKey:@"Market Mastro"];
     [seletedPageViewsDic setObject:eMCTabs forKey:@"EMC"];
     
     [self reloadView];*/
    
    
    /*   [self.navigationController setNavigationBarHidden:NO animated:NO];
     //    [self.navigationController setToolbarHidden:NO animated:NO];
     
     
     // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:13/255.0 green:16/255.0 blue:20/255.0 alpha:1.0]];
     
     [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     
     menuItems = @[@"market",@"market1",@"market2",@"market3",@"market4",@"market5",@"market6"];
     
     arrOfCollctionList = @[@"Agri",@"Costing & Difference",@"Expected MCX",@"Local Spot",@"International",@"Bullion",@"Base Metals",@"Energy"];
     [_collectionView reloadData];
     
     // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:13/255.0 green:16/255.0 blue:20/255.0 alpha:1.0]];
     
     
     // Do any additional setup after loading the view.
     SWRevealViewController *revealViewController = self.revealViewController;
     
     if ( revealViewController )
     {
     [self.sidebarButton setTarget: self.revealViewController];
     [self.sidebarButton setAction: @selector( revealToggle: )];
     [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
     }
     
     //HP
     [self initialSetUpForMarketPage];
     
     //AdBanner
     [self bannerAd];*/
}

-(void)loadData{
    
    
    marketTabs = [[NSMutableArray alloc] init];
    eMCTabs = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrOfTypes =  [[NSUserDefaults standardUserDefaults] valueForKey:@"commodity_types"];
    
    
    for (int i =0; i<arrOfTypes.count; i++)
    {
        NSDictionary *dic = [arrOfTypes objectAtIndex:i];
        
        if([[dic valueForKey:@"GroupType"] isEqualToString:@"OTHERS"])
        {
            [eMCTabs addObject:[dic valueForKey:@"GroupName"]];
        }
        else
        {
            [marketTabs addObject:[dic valueForKey:@"GroupName"]];
        }
        
    }
    
    
    [self setUpPageUI];
    
    //marketTabs = @[@"Bullion", @"Expected MCX", @"Costing & Difference", @"Base metals", @"Energy", @"Local Spot", @"International Markets"];
    //eMCTabs = @[@"Expected MCX", @"Costing & Difference"];
    
    seletedPageViewsDic = [[NSMutableDictionary alloc] init];
    [seletedPageViewsDic setObject:marketTabs forKey:@"Market Mastro"];
    [seletedPageViewsDic setObject:eMCTabs forKey:@"EMC"];
    
    [self reloadView];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //    [self.navigationController setToolbarHidden:NO animated:NO];
    
    
    // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:13/255.0 green:16/255.0 blue:20/255.0 alpha:1.0]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    menuItems = @[@"market",@"market1",@"market2",@"market3",@"market4",@"market5",@"market6"];
    
    arrOfCollctionList = @[@"Agri",@"Costing & Difference",@"Expected MCX",@"Local Spot",@"International",@"Bullion",@"Base Metals",@"Energy"];
    [_collectionView reloadData];
    
    // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:13/255.0 green:16/255.0 blue:20/255.0 alpha:1.0]];
    
    
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //HP
    [self initialSetUpForMarketPage];
    
    //AdBanner
    [self bannerAd];
}

- (void)buttonImageTitleAlign {
    for (UIButton *button in @[_btnMarket, _btnNews, _btnCalender, _btnPortfolio]) {
        // the space between the image and text
        CGFloat spacing = 8.0;
        
        // lower the text and push it left so it appears centered
        //  below the image
        CGSize imageSize = button.imageView.image.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(
                                                  0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // raise the image and push it right so it appears centered
        //  above the text
        CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
        button.imageEdgeInsets = UIEdgeInsetsMake(
                                                  - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        
        // increase the content height to avoid clipping
        CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
    }
}

-(void)setUpPageUI
{
    if (indexOfDrawer == 3)
    {
        [self.navigationItem setRightBarButtonItems:nil];
        return;
    }
    
    //alert button in navigation bar
    
    CGRect frameimg = CGRectMake(0, 0, 40, 25);
    UIButton *Alert = [[UIButton alloc] initWithFrame:frameimg];
    [Alert setImage:[UIImage imageNamed:@"act_alert_ico"] forState:UIControlStateNormal];
    [Alert setImage:[UIImage imageNamed:@"alert_ico"] forState:UIControlStateHighlighted];
    [Alert.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [Alert addTarget:self action:@selector(BtnAlertTapped) forControlEvents:UIControlEventTouchUpInside];
    
    //search button in navigation bar
    
    CGRect frameimg2 = CGRectMake(0, 0, 35, 25);
    UIButton *Search = [[UIButton alloc] initWithFrame:frameimg2];
    [Search setImage:[UIImage imageNamed:@"search_ico"] forState:UIControlStateNormal];
    [Search setImage:[UIImage imageNamed:@"search_ico"] forState:UIControlStateHighlighted];
    [Search.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [Search addTarget:self action:@selector(BtnSearchTapped) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frameimg3 = CGRectMake(0, 0, 35, 25);
    UIButton *list = [[UIButton alloc] initWithFrame:frameimg3];
    [list setImage:[UIImage imageNamed:@"act_boxview_ico"] forState:UIControlStateNormal];
    [list setImage:[UIImage imageNamed:@"act_listview_ico"] forState:UIControlStateSelected];
    [list.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [list addTarget:self action:@selector(filterClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //+ button in navigation bar
    
    UIBarButtonItem *btnAlert = [[UIBarButtonItem alloc] initWithCustomView:Alert];
    UIBarButtonItem *btnSearch = [[UIBarButtonItem alloc] initWithCustomView:Search];
    UIBarButtonItem *btnList = [[UIBarButtonItem alloc] initWithCustomView:list];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnList,btnAlert, btnSearch, nil]];
    
    if (indexOfDrawer == 2)
    {
        CGRect frameimg3 = CGRectMake(0, 0, 35, 25);
        UIButton *plusButton = [[UIButton alloc] initWithFrame:frameimg3];
        [plusButton setImage:[UIImage imageNamed:@"act_addcommodities_ico"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"act_addcommodities_ico"] forState:UIControlStateHighlighted];
        [plusButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [plusButton addTarget:self action:@selector(BtnSearchTapped) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect frameimg4 = CGRectMake(0, 0, 35, 25);
        UIButton *editButton = [[UIButton alloc] initWithFrame:frameimg4];
        [editButton setImage:[UIImage imageNamed:@"act_edit_ico"] forState:UIControlStateNormal];
        [editButton setImage:[UIImage imageNamed:@"act_edit_ico"] forState:UIControlStateHighlighted];
        [editButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [editButton addTarget:self action:@selector(editClicked) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect frameimg5 = CGRectMake(0, 0, 35, 25);
        UIButton *list = [[UIButton alloc] initWithFrame:frameimg5];
        [list setImage:[UIImage imageNamed:@"act_boxview_ico"] forState:UIControlStateNormal];
        [list setImage:[UIImage imageNamed:@"act_listview_ico"] forState:UIControlStateSelected];
        [list.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [list addTarget:self action:@selector(filterClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *btnAlert = [[UIBarButtonItem alloc] initWithCustomView:Alert];
        UIBarButtonItem *btnPlus = [[UIBarButtonItem alloc] initWithCustomView:plusButton];
        UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc] initWithCustomView:editButton];
        UIBarButtonItem *btnList = [[UIBarButtonItem alloc] initWithCustomView:list];
        
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnList,btnAlert,btnEdit,btnPlus, nil]];
    }
}

-(void)BtnAlertTapped
{
    AlertViewController *alert = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    [self.navigationController pushViewController:alert animated:YES];
}

- (void)filterClicked:(UIButton *)sender
{
    sender.selected =! sender.selected;
}

- (void)editClicked
{
    
}

-(void)BtnSearchTapped
{
    CreatePortflioVC *commodityPage = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatePortflioVC"];
    commodityPage.isFromVC = @"Dashboard";
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Dashboard" forKey:@"isFromVC"];
    
    [self.navigationController pushViewController:commodityPage animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *tSImg = [UIImage imageFromColor:[UIColor colorwithHexString:@"16191B"] size:_btnMarket.frame.size];
    [_btnMarket setBackgroundImage:tSImg forState:UIControlStateSelected];
    [_btnNews setBackgroundImage:tSImg forState:UIControlStateSelected];
    [_btnCalender setBackgroundImage:tSImg forState:UIControlStateSelected];
    [_btnPortfolio setBackgroundImage:tSImg forState:UIControlStateSelected];
    
    UIImage *tDImg = [UIImage imageFromColor:[UIColor colorwithHexString:@"0C1014"] size:_btnMarket.frame.size];
    [_btnMarket setBackgroundImage:tDImg forState:UIControlStateNormal];
    [_btnNews setBackgroundImage:tDImg forState:UIControlStateNormal];
    [_btnCalender setBackgroundImage:tDImg forState:UIControlStateNormal];
    [_btnPortfolio setBackgroundImage:tDImg forState:UIControlStateNormal];
    
    if (_btnMarket) {
        [self buttonImageTitleAlign];
    }
}

#pragma mark - MarketPage

- (void)initialSetUpForMarketPage
{
    [HPClassObj rateUpSetColor:viewCommodity1];
    [HPClassObj rateDownSetColor:viewCommodity2];
    [HPClassObj rateUpSetColor:viewCommodity3];
}
-(void)checkNetwork
{
    BOOL isinternetAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if(isinternetAvailable)
    {
        NSLog(@"Network reachable");
        [self MethodCallGenerateTokenApi];
    }
    else
    {
        NSLog(@"network not reachable");
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil]show];
    }
}

-(void)MethodCallGenerateTokenApi
{
    NSString *strOtp = [[NSUserDefaults standardUserDefaults] valueForKey:@"SavedOtp"];
    NSString *strUserId = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    strOtp = [NSString stringWithFormat:@"%@",strOtp];
    strUserId = [NSString stringWithFormat:@"%@",strUserId];
    
    if (strUserId !=nil || strOtp != nil)
    {
        [HUD show:YES];
        BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
        
        if (isNetworkAvailable)
        {
            NSDictionary *parameter = @{
                                        @"OTP":strOtp,
                                        @"UserID":strUserId
                                        };
            
            [[webManager sharedObject] CallPostMethod:parameter withMethod:@"api/GenerateToken" successResponce:^(id response)
             {
                 
                 NSLog(@"Generate token response = %@",response);
                 NSString *strTokenID = [NSString stringWithFormat:@"%@",[response valueForKey:@"TokenID"]];
                 [[NSUserDefaults standardUserDefaults] setObject:strTokenID forKey:@"TokenID"];
                 [self MethodGetcurrentActivePackage];
                 
             }
                                              failure:^(NSError *error)
             {
                 NSLog(@"Generate token error = %@",error);
             }];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }
}

/*
 
 /api/getActiveUserSubscription/{UserID}
 UserID
 get
 */

-(void)MethodGetcurrentActivePackage
{
    NSString *strUserID = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
    strUserID = [NSString stringWithFormat:@"%@",strUserID];
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        if (strUserID !=nil)
        {
            
            [[MethodsManager sharedManager]loadingView:self.view];
            
            [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/getActiveUserSubscription/%@",strUserID]
                                   successResponce:^(id response)
             {
                 [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"get current active package response = %@",response);
                 
                 NSDictionary *DicwithCurreentActivePackDetails = @{
                                                                    @"CPUsed":[response valueForKey:@"CPUsed"],
                                                                    @"ExpiredOn":[response valueForKey:@"ExpiredOn"],
                                                                    @"Groups":[response valueForKey:@"Groups"],
                                                                    @"PackageID": [response valueForKey:@"PackageID"],
                                                                    @"PackageName":[response valueForKey:@"PackageName"],
                                                                    @"Paid":[response valueForKey:@"Paid"],
                                                                    @"Price": [response valueForKey:@"Price"],
                                                                    @"PurchasedOn":[response valueForKey:@"PurchasedOn"],
                                                                    @"PurchasedStatus":[response valueForKey:@"PurchasedStatus"],
                                                                    @"USOrderID":[response valueForKey:@"USOrderID"],
                                                                    @"WithAd":[response valueForKey:@"WithAd"],
                                                                    @"isExpired":[response valueForKey:@"isExpired"]
                                                                    };
                 
                 
                 [[NSUserDefaults standardUserDefaults]setObject:DicwithCurreentActivePackDetails forKey:@"DicwithCurreentActivePackDetails"];
                 
                 NSMutableArray *arrOfTypes =  [[NSUserDefaults standardUserDefaults] valueForKey:@"commodity_types"];
                 
                 if(arrOfTypes==nil)
                 {
                     
                     [self MethodGetCommodityTypes];
                 }
                 
             }
                                           failure:^(NSError *error)
             {
                 [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"get current active package error = %@",error);
                 if (error.code==602) {
                     [self redirectToRegistrationPage:error];
                 }
                 else
                     [self MethodGetCommodityTypes];
             }];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        }
    }
}

/*
 //Method to get user details
 -(void)MethodGetUserDetails
 {
 NSString *strMobileNo = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
 strMobileNo = [NSString stringWithFormat:@"%@",strMobileNo];
 
 
 if (strUserID !=nil)
 {
 [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/getActiveUserSubscription/%@",strUserID]
 successResponce:^(id response)
 {
 [HUD hide:YES];
 NSLog(@"get current active package response = %@",response);
 
 
 NSDictionary *DicwithCurreentActivePackDetails = @{
 @"CPUsed":[response valueForKey:@"CPUsed"],
 @"ExpiredOn":[response valueForKey:@"ExpiredOn"],
 @"Groups":[response valueForKey:@"Groups"],
 @"PackageID": [response valueForKey:@"PackageID"],
 @"PackageName":[response valueForKey:@"PackageName"],
 @"Paid":[response valueForKey:@"Paid"],
 @"Price": [response valueForKey:@"Price"],
 @"PurchasedOn":[response valueForKey:@"PurchasedOn"],
 @"PurchasedStatus":[response valueForKey:@"PurchasedStatus"],
 @"USOrderID":[response valueForKey:@"USOrderID"],
 @"WithAd":[response valueForKey:@"WithAd"],
 @"isExpired":[response valueForKey:@"isExpired"]
 };
 
 
 [[NSUserDefaults standardUserDefaults]setObject:DicwithCurreentActivePackDetails forKey:@"DicwithCurreentActivePackDetails"];
 
 }
 failure:^(NSError *error)
 {
 [HUD hide:YES];
 NSLog(@"get current active package error = %@",error);
 }];
 }
 else
 {
 [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
 }
 }
 */



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(self.tableViewForNews == tableView)
    {
        return newsList.count;
        //        return menuItems.count;
    }
    else {
        return 15;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(tableView == self.tableViewForNews)
    {
        /*
         NewsTableViewCell *nCell = [tableView dequeueReusableCellWithIdentifier:newsCellId];
         if (!nCell) {
         nCell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCellId];
         }
         
         //        NewsTableViewCell *nCell = (NewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
         nCell.lblNewsTitle = [[newsList objectAtIndex:indexPath.row] objectForColumnName:@"title"];
         nCell.lblNewsTime = [[newsList objectAtIndex:indexPath.row] objectForColumnName:@"pubDate"];
         cell = nCell;
         */
        
        NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    else
    {
        NSString *CellIdentifier = @"market";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableViewForNews)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        UILabel *label = (UILabel*)[cell viewWithTag:21];
        UIImageView *imgView = (UIImageView*)[cell viewWithTag:20];
        
        NewDetailsVC *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDetailsVC"];
        calendarVC.titleForString = label.text;
        calendarVC.imageLoad = imgView.image;
        [self.navigationController pushViewController:calendarVC animated:YES];
    }
    else   if(tableView == self.tableViewForCalendar)
    {
        CalendarDetailsVC *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarDetailsVC"];
        [self.navigationController pushViewController:calendarVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reloadView
{
    UIButton *btnMarket = (UIButton*)[self.view viewWithTag:10];
    UIButton *btnPortfolio = (UIButton*)[self.view viewWithTag:11];
    UIButton *btnNews = (UIButton*)[self.view viewWithTag:12];
    UIButton *btnCalendar = (UIButton*)[self.view viewWithTag:13];
    
    btnMarket.selected = NO;
    btnPortfolio.selected = NO;
    btnNews.selected = NO;
    btnCalendar.selected = NO;
    
    if (indexOfDrawer>3) {
        if (btnMarket.selected) {
            indexOfDrawer = 0;
        }
        else if (btnNews.selected) {
            indexOfDrawer = 1;
        }
        else if (btnPortfolio.selected) {
            indexOfDrawer = 2;
        }
        else if (btnCalendar.selected) {
            indexOfDrawer = 3;
        }
        else {
            indexOfDrawer = 0;
        }
    }
    if(indexOfDrawer == 0)
    {
        self.title = @"Market Mastro";
        btnMarket.selected = YES;
        
        [self.viewForNews setHidden:YES];
        [self.viewForEMC setHidden:YES];
        [self.viewForCalendar setHidden:YES];
        [self.viewForPortflio setHidden:YES];
        [self.viewForMarket setHidden:NO];
        
        self.viewForMarket.frame = CGRectMake(0, 135, SCREEN_WIDTH, SCREEN_HEIGHT-135);
        [self.view addSubview:self.viewForMarket];
        [self setupMarketPageControl];
    }
    else if(indexOfDrawer == 2)
    {
        self.title = @"Market Portfolio";
        
        btnPortfolio.selected = YES;
        
        [self.viewForNews setHidden:YES];
        [self.viewForEMC setHidden:YES];
        [self.viewForCalendar setHidden:YES];
        [self.viewForMarket setHidden:YES];
        [self.viewForPortflio setHidden:NO];
        
        self.viewForPortflio.frame = CGRectMake(0, 135, SCREEN_WIDTH, SCREEN_HEIGHT-135);
        [self.view addSubview:self.viewForPortflio];
        [self.viewForPortflio addSubview:ViewSelected3Commodity];
        
        [ViewSelected3Commodity setFrame:CGRectMake(ViewSelected3Commodity.frame.origin.x, ViewSelected3Commodity.frame.origin.y, SCREEN_WIDTH, ViewSelected3Commodity.frame.size.height)];
    }
    else if(indexOfDrawer == 1)
    {
        self.title = @"EMC";
        btnNews.selected = YES;
        
        [self.viewForNews setHidden:YES];
        [self.viewForCalendar setHidden:YES];
        [self.viewForPortflio setHidden:YES];
        [self.viewForMarket setHidden:YES];
        [self.viewForEMC setHidden:NO];
        
        self.viewForEMC.frame = CGRectMake(0, 135, SCREEN_WIDTH, SCREEN_HEIGHT-135);
        [self.view addSubview:self.viewForEMC];
        [self.viewForEMC addSubview:ViewSelected3Commodity];
        [self setupMarketPageControl];
        
        [ViewSelected3Commodity setFrame:CGRectMake(ViewSelected3Commodity.frame.origin.x, ViewSelected3Commodity.frame.origin.y, SCREEN_WIDTH, ViewSelected3Commodity.frame.size.height)];
    }
    else if(indexOfDrawer == 3)
    {
        self.title = @"Calendar";
        btnCalendar.selected = YES;
        
        [self.viewForNews setHidden:YES];
        [self.viewForPortflio setHidden:YES];
        [self.viewForMarket setHidden:YES];
        [self.viewForEMC setHidden:YES];
        [self.viewForCalendar setHidden:NO];
        
        self.viewForCalendar.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
        [self.view addSubview:self.viewForCalendar];
        [self.tableViewForCalendar reloadData];
    }
}

- (IBAction)btnDeselectColorTapped:(id)sender{
    //12 ,16 ,20
    UIButton *btn = (UIButton*)sender;
    UIButton *btnMarket = (UIButton*)[self.view viewWithTag:10];
    
    if(btn == btnMarket)
    {
        self.title = @"Market Mastro";
    }
}

-(IBAction)optionBtnClick:(id)sender
{
    btnSelectedTab = (UIButton*)sender;
    UIButton *btnMarket = (UIButton*)[self.view viewWithTag:10];
    UIButton *btnPortfolio = (UIButton*)[self.view viewWithTag:11];
    UIButton *btnNews = (UIButton*)[self.view viewWithTag:12];
    UIButton *btnCalendar = (UIButton*)[self.view viewWithTag:13];
    
    btnPortfolio.selected = NO;
    btnNews.selected = NO;
    btnCalendar.selected = NO;
    btnMarket.selected = NO;
    
    if(btnSelectedTab == btnMarket)
    {
        self.title = @"Market Mastro";
        btnMarket.selected = YES;
        indexOfDrawer = 0;
        
        [self.viewForNews setHidden:YES];
        [self.viewForCalendar setHidden:YES];
        [self.viewForPortflio setHidden:YES];
        [self.viewForEMC setHidden:YES];
        [self.viewForMarket setHidden:NO];
        [self.view addSubview:self.viewForMarket];
        [self.viewForMarket addSubview:ViewSelected3Commodity];
        [self setupMarketPageControl];
    }
    else if(btnSelectedTab == btnPortfolio)
    {
        self.title = @"Market Mastro";
        btnPortfolio.selected = YES;
        indexOfDrawer = 2;
        
        [self.viewForNews setHidden:YES];
        [self.viewForCalendar setHidden:YES];
        [self.viewForMarket setHidden:YES];
        [self.viewForEMC setHidden:YES];
        [self.viewForPortflio setHidden:NO];
        //        self.viewForPortflio.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
        [self.view addSubview:self.viewForPortflio];
        
        [self.viewForPortflio addSubview:ViewSelected3Commodity];
        [self setUpOnTapPortfolio];
    }
    else if(btnSelectedTab == btnNews)
    {
        self.title = @"EMC";
        btnNews.selected = YES;
        indexOfDrawer = 1;
        
        [self.viewForCalendar setHidden:YES];
        [self.viewForMarket setHidden:YES];
        [self.viewForPortflio setHidden:YES];
        [self.viewForNews setHidden:YES];
        [self.viewForEMC setHidden:NO];
        [self.view addSubview:self.viewForEMC];
        [self.viewForEMC addSubview:ViewSelected3Commodity];
        [self setupMarketPageControl];
        
        //        [self.tableViewForNews reloadData];
        
        //Harish
        //        [self newsPage];
    }
    else if(btnSelectedTab == btnCalendar)
    {
        self.title = @"Calendar";
        btnCalendar.selected = YES;
        indexOfDrawer = 3;
        
        [self.viewForNews setHidden:YES];
        [self.viewForEMC setHidden:YES];
        [self.viewForMarket setHidden:YES];
        [self.viewForPortflio setHidden:YES];
        [self.viewForCalendar setHidden:NO];
        [self.view addSubview:self.viewForCalendar];
        [self.tableViewForCalendar reloadData];
    }
    
    [self setUpPageUI];
    
}
- (IBAction)btnClickOnCalendarDays:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    UIButton *btnMarket = (UIButton*)[self.view viewWithTag:110];
    UIButton *btnPortfolio = (UIButton*)[self.view viewWithTag:111];
    UIButton *btnNews = (UIButton*)[self.view viewWithTag:112];
    UIButton *btnCalendar = (UIButton*)[self.view viewWithTag:113];
    
    btnMarket.selected = NO;
    btnPortfolio.selected = NO;
    btnNews.selected = NO;
    btnCalendar.selected = NO;
    
    if(btn == btnMarket)
    {
        btnMarket.selected = YES;
    }
    else if(btn == btnPortfolio)
    {
        btnPortfolio.selected = YES;
    }
    else if(btn == btnNews)
    {
        btnNews.selected = YES;
    }
    else if(btn == btnCalendar)
    {
        btnCalendar.selected = YES;
    }
}

-(IBAction)alertListBtnClick:(id)sender
{
    AlertViewController *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    calendarVC.is_NotFromDraw = YES;
    
    [self.navigationController pushViewController:calendarVC animated:YES];
}

#pragma mark - Collectionview Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrOfCollctionList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    UIButton *btn = (UIButton *)[cell viewWithTag:1];
    [btn setTitle:arrOfCollctionList[indexPath.row] forState:UIControlStateNormal];
    return cell;
}

- (IBAction)BtnSideMenuTapped:(id)sender
{
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        //swati
        //        [self.btnSideMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self checkNetwork];
    }
}

#pragma mark - Market
-(void)setupMarketPageControl
{
    if ([self.title isEqualToString:@"Market Mastro"] && marketPageControl) {
        return;
    }
    else if ([self.title isEqualToString:@"EMC"] && eMCPageControl) {
        return;
    }
    //marketTabs
    NSArray *pageArr = [seletedPageViewsDic objectForKey:self.title];
    /**** 1. Setup pages using model class "ADPageModel" ****/
    
    /*Bullion, Expected MCX, Costing & Difference, Base metals, Energy, Agri, Local Spot, International Markets
     */
    NSMutableArray *arrPageModle = [[NSMutableArray alloc] init];
    for (int i=0; i<pageArr.count; i++)
    {
        ADPageModel *pageModel = [[ADPageModel alloc] init];
        //page0.view.backgroundColor =    COLOR_LIGHT_RED;
        pageModel.strPageTitle = [pageArr objectAtIndex:i];
        pageModel.iPageNumber = i;
        if (i!=0) {
            pageModel.bShouldLazyLoad =    YES;
        }
        else
        {
            MarketViewController *marketVCObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MarketViewController"];
            
            //swati
            marketVCObj.object = self;
            marketVCObj.title = [pageArr objectAtIndex:i];
            pageModel.viewController = marketVCObj;
        }
        [arrPageModle addObject:pageModel];
    }
    /**** 2. Initialize page control ****/
    
    ADPageControl *_pageControl;
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
    _pageControl.arrPageModel = arrPageModle;
    
    
    /**** 3. Customize parameters (Optinal, as all have default value set) ****/
    _pageControl.iFirstVisiblePageNumber =  0;
    _pageControl.iTitleViewHeight =         40;//Default 35//Required 34
    _pageControl.iPageIndicatorHeight =     6;
    
    //swati 31 jan
    _pageControl.fontTitleTabText =         [UIFont fontWithName:@"Lato-Regular" size:14];
    
    _pageControl.bEnablePagesEndBounceEffect =  NO;
    _pageControl.bEnableTitlesEndBounceEffect = NO;
    
    _pageControl.colorTabText =  [UIColor colorwithHexString:@"#666666"];//[UIColor whiteColor];
    //Harish
    _pageControl.seletedColorTabText = [UIColor colorwithHexString:@"#ffffff"];
    _pageControl.separatorColorOfTab = [UIColor colorwithHexString:@"#000000"];
    
    //73,75,78
    _pageControl.colorTitleBarBackground = [UIColor colorwithHexString:@"#16191B"];//0C1014
    //[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.5];
    
    //$$$ 31 jan notch
    _pageControl.colorPageIndicator =               [UIColor colorWithRed:12.0/255.0 green:16.0/255.0 blue:20.0/255.0 alpha:1.0];
    _pageControl.colorPageOverscrollBackground =    [UIColor colorwithHexString:@"#16191B"];
    
    _pageControl.bShowMoreTabAvailableIndicator =   NO;
    _pageControl.bHideShadow                    =   NO;
    
    
    //Uncomment to check custom fixed width tabs
    //_pageControl.iCustomTabWidth    =               [[UIScreen mainScreen] bounds].size.width/3;
    /**** 3. Add as subview ****/
    
    //    _pageControl.view.backgroundColor = [UIColor blackColor];
    
    if (pageArr.count>3) {
        marketPageControl = _pageControl;
        [viewMarketTables addSubview:marketPageControl.view];
    }
    else {
        eMCPageControl = _pageControl;
        [viewEMCTables addSubview:eMCPageControl.view];
    }
    
    //    CGRect frame;
    //    frame.origin.x = 0;
    //    frame.origin.y = _pageControlView.frame.origin.y + 60;
    //    frame.size.width = width;
    //    frame.size.height = 80;
    //    GoldSilverView.frame = frame;
    //    [self.view addSubview:GoldSilverView];
    
    
    // [self.view addSubview:_pageControl.view];
    _pageControl.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *subview = _pageControl.view;
    
    //Leading margin 0, Trailing margin 0
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[subview]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(subview)]];
    
    //Top margin 20 for status bar, Bottom margin 0
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subview]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(subview)]];
    
    
}
#pragma mark - ADPageControlDelegate

//LAZY LOADING

-(UIViewController *)adPageControlGetViewControllerForPageModel:(ADPageModel *) pageModel
{
    NSLog(@"ADPageControl :: Lazy load asking for page %d",pageModel.iPageNumber);
    //marketTabs
    NSArray *pageArr = [seletedPageViewsDic objectForKey:self.title];
    
    MarketViewController *page0 = [self.storyboard instantiateViewControllerWithIdentifier:@"MarketViewController"];
    
    //swati
    page0.object = self;
    
    page0.title = [pageArr objectAtIndex:pageModel.iPageNumber];
    
    /*
     switch (pageModel.iPageNumber) {
     case 0:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     case 1:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     case 2:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     case 3:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     case 4:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     case 5:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     case 6:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     case 7:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     
     default:
     {
     page0.view.backgroundColor =    [UIColor darkGrayColor];
     return page0;
     }
     break;
     }
     */
    return page0;
}

//CURRENT PAGE INDEX

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
}

#pragma mark - PortfolioPage

- (void)setUpOnTapPortfolio
{
    //[self emptyPortfolioViewHiddenStatus:NO];
    
    // return;
    
    //Temp Login
    
    /* if ([imgViewEmpty isHidden]) {
     if (portfolioVCObj && [portfolioVCObj.title isEqualToString:@"ProfolioList"]) {
     [self showPortfolioEditable];
     }
     else {
     [self emptyPortfolioViewHiddenStatus:NO];
     }
     }
     else {
     [self showPortfolioList];
     }*/
    
    NSString *query1 =[NSString stringWithFormat:@"SELECT * from UserPortfolio"];
    
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result) {
        if(result.rows.count>0){
            [self showPortfolioList];
        }else{
            [self emptyPortfolioViewHiddenStatus:NO];
        }
        
        
    } failure:^(NSString *errorMessage) {
        NSLog(@"Could not fetch rows , %@",errorMessage);
    }];
    
    
    
}

- (void)emptyPortfolioViewHiddenStatus:(BOOL)isHide
{
    [portfolioVCObj.view removeFromSuperview];
    portfolioVCObj = nil;
    [imgViewEmpty setHidden:isHide];
    [lblEmptyDescripiton setHidden:isHide];
    [btnOCreatePortfolio setHidden:isHide];
}
- (void)showPortfolioList {
    [self emptyPortfolioViewHiddenStatus:YES];
    portfolioVCObj =   [self.storyboard instantiateViewControllerWithIdentifier:@"MarketViewController"];
    portfolioVCObj.title = @"ProfolioList";
    CGRect portfolioFrame = CGRectMake(0, CGRectGetMaxY(ViewSelected3Commodity.frame), SCREEN_WIDTH, CGRectGetHeight(_viewForPortflio.frame)-CGRectGetMaxY(ViewSelected3Commodity.frame));
    portfolioVCObj.view.frame = portfolioFrame;
    [_viewForPortflio addSubview:portfolioVCObj.view];
}
- (void)showPortfolioEditable {
    [self emptyPortfolioViewHiddenStatus:YES];
    portfolioVCObj =   [self.storyboard instantiateViewControllerWithIdentifier:@"MarketViewController"];
    portfolioVCObj.title = @"ProfolioEditable";
    CGRect portfolioFrame = CGRectMake(0, CGRectGetMinY(ViewSelected3Commodity.frame), SCREEN_WIDTH, CGRectGetHeight(_viewForPortflio.frame)-CGRectGetMinY(ViewSelected3Commodity.frame));
    portfolioVCObj.view.frame = portfolioFrame;
    [_viewForPortflio addSubview:portfolioVCObj.view];
}

#pragma mark - NewsPage
- (void)newsPage {
    if (![NetworkManager connectedToNetwork]) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        return;
    }
    
    NSString *UUID = [[NSUserDefaults standardUserDefaults]valueForKey:@"SavedUUID"];
    NSString *strTokenId = [[NSUserDefaults standardUserDefaults] valueForKey:@"TokenID"];
    
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];//HH-mm-ss
    NSString *requestDate = [dateFormatter stringFromDate:currentdate];
    
    [dateFormatter setDateFormat:@"HH-mm-ss"];
    NSString *requestSecond = [dateFormatter stringFromDate:currentdate];
    
    NSDictionary *requestTime = @{@"RequestDate": requestDate, @"RequestSecond": requestSecond};
    
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
    [requestDict setObject:@"I" forKey:@"DeviceOS"];
    [requestDict setObject:@"1.0" forKey:@"AppVer"];
    [requestDict setObject:strTokenId forKey:@"Token"];
    [requestDict setObject:UUID forKey:@"UUID"];
    
    NSString *apiMethod;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"RequestTime"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *lRequestTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"RequestTime"];
        apiMethod = [NSString stringWithFormat:@"api/GetNews/%@/%@", [lRequestTime objectForKey:@"RequestDate"], [lRequestTime objectForKey:@"RequestSecond"]];
    }
    else {
        apiMethod = @"api/GetNews";
    }
    
    [NetworkManager sendWebRequest:nil withMethod:apiMethod successResponce:^(id response) {
        NSLog(@"Data : %@", response);
        if ([response isKindOfClass:[NSArray class]]) {
            
            //            [[NSUserDefaults standardUserDefaults] setObject:requestTime forKey:@"RequestTime"];Temp
            NSLog(@"requestDate : %@\nrequestTime : %@", requestDate, requestTime);
            [self setNewsToDB:response];
            [self reloadNews];
        }
    } failure:^(NSError *error) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }];
}

- (void)setNewsToDB:(NSArray*)newsArr {
    NSMutableArray *columnValues = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    for (NSDictionary *tDict in newsArr) {
        if ([[tDict objectForKey:@"description"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[self escapeApostrophe:[tDict objectForKey:@"description"]] forKey:@"description"];
        }
        else {
            [dataDic setObject:@"" forKey:@"description"];
        }
        
        if ([[tDict objectForKey:@"link"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[tDict objectForKey:@"link"] forKey:@"link"];
        }
        else {
            [dataDic setObject:@"" forKey:@"link"];
        }
        
        if ([[tDict objectForKey:@"pubDate"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[tDict objectForKey:@"pubDate"] forKey:@"pubDate"];
        }
        else {
            [dataDic setObject:@"" forKey:@"pubDate"];
        }
        
        if ([[tDict objectForKey:@"title"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[self escapeApostrophe:[tDict objectForKey:@"title"]] forKey:@"title"];
        }
        else {
            [dataDic setObject:@"" forKey:@"title"];
        }
        
        if ([[tDict objectForKey:@"type"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[tDict objectForKey:@"type"] forKey:@"type"];
        }
        else {
            [dataDic setObject:@"" forKey:@"type"];
        }
        [columnValues addObject:[NSString stringWithFormat:@"('%@')", [[dataDic allValues] componentsJoinedByString:@"', '"]]];
    }
    NSString *insertQry;
    if (columnValues.count>0) {
        insertQry = [NSString stringWithFormat:@"INSERT INTO NEWS (%@) VALUES %@", [[dataDic allKeys] componentsJoinedByString:@", "], [columnValues componentsJoinedByString:@", "]];
        
        [[SQLiteDatabase sharedInstance] executeQuery:insertQry withParams:nil success:^(SQLiteResult *result) {
            
        } failure:^(NSString *errorMessage) {
            NSLog(@"FAIL QRY : %@", insertQry);
        }];
    }
}

- (NSString*)escapeApostrophe:(NSString*)value {
    return [value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

- (void)reloadNews {
    NSString *selectNewsQry = @"SELECT * FROM NEWS";
    [[SQLiteDatabase sharedInstance] executeQuery:selectNewsQry withParams:nil success:^(SQLiteResult *result) {
        
        NSLog(@"result : %@", result);
        newsList = result.rows;
        //        [_tableViewForNews reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"Could not fetch rows , %@",errorMessage);
    }];
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
    
    self.viewForMarket.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    self.viewForPortflio.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    self.viewForNews.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    self.viewForCalendar.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    self.viewForEMC.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    NSLog(@"adViewDidReceiveAd");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    adBannerView.hidden = YES;
    self.viewForMarket.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
    self.viewForPortflio.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
    self.viewForNews.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
    self.viewForCalendar.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
    self.viewForEMC.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
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

//swati 8 feb
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"port"])
    {
        CreatePortflioVC *commodityPage = (CreatePortflioVC *)[segue destinationViewController];
        commodityPage.isFromVC = @"Port";
        [[NSUserDefaults standardUserDefaults]setObject:@"Port" forKey:@"isFromVC"];
        
    }
}


-(void)MethodGetCommodityTypes
{
    NSString *strUserID = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
    strUserID = [NSString stringWithFormat:@"%@",strUserID];
    
    BOOL isNetworkAvailable = [[MethodsManager sharedManager]isInternetAvailable];
    
    if (isNetworkAvailable)
    {
        if (strUserID !=nil)
        {
            
            [[MethodsManager sharedManager]loadingView:self.view];
            
            [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/GetCommodityTypes/%@",strUserID]
                                   successResponce:^(id response)
             {
                 [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"get commodity type response = %@",response);
                 
                 
                 
                 NSMutableArray *ArrGetCurrentAlertList = [[NSMutableArray alloc] init];
                 ArrGetCurrentAlertList = response;
                 
                 //  marketTabs = [[NSMutableArray alloc] init];
                 //  eMCTabs = [[NSMutableArray alloc] init];
                 
                 NSMutableArray *arrOfTypes = [[NSMutableArray alloc] init];
                 
                 for (int i =0; i<ArrGetCurrentAlertList.count; i++)
                 {
                     NSDictionary *dic = [ArrGetCurrentAlertList objectAtIndex:i];
                     
                     /* if([[dic valueForKey:@"GroupType"] isEqualToString:@"OTHERS"])
                      {
                      [eMCTabs addObject:[dic valueForKey:@"GroupName"]];
                      }
                      else
                      {
                      [marketTabs addObject:[dic valueForKey:@"GroupName"]];
                      }*/
                     
                     [arrOfTypes addObject:dic];
                     
                     // [arrOfCollctionList addObject:[dic valueForKey:@"GroupName"]];
                 }
                 
                 [[NSUserDefaults standardUserDefaults] setObject:arrOfTypes forKey:@"commodity_types"];
                 [self loadData];
             }
                                           failure:^(NSError *error)
             {
                 [[MethodsManager sharedManager]StopAnimating];
                 NSLog(@"get current active package error = %@",error);
             }];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        }
    }
}

#pragma mark - MultipleLoginRedirectRegistration
- (void)redirectToRegistrationPage:(NSError*)error {
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:error.localizedDescription
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"Ok", nil] show];
    
    ViewController *registrationPage = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    NSMutableArray *tArr = [[NSMutableArray alloc] init];
    [tArr addObject:registrationPage];
    [tArr addObject:self];
    self.navigationController.viewControllers = tArr;
    [self.navigationController popViewControllerAnimated:YES];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NSArray *tableNames = @[@"ALERT", @"CommodityGroup", @"CommodityType", @"News", @"PopularCommodity", @"UserInfo", @"UserPortfolio"];
    for (NSString *tableName in tableNames) {
        NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        [[SQLiteDatabase sharedInstance] executeUpdate:deleteQuery withParams:nil success:^(SQLiteResult *result) {
            NSLog(@"Query : %@ - Status : %@", deleteQuery, result.success?@"YES":@"NO");
        } failure:^(NSString *errorMessage) {
            NSLog(@"errorMessage : %@", errorMessage);
        }];
    }
}
@end
