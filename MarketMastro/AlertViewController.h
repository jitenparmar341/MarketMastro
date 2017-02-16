//
//  AlertViewController.h
//  MarketMastro
//
//  Created by Mac on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface AlertViewController : UIViewController {

    //Firebase
    __weak IBOutlet GADBannerView *adBannerView;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic) BOOL is_NotFromDraw;
@property (weak, nonatomic) IBOutlet UITableView *tableCurrentAlerts;

@end
