//
//  TermsAndPrivacyViewController.m
//  MarketMastro
//
//  Created by DHARMESH on 12/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "TermsAndPrivacyViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface TermsAndPrivacyViewController ()<UIWebViewDelegate>
{
    BOOL theBool;
}
@end

@implementation TermsAndPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.Webview setBackgroundColor:[UIColor blackColor]];
    [self.Webview setOpaque:NO];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)viewWillAppear:(BOOL)animated
{
    if([AFNetworkReachabilityManager sharedManager].isReachable)
    {
        self.Webview.delegate = self;
        
        if ([_strPrivacyOrService isEqualToString:@"Terms Of Service"])
        {
            _lblHeader.text = @"Terms Of Service";
            
            NSString *urlNameInString = @"http://admin.marketmastro.com/StaticPage/sPage?pagename=tos";
            NSURL *url = [NSURL URLWithString:urlNameInString];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            [self.Webview loadRequest:urlRequest];
        }
        else
        {
            _lblHeader.text = @"Privacy Policy";
            
            NSString *urlNameInString = @"http://admin.marketmastro.com/StaticPage/sPage?pagename=pp";
            NSURL *url = [NSURL URLWithString:urlNameInString];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            [self.Webview loadRequest:urlRequest];
        }
    }
    else
    {
        NSLog(@"Network not reachable");
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    progressView.progress = 0;
    theBool = false;
    //0.01667 is roughly 1/60, so it will update at 60 FPS
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    theBool = true;
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error
{
    if (error.code == NSURLErrorNotConnectedToInternet)
    {
        NSLog(@"You are not connected");
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please check your internet connection" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }
}


-(void)timerCallback {
    if (theBool) {
        if (progressView.progress >= 1) {
            progressView.hidden = true;
            [myTimer invalidate];
        }
        else {
            progressView.progress += 0.1;
        }
    }
    else {
        progressView.progress += 0.05;
        if (progressView.progress >= 0.95) {
            progressView.progress = 0.95;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
