//
//  HelpViewController.h
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController
{
    __weak IBOutlet UIWebView *webview;
    __weak IBOutlet UIProgressView *progressView;
      NSTimer *myTimer;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
