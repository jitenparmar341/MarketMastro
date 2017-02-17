//
//  FirstFourVC.h
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@import GoogleMobileAds;

@interface FirstFourVC : UIViewController<UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    
    //Selected 3 Commodity Outlets(Market & Portfolio)
    __weak IBOutlet UIView *ViewSelected3Commodity;
    
    __weak IBOutlet UIView *viewCommodity1;
    __weak IBOutlet UIView *viewCommodity2;
    __weak IBOutlet UIView *viewCommodity3;
    
    __weak IBOutlet UILabel *lblCName1;
    __weak IBOutlet UILabel *lblCName2;
    __weak IBOutlet UILabel *lblCName3;
    
    __weak IBOutlet UILabel *lblCExpireDate1;
    __weak IBOutlet UILabel *lblCExpireDate2;
    __weak IBOutlet UILabel *lblCExpireDate3;
    
    __weak IBOutlet UILabel *lblCRate1;
    __weak IBOutlet UILabel *lblCRate2;
    __weak IBOutlet UILabel *lblCRate3;
    
    __weak IBOutlet UILabel *lblCDifference1;
    __weak IBOutlet UILabel *lblCDifference2;
    __weak IBOutlet UILabel *lblCDifference3;
    
    __weak IBOutlet UIView *viewCommodityHL1;
    __weak IBOutlet UIView *viewCommodityHL2;
    __weak IBOutlet UIView *viewCommodityHL3;
    
    __weak IBOutlet UILabel *lblCHighRate1;
    __weak IBOutlet UILabel *lblCHighRate2;
    __weak IBOutlet UILabel *lblCHighRate3;
    
    __weak IBOutlet UILabel *lblCLowRate1;
    __weak IBOutlet UILabel *lblCLowRate2;
    __weak IBOutlet UILabel *lblCLowRate3;
    
    //MarketPage Outlet
    
    //Portfolio Page Outlet
    __weak IBOutlet UIImageView *imgViewEmpty;
    __weak IBOutlet UILabel *lblEmptyDescripiton;
    __weak IBOutlet UIButton *btnOCreatePortfolio;
    
    //EMC Outlet
    __weak IBOutlet UIView *viewEMCTables;
    
    
    //Firebase
    __weak IBOutlet GADBannerView *adBannerView;
    
    UIButton *btnSelectedTab;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *viewForNews;
@property (weak, nonatomic) IBOutlet UIView *viewForPortflio;
@property (weak, nonatomic) IBOutlet UIView *viewForCalendar;
@property (weak, nonatomic) IBOutlet UIView *viewForMarket;
@property (weak, nonatomic) IBOutlet UIView *viewForEMC;

@property (nonatomic, strong) IBOutlet UITableView * tableViewForNews;
@property (nonatomic, strong) IBOutlet UITableView * tableViewForCalendar;
@property (nonatomic, strong) IBOutlet UITableView * tableViewForPortfolio;
@property (nonatomic, strong) IBOutlet UITableView * tableViewForMarket;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *btnSideMenu;


@property (weak, nonatomic) IBOutlet UILabel *lblpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblscriptName;
@property (weak, nonatomic) IBOutlet UILabel *lblrate;
@property (weak, nonatomic) IBOutlet UILabel *lblShortName;

@property (weak, nonatomic) IBOutlet UILabel *lblpercent1;
@property (weak, nonatomic) IBOutlet UILabel *lblscriptName1;
@property (weak, nonatomic) IBOutlet UILabel *lblrate1;
@property (weak, nonatomic) IBOutlet UIView *lblshortname1;
@property (weak, nonatomic) IBOutlet UILabel *lblscriptname2;
@property (weak, nonatomic) IBOutlet UILabel *lblrate2;
@property (weak, nonatomic) IBOutlet UILabel *lblshortname2;
@property (weak, nonatomic) IBOutlet UILabel *lblpercent2;

@property (weak, nonatomic) IBOutlet UIButton *btnMarket;
@property (weak, nonatomic) IBOutlet UIButton *btnPortfolio;
@property (weak, nonatomic) IBOutlet UIButton *btnNews;
@property (weak, nonatomic) IBOutlet UIButton *btnCalender;



-(IBAction)BtnSideMenuTapped:(id)sender;

@end
