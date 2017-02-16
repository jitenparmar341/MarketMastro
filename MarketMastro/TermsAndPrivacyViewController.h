//
//  TermsAndPrivacyViewController.h
//  MarketMastro
//
//  Created by DHARMESH on 12/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsAndPrivacyViewController : UIViewController
{
     __weak IBOutlet UIProgressView *progressView;
     NSTimer *myTimer;
}
@property (weak, nonatomic) IBOutlet UIWebView *Webview;
@property (weak, nonatomic) NSString *strPrivacyOrService;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;

- (IBAction)btnBackTapped:(id)sender;

@end
