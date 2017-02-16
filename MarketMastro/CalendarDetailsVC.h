//
//  CalendarDetailsVC.h
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface CalendarDetailsVC : UIViewController<UITableViewDelegate> {
    //Firebase
    __weak IBOutlet GADBannerView *adBannerView;
}

@end
