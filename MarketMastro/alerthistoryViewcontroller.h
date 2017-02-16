//
//  alerthistoryViewcontroller.h
//  MarketMastro
//
//  Created by DHARMESH on 06/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface alerthistoryViewcontroller : UIViewController {
    //Firebase
    __weak IBOutlet GADBannerView *adBannerView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableAlertHistory;
@property (weak, nonatomic) IBOutlet UILabel *lblNoDataFound;

@end
