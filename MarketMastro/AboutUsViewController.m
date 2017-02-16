//
//  AboutUsViewController.m
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface AboutUsViewController ()<UIWebViewDelegate>
{
    BOOL theBool;
}
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"About Us";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    BOOL isInternetAvailable = [[MethodsManager sharedManager] isInternetAvailable];
    if(isInternetAvailable)
    {
         [self MethodForLoadWebView];
    }
    else
    {
        NSLog(@"Network not reachable");
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }
}

-(void)MethodForLoadWebView
{
    //Load webview with web link - ttp://admin.marketmastro.com/StaticPage/sPage?pagename=about
    NSString *urlNameInString = @"http://admin.marketmastro.com/StaticPage/sPage?pagename=about";
    NSURL *url = [NSURL URLWithString:urlNameInString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [webview setBackgroundColor:[UIColor blackColor]];
    [webview setOpaque:NO];
    [webview loadRequest:urlRequest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)alertListBtnClick:(id)sender
{
    AlertViewController *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    calendarVC.is_NotFromDraw = YES;

    [self.navigationController pushViewController:calendarVC animated:YES];
    
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


@end
