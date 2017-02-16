//
//  MarketDetailsVC.m
//  MarketMastro
//
//  Created by Vodlo iMac 022 on 24/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MarketDetailsVC.h"
#import "AppDelegate.h"
#import "MarketCreateAlertVC.h"

@interface MarketDetailsVC ()<GADBannerViewDelegate, GADInAppPurchaseDelegate, GADAdSizeDelegate>

@end

@implementation MarketDetailsVC

- (void)viewDidLoad
{
    
    self.title = @"Silver March 2007";
    [super viewDidLoad];
    [self setUpPageUI];
    
    [self.scrollView setContentSize:CGSizeMake(0, 700)];
    // Do any additional setup after loading the view.
    
    //AdBanner
    [self bannerAd];
}

-(void)setUpPageUI
{
    self.view.backgroundColor = ViewBackgroundColor;
    
    //set background color
    _WebView.backgroundColor = [UIColor clearColor];
    _WebView.opaque = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)addtionButtonClick:(id)sender
{
    self.viewForAddOptions.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.viewForAddOptions];    
}

-(IBAction)addPortfolioButtonClick:(id)sender
{
    [self.viewForAddOptions removeFromSuperview];
    self.viewForPopupView.frame = self.view.frame;
    [self.view addSubview:self.viewForPopupView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.viewForPopupView removeFromSuperview];
    });
}
-(IBAction)addAlertButtonClick:(id)sender
{
    [self.viewForAddOptions removeFromSuperview];

    MarketCreateAlertVC *createAlertvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MarketCreateAlertVC"];
    [self.navigationController pushViewController:createAlertvc animated:YES];

}
- (IBAction)dismissPopView:(id)sender {
    [self.viewForPopupView removeFromSuperview];
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
    
//    _tableCurrentAlerts.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    
    _scrollView.frame = CGRectMake(CGRectGetMinX(_scrollView.frame), CGRectGetMinY(_scrollView.frame), CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)-height);
    NSLog(@"adViewDidReceiveAd");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    adBannerView.hidden = YES;
    
    _scrollView.frame = CGRectMake(CGRectGetMinX(_scrollView.frame), CGRectGetMinY(_scrollView.frame), CGRectGetWidth(_scrollView.frame), SCREEN_HEIGHT-CGRectGetMinY(_scrollView.frame));
    
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
