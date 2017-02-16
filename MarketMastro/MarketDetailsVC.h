//
//  MarketDetailsVC.h
//  MarketMastro
//
//  Created by Vodlo iMac 022 on 24/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface MarketDetailsVC : UIViewController {
    //Firebase
    __weak IBOutlet GADBannerView *adBannerView;
}
@property (strong, nonatomic) IBOutlet UIView *viewForAddOptions;
@property (strong, nonatomic) IBOutlet UIView *viewForPopupView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIImageView *imgOHLC;
@property (weak, nonatomic) IBOutlet UIImageView *imgOpenInterestVolume;


@property (weak, nonatomic) IBOutlet UILabel *lblBidRate;
@property (weak, nonatomic) IBOutlet UILabel *lblBideQuantity;

@property (weak, nonatomic) IBOutlet UILabel *lblOffer;
@property (weak, nonatomic) IBOutlet UILabel *OfferQuantity;

@property (weak, nonatomic) IBOutlet UILabel *lblPrizerate;
@property (weak, nonatomic) IBOutlet UILabel *lblPercent;


@property (weak, nonatomic) IBOutlet UIWebView *WebView
;

@property (weak, nonatomic) IBOutlet UILabel *lblStandard;
@property (weak, nonatomic) IBOutlet UILabel *standardR1;
@property (weak, nonatomic) IBOutlet UILabel *standardR12;
@property (weak, nonatomic) IBOutlet UILabel *standardR13;


@property (weak, nonatomic) IBOutlet UILabel *lblAlertHeader;

@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end
