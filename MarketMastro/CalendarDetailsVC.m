//
//  CalendarDetailsVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "CalendarDetailsVC.h"

@interface CalendarDetailsVC ()<GADBannerViewDelegate, GADInAppPurchaseDelegate, GADAdSizeDelegate>

@end

@implementation CalendarDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Economic Calendar";
    // Do any additional setup after loading the view.
    
    //AdBanner
    [self bannerAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
    NSLog(@"adViewDidReceiveAd");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    adBannerView.hidden = YES;
    
    //    self.viewForEMC.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135);
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
